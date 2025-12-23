<?php
// rate_platform.php - API for users to rate platforms

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

// If no session user_id, try to get it from the request
if (!$user_id) {
    $user_id = filter_input(INPUT_POST, 'user_id', FILTER_VALIDATE_INT);
}

if (!$user_id) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'يجب تسجيل الدخول أولاً']);
    exit;
}
$platform_id = filter_input(INPUT_POST, 'platform_id', FILTER_VALIDATE_INT);
$rating = filter_input(INPUT_POST, 'rating', FILTER_VALIDATE_INT);

// Validate input
if (!$platform_id || !$rating || $rating < 1 || $rating > 5) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'البيانات المرسلة غير صالحة']);
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
    // Insert or update rating using ON DUPLICATE KEY UPDATE
    $stmt = $pdo->prepare("
        INSERT INTO platform_ratings (user_id, platform_id, rating)
        VALUES (?, ?, ?)
        ON DUPLICATE KEY UPDATE rating = VALUES(rating), created_at = CURRENT_TIMESTAMP
    ");
    $stmt->execute([$user_id, $platform_id, $rating]);

    // Update the average rating for the platform
    $stmt = $pdo->prepare("
        UPDATE platforms
        SET rating = (
            SELECT COALESCE(AVG(rating), 0)
            FROM platform_ratings
            WHERE platform_id = ?
        )
        WHERE id = ?
    ");
    $stmt->execute([$platform_id, $platform_id]);

    // Get the updated average rating and count
    $stmt = $pdo->prepare("
        SELECT 
            COALESCE(AVG(rating), 0) as avg_rating,
            COUNT(*) as rating_count
        FROM platform_ratings 
        WHERE platform_id = ?
    ");
    $stmt->execute([$platform_id]);
    $rating_data = $stmt->fetch(PDO::FETCH_ASSOC);

    echo json_encode([
        'success' => true,
        'message' => 'تم حفظ تقييمك بنجاح',
        'rating' => $rating,
        'avg_rating' => floatval($rating_data['avg_rating']),
        'rating_count' => intval($rating_data['rating_count'])
    ]);

} catch (PDOException $e) {
    error_log('Database error in rate_platform.php: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في النظام، يرجى المحاولة لاحقاً']);
}
?>