<?php
// profile_api.php
// CRUD endpoints for user profile (requires session)
require 'db_connect.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// debug log helper
function api_log($msg) {
    $dir = __DIR__ . DIRECTORY_SEPARATOR . 'logs';
    if (!is_dir($dir)) @mkdir($dir, 0755, true);
    error_log("[profile_api] " . $msg . "\n", 3, $dir . DIRECTORY_SEPARATOR . 'profile_api.log');
}

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

session_start();

// Simple auth: require session user_id or allow a test param ?user_id=
$userId = $_SESSION['user_id'] ?? ($_GET['user_id'] ?? null);
if (!$userId) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    exit();
}

try {
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        api_log('GET userId=' . $userId);
        // Read user profile
    $stmt = $pdo->prepare('SELECT id, firstName, lastName, email, phone, country, experience, goal, interest, joinDate FROM users WHERE id = ?');
        $stmt->execute([$userId]);
        $user = $stmt->fetch();
        if (!$user) {
            http_response_code(404);
            echo json_encode(['success' => false, 'message' => 'User not found']);
            exit();
        }

        // Attach avatar data from DB if present (avatar_data LONGBLOB)
    $stmt2 = $pdo->prepare('SELECT avatar_mime_type, avatar_data FROM users WHERE id = ?');
        $stmt2->execute([$userId]);
        $a = $stmt2->fetch();
        if ($a && $a['avatar_data']) {
            $b64 = base64_encode($a['avatar_data']);
            $user['avatar'] = 'data:' . ($a['avatar_mime_type'] ?? 'image/jpeg') . ';base64,' . $b64;
        } else {
            // fallback to file on disk
            $uploadsDir = __DIR__ . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'avatars' . DIRECTORY_SEPARATOR;
            $avatarFile = null;
            foreach (glob($uploadsDir . "avatar_{$userId}.*") as $f) { if (is_file($f)) { $avatarFile = $f; break; } }
            if ($avatarFile) $user['avatar'] = 'uploads/avatars/' . basename($avatarFile);
            else $user['avatar'] = null;
        }

        echo json_encode(['success' => true, 'user' => $user]);
        exit();
    }

    // Get JSON body
    $input = file_get_contents('php://input');
    $data = json_decode($input, true) ?: [];

    if ($_SERVER['REQUEST_METHOD'] === 'POST' || $_SERVER['REQUEST_METHOD'] === 'PUT') {
        // Password change flow if provided
        if (isset($data['currentPassword']) && isset($data['newPassword'])) {
            // Verify current password
            $stmt = $pdo->prepare('SELECT password FROM users WHERE id = ?');
            $stmt->execute([$userId]);
            $row = $stmt->fetch();
            if (!$row) {
                http_response_code(404);
                echo json_encode(['success' => false, 'message' => 'User not found']);
                exit();
            }
            if (!password_verify($data['currentPassword'], $row['password'])) {
                http_response_code(401);
                echo json_encode(['success' => false, 'message' => 'Current password is incorrect']);
                exit();
            }

            $newHash = password_hash($data['newPassword'], PASSWORD_BCRYPT);
            $stmt = $pdo->prepare('UPDATE users SET password = ? WHERE id = ?');
            $stmt->execute([$newHash, $userId]);
            echo json_encode(['success' => true, 'message' => 'Password updated']);
            exit();
        }

        // Update profile (partial updates allowed)
        $fields = [];
        $values = [];

    $allowed = ['firstName','lastName','email','phone','country','experience','goal','interest'];
        foreach ($allowed as $f) {
            if (isset($data[$f])) {
                $fields[] = "$f = ?";
                $values[] = $data[$f];
            }
        }

        if (count($fields) === 0) {
            echo json_encode(['success' => false, 'message' => 'No fields to update']);
            exit();
        }

        $values[] = $userId;
        $sql = 'UPDATE users SET ' . implode(', ', $fields) . ' WHERE id = ?';
        $stmt = $pdo->prepare($sql);
        $stmt->execute($values);

        echo json_encode(['success' => true, 'message' => 'Profile updated']);
        exit();
    }

    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        api_log('DELETE userId=' . $userId);
        // Delete account (dangerous) - remove DB row and avatar file
        // remove avatar files on disk
        $uploadsDir = __DIR__ . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'avatars' . DIRECTORY_SEPARATOR;
        foreach (glob($uploadsDir . "avatar_{$userId}.*") as $old) {
            if (is_file($old)) @unlink($old);
        }

        $stmt = $pdo->prepare('DELETE FROM users WHERE id = ?');
        $stmt->execute([$userId]);

        // Destroy session
        $_SESSION = [];
        if (ini_get('session.use_cookies')) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000,
                $params['path'], $params['domain'], $params['secure'], $params['httponly']
            );
        }
        session_destroy();

        echo json_encode(['success' => true, 'message' => 'Account deleted']);
        exit();
    }

    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}

?>
