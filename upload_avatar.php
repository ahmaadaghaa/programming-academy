<?php
// upload_avatar.php
require 'db_connect.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') exit;

session_start();
$userId = $_SESSION['user_id'] ?? ($_POST['user_id'] ?? null);
if (!$userId) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    exit();
}

// logging helper
function upload_log($msg) {
    $dir = __DIR__ . DIRECTORY_SEPARATOR . 'logs';
    if (!is_dir($dir)) @mkdir($dir, 0755, true);
    error_log("[upload_avatar] " . $msg . "\n", 3, $dir . DIRECTORY_SEPARATOR . 'upload_avatar.log');
}

if (!isset($_FILES['avatar'])) {
    upload_log('No file uploaded for userId=' . $userId);
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'No file uploaded']);
    exit();
}

$file = $_FILES['avatar'];
if ($file['error'] !== UPLOAD_ERR_OK) {
    upload_log('Upload error code=' . $file['error'] . ' for userId=' . $userId);
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Upload error']);
    exit();
}

// validate MIME type and size (limit to 5MB)
$finfo = new finfo(FILEINFO_MIME_TYPE);
$mime = $finfo->file($file['tmp_name']);
$allowed = ['image/jpeg'=>'jpg','image/png'=>'png','image/webp'=>'webp','image/gif'=>'gif'];
if (!isset($allowed[$mime])) {
    upload_log('Invalid MIME ' . $mime . ' for userId=' . $userId);
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Invalid image type']);
    exit();
}

if ($file['size'] > 5 * 1024 * 1024) {
    upload_log('File too large (' . $file['size'] . ') for userId=' . $userId);
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'File too large']);
    exit();
}

// create safe unique filename
$ext = $allowed[$mime];
$uploadsDir = __DIR__ . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'avatars' . DIRECTORY_SEPARATOR;
if (!is_dir($uploadsDir)) mkdir($uploadsDir, 0755, true);
// deterministic name to avoid DB schema changes and make lookup easy
$filename = 'avatar_' . $userId . '.' . $ext;
$destination = $uploadsDir . $filename;

// remove any existing avatars for this user (different extensions)
foreach (glob($uploadsDir . "avatar_{$userId}.*") as $old) {
    if (is_file($old)) @unlink($old);
}

if (!move_uploaded_file($file['tmp_name'], $destination)) {
    upload_log('Failed to move uploaded file to ' . $destination . ' for userId=' . $userId);
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Failed to move uploaded file']);
    exit();
}

// store mime type in DB (column avatar_mime_type exists in schema)
$relativePath = 'uploads/avatars/' . $filename;
try {
    // read file bytes
    $bytes = file_get_contents($destination);

    // update blob and mime type in DB; avatar_data column is expected to exist (LONGBLOB)
    $stmt = $pdo->prepare('UPDATE users SET avatar_mime_type = ?, avatar_data = ? WHERE id = ?');
    // bindValue is simpler for binary data
    $stmt->bindValue(1, $mime, PDO::PARAM_STR);
    $stmt->bindValue(2, $bytes, PDO::PARAM_LOB);
    $stmt->bindValue(3, $userId, PDO::PARAM_INT);
    $stmt->execute();

    upload_log('Avatar uploaded for userId=' . $userId . ' path=' . $relativePath . ' mime=' . $mime . ' size=' . strlen($bytes));

    echo json_encode(['success' => true, 'message' => 'Avatar uploaded', 'path' => $relativePath]);
} catch (PDOException $e) {
    upload_log('DB error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}

?>
