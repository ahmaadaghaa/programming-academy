<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
session_start();
require 'db_connect.php';

$category = $_GET['category'] ?? null;

if (!$category) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Category is required']);
    exit;
}

try {
    $stmt = $pdo->prepare("
        SELECT DISTINCT c.id, c.title, c.description, c.category, c.logo_path, COUNT(a.id) as assignment_count
        FROM courses c
        JOIN assignments a ON c.id = a.course_id
        WHERE c.category = ? AND c.is_active = 1
        GROUP BY c.id, c.title, c.description, c.category, c.logo_path
        ORDER BY c.title
    ");
    $stmt->execute([$category]);
    $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['success' => true, 'courses' => $courses]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database error']);
}
?>