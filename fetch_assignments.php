<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
session_start();
require 'db_connect.php';

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    exit;
}

$course = $_GET['course'] ?? null;

if (!$course) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Course is required']);
    exit;
}

try {
    // Include per-user completion info
    $stmt = $pdo->prepare("SELECT a.id, a.question, a.difficulty,
        COALESCE(ua.is_completed, 0) AS completed,
        ua.score, ua.status, ua.completed_at
        FROM assignments a
        LEFT JOIN user_assignments ua ON ua.assignment_id = a.id AND ua.user_id = ?
        WHERE a.course_id = ?
        ORDER BY a.assignment_order");
    $stmt->execute([$_SESSION['user_id'], $course]);
    $assignments = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['success' => true, 'assignments' => $assignments], JSON_UNESCAPED_UNICODE);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database error']);
}
?>