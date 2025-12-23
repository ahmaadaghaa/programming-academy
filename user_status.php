<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Credentials: true');
session_start();

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false]);
    exit;
}

// Include database connection
require 'db_connect.php';

// Get user data
$user_id = $_SESSION['user_id'];
try {
    $stmt = $pdo->prepare("SELECT id, username, firstName, lastName, email, avatar_data, avatar_mime_type, preferred_language FROM users WHERE id = ?");
    $stmt->execute([$user_id]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    error_log("Database error in user_status.php: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Database error']);
    exit;
}

if ($user) {
    $avatar = null;
    if (!empty($user['avatar_data'])) {
        $avatar = 'data:' . $user['avatar_mime_type'] . ';base64,' . base64_encode($user['avatar_data']);
    }
    
    // Store or update language in session
    $_SESSION['language'] = $user['preferred_language'] ?? 'ar';
    
    echo json_encode([
        'success' => true,
        'user' => [
            'id' => $user['id'],
            'username' => $user['username'],
            'firstName' => $user['firstName'],
            'lastName' => $user['lastName'],
            'email' => $user['email'],
            'avatar' => $avatar,
            'language' => $user['preferred_language'] ?? 'ar'
        ]
    ]);
} else {
    echo json_encode(['success' => false]);
}
?>