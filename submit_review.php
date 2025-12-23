<?php
// submit_review.php
// لا نستخدم session_start() لأننا نعتمد على JavaScript لتمرير user_id

header('Content-Type: application/json; charset=utf-8');

// تضمين ملف الاتصال بقاعدة البيانات
require 'db_connect.php';

// 1. استقبال user_id من البيانات المرسلة عبر JavaScript
$user_id = filter_input(INPUT_POST, 'user_id', FILTER_VALIDATE_INT);
$rating = filter_input(INPUT_POST, 'rating', FILTER_VALIDATE_INT);
$review_text = trim($_POST['review_text'] ?? '');

// 2. التحقق من هوية المستخدم (يجب أن يكون الـ ID صالحاً)
if ($user_id === false || $user_id < 1) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'لم يتم تحديد هوية المستخدم. يرجى تسجيل الدخول.']);
    exit();
}

// 3. التحقق من صحة المدخلات
if ($rating === false || $rating < 1 || $rating > 5) {
    echo json_encode(['success' => false, 'message' => 'التقييم غير صالح.']);
    exit();
}

if (empty($review_text) || strlen($review_text) > 500) {
    echo json_encode(['success' => false, 'message' => 'نص التقييم مطلوب ويجب ألا يتجاوز 500 حرف.']);
    exit();
}

try {
    // 4. إدخال التقييم في جدول academy_reviews باستخدام الـ ID المستلم
    $stmt = $pdo->prepare("INSERT INTO academy_reviews (user_id, rating, review_text) VALUES (?, ?, ?)");
    $stmt->execute([$user_id, $rating, $review_text]); 

    echo json_encode(['success' => true, 'message' => 'شكراً لك! تم إرسال تقييمك بنجاح.']);
    
} catch (PDOException $e) {
    // خطأ 500 في حال حدوث مشكلة في قاعدة البيانات
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في النظام أثناء حفظ التقييم. يرجى المحاولة لاحقاً.']);
}
?>