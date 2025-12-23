<?php
session_start();

// Redirect to login if the user is not even logged in
if (!isset($_SESSION['user_id'])) {
    header('Location: /login.html');
    exit();
}

// Check if the user has the 'admin' role
$hasAdminRole = false;
if (isset($_SESSION['roles']) && in_array('admin', $_SESSION['roles'])) {
    $hasAdminRole = true;
}

if (!$hasAdminRole) {
    // You can show a 403 Forbidden error or redirect them
    http_response_code(403);
    die('<h1>Access Denied</h1><p>You do not have permission to view this page.</p>');
}

// If the script reaches here, the user is a verified admin.
?>