<?php
// check_availability_api.php

require 'db_connect.php'; // تضمين ملف الاتصال بقاعدة البيانات

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); 
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// التعامل مع طلب OPTIONS المسبق
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit();
}

// 1. استقبال البيانات (username, email, phone)
$input = file_get_contents('php://input');
$data = json_decode($input, true);

$username = isset($data['username']) ? trim($data['username']) : '';
$email = isset($data['email']) ? trim($data['email']) : '';
$phone = isset($data['phone']) ? trim($data['phone']) : '';

// 2. التحقق من التكرار في قاعدة البيانات
try {
    // Check each provided field individually so we can return which fields conflict
    $conflicts = [];
    if ($email !== '') {
        $stmt = $pdo->prepare('SELECT COUNT(*) FROM users WHERE email = ?');
        $stmt->execute([$email]);
        if ($stmt->fetchColumn() > 0) $conflicts[] = 'email';
    }
    if ($username !== '') {
        $stmt = $pdo->prepare('SELECT COUNT(*) FROM users WHERE username = ?');
        $stmt->execute([$username]);
        if ($stmt->fetchColumn() > 0) $conflicts[] = 'username';
    }
    if ($phone !== '') {
        $stmt = $pdo->prepare('SELECT COUNT(*) FROM users WHERE phone = ?');
        $stmt->execute([$phone]);
        if ($stmt->fetchColumn() > 0) $conflicts[] = 'phone';
    }

    if (count($conflicts) > 0) {
        http_response_code(409);
        $msgParts = [];
        if (in_array('email', $conflicts)) $msgParts[] = 'البريد الإلكتروني';
        if (in_array('username', $conflicts)) $msgParts[] = 'اسم المستخدم';
        if (in_array('phone', $conflicts)) $msgParts[] = 'رقم الهاتف';
        $message = implode('، ', $msgParts) . ' مسجل بالفعل. الرجاء اختيار قيمة أخرى.';
        echo json_encode(['success' => false, 'message' => $message, 'fields' => $conflicts]);
        exit();
    }
    
    // إذا وصل هنا، فكل شيء متاح
    http_response_code(200);
    echo json_encode(['success' => true, 'message' => 'البيانات متوفرة. يمكنك المتابعة.']);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في قاعدة البيانات أثناء التحقق.']);
    exit();
}