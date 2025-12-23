<?php
// update_lesson_progress.php - Save lesson progress and course completion
session_start();
require 'db_connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    exit;
}

$userId = $_SESSION['user_id'];
$input = json_decode(file_get_contents('php://input'), true);

$lessonId = $input['lesson_id'] ?? null;
$action = $input['action'] ?? null; // 'update_position' or 'mark_complete'
$position = $input['position'] ?? 0; // Video position in seconds

if (!$lessonId || !$action) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Missing required parameters']);
    exit;
}

try {
    $pdo->beginTransaction();
    
    // 1. Get lesson's course_id
    $stmt = $pdo->prepare('SELECT course_id FROM lessons WHERE id = ?');
    $stmt->execute([$lessonId]);
    $lesson = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$lesson) {
        throw new Exception('Lesson not found');
    }
    
    $courseId = $lesson['course_id'];
    
    // 2. Handle different actions
    if ($action === 'update_position') {
        // Save video position for resume (don't create course enrollment yet)
        $stmt = $pdo->prepare('
            INSERT INTO user_lesson_progress (user_id, lesson_id, last_position, updated_at)
            VALUES (?, ?, ?, NOW())
            ON DUPLICATE KEY UPDATE
                last_position = VALUES(last_position),
                updated_at = NOW()
        ');
        $stmt->execute([$userId, $lessonId, (int)$position]);

        // Only update course progress if user is already enrolled (has completed at least one lesson)
        $stmt = $pdo->prepare('
            SELECT COUNT(*) as completed_count
            FROM user_lesson_progress ulp
            JOIN lessons l ON ulp.lesson_id = l.id
            WHERE ulp.user_id = ? AND l.course_id = ? AND ulp.completed_at IS NOT NULL
        ');
        $stmt->execute([$userId, $courseId]);
        $completedCount = $stmt->fetch(PDO::FETCH_ASSOC)['completed_count'];

        if ($completedCount > 0) {
            // User has completed lessons, update course progress
            $stmt = $pdo->prepare('
                UPDATE user_course_progress
                SET last_lesson_id = ?, last_accessed = NOW()
                WHERE user_id = ? AND course_id = ?
            ');
            $stmt->execute([$lessonId, $userId, $courseId]);
        }
        // If no completed lessons, don't create course enrollment record

        $message = 'Position saved';

    } elseif ($action === 'mark_complete') {
        // Mark lesson as completed
        $stmt = $pdo->prepare('
            INSERT INTO user_lesson_progress (user_id, lesson_id, completed_at, last_position, updated_at)
            VALUES (?, ?, NOW(), ?, NOW())
            ON DUPLICATE KEY UPDATE
                completed_at = NOW(),
                last_position = VALUES(last_position),
                updated_at = NOW()
        ');
        $stmt->execute([$userId, $lessonId, (int)$position]);

        $message = 'Lesson marked as complete';

    } elseif ($action === 'mark_incomplete') {
        // Mark lesson as incomplete (for relearning)
        $stmt = $pdo->prepare('
            UPDATE user_lesson_progress 
            SET completed_at = NULL, updated_at = NOW()
            WHERE user_id = ? AND lesson_id = ?
            AND completed_at IS NOT NULL
        ');
        $stmt->execute([$userId, $lessonId]);
        
        $message = 'Lesson marked as incomplete for relearning';
        
    } else {
        throw new Exception('Invalid action');
    }
    
    // 3. Recalculate course completion percentage
    $stmt = $pdo->prepare('
        SELECT COUNT(*) as total
        FROM lessons
        WHERE course_id = ?
    ');
    $stmt->execute([$courseId]);
    $totalLessons = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    $stmt = $pdo->prepare('
        SELECT COUNT(*) as completed
        FROM user_lesson_progress ulp
        JOIN lessons l ON ulp.lesson_id = l.id
        WHERE ulp.user_id = ? AND l.course_id = ? AND ulp.completed_at IS NOT NULL
    ');
    $stmt->execute([$userId, $courseId]);
    $completedLessons = $stmt->fetch(PDO::FETCH_ASSOC)['completed'];
    
    $percentage = $totalLessons > 0 ? round(($completedLessons / $totalLessons) * 100) : 0;
    
    // 4. Determine the correct last_lesson_id
    $lastLessonId = $lessonId; // Default to current lesson
    
    if ($action === 'mark_incomplete') {
        // When marking incomplete, find the last completed lesson
        $stmt = $pdo->prepare('
            SELECT ulp.lesson_id
            FROM user_lesson_progress ulp
            JOIN lessons l ON ulp.lesson_id = l.id
            WHERE ulp.user_id = ? AND l.course_id = ? AND ulp.completed_at IS NOT NULL
            ORDER BY ulp.completed_at DESC
            LIMIT 1
        ');
        $stmt->execute([$userId, $courseId]);
        $lastCompleted = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($lastCompleted) {
            $lastLessonId = $lastCompleted['lesson_id'];
        } else {
            // No completed lessons, find the first lesson in the course
            $stmt = $pdo->prepare('
                SELECT id FROM lessons 
                WHERE course_id = ? 
                ORDER BY sort_order ASC, id ASC 
                LIMIT 1
            ');
            $stmt->execute([$courseId]);
            $firstLesson = $stmt->fetch(PDO::FETCH_ASSOC);
            $lastLessonId = $firstLesson ? $firstLesson['id'] : $lessonId;
        }
    }
    
    // 5. Update course progress only if user has completed lessons
    if ($completedLessons > 0) {
        // Determine the correct last_lesson_id
        $lastLessonId = $lessonId; // Default to current lesson
        
        if ($action === 'mark_incomplete') {
            // When marking incomplete, find the last completed lesson
            $stmt = $pdo->prepare('
                SELECT ulp.lesson_id
                FROM user_lesson_progress ulp
                JOIN lessons l ON ulp.lesson_id = l.id
                WHERE ulp.user_id = ? AND l.course_id = ? AND ulp.completed_at IS NOT NULL
                ORDER BY ulp.completed_at DESC
                LIMIT 1
            ');
            $stmt->execute([$userId, $courseId]);
            $lastCompleted = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($lastCompleted) {
                $lastLessonId = $lastCompleted['lesson_id'];
            } else {
                // No completed lessons, find the first lesson in the course
                $stmt = $pdo->prepare('
                    SELECT id FROM lessons 
                    WHERE course_id = ? 
                    ORDER BY sort_order ASC, id ASC 
                    LIMIT 1
                ');
                $stmt->execute([$courseId]);
                $firstLesson = $stmt->fetch(PDO::FETCH_ASSOC);
                $lastLessonId = $firstLesson ? $firstLesson['id'] : $lessonId;
            }
        }
        
        // Update course progress
        $stmt = $pdo->prepare('
            INSERT INTO user_course_progress (user_id, course_id, percentage_completed, last_lesson_id, last_accessed, started_at)
            VALUES (?, ?, ?, ?, NOW(), NOW())
            ON DUPLICATE KEY UPDATE
                percentage_completed = VALUES(percentage_completed),
                last_lesson_id = VALUES(last_lesson_id),
                last_accessed = NOW()
        ');
        $stmt->execute([$userId, $courseId, $percentage, $lastLessonId]);
    } else {
        // No completed lessons, remove course progress record if it exists
        $stmt = $pdo->prepare('
            DELETE FROM user_course_progress 
            WHERE user_id = ? AND course_id = ?
        ');
        $stmt->execute([$userId, $courseId]);
    }
    
    $pdo->commit();
    
    echo json_encode([
        'success' => true,
        'message' => $message,
        'progress' => [
            'completed_lessons' => $completedLessons,
            'total_lessons' => $totalLessons,
            'percentage' => $percentage
        ]
    ]);
    
} catch (PDOException $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    error_log("Update progress error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database error']);
    
} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
