<?php
// fetch_course_lessons.php - Get all lessons for a course with user progress
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
$courseId = $_GET['course_id'] ?? null;

if (!$courseId) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Missing course_id']);
    exit;
}

try {
    // 1. Fetch course details
    $stmt = $pdo->prepare('
        SELECT id, title, description, category, level, logo_path, main_points 
        FROM courses 
        WHERE id = ?
    ');
    $stmt->execute([$courseId]);
    $course = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$course) {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Course not found']);
        exit;
    }
    
    // Parse main_points
    $points = array_filter(array_map('trim', explode("\n", $course['main_points'] ?? '')));
    $course['main_points'] = array_values($points);
    
    // 2. Fetch all lessons for this course
    $stmt = $pdo->prepare('
        SELECT 
            l.id,
            l.title,
            l.description,
            l.sort_order,
            l.resources_code,
            l.created_at,
            l.updated_at
        FROM lessons l
        WHERE l.course_id = ?
        ORDER BY l.sort_order ASC, l.id ASC
    ');
    $stmt->execute([$courseId]);
    $lessons = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // 3. Fetch user's progress for these lessons
    $stmt = $pdo->prepare('
        SELECT 
            lesson_id,
            completed_at,
            last_position
        FROM user_lesson_progress
        WHERE user_id = ? AND lesson_id IN (SELECT id FROM lessons WHERE course_id = ?)
    ');
    $stmt->execute([$userId, $courseId]);
    $progressData = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Map progress by lesson_id
    $progressMap = [];
    foreach ($progressData as $prog) {
        $progressMap[$prog['lesson_id']] = [
            'completed' => !is_null($prog['completed_at']),
            'completed_at' => $prog['completed_at'],
            'last_position' => (int)$prog['last_position']
        ];
    }
    
    // 4. Enrich lessons with progress data
    $completedCount = 0;
    foreach ($lessons as &$lesson) {
        $lessonId = $lesson['id'];
        $lesson['completed'] = $progressMap[$lessonId]['completed'] ?? false;
        $lesson['last_position'] = $progressMap[$lessonId]['last_position'] ?? 0;
        
        if ($lesson['completed']) {
            $completedCount++;
        }
        
        // Add video URL (don't expose actual path) and cache-bust when updated
        $versionSource = $lesson['updated_at'] ?? $lesson['created_at'] ?? null;
        $version = $versionSource ? strtotime($versionSource) : time();
        $lesson['video_url'] = "stream_video.php?lesson_id=" . $lessonId . "&v=" . $version;
    }
    unset($lesson);
    
    // 5. Get or calculate course progress
    $totalLessons = count($lessons);
    $coursePercentage = $totalLessons > 0 ? round(($completedCount / $totalLessons) * 100) : 0;
    
    // Get course progress record (only if user has completed lessons)
    $stmt = $pdo->prepare('
        SELECT percentage_completed, last_lesson_id, started_at, last_accessed
        FROM user_course_progress
        WHERE user_id = ? AND course_id = ?
    ');
    $stmt->execute([$userId, $courseId]);
    $courseProgress = $stmt->fetch(PDO::FETCH_ASSOC);

    // Don't create course progress record automatically - only when lessons are completed
    
    // 6. Build response
    $response = [
        'success' => true,
        'course' => $course,
        'lessons' => $lessons,
        'progress' => [
            'completed_lessons' => $completedCount,
            'total_lessons' => $totalLessons,
            'percentage' => $coursePercentage,
            'last_lesson_id' => $courseProgress['last_lesson_id'] ?? null,
            'started_at' => $courseProgress['started_at'] ?? null
        ]
    ];
    
    echo json_encode($response, JSON_UNESCAPED_UNICODE);
    
} catch (PDOException $e) {
    error_log("Fetch lessons error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error occurred'
    ]);
}
?>
