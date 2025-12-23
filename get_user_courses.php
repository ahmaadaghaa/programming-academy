<?php
// get_user_courses.php - Get all courses for the logged-in user with progress
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

try {
    // Fetch user's courses with progress - only courses where user has completed at least one video
    $stmt = $pdo->prepare('
        SELECT
            c.id,
            c.title,
            c.description,
            c.category,
            c.level,
            c.logo_path,
            c.main_points,
            COALESCE(ucp.percentage_completed, 0) as percentage_completed,
            ucp.last_lesson_id,
            ucp.started_at,
            ucp.last_accessed,
            COUNT(l.id) as total_lessons,
            COUNT(ulp.lesson_id) as completed_lessons
        FROM courses c
        INNER JOIN user_course_progress ucp ON c.id = ucp.course_id AND ucp.user_id = ?
        LEFT JOIN lessons l ON c.id = l.course_id
        LEFT JOIN user_lesson_progress ulp ON l.id = ulp.lesson_id AND ulp.user_id = ?
        GROUP BY c.id, c.title, c.description, c.category, c.level, c.logo_path, c.main_points,
                 ucp.percentage_completed, ucp.last_lesson_id, ucp.started_at, ucp.last_accessed
        HAVING COUNT(ulp.lesson_id) > 0  -- Only show courses with at least one completed lesson
        ORDER BY ucp.last_accessed DESC, c.created_at DESC
    ');
    $stmt->execute([$userId, $userId]);
    $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Process each course
    foreach ($courses as &$course) {
        // Parse main_points
        $points = array_filter(array_map('trim', explode("\n", $course['main_points'] ?? '')));
        $course['main_points'] = array_values($points);

        // Add icon and color classes
        $course['icon_class'] = determineIconClass($course['title']);
        $course['color_class'] = determineColorClass($course['title']);

        // Calculate percentage if not set
        if ($course['percentage_completed'] == 0 && $course['total_lessons'] > 0) {
            $course['percentage_completed'] = round(($course['completed_lessons'] / $course['total_lessons']) * 100);
        }

        // Get last lesson title if exists
        if ($course['last_lesson_id']) {
            $stmt = $pdo->prepare('SELECT title FROM lessons WHERE id = ?');
            $stmt->execute([$course['last_lesson_id']]);
            $lastLesson = $stmt->fetch(PDO::FETCH_ASSOC);
            $course['last_lesson_title'] = $lastLesson['title'] ?? null;
        } else {
            $course['last_lesson_title'] = null;
        }
    }
    unset($course);

    echo json_encode([
        'success' => true,
        'courses' => $courses
    ], JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {
    error_log("Get user courses error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error occurred'
    ]);
}

// Functions to determine icon and color classes
function determineIconClass($title) {
    $title = strtolower($title);
    if (strpos($title, 'javascript') !== false || strpos($title, 'js') !== false) {
        return 'fab fa-js-square';
    } elseif (strpos($title, 'python') !== false) {
        return 'fab fa-python';
    } elseif (strpos($title, 'php') !== false) {
        return 'fab fa-php';
    } elseif (strpos($title, 'html') !== false) {
        return 'fab fa-html5';
    } elseif (strpos($title, 'css') !== false) {
        return 'fab fa-css3-alt';
    } elseif (strpos($title, 'c++') !== false) {
        return 'fas fa-code';
    } elseif (strpos($title, 'java') !== false) {
        return 'fab fa-java';
    } elseif (strpos($title, 'c#') !== false || strpos($title, 'csharp') !== false) {
        return 'fas fa-code';
    } else {
        return 'fas fa-code';
    }
}

function determineColorClass($title) {
    $title = strtolower($title);
    if (strpos($title, 'c++') !== false) {
        return 'cpp-icon';
    } elseif (strpos($title, 'python') !== false) {
        return 'python-icon';
    } elseif (strpos($title, 'php') !== false) {
        return 'php-icon';
    } elseif (strpos($title, 'javascript') !== false || strpos($title, 'js') !== false) {
        return 'js-icon';
    } elseif (strpos($title, 'html') !== false) {
        return 'web-icon';
    } elseif (strpos($title, 'css') !== false) {
        return 'web-icon';
    } elseif (strpos($title, 'java') !== false) {
        return 'java-icon';
    } elseif (strpos($title, 'c#') !== false || strpos($title, 'csharp') !== false) {
        return 'csharp-icon';
    } else {
        return 'default-icon';
    }
}
?>
