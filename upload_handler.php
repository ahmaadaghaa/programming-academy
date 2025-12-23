<?php
// upload_handler.php - المعالج الرئيسي للرفع والملفات

require 'admin_check.php'; // التأكد من أن المستخدم مدير
require 'db_connect.php'; // اتصال قاعدة البيانات

// --- 1. فحص الحماية: يجب أن يكون الطلب POST فقط ---
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: admin.php?tab=courses'); 
    exit();
}

/**
 * وظيفة لتنظيف الأسماء وجعلها آمنة للاستخدام كمسارات مجلدات
 */
function sanitize_folder_name($name) {
    $name = preg_replace('/[^\\w\\-\\s\\.]/u', '', $name); 
    $name = trim($name);
    $name = str_replace(' ', '_', $name);
    return empty($name) ? 'default_folder' : mb_substr($name, 0, 100, 'UTF-8');
}

try {
    $pdo->beginTransaction();

    $courseId = $_POST['course_id'] ?? null;
    $courseTitle = "";
    $courseCategory = "";
    $courseLogoPath = null;

    // -----------------------------------------------------------------------
    // 🚨 Step 1: Handle Course Creation OR Fetch Existing Course Details 🚨
    // -----------------------------------------------------------------------
    if ($courseId === 'new') {
        // --- A: Create New Course ---
        $newCourseTitle = $_POST['new_course_title'] ?? null;
        $newCourseCategory = $_POST['new_course_category'] ?? null;
        $newCourseDescription = $_POST['new_course_description'] ?? null;
        $newCoursePoints = $_POST['new_course_main_points'] ?? null; 
        
        // 🚨 FIX 1: تم تغيير اسم المتغير من new_course_main_level إلى level 🚨
        $newCourselevel = $_POST['level'] ?? null; 
        
        if (empty($newCourseTitle) || empty($newCourseCategory)) {
            throw new Exception("New course title and category are required.");
        }

        // 🚨 FIXED: معالجة شعار الكورس بشكل صحيح - بدون مسافات 🚨
if (isset($_FILES['course_logo']) && $_FILES['course_logo']['error'] === UPLOAD_ERR_OK) {
    // التحقق من نوع الملف
    $allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
    $logoMimeType = $_FILES['course_logo']['type'];
    
    if (!in_array($logoMimeType, $allowedTypes)) {
        throw new Exception("Invalid logo file type. Only JPEG, PNG, GIF, and WebP are allowed.");
    }
    
    // التحقق من حجم الملف (5MB max)
    if ($_FILES['course_logo']['size'] > 5 * 1024 * 1024) {
        throw new Exception("Logo file size exceeds 5MB limit.");
    }
    
    $logoTempName = $_FILES['course_logo']['tmp_name'];
    
    // 🚨 FIX: تنظيف اسم الملف - إزالة المسافات والأحرف الخاصة 🚨
    $originalName = $_FILES['course_logo']['name'];
    $logoExtension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    
    // إنشاء اسم ملف آمن بدون مسافات
    $safeBaseName = preg_replace('/[^a-zA-Z0-9_-]/', '_', pathinfo($originalName, PATHINFO_FILENAME));
    $safeBaseName = preg_replace('/_+/', '_', $safeBaseName); // إزالة الشرطات السفلية المتكررة
    $safeBaseName = trim($safeBaseName, '_'); // إزالة الشرطات من البداية والنهاية
    
    // إذا كان الاسم فارغاً بعد التنظيف، استخدم اسم افتراضي
    if (empty($safeBaseName)) {
        $safeBaseName = 'course_logo';
    }
    
    $logoFilename = 'logo_' . uniqid() . '_' . $safeBaseName . '.' . $logoExtension;
    
    // إنشاء مجلد الشعارات إن لم يكن موجوداً
    $uploadLogoDir = __DIR__ . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'logos';
    if (!is_dir($uploadLogoDir)) {
        if (!@mkdir($uploadLogoDir, 0777, true)) {
            throw new Exception("Failed to create logos directory.");
        }
    }
    
    $logoFullPath = $uploadLogoDir . DIRECTORY_SEPARATOR . $logoFilename;
    
    // نقل الملف
    if (move_uploaded_file($logoTempName, $logoFullPath)) {
        // حفظ المسار النسبي في قاعدة البيانات
        $courseLogoPath = 'uploads/logos/' . $logoFilename;
        error_log("Logo uploaded successfully: " . $courseLogoPath);
    } else {
        error_log("Failed to move logo file: " . $logoFilename);
        $courseLogoPath = null;
    }
}

        // 🚨 FIX 2 & 3: تم تعديل استعلام SQL ليحتوي على 6 علامات استفهام + NOW() لتطابق 7 أعمدة 🚨
        $stmt = $pdo->prepare(
            "INSERT INTO courses (title, description, main_points, category, logo_path, level, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())"
        );
        $stmt->execute([
            $newCourseTitle,
            $newCourseDescription,
            $newCoursePoints,
            $newCourseCategory,
            $courseLogoPath,
            $newCourselevel // القيمة الجديدة للمستوى
        ]);
        $courseId = $pdo->lastInsertId();
        $courseTitle = $newCourseTitle;
        $courseCategory = $newCourseCategory;
        

    } else {
        // --- B: Fetch Existing Course Details ---
        if (empty($courseId)) {
            throw new Exception("Please select a course or choose to create a new one.");
        }
        $stmt = $pdo->prepare("SELECT title, category FROM courses WHERE id = ?");
        $stmt->execute([$courseId]);
        $courseData = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$courseData) {
            throw new Exception("Selected course does not exist.");
        }
        $courseTitle = $courseData['title'];
        $courseCategory = $courseData['category'];
    }
    
    // -----------------------------------------------------------------------
    // Step 2: Process Uploaded Video Files
    // -----------------------------------------------------------------------
    
    if (!isset($_FILES['videos']) || empty($_FILES['videos']['name'][0])) {
        $pdo->commit(); 
        echo "<h1>Success!</h1><p>Course <b>'{$courseTitle}'</b> was " . ($courseId === 'new' ? 'created' : 'selected') . " successfully" . ($courseLogoPath ? " with logo" : "") . " with no lessons uploaded.</p><p><a href='admin.php?tab=courses'>Go back</a></p>";
        exit;
    }

    $videoCount = count($_FILES['videos']['name']);
    $lessonTitles = $_POST['titles'] ?? [];

    if ($videoCount !== count($lessonTitles)) {
        throw new Exception("The number of uploaded videos does not match the number of lesson titles.");
    }

    $safeCategory = sanitize_folder_name($courseCategory ?? 'Other'); 
    $safeTitle = sanitize_folder_name($courseTitle);
    
    $courseUploadDir = __DIR__ . DIRECTORY_SEPARATOR . 'videos' . DIRECTORY_SEPARATOR . $safeCategory . DIRECTORY_SEPARATOR . $courseId . DIRECTORY_SEPARATOR; 
    
    if (!is_dir($courseUploadDir) && !@mkdir($courseUploadDir, 0777, true)) {
        throw new Exception("Failed to create upload directory: " . $courseUploadDir);
    }
    
    // Determine starting sort order (append after existing lessons)
    $stmt = $pdo->prepare("SELECT COALESCE(MAX(sort_order), 0) FROM lessons WHERE course_id = ?");
    $stmt->execute([$courseId]);
    $baseSortOrder = (int)$stmt->fetchColumn();

    for ($i = 0; $i < $videoCount; $i++) {
        if ($_FILES['videos']['error'][$i] !== UPLOAD_ERR_OK) {
            throw new Exception("Error uploading file: " . $_FILES['videos']['name'][$i]);
        }

        $tmpName = $_FILES['videos']['tmp_name'][$i];
        
        $fileExtension = pathinfo($_FILES['videos']['name'][$i], PATHINFO_EXTENSION);
        $uniqueFilename = uniqid('lesson_', true) . '.' . $fileExtension;
        $destinationPath = $courseUploadDir . $uniqueFilename;

        if (move_uploaded_file($tmpName, $destinationPath)) {
            $title = $lessonTitles[$i];
            $description = $_POST['descriptions'][$i] ?? null;
            $code = $_POST['codes'][$i] ?? null;
            
            $relativePath = 'videos' . DIRECTORY_SEPARATOR . $safeCategory . DIRECTORY_SEPARATOR . $courseId . DIRECTORY_SEPARATOR . $uniqueFilename;
            
            $sortOrder = $baseSortOrder + $i + 1; // append after existing lessons

            $stmt = $pdo->prepare(
                "INSERT INTO lessons (course_id, title, description, video_data, video_mime, resources_code, sort_order, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())"
            );
            $stmt->execute([$courseId, $title, $description, $relativePath, $_FILES['videos']['type'][$i], $code, $sortOrder]);
        } else {
            throw new Exception("Could not move uploaded file: " . $_FILES['videos']['name'][$i]);
        }
    }

    $pdo->commit();
    
    $logoMessage = $courseLogoPath ? " مع شعار الكورس" : "";
    echo "<h1>Upload Successful!</h1><p>{$videoCount} lessons were added to the course <b>'{$courseTitle}'</b>{$logoMessage}.</p><p><a href='admin.php?tab=courses'>Go back</a></p>";

} catch (\PDOException $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    error_log("Database Error: " . $e->getMessage());
    die('An error occurred in the database. Please check the server logs for details.');
} catch (\Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    error_log("Logic/File Error: " . $e->getMessage());
    die('Error: ' . $e->getMessage());
}
?>