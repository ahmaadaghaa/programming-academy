<?php
// save_user_preferences.php - API to save user questionnaire preferences

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

session_start();
require 'db_connect.php';

// Check if user is logged in
$user_id = $_SESSION['user_id'] ?? null;
if (!$user_id) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'يجب تسجيل الدخول أولاً']);
    exit;
}

// Get preferences from request
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'بيانات غير صالحة']);
    exit;
}

// Validate user_id matches session
if ($input['user_id'] != $user_id) {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'غير مصرح لك']);
    exit;
}

try {
    // Prepare preferences data
    $preferences = [
        'user_id' => $user_id,
        'preferred_level' => $input['level'] ?? null,
        'preferred_language' => $input['language'] ?? null,
        'goals' => $input['goal'] ?? null,
        'time_commitment' => $input['time_commitment'] ?? null,
        'updated_at' => date('Y-m-d H:i:s')
    ];

    // Insert or update preferences
    $stmt = $pdo->prepare("
        INSERT INTO user_preferences (user_id, preferred_level, preferred_language, goals, time_commitment, updated_at)
        VALUES (?, ?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
            preferred_level = VALUES(preferred_level),
            preferred_language = VALUES(preferred_language),
            goals = VALUES(goals),
            time_commitment = VALUES(time_commitment),
            updated_at = VALUES(updated_at)
    ");

    $stmt->execute([
        $preferences['user_id'],
        $preferences['preferred_level'],
        $preferences['preferred_language'],
        $preferences['goals'],
        $preferences['time_commitment'],
        $preferences['updated_at']
    ]);

    echo json_encode([
        'success' => true,
        'message' => 'تم حفظ التفضيلات بنجاح'
    ]);

} catch (PDOException $e) {
    error_log('Database error in save_user_preferences.php: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'حدث خطأ في حفظ التفضيلات'
    ]);
}
?>