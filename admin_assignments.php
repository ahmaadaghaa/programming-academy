<?php
// admin_assignments.php - Handle assignment management for admin
session_start();
require 'db_connect.php';

// Admin authentication check
if (!isset($_SESSION['user_id']) || !isset($_SESSION['roles']) || !in_array('admin', $_SESSION['roles'])) {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        if (isset($_GET['id'])) {
            // Get single assignment
            getAssignment($_GET['id']);
        } else {
            // Get all assignments
            getAllAssignments();
        }
        break;

    case 'POST':
        // Create new assignment
        createAssignment();
        break;

    case 'PUT':
        // Update assignment
        updateAssignment();
        break;

    case 'DELETE':
        // Delete assignment
        deleteAssignment($_GET['id']);
        break;

    default:
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
        break;
}

function getAllAssignments() {
    global $pdo;

    try {
        $stmt = $pdo->query("SELECT a.id, a.course_id, a.question, a.difficulty, a.assignment_order, a.created_at, c.title as course_title, c.category FROM assignments a JOIN courses c ON a.course_id = c.id ORDER BY c.category, c.title, a.assignment_order");
        $assignments = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode(['success' => true, 'assignments' => $assignments]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Database error']);
    }
}

function getAssignment($id) {
    global $pdo;

    try {
        $stmt = $pdo->prepare("SELECT a.id, a.course_id, a.question, a.difficulty, a.assignment_order, a.created_at, c.title as course_title, c.category FROM assignments a JOIN courses c ON a.course_id = c.id WHERE a.id = ?");
        $stmt->execute([$id]);
        $assignment = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($assignment) {
            echo json_encode(['success' => true, 'assignment' => $assignment]);
        } else {
            http_response_code(404);
            echo json_encode(['success' => false, 'message' => 'Assignment not found']);
        }
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Database error']);
    }
}

function createAssignment() {
    global $pdo;

    $data = json_decode(file_get_contents('php://input'), true);

    if (!$data || !isset($data['course_id']) || !isset($data['question']) || !isset($data['difficulty']) || !isset($data['assignment_order'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Missing required fields']);
        return;
    }

    try {
        $stmt = $pdo->prepare("INSERT INTO assignments (course_id, question, difficulty, assignment_order) VALUES (?, ?, ?, ?)");
        $stmt->execute([$data['course_id'], $data['question'], $data['difficulty'], $data['assignment_order']]);

        echo json_encode(['success' => true, 'message' => 'Assignment created successfully']);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Database error']);
    }
}

function updateAssignment() {
    global $pdo;

    $data = json_decode(file_get_contents('php://input'), true);

    if (!$data || !isset($data['id']) || !isset($data['course_id']) || !isset($data['question']) || !isset($data['difficulty']) || !isset($data['assignment_order'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Missing required fields']);
        return;
    }

    try {
        $stmt = $pdo->prepare("UPDATE assignments SET course_id = ?, question = ?, difficulty = ?, assignment_order = ? WHERE id = ?");
        $stmt->execute([$data['course_id'], $data['question'], $data['difficulty'], $data['assignment_order'], $data['id']]);

        echo json_encode(['success' => true, 'message' => 'Assignment updated successfully']);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Database error']);
    }
}

function deleteAssignment($id) {
    global $pdo;

    if (!$id) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Assignment ID required']);
        return;
    }

    try {
        $stmt = $pdo->prepare("DELETE FROM assignments WHERE id = ?");
        $stmt->execute([$id]);

        echo json_encode(['success' => true, 'message' => 'Assignment deleted successfully']);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Database error']);
    }
}
?>