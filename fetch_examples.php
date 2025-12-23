<?php
// fetch_examples.php - API to fetch programming examples

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

try {
    require 'db_connect.php';

    // Get query parameters
    $category = $_GET['category'] ?? 'all';
    $search = $_GET['search'] ?? '';
    $difficulty = $_GET['difficulty'] ?? 'all';
    $limit = (int)($_GET['limit'] ?? 50);
    $offset = (int)($_GET['offset'] ?? 0);

    $sql = "SELECT id, title, description, category, difficulty, image_url,
                   code_snippet, code_language, technologies, demo_url, requires_special_env, special_env_message, created_at
            FROM examples
            WHERE is_active = 1";

    $params = [];

    // Add filters
    if ($category !== 'all') {
        $sql .= " AND category = ?";
        $params[] = $category;
    }

    if ($difficulty !== 'all') {
        $sql .= " AND difficulty = ?";
        $params[] = $difficulty;
    }

    if (!empty($search)) {
        $sql .= " AND (title LIKE ? OR description LIKE ?)";
        $params[] = "%$search%";
        $params[] = "%$search%";
    }

    $sql .= " ORDER BY created_at DESC LIMIT ? OFFSET ?";
    $params[] = $limit;
    $params[] = $offset;

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $examples = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Process technologies JSON
    foreach ($examples as &$example) {
        if ($example['technologies']) {
            $example['technologies'] = json_decode($example['technologies'], true);
        } else {
            $example['technologies'] = [];
        }
    }

    echo json_encode([
        'success' => true,
        'examples' => $examples,
        'total' => count($examples)
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Failed to fetch examples: ' . $e->getMessage()
    ]);
}
?>