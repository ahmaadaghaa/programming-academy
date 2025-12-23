<?php
// fetch_user_progress.php - API to get user's challenge progress and statistics
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

session_start();

require 'db_connect.php';

try {
    // Check if user is logged in
    if (!isset($_SESSION['user_id'])) {
        echo json_encode([
            'success' => false,
            'message' => 'يجب تسجيل الدخول لعرض الإحصائيات',
            'showLogin' => true
        ]);
        exit;
    }

    $user_id = $_SESSION['user_id'];

    // Get overall user statistics
    $overallStats = getUserOverallStats($pdo, $user_id);

    // Get progress by category
    $categoryProgress = getUserCategoryProgress($pdo, $user_id);

    // Get recent activity (last 5 attempts)
    $recentActivity = getUserRecentActivity($pdo, $user_id);

    echo json_encode([
        'success' => true,
        'stats' => $overallStats,
        'categories' => $categoryProgress,
        'recentActivity' => $recentActivity
    ]);

} catch (Exception $e) {
    error_log("Error in fetch_user_progress.php: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في استرجاع الإحصائيات']);
}

function getUserOverallStats($pdo, $user_id) {
    $stmt = $pdo->prepare("
        SELECT
            COUNT(CASE WHEN uc.completed = 1 THEN 1 END) as completed_challenges,
            COALESCE(SUM(uc.best_score), 0) as total_points,
            COUNT(uc.challenge_id) as attempted_challenges,
            ROUND(
                (COUNT(CASE WHEN uc.completed = 1 THEN 1 END) * 100.0) /
                NULLIF(COUNT(uc.challenge_id), 0),
                1
            ) as success_rate
        FROM user_challenges uc
        WHERE uc.user_id = ?
    ");
    $stmt->execute([$user_id]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function getUserCategoryProgress($pdo, $user_id) {
    $stmt = $pdo->prepare("
        SELECT
            c.category,
            COUNT(DISTINCT c.id) as total_in_category,
            COUNT(DISTINCT CASE WHEN uc.completed = 1 THEN c.id END) as completed_in_category,
            ROUND(
                (COUNT(DISTINCT CASE WHEN uc.completed = 1 THEN c.id END) * 100.0) /
                NULLIF(COUNT(DISTINCT c.id), 0),
                1
            ) as progress_percentage
        FROM challenges c
        LEFT JOIN user_challenges uc ON c.id = uc.challenge_id AND uc.user_id = ?
        WHERE c.is_active = 1
        GROUP BY c.category
        ORDER BY c.category
    ");
    $stmt->execute([$user_id]);
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Map categories to Arabic names
    $categoryNames = [
        'algorithms' => 'الخوارزميات',
        'data-structures' => 'هياكل البيانات',
        'web' => 'تطوير الويب',
        'database' => 'قواعد البيانات'
    ];

    foreach ($results as &$result) {
        $result['category_name'] = $categoryNames[$result['category']] ?? $result['category'];
    }

    return $results;
}

function getUserRecentActivity($pdo, $user_id) {
    $stmt = $pdo->prepare("
        SELECT
            c.title,
            c.category,
            uc.attempts,
            uc.completed,
            uc.best_score,
            uc.last_attempted
        FROM user_challenges uc
        JOIN challenges c ON uc.challenge_id = c.id
        WHERE uc.user_id = ?
        ORDER BY uc.last_attempted DESC
        LIMIT 5
    ");
    $stmt->execute([$user_id]);
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Map categories to Arabic
    $categoryNames = [
        'algorithms' => 'الخوارزميات',
        'data-structures' => 'هياكل البيانات',
        'web' => 'تطوير الويب',
        'database' => 'قواعد البيانات'
    ];

    foreach ($results as &$result) {
        $result['category_name'] = $categoryNames[$result['category']] ?? $result['category'];
    }

    return $results;
}
?>