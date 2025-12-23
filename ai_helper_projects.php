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
require 'db_connect.php';
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'غير مصرح لك. يرجى تسجيل الدخول أولاً.']);
    exit;
}

// Parse JSON input
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'بيانات غير صحيحة']);
    exit;
}

$mode = isset($input['mode']) ? $input['mode'] : 'hint';
$question = isset($input['question']) ? trim($input['question']) : '';
$code = isset($input['code']) ? trim($input['code']) : '';
$courseId = isset($input['course_id']) ? (int)$input['course_id'] : null;
$assignmentId = isset($input['assignment_id']) ? (int)$input['assignment_id'] : null;

// Basic validation
if ($question === '') {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'يرجى إرسال السؤال.']);
    exit;
}

// Basic size guard
if (strlen($code) > 8000) {
    http_response_code(413);
    echo json_encode(['success' => false, 'message' => 'الكود طويل جداً، يرجى تقليله.']);
    exit;
}

if ($mode === 'fix') {
    $prompt = '';
    if ($code !== '') {
        $prompt = "أصلِح الكود التالي بحيث يحل السؤال بشكل صحيح وكامل.\n" .
            "أعد الإخراج كوداً فقط بدون أي شرح أو تعليق.\n" .
            "إذا رغبت فضعه داخل كتلة شيفرة ثلاثية ``` لكن بدون أي نص خارجها.\n\n" .
            "السؤال:\n$question\n\nالكود الحالي:\n$code";
    } else {
        $prompt = "اكتب حلاً صحيحاً وكاملاً ومباشراً للسؤال التالي.\n" .
            "أعد الإخراج كوداً فقط بدون أي شرح أو تعليق.\n" .
            "إذا رغبت فضعه داخل كتلة شيفرة ثلاثية ``` لكن بدون أي نص خارجها.\n\n" .
            "السؤال:\n$question";
    }

    $payload = [
        'model' => 'qwen2.5-coder:0.5b',
        'messages' => [
            ['role' => 'system', 'content' => 'أنت خبير برمجة صارم ودقيق. مهمتك تقييم ما إذا كان الكود المقدم يحل السؤال المطلوب بالكامل. يجب أن تكون حازماً ولا تتساهل في التقييم.'],
            ['role' => 'user', 'content' => $prompt],
        ],
        'stream' => false,
    ];

    $ch = curl_init('http://localhost:11434/api/chat');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
        CURLOPT_POSTFIELDS => json_encode($payload),
        CURLOPT_TIMEOUT => 30,
    ]);

    $response = curl_exec($ch);
    if ($response === false) {
        http_response_code(502);
        echo json_encode(['success' => false, 'message' => 'تعذر الاتصال بـ Ollama. تأكد من تشغيل Ollama على http://localhost:11434']);
        curl_close($ch);
        exit;
    }

    $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($status < 200 || $status >= 300) {
        http_response_code(502);
        echo json_encode(['success' => false, 'message' => 'خدمة Ollama لم تُرجع استجابة صالحة.']);
        exit;
    }

    $decoded = json_decode($response, true);
    $aiResponse = $decoded['message']['content'] ?? '';

    if ($aiResponse === '') {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'تعذر استخراج الرد من النموذج.']);
        exit;
    }

    // Extract code block if present
    $fixed = $aiResponse;
    if (preg_match('/```[a-zA-Z0-9+\-_.]*\n([\s\S]*?)```/u', $aiResponse, $m)) {
        $fixed = trim($m[1]);
    } else {
        $fixed = trim($fixed);
    }

    echo json_encode([
        'success' => true,
        'ai_response' => ($code !== '' ? 'تم إصلاح الكود وإدراجه في المحرر.' : 'تم توليد حل صحيح وإدراجه في المحرر.'),
        'fixed_code' => $fixed,
        'course_id' => $courseId,
        'assignment_id' => $assignmentId,
        'mode' => 'fix',
    ]);
    exit;
}

$isCodeCheck = ($code !== '');

