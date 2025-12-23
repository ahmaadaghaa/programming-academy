<?php
// get_avatar.php?user_id= or ?file=filename
// Serves avatar files with proper headers. Prefer using direct file URLs under uploads/, but this is a safe fallback.
if (isset($_GET['file'])) {
    $file = basename($_GET['file']);
    $path = __DIR__ . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'avatars' . DIRECTORY_SEPARATOR . $file;
    if (!file_exists($path)) {
        http_response_code(404);
        exit('Not found');
    }
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $mime = $finfo->file($path);
    header('Content-Type: ' . $mime);
    header('Cache-Control: public, max-age=604800');
    readfile($path);
    exit();
}

// optionally serve by user id
if (isset($_GET['user_id'])) {
    $id = (int)$_GET['user_id'];
    $uploadsDir = __DIR__ . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'avatars' . DIRECTORY_SEPARATOR;
    $found = null;
    foreach (glob($uploadsDir . "avatar_{$id}.*") as $f) {
        if (is_file($f)) { $found = $f; break; }
    }
    if (!$found) { http_response_code(404); exit('No avatar'); }
    $mime = (new finfo(FILEINFO_MIME_TYPE))->file($found);
    header('Content-Type: ' . $mime);
    header('Cache-Control: public, max-age=604800');
    readfile($found);
    exit();
}

http_response_code(400);
echo 'No file specified';

?>
