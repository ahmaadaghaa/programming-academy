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
$token = trim($input['token'] ?? '');
$password = $input['password'] ?? '';

if (empty($token) || empty($password)) {
    echo json_encode(['success' => false, 'message' => 'بيانات غير مكتملة']);
    exit;
}

if (strlen($password) < 6) {
    echo json_encode(['success' => false, 'message' => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل']);
    exit;
}

// Check token
$stmt = $pdo->prepare("SELECT email FROM password_resets WHERE token = ? AND expires_at > NOW()");
$stmt->execute([$token]);
$reset = $stmt->fetch();

if (!$reset) {
    echo json_encode(['success' => false, 'message' => 'الرابط غير صحيح أو منتهي الصلاحية']);
    exit;
}

$email = $reset['email'];
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

// Update password
$stmt = $pdo->prepare("UPDATE users SET password = ? WHERE email = ?");
$stmt->execute([$hashed_password, $email]);

// Delete token
$stmt = $pdo->prepare("DELETE FROM password_resets WHERE token = ?");
$stmt->execute([$token]);

echo json_encode(['success' => true, 'message' => 'تم إعادة تعيين كلمة المرور بنجاح']);
?>