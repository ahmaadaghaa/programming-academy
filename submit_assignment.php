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

$data = json_decode(file_get_contents('php://input'), true);
$user_id = $_SESSION['user_id'];
$assignment_id = $data['assignment_id'] ?? null;
$solution = $data['solution'] ?? null;

if (!$assignment_id || !$solution) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Assignment ID and solution are required']);
    exit;
}

try {
    // Insert or update user assignment
    $stmt = $pdo->prepare("INSERT INTO user_assignments (user_id, assignment_id, solution) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE solution = VALUES(solution), submitted_at = CURRENT_TIMESTAMP");
    $stmt->execute([$user_id, $assignment_id, $solution]);

    // Determine pass threshold (default 70 if not present in assignments)
    $threshold = 70;
    try {
        $th = $pdo->prepare("SELECT pass_threshold FROM assignments WHERE id = ?");
        $th->execute([$assignment_id]);
        $row = $th->fetch(PDO::FETCH_ASSOC);
        if ($row && isset($row['pass_threshold'])) {
            $threshold = (int)$row['pass_threshold'];
        }
    } catch (Exception $e) {
        // ignore if column not present
    }

    // Simulate scoring (random for demo)
    $score = rand(70, 100); // Random score between 70-100
    $stmt = $pdo->prepare("UPDATE user_assignments SET score = ?, status = 'graded',
        is_completed = CASE WHEN ? >= ? THEN 1 ELSE 0 END,
        completed_at = CASE WHEN ? >= ? THEN CURRENT_TIMESTAMP ELSE completed_at END
        WHERE user_id = ? AND assignment_id = ?");
    $stmt->execute([$score, $score, $threshold, $score, $threshold, $user_id, $assignment_id]);

    echo json_encode(['success' => true, 'message' => 'Assignment submitted successfully', 'score' => $score]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database error']);
}
?>