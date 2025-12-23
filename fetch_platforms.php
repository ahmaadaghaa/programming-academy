<?php
// fetch_platforms.php - API to fetch platforms with filtering and user-specific data

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

session_start();
require 'db_connect.php';

// Get user_id from session or from query parameter (fallback for when session is not maintained)
$user_id = $_SESSION['user_id'] ?? null;

// If no session user_id, try to get it from the query parameter
if (!$user_id) {
    $user_id = filter_input(INPUT_GET, 'user_id', FILTER_VALIDATE_INT);
}

// Get filter parameters
$category = $_GET['category'] ?? 'all';
$level = $_GET['level'] ?? 'all';
$language = $_GET['language'] ?? 'all';
$search = $_GET['search'] ?? '';
$favorites = isset($_GET['favorites']) ? filter_var($_GET['favorites'], FILTER_VALIDATE_BOOLEAN) : false;
$limit = (int)($_GET['limit'] ?? 50);
$offset = (int)($_GET['offset'] ?? 0);

try {
    // Build WHERE conditions
    $where_conditions = ["p.is_active = 1"];
    $params = [];

    if ($category !== 'all') {
        $where_conditions[] = "p.category = ?";
        $params[] = $category;
    }

    // Handle favorites filter
    if ($favorites) {
        if ($user_id) {
            $where_conditions[] = "EXISTS (SELECT 1 FROM platform_bookmarks pb WHERE pb.platform_id = p.id AND pb.user_id = ?)";
            $params[] = $user_id;
        } else {
            // If no user, show no favorites
            $where_conditions[] = "1 = 0";
        }
    }

    if ($level !== 'all') {
        $where_conditions[] = "p.level = ?";
        $params[] = $level;
    }

    if ($language !== 'all') {
        if ($language === 'arabic') {
            $where_conditions[] = "p.language IN ('arabic', 'both')";
        } elseif ($language === 'english') {
            $where_conditions[] = "p.language IN ('english', 'both')";
        }
    }

    if (!empty($search)) {
        $where_conditions[] = "(p.name LIKE ? OR p.description LIKE ?)";
        $params[] = "%{$search}%";
        $params[] = "%{$search}%";
    }

    $where_clause = implode(" AND ", $where_conditions);

    // Get platforms with ratings and user-specific data
    $sql = "
        SELECT
            p.*,
            COALESCE(AVG(pr.rating), 0) as avg_rating,
            COUNT(DISTINCT pr.id) as rating_count,
            COUNT(DISTINCT pb.id) as bookmark_count,
            CASE WHEN ? IS NOT NULL AND pb_user.id IS NOT NULL THEN 1 ELSE 0 END as is_bookmarked,
            CASE WHEN ? IS NOT NULL THEN COALESCE(upr.rating, 0) ELSE 0 END as user_rating,
            -- Rating distribution
            COUNT(CASE WHEN pr.rating = 1 THEN 1 END) as rating_1_count,
            COUNT(CASE WHEN pr.rating = 2 THEN 1 END) as rating_2_count,
            COUNT(CASE WHEN pr.rating = 3 THEN 1 END) as rating_3_count,
            COUNT(CASE WHEN pr.rating = 4 THEN 1 END) as rating_4_count,
            COUNT(CASE WHEN pr.rating = 5 THEN 1 END) as rating_5_count
        FROM platforms p
        LEFT JOIN platform_ratings pr ON p.id = pr.platform_id
        LEFT JOIN platform_bookmarks pb ON p.id = pb.platform_id
        LEFT JOIN platform_bookmarks pb_user ON p.id = pb_user.platform_id AND pb_user.user_id = ?
        LEFT JOIN platform_ratings upr ON p.id = upr.platform_id AND upr.user_id = ?
        WHERE {$where_clause}
        GROUP BY p.id
        ORDER BY p.created_at DESC
        LIMIT ? OFFSET ?
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute(array_merge([$user_id, $user_id, $user_id, $user_id], $params, [$limit, $offset]));
    $platforms = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Process platforms data
    foreach ($platforms as &$platform) {
        // Decode features JSON
        $platform['features'] = json_decode($platform['features'], true) ?? [];

        // Convert numeric values
        $platform['rating'] = floatval($platform['rating']);
        $platform['avg_rating'] = floatval($platform['avg_rating']);
        $platform['user_count'] = (int)$platform['user_count'];
        $platform['problem_count'] = (int)$platform['problem_count'];
        $platform['rating_count'] = (int)$platform['rating_count'];
        $platform['bookmark_count'] = (int)$platform['bookmark_count'];
        $platform['is_bookmarked'] = (bool)$platform['is_bookmarked'];
        $platform['user_rating'] = (int)$platform['user_rating'];

        // Clean up internal fields
        unset($platform['is_active']);
    }

    // Get total count for pagination
    $count_sql = "SELECT COUNT(*) as total FROM platforms p WHERE {$where_clause}";
    $count_stmt = $pdo->prepare($count_sql);
    $count_stmt->execute($params);
    $total_count = $count_stmt->fetch()['total'];

    echo json_encode([
        'success' => true,
        'platforms' => $platforms,
        'pagination' => [
            'total' => (int)$total_count,
            'limit' => $limit,
            'offset' => $offset,
            'has_more' => ($offset + $limit) < $total_count
        ],
        'filters' => [
            'category' => $category,
            'level' => $level,
            'language' => $language,
            'search' => $search
        ]
    ]);

} catch (PDOException $e) {
    error_log('Database error in fetch_platforms.php: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'حدث خطأ في جلب المنصات',
        'platforms' => []
    ]);
}
?>