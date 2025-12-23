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
if (!$input && $_SERVER['REQUEST_METHOD'] === 'POST') {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'بيانات JSON غير صحيحة']);
    exit;
}

// For GET requests or debugging, provide a simple response
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    echo json_encode(['success' => false, 'message' => 'طريقة طلب غير مدعومة. استخدم POST.']);
    exit;
}

$mode = isset($input['mode']) ? $input['mode'] : 'user_message';
$question = isset($input['question']) ? trim($input['question']) : '';
$code = isset($input['code']) ? trim($input['code']) : '';
$challengeId = isset($input['challenge_id']) ? (int)$input['challenge_id'] : null;
$userMessage = isset($input['user_message']) ? trim($input['user_message']) : '';

if ($mode === 'solution') {
    $prompt = "أعطِ الحل الكامل والصحيح لهذا التحدي البرمجي. أعد الكود فقط بدون أي شرح أو تعليقات إضافية.\n\nالتحدي:\n$question";

    $payload = [
        'model' => 'qwen2.5-coder:0.5b',
        'messages' => [
            ['role' => 'system', 'content' => 'أنت معلم برمجة. قدم الكود فقط بدون أي شرح أو تعليقات إضافية.'],
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
        CURLOPT_TIMEOUT => 60, // Increased timeout for solution generation
        CURLOPT_CONNECTTIMEOUT => 5, // Connection timeout
    ]);

    $response = curl_exec($ch);
    if ($response === false) {
        $curlError = curl_error($ch);
        curl_close($ch);
        http_response_code(502);
        echo json_encode(['success' => false, 'message' => 'تعذر الاتصال بـ Ollama: ' . $curlError]);
        exit;
    }

    $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($status < 200 || $status >= 300) {
        http_response_code(502);
        echo json_encode(['success' => false, 'message' => 'خدمة Ollama غير متاحة (رمز الخطأ: ' . $status . ')']);
        exit;
    }

    $decoded = json_decode($response, true);
    $aiResponse = $decoded['message']['content'] ?? '';

    if ($aiResponse === '') {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'تعذر استخراج الرد من النموذج.']);
        exit;
    }

    echo json_encode([
        'success' => true,
        'ai_response' => trim($aiResponse),
        'challenge_id' => $challengeId,
    ]);
    exit;
}

