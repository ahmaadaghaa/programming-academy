<?php
// login_api.php

// تضمين ملف الاتصال بقاعدة البيانات
require 'db_connect.php'; 

// إعداد رؤوس الاستجابة
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // يجب تغيير هذا في بيئة الإنتاج
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// التعامل مع طلب OPTIONS المسبق
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

// 1. التحقق من طريقة الطلب (يجب أن تكون POST)
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit();
}

// 2. استقبال بيانات تسجيل الدخول
$input = file_get_contents('php://input');
$data = json_decode($input, true);

$identifier = $data['identifier'] ?? ''; // قد يكون اسم مستخدم أو بريد إلكتروني
$password = $data['password'] ?? '';

// 3. التحقق من البيانات الأساسية
if (empty($identifier) || empty($password)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'الرجاء إدخال اسم المستخدم وكلمة المرور.']);
    exit();
}

// 4. البحث عن المستخدم باستخدام البريد الإلكتروني أو اسم المستخدم (SQL Injection safe)
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? OR email = ?");
$stmt->execute([$identifier, $identifier]);
$user = $stmt->fetch();

if (!$user) {
    // المستخدم غير موجود
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'بيانات الاعتماد غير صحيحة.']);
    exit();
}

// 5. التحقق من كلمة المرور
// استخدام password_verify لمقارنة كلمة المرور المدخلة بالهاش المخزن
if (password_verify($password, $user['password'])) {
    
    // =========================================================
    // START: NEW ROLE FETCH LOGIC
    // ---------------------------------------------------------
    // استعلام لجلب أسماء الأدوار (roles) الخاصة بالمستخدم
    $role_stmt = $pdo->prepare('
        SELECT r.name 
        FROM user_roles ur
        JOIN roles r ON ur.role_id = r.id
        WHERE ur.user_id = ?
    ');
    $role_stmt->execute([$user['id']]);
    // جلب النتائج كعمود واحد (array of role names, e.g., ['student', 'admin'])
    $roles = $role_stmt->fetchAll(PDO::FETCH_COLUMN); 
    // ---------------------------------------------------------
    // END: NEW ROLE FETCH LOGIC
    // =========================================================

    // Get avatar if exists
    $avatar = null;
    if (!empty($user['avatar_data'])) {
        $avatar = 'data:' . $user['avatar_mime_type'] . ';base64,' . base64_encode($user['avatar_data']);
    }

  

    session_start(); 
    $_SESSION['user_id'] = $user['id']; 
    $_SESSION['roles'] = $roles; // <-- CRITICAL: Store the roles in the session

    // تسجيل الدخول ناجح
    http_response_code(200);
    
    // إرسال البيانات الأساسية التي ستحتاجها الواجهة الأمامية
    echo json_encode([
        'success' => true,
        'message' => 'تم تسجيل الدخول بنجاح!',
        'id' => $user['id'],
        'username' => $user['username'],
        'firstName' => $user['firstName'],
        'lastName' => $user['lastName'],
        'email' => $user['email'],
        'avatar' => $avatar,
    ]);
    
} else {
    // فشل التحقق من كلمة المرور
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'بيانات الاعتماد غير صحيحة.']);
}

// لا يوجد داعي لـ exit() هنا لأن البرنامج ينتهي بعد إرسال الـ JSON