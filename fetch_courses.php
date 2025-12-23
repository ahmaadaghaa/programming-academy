<?php
// fetch_courses.php - API عام لجلب الكورسات حسب التصنيف (يعمل مع جميع الفئات)

// التأكد من أن جميع الأخطاء سيتم معالجتها كـ JSON
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); 
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

try {
    // 🚨 يجب التأكد من وجود ملف db_connect.php في نفس المجلد 🚨
    require 'db_connect.php'; 
    
    // 1. استقبال معامل التصنيف من رابط الـ URL
    $category = $_GET['category'] ?? null;
    
    // بناء استعلام SQL لجلب البيانات الكاملة للكورسات مع عدد الدروس
    $sql = "SELECT 
                c.id, 
                c.title, 
                c.description, 
                c.category, 
                c.main_points,
                c.logo_path,
                c.created_at,
                c.level,
                COUNT(l.id) as lesson_count

            FROM courses c
            LEFT JOIN lessons l ON c.id = l.course_id";
    
    $params = [];
    
    // 2. تطبيق شرط WHERE إذا تم تحديد تصنيف
    $sql .= " WHERE c.is_active = 1";
    if ($category) {
        $sql .= " AND c.category = ?";
        $params[] = $category;
    }
    
    // 3. التجميع والترتيب - ضمان إدراج جميع الأعمدة غير المجمّعة 🚨
    $sql .= " GROUP BY c.id, c.title, c.description, c.category, c.main_points, c.logo_path, c.created_at , c.level ORDER BY c.created_at DESC";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // 4. معالجة البيانات قبل الإرسال
    $processedCourses = [];
    foreach ($courses as $course) {
        // تحويل main_points من string إلى array (بافتراض أنها مفصولة بأسطر جديدة)
        $points = array_filter(array_map('trim', explode("\n", trim($course['main_points'] ?? ''))));
        $course['main_points'] = array_values($points); // Re-index array
        
        $course['icon_class'] = determineIconClass($course['title']);
        $course['color_class'] = determineColorClass($course['title']);
        
        // 🚨 FIX: معالجة مسار الشعار بشكل صحيح 🚨
        if (!empty($course['logo_path'])) {
            $logoPath = $course['logo_path'];
            
            // تحويل الـ backslashes إلى forward slashes
            $logoPath = str_replace('\\', '/', $logoPath);
            
            // إزالة أي / من البداية إذا وجدت
            $logoPath = ltrim($logoPath, '/');
            
            // بناء المسار الكامل على السيرفر
            $fullPath = __DIR__ . DIRECTORY_SEPARATOR . $logoPath;
            
            // التحقق من وجود الملف فعلياً
            if (file_exists($fullPath)) {
                // إرجاع المسار النسبي بدون / في البداية
                // سيتم إضافة ../ في الـ HTML حسب موقع الصفحة
                $course['logo_path'] = $logoPath;
            } else {
                // إذا لم يكن الملف موجوداً، نجعل logo_path فارغاً
                error_log("Logo file not found: " . $fullPath);
                $course['logo_path'] = null;
            }
        } else {
            $course['logo_path'] = null;
        }

        $processedCourses[] = $course;
    }

    // إرسال البيانات كـ JSON
    echo json_encode(['success' => true, 'courses' => $processedCourses]);

} catch (\PDOException $e) {
    // 🚨 معالجة أخطاء قاعدة البيانات 🚨
    http_response_code(500);
    echo json_encode([
        'success' => false, 
        'message' => 'Database error: Could not fetch courses. Check MySQL logs.', 
        'details' => $e->getMessage()
    ]);
    exit;
} catch (\Exception $e) {
    // 🚨 معالجة الأخطاء العامة (مثل عدم وجود db_connect.php) 🚨
    http_response_code(500);
    echo json_encode([
        'success' => false, 
        'message' => 'Server error: ' . $e->getMessage()
    ]);
    exit;
}

// ----------------------------------------------------------------
// تعريف الدوال المساعدة (لضمان أنها موجودة)
// ----------------------------------------------------------------
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