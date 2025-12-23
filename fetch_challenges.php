<?php
// fetch_challenges.php - Public API to fetch challenges for display
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

session_start();
require 'db_connect.php';

try {
    $user_id = isset($_SESSION['user_id']) ? $_SESSION['user_id'] : null;

    // Get all active challenges with statistics and user completion status
    $stmt = $pdo->prepare("
        SELECT
            c.*,
            COALESCE(SUM(uc.attempts), 0) as total_attempts,
            COALESCE(COUNT(CASE WHEN uc.completed = 1 THEN 1 END), 0) as total_completions,
            CASE WHEN ? IS NOT NULL AND uc_user.completed = 1 THEN 1 ELSE 0 END as user_completed
        FROM challenges c
        LEFT JOIN user_challenges uc ON c.id = uc.challenge_id
        LEFT JOIN user_challenges uc_user ON c.id = uc_user.challenge_id AND uc_user.user_id = ?
        WHERE c.is_active = 1
        GROUP BY c.id
        ORDER BY c.created_at DESC
    ");
    $stmt->execute([$user_id, $user_id]);
    $challenges = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['success' => true, 'challenges' => $challenges]);
} catch (Exception $e) {
    error_log("Error in fetch_challenges.php: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في استرجاع التحديات']);
}
?>