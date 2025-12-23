<?php
// add_language_to_users.php - Add language column to users table
require 'db_connect.php';

try {
    // Add language column
    $pdo->exec("ALTER TABLE users ADD COLUMN preferred_language VARCHAR(5) DEFAULT 'ar' AFTER email");
    echo "✓ Language column added successfully\n";
} catch (PDOException $e) {
    if (strpos($e->getMessage(), 'Duplicate column') !== false) {
        echo "✓ Language column already exists\n";
    } else {
        echo "✗ Error: " . $e->getMessage() . "\n";
    }
}
?>
