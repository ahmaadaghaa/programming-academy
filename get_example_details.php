<?php
// get_example_details.php - API to get full example details including code

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
session_start();
require 'db_connect.php';

$exampleId = (int)($_GET['id'] ?? 0);

if (!$exampleId) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Example ID required']);
    exit;
}

try {
    // Get example details
    $stmt = $pdo->prepare("SELECT * FROM examples WHERE id = ? AND is_active = 1");
    $stmt->execute([$exampleId]);
    $example = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$example) {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Example not found']);
        exit;
    }

    // Process technologies
    $example['technologies'] = json_decode($example['technologies'] ?? '[]', true);

    echo json_encode(['success' => true, 'example' => $example]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Failed to fetch example: ' . $e->getMessage()]);
}
?>