<?php
// admin_platforms.php - Admin API for managing platforms

error_reporting(0);
ini_set('display_errors', 0);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

session_start();
require 'db_connect.php';

// Function to sanitize folder names
function sanitize_folder_name($name) {
    $name = preg_replace('/[^\\w\\-\\s\\.]/u', '', $name);
    $name = trim($name);
    $name = str_replace(' ', '_', $name);
    return empty($name) ? 'default_folder' : mb_substr($name, 0, 100, 'UTF-8');
}

// Check if user is logged in and has admin role
// if (!isset($_SESSION['user_id']) || !isset($_SESSION['roles']) || !in_array('admin', $_SESSION['roles'])) {
//     http_response_code(403);
//     echo json_encode(['success' => false, 'message' => 'غير مصرح لك بالوصول إلى هذه الصفحة']);
//     exit;
// }

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? $_POST['action'] ?? '';

// Handle PUT requests (for updates)
if ($method === 'POST' && isset($_POST['_method']) && $_POST['_method'] === 'PUT') {
    $method = 'PUT';
}

try {
    switch ($method) {
        case 'GET':
            // Handle different GET actions
            try {
                if ($action === 'get_examples') {
                    // Get all examples
                    try {
                        $stmt = $pdo->query("SELECT * FROM examples ORDER BY id DESC");
                        $examples = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    } catch (Exception $e) {
                        $examples = [];
                    }
                    echo json_encode(['success' => true, 'examples' => $examples]);
                } elseif ($action === 'get_example' && isset($_GET['id'])) {
                    // Get single example
                    try {
                        $stmt = $pdo->prepare("SELECT * FROM examples WHERE id = ?");
                        $stmt->execute([$_GET['id']]);
                        $example = $stmt->fetch(PDO::FETCH_ASSOC);

                        if ($example) {
                            echo json_encode(['success' => true, 'example' => $example]);
                        } else {
                            http_response_code(404);
                            echo json_encode(['success' => false, 'message' => 'المثال غير موجود']);
                        }
                    } catch (Exception $e) {
                        http_response_code(404);
                        echo json_encode(['success' => false, 'message' => 'المثال غير موجود']);
                    }
                } elseif ($action === 'get_courses') {
                    // Get all courses with lesson count
                    try {
                        $stmt = $pdo->query("SELECT c.*, COUNT(l.id) as lesson_count FROM courses c LEFT JOIN lessons l ON c.id = l.course_id GROUP BY c.id ORDER BY c.id DESC");
                        $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    } catch (Exception $e) {
                        $courses = [];
                    }
                    echo json_encode(['success' => true, 'courses' => $courses]);
                } elseif ($action === 'get_course' && isset($_GET['id'])) {
                    // Get single course
                    try {
                        $stmt = $pdo->prepare("SELECT * FROM courses WHERE id = ?");
                        $stmt->execute([$_GET['id']]);
                        $course = $stmt->fetch(PDO::FETCH_ASSOC);

                        if ($course) {
                            echo json_encode(['success' => true, 'course' => $course]);
                        } else {
                            http_response_code(404);
                            echo json_encode(['success' => false, 'message' => 'الدورة غير موجودة']);
                        }
                    } catch (Exception $e) {
                        http_response_code(404);
                        echo json_encode(['success' => false, 'message' => 'الدورة غير موجودة']);
                    }
                } elseif ($action === 'get_course_lessons' && isset($_GET['course_id'])) {
                    // Get lessons for a course ordered by sort_order then id
                    try {
                        $stmt = $pdo->prepare("SELECT * FROM lessons WHERE course_id = ? ORDER BY sort_order ASC, id ASC");
                        $stmt->execute([$_GET['course_id']]);
                        $lessons = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    } catch (Exception $e) {
                        $lessons = [];
                    }
                    echo json_encode(['success' => true, 'lessons' => $lessons]);
                } elseif (isset($_GET['id'])) {
                    // Get single platform (legacy)
                    try {
                        $stmt = $pdo->prepare("SELECT * FROM platforms WHERE id = ?");
                        $stmt->execute([$_GET['id']]);
                        $platform = $stmt->fetch(PDO::FETCH_ASSOC);

                        if ($platform) {
                            $platform['features'] = json_decode($platform['features'], true);
                            echo json_encode(['success' => true, 'platform' => $platform]);
                        } else {
                            http_response_code(404);
                            echo json_encode(['success' => false, 'message' => 'المنصة غير موجودة']);
                        }
                    } catch (Exception $e) {
                        http_response_code(404);
                        echo json_encode(['success' => false, 'message' => 'المنصة غير موجودة']);
                    }
                } else {
                    // Get all platforms (default)
                    try {
                        $stmt = $pdo->query("SELECT * FROM platforms ORDER BY id DESC");
                        $platforms = $stmt->fetchAll(PDO::FETCH_ASSOC);

                        // Decode features JSON for each platform
                        foreach ($platforms as &$platform) {
                            $decoded = json_decode($platform['features'], true);
                            $platform['features'] = is_array($decoded) ? $decoded : [];
                        }
                    } catch (Exception $e) {
                        $platforms = [];
                    }

                    echo json_encode(['success' => true, 'platforms' => $platforms]);
                }
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => 'خطأ في قاعدة البيانات: ' . $e->getMessage()]);
            }
            break;

        case 'POST':
            // Handle both platforms and examples
            $data = json_decode(file_get_contents('php://input'), true);

            if (!$data) {
                $data = $_POST;
            }

            try {
                // Handle quick status toggle
                if (isset($data['action']) && $data['action'] === 'toggle_status') {
                    $table = isset($data['type']) && $data['type'] === 'example' ? 'examples' : 'platforms';

                    if ($table === 'examples') {
                        $stmt = $pdo->prepare("UPDATE {$table} SET is_active = ?, updated_at = NOW() WHERE id = ?");
                    } else {
                        $stmt = $pdo->prepare("UPDATE {$table} SET is_active = ? WHERE id = ?");
                    }

                    $stmt->execute($table === 'examples' ? [$data['is_active'], $data['id']] : [$data['is_active'], $data['id']]);
                    echo json_encode(['success' => true, 'message' => 'تم تحديث الحالة بنجاح']);
                    exit;
                }

                // Handle course management actions
                if (isset($data['action']) && $data['action'] === 'toggle_course_status') {
                    $course_id = $data['course_id'] ?? null;
                    $enable = $data['enable'] ?? 0;

                    if (!$course_id) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => 'معرف الكورس مطلوب']);
                        break;
                    }

                    $stmt = $pdo->prepare("UPDATE courses SET is_active = ? WHERE id = ?");
                    $stmt->execute([$enable, $course_id]);

                    echo json_encode(['success' => true, 'message' => 'تم تحديث حالة الكورس بنجاح']);
                    break;
                }

                if (isset($data['action']) && $data['action'] === 'delete_course') {
                    $course_id = $data['course_id'] ?? null;

                    if (!$course_id) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => 'معرف الكورس مطلوب']);
                        break;
                    }

                    // Start transaction for safe deletion
                    $pdo->beginTransaction();

                    try {
                        // Get course info for file deletion
                        $stmt = $pdo->prepare("SELECT title, category FROM courses WHERE id = ?");
                        $stmt->execute([$course_id]);
                        $course = $stmt->fetch(PDO::FETCH_ASSOC);

                        if (!$course) {
                            throw new Exception('الكورس غير موجود');
                        }

                        // Get all lesson video paths
                        $stmt = $pdo->prepare("SELECT video_data FROM lessons WHERE course_id = ?");
                        $stmt->execute([$course_id]);
                        $lessons = $stmt->fetchAll(PDO::FETCH_ASSOC);

                        // Delete video files from filesystem
                        foreach ($lessons as $lesson) {
                            if ($lesson['video_data'] && file_exists($lesson['video_data'])) {
                                unlink($lesson['video_data']);
                            }
                        }

                        // Delete course logo if exists
                        $stmt = $pdo->prepare("SELECT logo_path FROM courses WHERE id = ?");
                        $stmt->execute([$course_id]);
                        $logo = $stmt->fetchColumn();

                        if ($logo && file_exists($logo)) {
                            unlink($logo);
                        }

                        // Delete from database (lessons will be deleted by CASCADE if FK is set)
                        $stmt = $pdo->prepare("DELETE FROM lessons WHERE course_id = ?");
                        $stmt->execute([$course_id]);

                        $stmt = $pdo->prepare("DELETE FROM courses WHERE id = ?");
                        $stmt->execute([$course_id]);

                        $pdo->commit();

                        echo json_encode(['success' => true, 'message' => 'تم حذف الكورس وجميع الدروس المرتبطة به نهائياً']);

                    } catch (Exception $e) {
                        $pdo->rollBack();
                        http_response_code(500);
                        echo json_encode(['success' => false, 'message' => 'فشل في حذف الكورس: ' . $e->getMessage()]);
                    }
                    break;
                }

                // Handle course update
                if (isset($data['action']) && $data['action'] === 'update_course') {
                    $course_id = $data['id'] ?? null;
                    $title = $data['title'] ?? '';
                    $description = $data['description'] ?? '';
                    $category = $data['category'] ?? '';
                    $level = $data['level'] ?? '';
                    $main_points = $data['main_points'] ?? '';
                    $lessons = $data['lessons'] ?? [];

                    if (!$course_id || !$title || !$description || !$category || !$level) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => 'جميع الحقول المطلوبة يجب ملؤها']);
                        break;
                    }

                    if (!$course_id || !$title || !$description || !$category || !$level) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => 'جميع الحقول المطلوبة يجب ملؤها']);
                        break;
                    }

                    // Start transaction
                    $pdo->beginTransaction();

                    try {
                        // Update course
                        $stmt = $pdo->prepare("
                            UPDATE courses 
                            SET title = ?, description = ?, category = ?, level = ?, main_points = ?, updated_at = NOW()
                            WHERE id = ?
                        ");
                        $stmt->execute([$title, $description, $category, $level, $main_points, $course_id]);

                        // Handle lessons
                        $lesson_index = 0;
                        foreach ($lessons as $lesson) {
                            $lesson_index++;

                            // Check if there's a video file for this lesson
                            $video_path = null;
                            $video_mime = null;

                            if (isset($_FILES['lesson_video']['name'][$lesson_index - 1]) &&
                                $_FILES['lesson_video']['error'][$lesson_index - 1] === UPLOAD_ERR_OK) {

                                $video_dir = __DIR__ . '/videos/' . sanitize_folder_name($category) . '/' . sanitize_folder_name($title);
                                if (!is_dir($video_dir)) {
                                    mkdir($video_dir, 0777, true);
                                }

                                $video_filename = 'lesson_' . $lesson_index . '_' . uniqid() . '_' . basename($_FILES['lesson_video']['name'][$lesson_index - 1]);
                                $video_full_path = $video_dir . '/' . $video_filename;
                                $video_path = 'videos/' . sanitize_folder_name($category) . '/' . sanitize_folder_name($title) . '/' . $video_filename;
                                $video_mime = $_FILES['lesson_video']['type'][$lesson_index - 1];

                                if (!move_uploaded_file($_FILES['lesson_video']['tmp_name'][$lesson_index - 1], $video_full_path)) {
                                    throw new Exception('فشل في رفع فيديو الدرس: ' . $lesson['title']);
                                }
                            }

                            if (isset($lesson['id'])) {
                                // Update existing lesson
                                $update_fields = "title = ?, description = ?, sort_order = ?, resources_code = ?, updated_at = NOW()";
                                $update_values = [
                                    $lesson['title'],
                                    $lesson['description'] ?? '',
                                    $lesson['order_index'] ?? 0,
                                    $lesson['resources_code'] ?? ''
                                ];

                                // Add video fields if a new video was uploaded
                                if ($video_path) {
                                    $update_fields .= ", video_data = ?, video_mime = ?";
                                    $update_values[] = $video_path;
                                    $update_values[] = $video_mime;
                                }

                                $update_values[] = $lesson['id'];
                                $update_values[] = $course_id;

                                $stmt = $pdo->prepare("
                                    UPDATE lessons
                                    SET {$update_fields}
                                    WHERE id = ? AND course_id = ?
                                ");
                                $stmt->execute($update_values);
                            } else {
                                // Add new lesson
                                $stmt = $pdo->prepare("
                                    INSERT INTO lessons (course_id, title, description, sort_order, resources_code, video_data, video_mime, created_at)
                                    VALUES (?, ?, ?, ?, ?, ?, ?, NOW())
                                ");
                                $stmt->execute([
                                    $course_id,
                                    $lesson['title'],
                                    $lesson['description'] ?? '',
                                    $lesson['order_index'] ?? 0,
                                    $lesson['resources_code'] ?? '',
                                    $video_path,
                                    $video_mime
                                ]);
                            }
                        }

                        $pdo->commit();
                        echo json_encode(['success' => true, 'message' => 'تم تحديث الكورس بنجاح']);

                    } catch (Exception $e) {
                        $pdo->rollBack();
                        http_response_code(500);
                        echo json_encode(['success' => false, 'message' => 'فشل في تحديث الكورس: ' . $e->getMessage()]);
                    }
                    break;
                }

                // Handle course info update (without lessons/videos)
                if (isset($data['action']) && $data['action'] === 'update_course_info') {
                    $course_id = $data['id'] ?? null;
                    $title = $data['title'] ?? '';
                    $description = $data['description'] ?? '';
                    $category = $data['category'] ?? '';
                    $level = $data['level'] ?? '';
                    $main_points = $data['main_points'] ?? '';

                    if (!$course_id || !$title || !$description || !$category || !$level) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => 'جميع الحقول المطلوبة يجب ملؤها']);
                        break;
                    }

                    // Handle optional logo upload similar to admin_upload
                    $newLogoPath = null;
                    if (isset($_FILES['course_logo']) && $_FILES['course_logo']['error'] === UPLOAD_ERR_OK) {
                        $logoName = basename($_FILES['course_logo']['name']);
                        $ext = pathinfo($logoName, PATHINFO_EXTENSION);
                        $safeName = uniqid('logo_', true) . ($ext ? "." . $ext : '');

                        $uploadLogoDir = __DIR__ . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'logos';
                        if (!is_dir($uploadLogoDir)) {
                            @mkdir($uploadLogoDir, 0777, true);
                        }

                        $destPath = $uploadLogoDir . DIRECTORY_SEPARATOR . $safeName;
                        if (move_uploaded_file($_FILES['course_logo']['tmp_name'], $destPath)) {
                            $newLogoPath = 'uploads/logos/' . $safeName;

                            // Remove old logo if exists
                            $oldLogo = $pdo->prepare("SELECT logo_path FROM courses WHERE id = ?");
                            $oldLogo->execute([$course_id]);
                            $oldPath = $oldLogo->fetchColumn();
                            if ($oldPath && file_exists(__DIR__ . '/' . $oldPath)) {
                                @unlink(__DIR__ . '/' . $oldPath);
                            }
                        }
                    }

                    try {
                        if ($newLogoPath) {
                            $stmt = $pdo->prepare("
                                UPDATE courses 
                                SET title = ?, description = ?, category = ?, level = ?, main_points = ?, logo_path = ?, updated_at = NOW()
                                WHERE id = ?
                            ");
                            $stmt->execute([$title, $description, $category, $level, $main_points, $newLogoPath, $course_id]);
                        } else {
                            $stmt = $pdo->prepare("
                                UPDATE courses 
                                SET title = ?, description = ?, category = ?, level = ?, main_points = ?, updated_at = NOW()
                                WHERE id = ?
                            ");
                            $stmt->execute([$title, $description, $category, $level, $main_points, $course_id]);
                        }

                        echo json_encode(['success' => true, 'message' => 'تم تحديث معلومات الكورس بنجاح']);
                    } catch (Exception $e) {
                        http_response_code(500);
                        echo json_encode(['success' => false, 'message' => 'خطأ في تحديث الكورس']);
                    }
                    break;
                }

                // Handle single lesson update (metadata + optional video)
                if (isset($data['action']) && $data['action'] === 'update_lesson') {
                    $lesson_id = $data['lesson_id'] ?? null;
                    $title = $data['title'] ?? '';
                    $description = $data['description'] ?? '';
                    $resources_code = $data['resources_code'] ?? '';
                    $sort_order = isset($data['sort_order']) ? (int)$data['sort_order'] : 0;

                    if (!$lesson_id || !$title) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => 'معرف الدرس والعنوان مطلوبان']);
                        break;
                    }

                    // Resolve course info for pathing
                    $stmt = $pdo->prepare("SELECT l.course_id, c.title AS course_title, c.category, l.video_data FROM lessons l JOIN courses c ON l.course_id = c.id WHERE l.id = ?");
                    $stmt->execute([$lesson_id]);
                    $info = $stmt->fetch(PDO::FETCH_ASSOC);
                    if (!$info) {
                        http_response_code(404);
                        echo json_encode(['success' => false, 'message' => 'الدرس غير موجود']);
                        break;
                    }

                    $newVideoPath = null;
                    $newVideoMime = null;

                    if (isset($_FILES['lesson_video']) && $_FILES['lesson_video']['error'] === UPLOAD_ERR_OK) {
                        $ext = pathinfo($_FILES['lesson_video']['name'], PATHINFO_EXTENSION);
                        $videoDir = __DIR__ . '/videos/' . sanitize_folder_name($info['category']) . '/' . sanitize_folder_name($info['course_title']);
                        if (!is_dir($videoDir)) {
                            @mkdir($videoDir, 0777, true);
                        }
                        $fileName = 'lesson_' . $lesson_id . '_' . uniqid() . ($ext ? "." . $ext : '');
                        $fullPath = $videoDir . '/' . $fileName;
                        if (move_uploaded_file($_FILES['lesson_video']['tmp_name'], $fullPath)) {
                            $newVideoPath = 'videos/' . sanitize_folder_name($info['category']) . '/' . sanitize_folder_name($info['course_title']) . '/' . $fileName;
                            $newVideoMime = $_FILES['lesson_video']['type'] ?? null;

                            // Delete old file if exists
                            if (!empty($info['video_data']) && file_exists(__DIR__ . '/' . $info['video_data'])) {
                                @unlink(__DIR__ . '/' . $info['video_data']);
                            }
                        }
                    }

                    try {
                        if ($newVideoPath) {
                            $stmt = $pdo->prepare("UPDATE lessons SET title = ?, description = ?, resources_code = ?, sort_order = ?, video_data = ?, video_mime = ?, updated_at = NOW() WHERE id = ?");
                            $stmt->execute([$title, $description, $resources_code, $sort_order, $newVideoPath, $newVideoMime, $lesson_id]);
                        } else {
                            $stmt = $pdo->prepare("UPDATE lessons SET title = ?, description = ?, resources_code = ?, sort_order = ?, updated_at = NOW() WHERE id = ?");
                            $stmt->execute([$title, $description, $resources_code, $sort_order, $lesson_id]);
                        }

                        echo json_encode(['success' => true, 'message' => 'تم تحديث الدرس بنجاح']);
                    } catch (Exception $e) {
                        http_response_code(500);
                        echo json_encode(['success' => false, 'message' => 'فشل في تحديث الدرس']);
                    }
                    break;
                }

                // Handle lesson deletion
                if (isset($data['action']) && $data['action'] === 'delete_lesson') {
                    $lesson_id = $data['id'] ?? null;

                    if (!$lesson_id) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => 'معرف الدرس مطلوب']);
                        break;
                    }

                    // Remove video file if exists
                    $stmt = $pdo->prepare("SELECT video_data FROM lessons WHERE id = ?");
                    $stmt->execute([$lesson_id]);
                    $oldVideo = $stmt->fetchColumn();

                    $stmt = $pdo->prepare("DELETE FROM lessons WHERE id = ?");
                    $stmt->execute([$lesson_id]);

                    if ($oldVideo && file_exists(__DIR__ . '/' . $oldVideo)) {
                        @unlink(__DIR__ . '/' . $oldVideo);
                    }

                    echo json_encode(['success' => true, 'message' => 'تم حذف الدرس بنجاح']);
                    break;
                }

                // Handle lesson reordering
                if (isset($data['action']) && $data['action'] === 'reorder_lesson') {
                    $lesson_id = $data['lesson_id'] ?? null;
                    $direction = $data['direction'] ?? null; // 'up' or 'down'

                    if (!$lesson_id || !in_array($direction, ['up', 'down'])) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => 'معرف الدرس والاتجاه مطلوبان']);
                        break;
                    }

                    // Start transaction
                    $pdo->beginTransaction();

                    try {
                        // Get current lesson info
                        $stmt = $pdo->prepare("SELECT course_id, sort_order FROM lessons WHERE id = ?");
                        $stmt->execute([$lesson_id]);
                        $current_lesson = $stmt->fetch(PDO::FETCH_ASSOC);

                        if (!$current_lesson) {
                            throw new Exception('الدرس غير موجود');
                        }

                        $course_id = $current_lesson['course_id'];
                        $current_order = $current_lesson['sort_order'];

                        // Find adjacent lesson
                        if ($direction === 'up') {
                            $stmt = $pdo->prepare("
                                SELECT id, sort_order FROM lessons
                                WHERE course_id = ? AND sort_order < ?
                                ORDER BY sort_order DESC LIMIT 1
                            ");
                        } else {
                            $stmt = $pdo->prepare("
                                SELECT id, sort_order FROM lessons
                                WHERE course_id = ? AND sort_order > ?
                                ORDER BY sort_order ASC LIMIT 1
                            ");
                        }

                        $stmt->execute([$course_id, $current_order]);
                        $adjacent_lesson = $stmt->fetch(PDO::FETCH_ASSOC);

                        if (!$adjacent_lesson) {
                            // No adjacent lesson to swap with
                            $pdo->rollBack();
                            echo json_encode(['success' => false, 'message' => 'لا يمكن نقل الدرس في هذا الاتجاه']);
                            break;
                        }

                        // Swap sort orders
                        $stmt = $pdo->prepare("UPDATE lessons SET sort_order = ? WHERE id = ?");
                        $stmt->execute([$adjacent_lesson['sort_order'], $lesson_id]);

                        $stmt = $pdo->prepare("UPDATE lessons SET sort_order = ? WHERE id = ?");
                        $stmt->execute([$current_order, $adjacent_lesson['id']]);

                        $pdo->commit();
                        echo json_encode(['success' => true, 'message' => 'تم إعادة ترتيب الدرس بنجاح']);

                    } catch (Exception $e) {
                        $pdo->rollBack();
                        http_response_code(500);
                        echo json_encode(['success' => false, 'message' => 'فشل في إعادة ترتيب الدرس: ' . $e->getMessage()]);
                    }
                    break;
                }

                // Check if this is an example (has title field) or platform (has name field)
                if (isset($data['title'])) {
                    // Add new example
                    $required_fields = ['title', 'description', 'category', 'difficulty', 'code_language', 'code_snippet'];
                    foreach ($required_fields as $field) {
                        if (empty($data[$field])) {
                            http_response_code(400);
                            echo json_encode(['success' => false, 'message' => "الحقل {$field} مطلوب"]);
                            exit;
                        }
                    }

                    // Prepare technologies as JSON
                    $technologies = isset($data['technologies']) ? json_encode($data['technologies']) : '[]';

                    $stmt = $pdo->prepare("
                        INSERT INTO examples (title, description, category, difficulty, image_url, code_snippet, code_language, technologies, demo_url, requires_special_env, special_env_message, is_active, created_at, updated_at)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())
                    ");

                    $stmt->execute([
                        $data['title'],
                        $data['description'],
                        $data['category'],
                        $data['difficulty'],
                        $data['image_url'] ?? null,
                        $data['code_snippet'],
                        $data['code_language'],
                        $technologies,
                        $data['demo_url'] ?? null,
                        isset($data['requires_special_env']) ? 1 : 0,
                        $data['special_env_message'] ?? null,
                        isset($data['is_active']) ? 1 : 0
                    ]);

                    echo json_encode(['success' => true, 'message' => 'تم إضافة المثال بنجاح']);
                } else {
                    // Add new platform (existing logic)
                    $required_fields = ['name', 'description', 'url', 'category', 'level', 'language'];
                    foreach ($required_fields as $field) {
                        if (empty($data[$field])) {
                            http_response_code(400);
                            echo json_encode(['success' => false, 'message' => "الحقل {$field} مطلوب"]);
                            exit;
                        }
                    }

                    // Prepare features as JSON
                    $features = isset($data['features']) ? json_encode($data['features']) : '[]';

                    $stmt = $pdo->prepare("
                    INSERT INTO platforms (name, description, url, category, level, language,
                                         user_count, problem_count, features, logo_url)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");

                $stmt->execute([
                    $data['name'],
                    $data['description'],
                    $data['url'],
                    $data['category'],
                    $data['level'],
                    $data['language'],
                    $data['user_count'] ?? 0,
                    $data['problem_count'] ?? 0,
                    $features,
                    $data['logo_url'] ?? ''
                ]);

                $new_id = $pdo->lastInsertId();
                echo json_encode([
                    'success' => true,
                    'message' => 'تم إضافة المنصة بنجاح',
                    'platform_id' => $new_id
                ]);
                }
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => 'خطأ في قاعدة البيانات: ' . $e->getMessage()]);
            }
            break;

        case 'PUT':
            // Handle both platforms and examples updates
            $data = json_decode(file_get_contents('php://input'), true);

            if (!$data) {
                $data = $_POST;
            }

            if (!isset($data['id'])) {
                http_response_code(400);
                echo json_encode(['success' => false, 'message' => 'المعرف مطلوب']);
                exit;
            }

            // Check if this is an example (has title field) or platform (has name field)
            if (isset($data['title'])) {
                // Update example
                $required_fields = ['title', 'description', 'category', 'difficulty', 'code_language', 'code_snippet'];
                foreach ($required_fields as $field) {
                    if (empty($data[$field])) {
                        http_response_code(400);
                        echo json_encode(['success' => false, 'message' => "الحقل {$field} مطلوب"]);
                        exit;
                    }
                }

                // Check if example exists
                $stmt = $pdo->prepare("SELECT id FROM examples WHERE id = ?");
                $stmt->execute([$data['id']]);
                if ($stmt->rowCount() === 0) {
                    http_response_code(404);
                    echo json_encode(['success' => false, 'message' => 'المثال غير موجود']);
                    exit;
                }

                // Prepare technologies as JSON
                $technologies = isset($data['technologies']) ? json_encode($data['technologies']) : '[]';

                $stmt = $pdo->prepare("
                    UPDATE examples
                    SET title = ?, description = ?, category = ?, difficulty = ?, image_url = ?,
                        code_snippet = ?, code_language = ?, technologies = ?, demo_url = ?,
                        requires_special_env = ?, special_env_message = ?, is_active = ?,
                        updated_at = NOW()
                    WHERE id = ?
                ");

                $stmt->execute([
                    $data['title'],
                    $data['description'],
                    $data['category'],
                    $data['difficulty'],
                    $data['image_url'] ?? null,
                    $data['code_snippet'],
                    $data['code_language'],
                    $technologies,
                    $data['demo_url'] ?? null,
                    isset($data['requires_special_env']) ? 1 : 0,
                    $data['special_env_message'] ?? null,
                    isset($data['is_active']) ? 1 : 0,
                    $data['id']
                ]);

                echo json_encode(['success' => true, 'message' => 'تم تحديث المثال بنجاح']);
            } else {
                // Update platform (existing logic)
                // Check if platform exists
                $stmt = $pdo->prepare("SELECT id FROM platforms WHERE id = ?");
                $stmt->execute([$data['id']]);
                if ($stmt->rowCount() === 0) {
                    http_response_code(404);
                    echo json_encode(['success' => false, 'message' => 'المنصة غير موجودة']);
                    exit;
                }

                // Prepare features as JSON
                $features = isset($data['features']) ? json_encode($data['features']) : '[]';

                $stmt = $pdo->prepare("
                    UPDATE platforms
                    SET name = ?, description = ?, url = ?, category = ?, level = ?, language = ?,
                        user_count = ?, problem_count = ?, features = ?, logo_url = ?,
                        is_active = ?
                    WHERE id = ?
                ");

                $stmt->execute([
                    $data['name'],
                    $data['description'],
                    $data['url'],
                    $data['category'],
                    $data['level'],
                    $data['language'],
                $data['user_count'] ?? 0,
                $data['problem_count'] ?? 0,
                $features,
                $data['logo_url'] ?? '',
                $data['is_active'] ?? true,
                $data['id']
            ]);

            echo json_encode(['success' => true, 'message' => 'تم تحديث المنصة بنجاح']);
            }
            break;

        case 'DELETE':
            // Handle both platforms and examples deletion
            if (!isset($_GET['id'])) {
                http_response_code(400);
                echo json_encode(['success' => false, 'message' => 'المعرف مطلوب']);
                exit;
            }

            $permanent = isset($_GET['permanent']) && $_GET['permanent'] === 'true';
            $type = $_GET['type'] ?? 'platform'; // Default to platform for backward compatibility

            if ($type === 'example') {
                if ($permanent) {
                    // Permanent delete example
                    $stmt = $pdo->prepare("DELETE FROM examples WHERE id = ?");
                    $stmt->execute([$_GET['id']]);
                    echo json_encode(['success' => true, 'message' => 'تم حذف المثال نهائياً بنجاح']);
                } else {
                    // Soft delete example
                    $stmt = $pdo->prepare("UPDATE examples SET is_active = 0 WHERE id = ?");
                    $stmt->execute([$_GET['id']]);
                    echo json_encode(['success' => true, 'message' => 'تم إلغاء تفعيل المثال بنجاح']);
                }
            } elseif ($type === 'course') {
                if ($permanent) {
                    // Permanent delete course with lessons and videos
                    $pdo->beginTransaction();
                    try {
                        // Get course info
                        $stmt = $pdo->prepare("SELECT title, category, logo_path FROM courses WHERE id = ?");
                        $stmt->execute([$_GET['id']]);
                        $course = $stmt->fetch(PDO::FETCH_ASSOC);

                        if (!$course) {
                            throw new Exception('الكورس غير موجود');
                        }

                        // Get all lesson video paths
                        $stmt = $pdo->prepare("SELECT video_data FROM lessons WHERE course_id = ?");
                        $stmt->execute([$_GET['id']]);
                        $lessons = $stmt->fetchAll(PDO::FETCH_ASSOC);

                        // Delete video files
                        foreach ($lessons as $lesson) {
                            if ($lesson['video_data'] && file_exists(__DIR__ . '/' . $lesson['video_data'])) {
                                unlink(__DIR__ . '/' . $lesson['video_data']);
                            }
                        }

                        // Delete course logo
                        if ($course['logo_path'] && file_exists(__DIR__ . '/' . $course['logo_path'])) {
                            unlink(__DIR__ . '/' . $course['logo_path']);
                        }

                        // Delete from database
                        $stmt = $pdo->prepare("DELETE FROM lessons WHERE course_id = ?");
                        $stmt->execute([$_GET['id']]);

                        $stmt = $pdo->prepare("DELETE FROM courses WHERE id = ?");
                        $stmt->execute([$_GET['id']]);

                        $pdo->commit();
                        echo json_encode(['success' => true, 'message' => 'تم حذف الكورس وجميع الدروس والفيديوهات المرتبطة به نهائياً']);
                    } catch (Exception $e) {
                        $pdo->rollBack();
                        http_response_code(500);
                        echo json_encode(['success' => false, 'message' => 'فشل في حذف الكورس: ' . $e->getMessage()]);
                    }
                } else {
                    // Soft delete course
                    $stmt = $pdo->prepare("UPDATE courses SET is_active = 0 WHERE id = ?");
                    $stmt->execute([$_GET['id']]);
                    echo json_encode(['success' => true, 'message' => 'تم إلغاء تفعيل الكورس بنجاح']);
                }
            } else {
                if ($permanent) {
                    // Permanent delete platform
                    $stmt = $pdo->prepare("DELETE FROM platforms WHERE id = ?");
                    $stmt->execute([$_GET['id']]);
                    echo json_encode(['success' => true, 'message' => 'تم حذف المنصة نهائياً بنجاح']);
                } else {
                    // Soft delete platform
                    $stmt = $pdo->prepare("UPDATE platforms SET is_active = 0 WHERE id = ?");
                    $stmt->execute([$_GET['id']]);
                    echo json_encode(['success' => true, 'message' => 'تم إلغاء تفعيل المنصة بنجاح']);
                }
            }
            break;

        default:
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'طريقة الطلب غير مدعومة']);
    }

} catch (PDOException $e) {
    error_log('Database error in admin_platforms.php: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'حدث خطأ في النظام، يرجى المحاولة لاحقاً']);
}

?>