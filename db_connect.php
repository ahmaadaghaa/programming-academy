<?php
// db_connect.php

// 1. Define Database Credentials
$host = 'localhost'; // Usually 'localhost' or your server IP
$dbname = 'programming_academy'; // **REPLACE** with your database name
$user = 'root'; // **REPLACE** with your database username
$pass = ''; // **REPLACE** with your database password

// 2. Set DSN (Data Source Name)
$dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";

// 3. Set PDO Options (for secure and reliable connections)
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION, // Throw exceptions on errors
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,       // Return results as associative arrays
    PDO::ATTR_EMULATE_PREPARES   => false,                  // Use native prepared statements
];

// 4. Create a PDO Connection
try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    // Return a JSON error response if the connection fails
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database connection failed: ' . $e->getMessage()]);
    exit();
}

// The $pdo variable now holds the connection object, ready for queries.
?>