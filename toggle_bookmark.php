<?php
// toggle_bookmark.php - API for toggling platform bookmarks

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

session_start();
require 'db_connect.php';

// Get user_id from session or from request (fallback for when session is not maintained)
$user_id = $_SESSION['user_id'] ?? null;

// If no session user_id, try to get it from the request (like submit_review.php does)
if (!$user_id) {
    $input = json_decode(file_get_contents('php://input'), true);
    $user_id = $input['user_id'] ?? null;
}

if (!$user_id) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'يجب تسجيل الدخول أولاً']);
    exit;
}
$input = json_decode(file_get_contents('php://input'), true);

$platform_id = $input['platform_id'] ?? null;
$action = $input['action'] ?? null;

// Validate input
if (!$platform_id || !is_numeric($platform_id)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'معرف المنصة غير صالح']);
    exit;
}

// Check if platform exists
$stmt = $pdo->prepare("SELECT id FROM platforms WHERE id = ? AND is_active = 1");
$stmt->execute([$platform_id]);
if ($stmt->rowCount() === 0) {
    http_response_code(404);
    echo json_encode(['success' => false, 'message' => 'المنصة غير موجودة']);
    exit;
}

try {
    if ($action === 'add') {
        // Add bookmark
        $stmt = $pdo->prepare("INSERT IGNORE INTO platform_bookmarks (user_id, platform_id) VALUES (?, ?)");
        $stmt->execute([$user_id, $platform_id]);
        echo json_encode(['success' => true, 'message' => 'تم إضافة المنصة للمفضلة']);
    } elseif ($action === 'remove') {
        // Remove bookmark
        $stmt = $pdo->prepare("DELETE FROM platform_bookmarks WHERE user_id = ? AND platform_id = ?");
        $stmt->execute([$user_id, $platform_id]);
        echo json_encode(['success' => true, 'message' => 'تم إزالة المنصة من المفضلة']);
    } else {
        // Toggle bookmark (check current state and do opposite)
        $stmt = $pdo->prepare("SELECT id FROM platform_bookmarks WHERE user_id = ? AND platform_id = ?");
        $stmt->execute([$user_id, $platform_id]);
        $exists = $stmt->rowCount() > 0;

        if ($exists) {
            // Remove bookmark
            $stmt = $pdo->prepare("DELETE FROM platform_bookmarks WHERE user_id = ? AND platform_id = ?");
            $stmt->execute([$user_id, $platform_id]);
            echo json_encode(['success' => true, 'message' => 'تم إزالة المنصة من المفضلة']);
        } else {
            // Add bookmark
            $stmt = $pdo->prepare("INSERT INTO platform_bookmarks (user_id, platform_id) VALUES (?, ?)");
            $stmt->execute([$user_id, $platform_id]);
            echo json_encode(['success' => true, 'message' => 'تم إضافة المنصة للمفضلة']);
        }
    }

} catch (PDOException $e) {
    error_log('Database error in toggle_bookmark.php: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في النظام، يرجى المحاولة لاحقاً']);
}
?>