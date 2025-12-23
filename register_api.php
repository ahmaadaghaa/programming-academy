<?php
// register_api.php
require 'db_connect.php'; // Include the database connection

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // IMPORTANT: Adjust this in production for security
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

// Only proceed if it is a POST request
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
    exit();
}

// 1. Get and decode the JSON data sent from the front-end
$input = file_get_contents('php://input');
$data = json_decode($input, true);

// 2. Basic Validation & Data Preparation
if (
    !isset($data['firstName'], $data['lastName'], $data['email'], $data['username'], $data['password']) ||
    empty($data['firstName']) || empty($data['email']) || empty($data['username']) || empty($data['password'])
) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'الرجاء ملء جميع الحقول المطلوبة.']);
    exit();
}

$firstName = trim($data['firstName']);
$lastName = trim($data['lastName']);
$email = trim($data['email']);
$phone = $data['phone'] ?? null;
$username = trim($data['username']);
$password = $data['password'];
$country = $data['country'] ?? null;
$experience = $data['experience'] ?? null;
$goal = $data['goal'] ?? null;
$interest = $data['interest'] ?? null;

// 3. Securely Hash the Password
$hashedPassword = password_hash($password, PASSWORD_BCRYPT);

// 4. Check for existing user (username, email, OR phone)
try {
    // تحديث استعلام SQL ليشمل التحقق من رقم الهاتف
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM users WHERE email = ? OR username = ? OR phone = ?");
    
    // إضافة $phone إلى مصفوفة التنفيذ
    $stmt->execute([$email, $username, $phone]); 
    
    if ($stmt->fetchColumn() > 0) {
        http_response_code(409); // Conflict
        // تحديث رسالة الخطأ لتكون أكثر شمولاً
        echo json_encode(['success' => false, 'message' => 'اسم المستخدم أو البريد الإلكتروني أو رقم الهاتف مسجل بالفعل. الرجاء اختيار بيانات أخرى.']);
        exit();
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database error during check: ' . $e->getMessage()]);
    exit();
}

// 5. Insert New User Data
try {
    $sql = "INSERT INTO users (firstName, lastName, email, phone, username, password, country, experience, goal, interest) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    $stmt = $pdo->prepare($sql);
    
    $stmt->execute([
        $firstName, 
        $lastName, 
        $email, 
        $phone, 
        $username, 
        $hashedPassword, // Store the HASHED password
        $country, 
        $experience, 
        $goal, 
        $interest
    ]);
    
    // Registration successful
    http_response_code(201); // Created
    echo json_encode([
        'success' => true, 
        'message' => 'تم إنشاء الحساب بنجاح!',
        'userId' => $pdo->lastInsertId(),
        'username' => $username,
        'firstName' => $firstName
    ]);

} catch (PDOException $e) {
    // Registration failed
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'فشل إنشاء الحساب: ' . $e->getMessage()]);
}
?>