if ($mode === 'verify') {
    // Get challenge details including points
    $challengeStmt = $pdo->prepare("SELECT points, description FROM challenges WHERE id = ?");
    $challengeStmt->execute([$challengeId]);
    $challenge = $challengeStmt->fetch(PDO::FETCH_ASSOC);

    if (!$challenge) {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'التحدي غير موجود']);
        exit;
    }

    $challengePoints = (int)$challenge['points'];
    $challengeDescription = $challenge['description'];

    // Validate that there's actual code, not just text
    $code = trim($code);
    if (empty($code)) {
        echo json_encode([
            'success' => true,
            'ai_response' => 'يرجى كتابة كود برمجي لحل التحدي.',
            'verdict' => 'no',
            'hint' => 'يجب تقديم كود برمجي صحيح، لا يمكن قبول نص عادي.',
            'challenge_id' => $challengeId,
            'updated_completion' => false,
        ]);
        exit;
    }

    // Basic code validation - check for programming constructs
    $hasCodeIndicators = false;
    $codeIndicators = ['function', 'def ', 'class ', 'if ', 'for ', 'while ', 'print', 'console.log', 'return ', 'var ', 'let ', 'const ', 'int ', 'string ', 'public ', 'private ', '#include', 'import '];
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
            'ai_response' => 'يجب تقديم كود برمجي حقيقي لحل التحدي.',
            'verdict' => 'no',
            'hint' => 'اكتب كود برمجي يحل التحدي المطلوب، لا تكتب جمل مثل "إجابتي صحيحة".',
            'challenge_id' => $challengeId,
            'updated_completion' => false,
        ]);
        exit;
    }

    $prompt = "تحليل دقيق للكود - الطلب رقم " . time() . ":\n\n" .
        "السؤال/التحدي: " . $challengeDescription . "\n\n" .
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
        "{\"verdict\": \"no\", \"hint\": \"وصف المشكلة بالتفصيل\"}";

    $payload = [
        'model' => 'qwen2.5-coder:0.5b',
        'messages' => [
            ['role' => 'system', 'content' => 'أنت خبير برمجة صارم ودقيق. مهمتك تقييم ما إذا كان الكود المقدم يحل التحدي المطلوب بالكامل. يجب أن تكون حازماً ولا تتساهل في التقييم.'],
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
        echo json_encode(['success' => false, 'message' => 'تعذر الاتصال بـ Ollama.']);
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

    // Parse verdict
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

    // If JSON parsing failed, try to extract from text
    if ($verdict === null) {
        // Look for explicit verdict in the text
        if (preg_match('/"verdict"\s*:\s*"([^"]+)"/i', $aiResponse, $matches)) {
            $v = strtolower(trim($matches[1]));
            if ($v === 'yes' || $v === 'no') {
                $verdict = $v;
                // Try to extract hint too
                if (preg_match('/"hint"\s*:\s*"([^"]*)"/i', $aiResponse, $hintMatches)) {
                    $hintOut = trim($hintMatches[1]);
                }
            }
        }
    }

    // Fallback - improved text analysis
    if ($verdict === null) {
        $lower = mb_strtolower($aiResponse, 'UTF-8');

        // Check for explicit verdict patterns first
        if (preg_match('/verdict.*?(yes|no)/i', $lower, $matches)) {
            $verdict = strtolower($matches[1]);
        } elseif (preg_match('/(yes|no).*?verdict/i', $lower, $matches)) {
            $verdict = strtolower($matches[1]);
        }

        // If no explicit verdict, be very strict - default to 'no'
        if ($verdict === null) {
            // Only accept very clear positive indicators, otherwise default to 'no'
            $hasClearPositive = strpos($lower, 'verdict') !== false &&
                               (strpos($lower, '"yes"') !== false || strpos($lower, 'نعم') !== false) &&
                               strpos($lower, '"no"') === false && strpos($lower, 'لا') === false;

            if ($hasClearPositive) {
                $verdict = 'yes';
            } else {
                $verdict = 'no'; // Default to 'no' for safety
            }
        }

        // Extract hint for 'no' verdicts
        if ($verdict === 'no') {
            $hintOut = trim(preg_replace('/\{.*\}/s', '', $aiResponse));
            // Remove any verdict-related text
            $hintOut = preg_replace('/verdict.*?(yes|no)/i', '', $hintOut);
            $hintOut = preg_replace('/(yes|no).*?verdict/i', '', $hintOut);
            $hintOut = trim($hintOut);

            // Get first meaningful sentence
            $sentences = preg_split('/[\.!؟\n]/u', $hintOut);
            foreach ($sentences as $sentence) {
                $sentence = trim($sentence);
                if (!empty($sentence) && strlen($sentence) > 10) {
                    $hintOut = $sentence;
                    break;
                }
            }

            $hintOut = mb_substr($hintOut, 0, 120, 'UTF-8');
            if (empty($hintOut)) {
                $hintOut = 'راجع الكود وتأكد من أنه يحل جميع متطلبات التحدي';
            }
        }
    }

    $aiText = $verdict === 'yes' ? 'ممتاز! الحل صحيح تماماً.' : ('الحل غير مكتمل — تلميح: ' . ($hintOut !== '' ? $hintOut : 'راجع متطلبات التحدي'));

    $updatedCompletion = false;
    if ($verdict === 'yes' && $challengeId) {
        try {
            $stmt = $pdo->prepare("INSERT INTO user_challenges (user_id, challenge_id, attempts, completed, best_score, last_attempted)
                VALUES (?, ?, 1, 1, ?, CURRENT_TIMESTAMP)
                ON DUPLICATE KEY UPDATE attempts = attempts + 1, completed = 1, best_score = GREATEST(best_score, ?), last_attempted = CURRENT_TIMESTAMP");
            $stmt->execute([$_SESSION['user_id'], $challengeId, $challengePoints, $challengePoints]);
            $updatedCompletion = true;
        } catch (Exception $e) {
            // ignore db error for this optional update
        }
    } elseif ($challengeId) {
        // Even if not completed, increment attempts
        try {
            $stmt = $pdo->prepare("INSERT INTO user_challenges (user_id, challenge_id, attempts, completed, last_attempted)
                VALUES (?, ?, 1, 0, CURRENT_TIMESTAMP)
                ON DUPLICATE KEY UPDATE attempts = attempts + 1, last_attempted = CURRENT_TIMESTAMP");
            $stmt->execute([$_SESSION['user_id'], $challengeId]);
        } catch (Exception $e) {
            // ignore db error
        }
    }

    echo json_encode([
        'success' => true,
        'ai_response' => $aiText,
        'verdict' => $verdict,
        'hint' => $verdict === 'no' ? $hintOut : '',
        'challenge_id' => $challengeId,
        'updated_completion' => $updatedCompletion,
        'debug' => [
            'raw_ai_response' => $aiResponse,
            'challenge_points' => $challengePoints,
            'challenge_description' => $challengeDescription,
            'user_code' => $code,
            'parsing_steps' => [
                'json_found' => ($jsonStart !== false && $jsonEnd !== false),
                'regex_verdict_found' => preg_match('/"verdict"\s*:\s*"([^"]+)"/i', $aiResponse, $matches),
                'final_verdict_method' => $verdict === 'yes' ? 'positive' : 'negative'
            ],
            'prompt_sent' => $prompt
        ]
    ]);
    exit;
}

if ($userMessage !== '') {
    // General chat with AI assistant
    $context = "أنت مساعد ذكي لمطوري البرمجة. المستخدم يعمل على تحدي برمجي. سؤال التحدي: $question\n";
    if ($code !== '') {
        $context .= "الكود الحالي:\n$code\n";
    }
    $context .= "رسالة المستخدم: $userMessage";

    $payload = [
        'model' => 'qwen2.5-coder:0.5b',
        'messages' => [
            ['role' => 'system', 'content' => 'أنت مساعد برمجة مفيد وودود. أجب بالعربية وكن مفيداً.'],
            ['role' => 'user', 'content' => $context],
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
        echo json_encode(['success' => false, 'message' => 'تعذر الاتصال بـ Ollama.']);
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

    echo json_encode([
        'success' => true,
        'ai_response' => trim($aiResponse),
        'challenge_id' => $challengeId,
    ]);
    exit;
}

// Default hint mode for challenges
$prompt = "أعطِ تلميحاً عربياً قصيراً جداً (سطر واحد) يساعد على حل تحدي البرمجة دون كشف الحل الكامل.\n\nالتحدي:\n$question";

$payload = [
    'model' => 'qwen2.5-coder:0.5b',
    'messages' => [
        ['role' => 'system', 'content' => 'أنت مساعد يقدم تلميحاً عربياً قصيراً جداً لتحديات البرمجة.'],
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
    CURLOPT_TIMEOUT => 15, // Reduced timeout
    CURLOPT_CONNECTTIMEOUT => 5, // Connection timeout
]);

$response = curl_exec($ch);
if ($response === false) {
    $curlError = curl_error($ch);
    curl_close($ch);
    http_response_code(502);
    echo json_encode(['success' => false, 'message' => 'تعذر الاتصال بـ Ollama: ' . $curlError]);
    exit;
}

$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($status < 200 || $status >= 300) {
    http_response_code(502);
    echo json_encode(['success' => false, 'message' => 'خدمة Ollama غير متاحة (رمز الخطأ: ' . $status . ')']);
    exit;
}

$decoded = json_decode($response, true);
$aiResponse = $decoded['message']['content'] ?? '';

if ($aiResponse === '') {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'تعذر استخراج الرد من النموذج.']);
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
    'challenge_id' => $challengeId,
]);
?>