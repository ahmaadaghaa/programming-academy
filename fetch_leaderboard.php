<?php
// fetch_leaderboard.php - API to get leaderboard data
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require 'db_connect.php';

try {
    // Get top 20 users by total points from completed challenges
    $stmt = $pdo->prepare("
        SELECT
            u.id,
            u.firstName,
            u.lastName,
            u.username,
            COALESCE(SUM(uc.best_score), 0) as total_points,
            COUNT(CASE WHEN uc.completed = 1 THEN 1 END) as completed_challenges,
            COUNT(uc.challenge_id) as attempted_challenges
        FROM users u
        LEFT JOIN user_challenges uc ON u.id = uc.user_id AND uc.completed = 1
        GROUP BY u.id, u.firstName, u.lastName, u.username
        HAVING total_points > 0
        ORDER BY total_points DESC, completed_challenges DESC
        LIMIT 20
    ");

    $stmt->execute();
    $leaderboard = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Format the data for frontend
    $formattedLeaderboard = array_map(function($user, $rank) {
        // Create display name
        $displayName = '';
        if (!empty($user['firstName']) && !empty($user['lastName'])) {
            $displayName = $user['firstName'] . ' ' . $user['lastName'];
        } elseif (!empty($user['firstName'])) {
            $displayName = $user['firstName'];
        } elseif (!empty($user['username'])) {
            $displayName = $user['username'];
        } else {
            $displayName = 'مستخدم مجهول';
        }

        // Get first letter for avatar
        $firstLetter = mb_substr($displayName, 0, 1, 'UTF-8');

        return [
            'rank' => $rank + 1,
            'name' => $displayName,
            'points' => (int)$user['total_points'],
            'avatar_letter' => $firstLetter,
            'completed_challenges' => (int)$user['completed_challenges']
        ];
    }, $leaderboard, array_keys($leaderboard));

    echo json_encode([
        'success' => true,
        'leaderboard' => $formattedLeaderboard,
        'total_participants' => count($formattedLeaderboard)
    ]);

} catch (Exception $e) {
    error_log("Error in fetch_leaderboard.php: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'حدث خطأ في استرجاع لوحة المتصدرين'
    ]);
}
?>