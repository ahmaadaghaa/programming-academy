<?php
// get_platform_recommendations.php - API for personalized platform recommendations

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

session_start();
require 'db_connect.php';

// Check if user is logged in for personalized recommendations
$user_logged_in = isset($_SESSION['user_id']);
$user_id = $user_logged_in ? $_SESSION['user_id'] : null;

// Get user answers from the recommendation tool
$input = json_decode(file_get_contents('php://input'), true);
if ($input === null) {
    $input = [];
}

// Map Arabic answers to English
$level_map = [
    'مبتدئ' => 'beginner',
    'متوسط' => 'intermediate',
    'متقدم' => 'advanced'
];

$goal_map = [
    'تحضير لمقابلات العمل' => 'interviews',
    'تحسين المهارات الخوارزمية' => 'algorithms',
    'التعلم والممارسة' => 'learning'
];

$language_map = [
    'العربية' => 'arabic',
    'الإنجليزية' => 'english',
    'لا يهم' => 'any'
];

$user_level = $level_map[$input['level']] ?? 'beginner';
$user_goal = $goal_map[$input['goal']] ?? 'learning';
$user_language = $language_map[$input['language']] ?? 'any';

$recommendations = [];
$explanation = '';

try {
    // If user is logged in, get their actual progress to determine real level
    $actual_level = $user_level;
    /*
    if ($user_logged_in) {
        $stmt = $pdo->prepare("
            SELECT
                COUNT(CASE WHEN ulp.completed_at IS NOT NULL THEN 1 END) as completed_lessons,
                COUNT(DISTINCT l.id) as total_lessons,
                c.level as course_level
            FROM user_lesson_progress ulp
            RIGHT JOIN lessons l ON ulp.lesson_id = l.id
            LEFT JOIN courses c ON l.course_id = c.id
            WHERE ulp.user_id = ? OR ulp.user_id IS NULL
            GROUP BY c.level
        ");
        $stmt->execute([$user_id]);
        $progress_data = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Calculate actual level based on completion percentage
        $total_completed = 0;
        $total_lessons = 0;

        foreach ($progress_data as $data) {
            $total_completed += $data['completed_lessons'] ?? 0;
            $total_lessons += $data['total_lessons'] ?? 0;
        }

        $completion_rate = $total_lessons > 0 ? ($total_completed / $total_lessons) * 100 : 0;

        if ($completion_rate > 70) {
            $actual_level = 'advanced';
        } elseif ($completion_rate > 30) {
            $actual_level = 'intermediate';
        } else {
            $actual_level = 'beginner';
        }

        $explanation = "بناءً على تقدمك في الأكاديمية (أكملت {$total_completed} درس من {$total_lessons})، مستواك المقدر هو: {$actual_level}";
    } else {
        $explanation = "بناءً على إجاباتك في الاستبيان";
    }
    */
    $explanation = "بناءً على إجاباتك في الاستبيان";

    // Generate recommendations based on user preferences and actual level
    $where_conditions = [];
    $params = [];

    // Language preference
    if ($user_language === 'arabic') {
        $where_conditions[] = "language IN ('arabic', 'both')";
    } elseif ($user_language === 'english') {
        $where_conditions[] = "language IN ('english', 'both')";
    }

    // Level matching
    if ($actual_level === 'beginner') {
        $where_conditions[] = "level IN ('beginner', 'intermediate')";
    } elseif ($actual_level === 'intermediate') {
        $where_conditions[] = "level IN ('intermediate', 'advanced')";
    } else {
        $where_conditions[] = "level = 'advanced'";
    }

    // Goal-based filtering
    if ($user_goal === 'interviews') {
        $where_conditions[] = "features LIKE '%مقابلات%' OR features LIKE '%interviews%'";
    } elseif ($user_goal === 'algorithms') {
        $where_conditions[] = "features LIKE '%خوارزميات%' OR features LIKE '%algorithms%'";
    }

    $where_clause = !empty($where_conditions) ? " AND " . implode(" AND ", $where_conditions) : "";

    // Get recommended platforms
    $stmt = $pdo->prepare("
        SELECT id, name, description, url, category, level, language, rating,
               user_count, problem_count, features, logo_url
        FROM platforms
        WHERE is_active = 1
        {$where_clause}
        ORDER BY rating DESC, user_count DESC
        LIMIT 4
    ");

    $stmt->execute($params);
    $platforms = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // If no specific matches, get general recommendations
    if (empty($platforms)) {
        $stmt = $pdo->prepare("
            SELECT id, name, description, url, category, level, language, rating,
                   user_count, problem_count, features, logo_url
            FROM platforms
            WHERE is_active = 1 AND level = ?
            ORDER BY rating DESC
            LIMIT 4
        ");
        $stmt->execute([$actual_level]);
        $platforms = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Format recommendations
    $recommendations = array_map(function($platform) use ($user_level, $user_goal, $user_language) {
        $match_reasons = [];

        // Level match
        if ($platform['level'] === $user_level) {
            $match_reasons[] = "مستوى مناسب لك";
        }

        // Language match
        if (($user_language === 'arabic' && in_array($platform['language'], ['arabic', 'both'])) ||
            ($user_language === 'english' && in_array($platform['language'], ['english', 'both'])) ||
            $user_language === 'any') {
            $match_reasons[] = "لغة مناسبة";
        }

        // Goal match (simplified)
        if ($user_goal === 'interviews' && strpos($platform['features'], 'مقابلات') !== false) {
            $match_reasons[] = "مناسب للمقابلات";
        } elseif ($user_goal === 'algorithms' && strpos($platform['features'], 'خوارزميات') !== false) {
            $match_reasons[] = "مناسب للخوارزميات";
        }

        return [
            'id' => $platform['id'],
            'name' => $platform['name'],
            'description' => $platform['description'],
            'url' => $platform['url'],
            'category' => $platform['category'],
            'level' => $platform['level'],
            'language' => $platform['language'],
            'rating' => floatval($platform['rating']),
            'features' => json_decode($platform['features'], true) ?? [],
            'match_reason' => !empty($match_reasons) ? implode(" • ", $match_reasons) : "مناسب لمستواك العام"
        ];
    }, $platforms);

    echo json_encode([
        'success' => true,
        'recommendations' => $recommendations,
        'actual_level' => $actual_level,
        'explanation' => $explanation,
        'personalized' => $user_logged_in
    ]);

} catch (PDOException $e) {
    error_log('Database error in get_platform_recommendations.php: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'حدث خطأ في النظام، يرجى المحاولة لاحقاً',
        'recommendations' => []
    ]);
}
?>