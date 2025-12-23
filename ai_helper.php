<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

session_start();
// Optional: enforce auth
// if (!isset($_SESSION['user_id'])) {
//     http_response_code(401);
//     echo json_encode(['success' => false, 'message' => 'غير مصرح لك.']);
//     exit;
// }
$apiKey = getenv('DEEPSEEK_API_KEY');
if (!$apiKey) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'مفتاح خدمة DeepSeek غير متوفر.']);
    exit;
}

$raw = file_get_contents('php://input');
$data = json_decode($raw, true);
$question = isset($data['question']) ? trim($data['question']) : '';
$code = isset($data['code']) ? trim($data['code']) : '';
$courseId = isset($data['course_id']) ? $data['course_id'] : '';

if ($question === '' || $code === '') {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'يرجى إرسال السؤال والكود.']);
    exit;
}

// Basic size guard
if (strlen($code) > 8000) {
    http_response_code(413);
    echo json_encode(['success' => false, 'message' => 'الكود طويل جداً، يرجى تقليله.']);
    exit;
}

$prompt = "قيّم هل الكود يحل السؤال بالكامل أم لا.\n" .
    "أعد الإجابة حصراً بصيغة JSON دقيقة بدون أي نص إضافي: \n" .
    "{\n  \"verdict\": \"yes|no\",\n  \"hint\": \"جملة عربية قصيرة جداً توضح موضع النقص إن كان no\"\n}\n" .
    "ملاحظات مهمة:\n" .
    "- إذا كان الحل صحيحاً تماماً فاكتب verdict=\"yes\" وضع hint كسلسلة فارغة \"\".\n" .
    "- إذا كان غير مكتمل أو به خطأ فاكتب verdict=\"no\" وقدّم hint من سطر واحد فقط يشير للمكان أو الشرط المفقود دون حل كامل.\n" .
    "- لا تكتب أي شيء خارج JSON.\n" .
    "- لا تكرر الكود أو السؤال في الرد.\n\n" .
    "السؤال:\n$question\n\nالكود:\n$code";

$payload = [
    'model' => 'DeepSeek-R1-0528',
    'messages' => [
        ['role' => 'system', 'content' => 'أنت مصحح كود صارم. لا تُرجِع إلا JSON المطلوب.'],
        ['role' => 'user', 'content' => $prompt],
    ],
    'max_tokens' => 200,
    'temperature' => 0.3,
];

$ch = curl_init('https://api.deepseek.com/v1/chat/completions');
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POST => true,
    CURLOPT_HTTPHEADER => [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $apiKey,
    ],
    CURLOPT_POSTFIELDS => json_encode($payload),
]);

$response = curl_exec($ch);
if ($response === false) {
    http_response_code(502);
    echo json_encode(['success' => false, 'message' => 'تعذر الاتصال بنموذج الذكاء الاصطناعي.']);
    curl_close($ch);
    exit;
}

$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

$decoded = json_decode($response, true);

if ($status < 200 || $status >= 300) {
    http_response_code(502);
    echo json_encode([
        'success' => false,
        'message' => 'الخدمة لم تُرجع استجابة صالحة.',
        'debug_status' => $status,
        'debug_body' => $decoded,
    ]);
    exit;
}
$aiResponse = $decoded['choices'][0]['message']['content'] ?? '';

if ($aiResponse === '') {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'تعذر استخراج الرد.']);
    exit;
}

// Normalize output to Yes/No + tiny hint
$verdict = null;
$hintOut = '';

$jsonStart = strpos($aiResponse, '{');
$jsonEnd = strrpos($aiResponse, '}');
if ($jsonStart !== false && $jsonEnd !== false && $jsonEnd > $jsonStart) {
    $jsonStr = substr($aiResponse, $jsonStart, $jsonEnd - $jsonStart + 1);
    $parsed = json_decode($jsonStr, true);
    if (is_array($parsed)) {
        $v = strtolower(trim($parsed['verdict'] ?? ''));
        if ($v === 'yes' || $v === 'no') {
            $verdict = $v;
            $hintOut = trim((string)($parsed['hint'] ?? ''));
        }
    }
}

if ($verdict === null) {
    $lower = trim(mb_strtolower($aiResponse, 'UTF-8'));
    if (preg_match('/^\s*(نعم|yes|صحيح|correct)\s*$/u', $lower)) {
        $verdict = 'yes';
    } else {
        $verdict = 'no';
        $hintOut = preg_split('/[\.!؟\n]/u', trim($aiResponse))[0] ?? '';
        $hintOut = mb_substr(trim($hintOut), 0, 120, 'UTF-8');
    }
}

$aiText = $verdict === 'yes' ? 'نعم' : ('لا — تلميح: ' . ($hintOut !== '' ? $hintOut : 'راجع شروط السؤال أو حدود المدخلات'));

// Additional safeguard: if verdict is yes but code doesn't look like code, override to no
if ($verdict === 'yes' && (strlen($code) < 5 || !preg_match('/[{}();]/', $code))) {
    $verdict = 'no';
    $hintOut = 'الكود لا يحتوي على عناصر برمجة أساسية';
    $aiText = 'لا — تلميح: ' . $hintOut;
}

echo json_encode([
    'success' => true,
    'ai_response' => $aiText,
    'verdict' => $verdict,
    'hint' => $verdict === 'no' ? $hintOut : '',
    'course_id' => $courseId,
]);
