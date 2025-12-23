<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
session_start();
require 'db_connect.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'طريقة الطلب غير مسموحة']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
$email = trim($input['email'] ?? '');

if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(['success' => false, 'message' => 'يرجى إدخال بريد إلكتروني صحيح']);
    exit;
}

// Check if email exists
$stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
$stmt->execute([$email]);
$user = $stmt->fetch();

if (!$user) {
    // Don't reveal if email exists or not for security
    echo json_encode(['success' => true, 'message' => 'تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني إذا كان مسجلاً']);
    exit;
}

// Generate token
$token = bin2hex(random_bytes(32));
$expires_at = (new DateTime('+1 hour'))->format('Y-m-d H:i:s');

// Insert or update token
$stmt = $pdo->prepare("INSERT INTO password_resets (email, token, expires_at) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE token = VALUES(token), expires_at = VALUES(expires_at)");
$stmt->execute([$email, $token, $expires_at]);

// Send email
$reset_link = "http://localhost/programming-academy/reset-password.html?token=" . $token;
$subject = "إعادة تعيين كلمة المرور - أكاديمية البرمجة";
$message = "
مرحباً،

لقد طلبت إعادة تعيين كلمة المرور لحسابك في أكاديمية البرمجة.

انقر على الرابط التالي لإعادة تعيين كلمة المرور:
$reset_link

هذا الرابط صالح لمدة ساعة واحدة.

إذا لم تطلب هذا، يرجى تجاهل هذا البريد.

مع خالص التحية،
فريق أكاديمية البرمجة
";

$headers = "From: no-reply@programming-academy.com\r\n";
$headers .= "Content-Type: text/plain; charset=UTF-8\r\n";

if (mail($email, $subject, $message, $headers)) {
    echo json_encode(['success' => true, 'message' => 'تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني']);
} else {
    echo json_encode(['success' => false, 'message' => 'فشل في إرسال البريد الإلكتروني. حاول مرة أخرى لاحقاً']);
}
?>