if ($isCodeCheck) {
    // Validate that there's actual code, not just text
    $code = trim($code);
    if (empty($code)) {
        echo json_encode([
            'success' => true,
            'ai_response' => 'يرجى كتابة كود برمجي لحل السؤال.',
            'verdict' => 'no',
            'hint' => 'يجب تقديم كود برمجي صحيح، لا يمكن قبول نص عادي.',
            'course_id' => $courseId,
            'assignment_id' => $assignmentId,
            'updated_completion' => false,
        ]);
        exit;
    }

    // Basic code validation - check for programming constructs
    $hasCodeIndicators = false;
    $codeIndicators = ['function', 'def ', 'class ', 'if ', 'for ', 'while ', 'print', 'console.log', 'return ', 'var ', 'let ', 'const ', 'int ', 'string ', 'public ', 'private ', '#include', 'import ', 'color:', 'margin:', 'padding:', 'background:', 'font-', 'width:', 'height:', 'display:', 'position:', 'flex', 'grid', '@media', 'body', '.class', '#id'];
    foreach ($codeIndicators as $indicator) {
        if (stripos($code, $indicator) !== false) {
            $hasCodeIndicators = true;
            break;
        }
    }

    // Check for common non-code phrases that indicate cheating
    $isLikelyCheating = false;
    $cheatingPhrases = ['إجابتي صحيحة', 'my answer is correct', 'my answer is right', 'الإجابة صحيحة', 'الكود صحيح', 'the code is correct', 'the code is right'];
    foreach ($cheatingPhrases as $phrase) {
        if (stripos($code, $phrase) !== false) {
            $isLikelyCheating = true;
            break;
        }
    }

    if ($isLikelyCheating || !$hasCodeIndicators) {
        echo json_encode([
            'success' => true,
            'ai_response' => 'يجب تقديم كود برمجي حقيقي لحل السؤال.',
            'verdict' => 'no',
            'hint' => 'اكتب كود برمجي يحل السؤال المطلوب، لا تكتب جمل مثل "إجابتي صحيحة".',
            'course_id' => $courseId,
            'assignment_id' => $assignmentId,
            'updated_completion' => false,
        ]);
        exit;
    }

    $prompt = "تحليل دقيق للكود - الطلب رقم " . time() . ":\n\n" .
        "السؤال: " . $question . "\n\n" .
        "الكود المقدم من المستخدم:\n```\n" . $code . "\n```\n\n" .
        "تعليمات التقييم الصارمة:\n" .
        "1. أولاً: تأكد أن النص المقدم هو كود برمجي حقيقي وليس نص عادي\n" .
        "2. إذا كان النص جمل مثل \"إجابتي صحيحة\" أو \"my answer is correct\" فهذا ليس كود برمجي\n" .
        "3. اقرأ السؤال بعناية وفهم المتطلبات البرمجية المطلوبة\n" .
        "4. قم بتحليل الكود البرمجي سطراً بسطر بعناية\n" .
        "5. تحقق من أن الكود يحل جميع المتطلبات المطلوبة بالضبط\n" .
        "6. تحقق من صحة المنطق والخوارزم بدقة\n" .
        "7. تحقق من معالجة الحالات الاستثنائية بشكل صحيح\n" .
        "8. تحقق من أن الكود يعمل بالطريقة المطلوبة تماماً دون أي نقص\n\n" .
        "قواعد التقييم الصارمة:\n" .
        "- إذا لم يكن النص كود برمجي حقيقي: verdict = \"no\"\n" .
        "- verdict = \"yes\" فقط إذا كان الكود البرمجي صحيحاً 100% ومكتملاً بالكامل\n" .
        "- verdict = \"no\" إذا كان هناك أي خطأ أو نقص أو عدم تطابق\n" .
        "- لا تتساهل أبداً في التقييم\n\n" .
        "الإجابة يجب أن تكون JSON فقط بدون أي نص إضافي:\n" .
        "{\"verdict\": \"yes\", \"hint\": \"\"}\n" .
        "أو\n" .
        "{\"verdict\": \"no\", \"hint\": \"وصف المشكلة بالتفصيل\"}\n\n" .
        "لا تكرر الكود أو السؤال في الرد.";
} else {
    $prompt = "المطلوب: أعطِ تلميحاً عربياً قصيراً جداً (سطر واحد) يساعد على حل السؤال دون كشف الحل.\n\nالسؤال:\n$question";
}

$payload = [
    'model' => 'qwen2.5-coder:0.5b',
    'messages' => [
        ['role' => 'system', 'content' => $isCodeCheck ? 'أنت مصحح كود صارم. لا تُرجِع إلا JSON المطلوب.' : 'أنت مساعد يقدم تلميحاً عربياً قصيراً جداً.'],
        ['role' => 'user', 'content' => $prompt],
    ],
    'stream' => false,
];

$ch = curl_init('http://localhost:11434/api/chat');
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POST => true,
    CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
    CURLOPT_POSTFIELDS => json_encode($payload),
    CURLOPT_TIMEOUT => 30,
]);

$response = curl_exec($ch);
if ($response === false) {
    http_response_code(502);
    echo json_encode(['success' => false, 'message' => 'تعذر الاتصال بـ Ollama. تأكد من تشغيل Ollama على http://localhost:11434']);
    curl_close($ch);
    exit;
}

$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($status < 200 || $status >= 300) {
    http_response_code(502);
    echo json_encode(['success' => false, 'message' => 'خدمة Ollama لم تُرجع استجابة صالحة.']);
    exit;
}

$decoded = json_decode($response, true);
$aiResponse = $decoded['message']['content'] ?? '';

if ($aiResponse === '') {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'تعذر استخراج الرد من النموذج.']);
    exit;
}

// Normalize output: for code checks enforce Yes/No + tiny hint
if ($isCodeCheck) {
    $verdict = null;
    $hintOut = '';

    // Try to parse strict JSON from model
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

    // Fallback heuristics if JSON missing
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

    $updatedCompletion = false;
    if ($verdict === 'yes' && $assignmentId) {
        try {
            $stmt = $pdo->prepare("INSERT INTO user_assignments (user_id, assignment_id, solution, score, status, is_completed, completed_at)
                VALUES (?, ?, ?, ?, 'graded', 1, CURRENT_TIMESTAMP)
                ON DUPLICATE KEY UPDATE solution = VALUES(solution), score = VALUES(score), status = 'graded', is_completed = 1, completed_at = CURRENT_TIMESTAMP");
            $stmt->execute([$_SESSION['user_id'], $assignmentId, $code, 100]);
            $updatedCompletion = true;
        } catch (Exception $e) {
            // ignore db error for this optional update
        }
    }

    echo json_encode([
        'success' => true,
        'ai_response' => $aiText,
        'verdict' => $verdict,
        'hint' => $verdict === 'no' ? $hintOut : '',
        'course_id' => $courseId,
        'assignment_id' => $assignmentId,
        'updated_completion' => $updatedCompletion,
    ]);
    exit;
}

// Hint-only mode: keep it short
$hintLine = trim(preg_replace('/\s+/', ' ', $aiResponse));
if (mb_strlen($hintLine, 'UTF-8') > 160) {
    $hintLine = mb_substr($hintLine, 0, 160, 'UTF-8');
}

echo json_encode([
    'success' => true,
    'ai_response' => 'تلميح: ' . $hintLine,
    'course_id' => $courseId,
    'assignment_id' => $assignmentId,
]);
?>