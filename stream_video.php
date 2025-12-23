<?php
// stream_video.php - Professional video streaming with range request support
session_start();
require 'db_connect.php';

// Security: Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    die('Unauthorized access');
}

$userId = $_SESSION['user_id'];
$lessonId = $_GET['lesson_id'] ?? null;

if (!$lessonId) {
    http_response_code(400);
    die('Missing lesson_id parameter');
}

try {
    // Fetch lesson video path
    $stmt = $pdo->prepare('SELECT video_data, video_mime, title FROM lessons WHERE id = ?');
    $stmt->execute([$lessonId]);
    $lesson = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$lesson) {
        http_response_code(404);
        die('Video not found');
    }
    
    // Build full path to video file
    $videoPath = __DIR__ . DIRECTORY_SEPARATOR . $lesson['video_data'];
    
    // Security: Prevent directory traversal
    $videoPath = realpath($videoPath);
    $basePath = realpath(__DIR__ . DIRECTORY_SEPARATOR . 'videos');
    
    if (!$videoPath || strpos($videoPath, $basePath) !== 0) {
        http_response_code(403);
        die('Access denied');
    }
    
    if (!file_exists($videoPath)) {
        http_response_code(404);
        die('Video file not found on server');
    }
    
    // Get file info
    $fileSize = filesize($videoPath);
    $mimeType = $lesson['video_mime'] ?: 'video/mp4';
    
    // Range request support
    $start = 0;
    $end = $fileSize - 1;
    $length = $fileSize;
    
    // Check if client sent Range header
    if (isset($_SERVER['HTTP_RANGE'])) {
        $range = $_SERVER['HTTP_RANGE'];
        
        // Parse range header (format: "bytes=start-end")
        if (preg_match('/bytes=(\d+)-(\d*)/', $range, $matches)) {
            $start = intval($matches[1]);
            $end = $matches[2] !== '' ? intval($matches[2]) : $end;
            
            // Validate range
            if ($start > $end || $start >= $fileSize) {
                http_response_code(416); // Range Not Satisfiable
                header("Content-Range: bytes */$fileSize");
                exit;
            }
            
            $length = $end - $start + 1;
            http_response_code(206); // Partial Content
            header("Content-Range: bytes $start-$end/$fileSize");
        }
    }
    
    // Set headers for streaming
    header("Content-Type: $mimeType");
    header("Content-Length: $length");
    header("Accept-Ranges: bytes");
    header("Cache-Control: no-store, no-cache, must-revalidate");
    header("Pragma: no-cache");
    header("Expires: 0");
    header("Content-Disposition: inline; filename=\"" . basename($videoPath) . "\"");
    header("X-Content-Type-Options: nosniff");
    
    // Open file and seek to start position
    $fp = fopen($videoPath, 'rb');
    if (!$fp) {
        http_response_code(500);
        die('Could not open video file');
    }
    
    fseek($fp, $start);
    
    // Stream video in chunks
    $bufferSize = 8192; // 8KB chunks
    $bytesRemaining = $length;
    
    while (!feof($fp) && $bytesRemaining > 0 && connection_status() == 0) {
        $readSize = min($bufferSize, $bytesRemaining);
        echo fread($fp, $readSize);
        flush();
        $bytesRemaining -= $readSize;
    }
    
    fclose($fp);
    exit;
    
} catch (PDOException $e) {
    error_log("Video streaming error: " . $e->getMessage());
    http_response_code(500);
    die('Database error occurred');
} catch (Exception $e) {
    error_log("Video streaming error: " . $e->getMessage());
    http_response_code(500);
    die('An error occurred');
}
?>
