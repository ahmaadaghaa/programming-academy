<?php
// admin_challenges.php - API for managing challenges
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, PATCH, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

session_start();

// Admin authentication check
if (!isset($_SESSION['user_id']) || !isset($_SESSION['roles']) || !in_array('admin', $_SESSION['roles'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'غير مصرح لك بالوصول - يرجى تسجيل الدخول كمدير']);
    exit;
}

require 'db_connect.php';

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];

try {
    switch ($method) {
        case 'GET':
            if (isset($_GET['id'])) {
                // Get single challenge
                getChallenge($_GET['id']);
            } else {
                // Get all challenges
                getChallenges();
            }
            break;

        case 'POST':
            // Add new challenge
            addChallenge();
            break;

        case 'PUT':
            // Update challenge
            updateChallenge();
            break;

        case 'DELETE':
            // Delete challenge
            deleteChallenge();
            break;

        case 'PATCH':
            // Toggle challenge status
            toggleChallengeStatus();
            break;

        default:
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'طريقة غير مدعومة']);
            break;
    }
} catch (Exception $e) {
    error_log("Error in admin_challenges.php: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في الخادم']);
}

function getChallenges() {
    global $pdo;

    try {
        $stmt = $pdo->query("SELECT * FROM challenges ORDER BY created_at DESC");
        $challenges = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode(['success' => true, 'challenges' => $challenges]);
    } catch (Exception $e) {
        error_log("Error in getChallenges: " . $e->getMessage());
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'حدث خطأ في استرجاع التحديات']);
    }
}

function getChallenge($id) {
    global $pdo;

    $stmt = $pdo->prepare("SELECT * FROM challenges WHERE id = ?");
    $stmt->execute([$id]);
    $challenge = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($challenge) {
        echo json_encode(['success' => true, 'challenge' => $challenge]);
    } else {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'التحدي غير موجود']);
    }
}

function addChallenge() {
    global $pdo;

    $data = json_decode(file_get_contents('php://input'), true);

    if (!$data) {
        error_log("Invalid JSON data received: " . file_get_contents('php://input'));
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'بيانات غير صالحة']);
        return;
    }

    error_log("Received data: " . json_encode($data));

    // Validate required fields
    $required = ['title', 'description', 'category', 'difficulty', 'points'];
    foreach ($required as $field) {
        if (!isset($data[$field]) || empty($data[$field])) {
            error_log("Missing required field: $field");
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => "الحقل $field مطلوب"]);
            return;
        }
    }

    try {
        // Handle test_cases - ensure it's valid JSON or null
        $test_cases = null;
        if (isset($data['test_cases'])) {
            $test_cases_candidate = trim($data['test_cases']);
            if (!empty($test_cases_candidate)) {
                $decoded = json_decode($test_cases_candidate);
                if (json_last_error() === JSON_ERROR_NONE) {
                    $test_cases = $test_cases_candidate;
                } else {
                    error_log("Invalid JSON in test_cases: " . $test_cases_candidate);
                    http_response_code(400);
                    echo json_encode(['success' => false, 'message' => 'حالات الاختبار يجب أن تكون بتنسيق JSON صالح']);
                    return;
                }
            }
        }

        // Ensure points is an integer
        $points = isset($data['points']) ? (int)$data['points'] : 0;

        $stmt = $pdo->prepare("INSERT INTO challenges (title, description, category, difficulty, points, code_language, test_cases, solution_template) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $result = $stmt->execute([
            $data['title'],
            $data['description'],
            $data['category'],
            $data['difficulty'],
            $points,
            $data['code_language'] ?? null,
            $test_cases,
            $data['solution_template'] ?? null
        ]);

        if ($result) {
            echo json_encode(['success' => true, 'message' => 'تم إضافة التحدي بنجاح']);
        } else {
            error_log("Database insertion failed");
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'فشل في إضافة التحدي']);
        }
    } catch (Exception $e) {
        error_log("Database error: " . $e->getMessage());
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'خطأ في قاعدة البيانات: ' . $e->getMessage()]);
    }
}

function updateChallenge() {
    global $pdo;

    $data = json_decode(file_get_contents('php://input'), true);

    if (!$data || !isset($data['id'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'بيانات غير صالحة']);
        return;
    }

    // Validate required fields
    $required = ['title', 'description', 'category', 'difficulty', 'points'];
    foreach ($required as $field) {
        if (!isset($data[$field]) || empty($data[$field])) {
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => "الحقل $field مطلوب"]);
            return;
        }
    }

    $stmt = $pdo->prepare("UPDATE challenges SET title = ?, description = ?, category = ?, difficulty = ?, points = ?, code_language = ?, test_cases = ?, solution_template = ? WHERE id = ?");
    $result = $stmt->execute([
        $data['title'],
        $data['description'],
        $data['category'],
        $data['difficulty'],
        $data['points'],
        $data['code_language'] ?? null,
        $data['test_cases'] ?? null,
        $data['solution_template'] ?? null,
        $data['id']
    ]);

    if ($result) {
        echo json_encode(['success' => true, 'message' => 'تم تحديث التحدي بنجاح']);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'فشل في تحديث التحدي']);
    }
}

function deleteChallenge() {
    global $pdo;

    if (!isset($_GET['id'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'معرف التحدي مطلوب']);
        return;
    }

    $stmt = $pdo->prepare("DELETE FROM challenges WHERE id = ?");
    $result = $stmt->execute([$_GET['id']]);

    if ($result) {
        echo json_encode(['success' => true, 'message' => 'تم حذف التحدي نهائياً من قاعدة البيانات']);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'فشل في حذف التحدي']);
    }
}

function toggleChallengeStatus() {
    global $pdo;

    $data = json_decode(file_get_contents('php://input'), true);

    if (!$data || !isset($data['id']) || !isset($data['is_active'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'بيانات غير صالحة']);
        return;
    }

    $stmt = $pdo->prepare("UPDATE challenges SET is_active = ? WHERE id = ?");
    $result = $stmt->execute([$data['is_active'], $data['id']]);

    if ($result) {
        echo json_encode(['success' => true, 'message' => 'تم تحديث حالة التحدي بنجاح']);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'فشل في تحديث حالة التحدي']);
    }
}
?>