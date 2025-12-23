<?php
// fetch_reviews.php
header('Content-Type: application/json; charset=utf-8');
require 'db_connect.php';

try {
    // [التعديل]: الآن نجلب user_id مباشرة بدلاً من الصورة
    $stmt = $pdo->prepare("
        SELECT 
            r.id, r.rating, r.review_text, 
            u.id AS user_id, u.firstName, u.lastName, u.interest
        FROM academy_reviews r
        JOIN users u ON r.user_id = u.id
        ORDER BY r.id DESC 
        LIMIT 6
    ");
    $stmt->execute();
    $reviews = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // لا حاجة لـ Base64 هنا. سنقوم ببناء مسار الصورة في JavaScript باستخدام user_id
    echo json_encode(['success' => true, 'reviews' => $reviews]);

} catch (PDOException $e) {
    http_response_code(500);
    error_log("Database Error in fetch_reviews.php: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في النظام.']);
}
?>