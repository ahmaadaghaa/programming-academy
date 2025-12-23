<?php
// fetch_platform_stats.php - API to get platform-wide statistics for challenges page
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require 'db_connect.php';

try {
    // Get platform statistics
    $stats = getPlatformStats($pdo);

    echo json_encode([
        'success' => true,
        'stats' => $stats
    ]);

} catch (Exception $e) {
    error_log("Error in fetch_platform_stats.php: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في استرجاع الإحصائيات']);
}

function getPlatformStats($pdo) {
    $stats = [];

    // 1. Total active challenges
    $stmt = $pdo->query("SELECT COUNT(*) as total_challenges FROM challenges WHERE is_active = 1");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $stats['total_challenges'] = $result['total_challenges'];

    // 2. Total active users (users who have logged in within last 30 days or have challenge attempts)
    $stmt = $pdo->query("
        SELECT COUNT(DISTINCT u.id) as active_users
        FROM users u
        LEFT JOIN user_challenges uc ON u.id = uc.user_id
        WHERE u.joinDate >= DATE_SUB(NOW(), INTERVAL 30 DAY)
           OR uc.last_attempted >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    ");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $stats['active_users'] = $result['active_users'];

    // If no recent activity, fall back to total users
    if ($stats['active_users'] == 0) {
        $stmt = $pdo->query("SELECT COUNT(*) as total_users FROM users");
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stats['active_users'] = $result['total_users'];
    }

    // 3. Total completed challenges across all users
    $stmt = $pdo->query("SELECT COUNT(*) as total_completions FROM user_challenges WHERE completed = 1");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $stats['total_completions'] = $result['total_completions'];

    // 4. Average rating (placeholder for now - would need reviews table)
    // For now, calculate based on completion rate as a proxy
    $totalAttempts = 0;
    $stmt = $pdo->query("SELECT SUM(attempts) as total_attempts FROM user_challenges");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $totalAttempts = $result['total_attempts'] ?: 0;

    if ($totalAttempts > 0) {
        $completionRate = ($stats['total_completions'] / $totalAttempts) * 5; // Scale to 5-star rating
        $stats['average_rating'] = round(min($completionRate, 5.0), 1);
    } else {
        $stats['average_rating'] = 0.0;
    }

    return $stats;
}
?>