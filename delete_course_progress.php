<?php
// delete_course_progress.php - Delete user's progress for a specific course
session_start();
require 'db_connect.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    exit;
}

$userId = $_SESSION['user_id'];
$courseId = $_POST['course_id'] ?? null;

if (!$courseId) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Missing course_id']);
    exit;
}

try {
    // Start transaction
    $pdo->beginTransaction();

    // Delete lesson progress for this course
    $stmt = $pdo->prepare('
        DELETE ulp FROM user_lesson_progress ulp
        INNER JOIN lessons l ON ulp.lesson_id = l.id
        WHERE ulp.user_id = ? AND l.course_id = ?
    ');
    $stmt->execute([$userId, $courseId]);

    // Delete course progress
    $stmt = $pdo->prepare('
        DELETE FROM user_course_progress
        WHERE user_id = ? AND course_id = ?
    ');
    $stmt->execute([$userId, $courseId]);

    // Commit transaction
    $pdo->commit();

    echo json_encode([
        'success' => true,
        'message' => 'Course progress deleted successfully'
    ]);

} catch (PDOException $e) {
    $pdo->rollBack();
    error_log("Delete course progress error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error occurred'
    ]);
}
?>
