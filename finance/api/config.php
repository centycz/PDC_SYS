<?php
// Database configuration for finance system
error_reporting(E_ALL);
ini_set('display_errors', 1);

// CORS headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Database connection
function getFinanceDb() {
    static $pdo = null;
    if ($pdo) return $pdo;
    
    try {
        $dbPath = __DIR__ . '/../db/finance.db';
        $pdo = new PDO('sqlite:' . $dbPath);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        
        // Create table if it doesn't exist
        $pdo->exec("
            CREATE TABLE IF NOT EXISTS transactions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                type TEXT NOT NULL CHECK(type IN ('income', 'expense')),
                amount DECIMAL(10,2) NOT NULL,
                description TEXT NOT NULL,
                category TEXT NOT NULL,
                date DATE NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ");
        
        return $pdo;
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'error' => 'Database connection failed: ' . $e->getMessage()]);
        exit;
    }
}

// Input sanitization function
function sanitizeInput($input) {
    if (is_array($input)) {
        return array_map('sanitizeInput', $input);
    }
    return htmlspecialchars(trim($input), ENT_QUOTES, 'UTF-8');
}

// JSON response helper
function jsonResponse($success, $data = null, $message = null) {
    echo json_encode([
        'success' => $success,
        'data' => $data,
        'message' => $message
    ]);
    exit;
}

// Validate required fields
function validateRequired($data, $fields) {
    foreach ($fields as $field) {
        if (!isset($data[$field]) || empty(trim($data[$field]))) {
            jsonResponse(false, null, "Field '$field' is required");
        }
    }
}

// Validate transaction type
function validateTransactionType($type) {
    if (!in_array($type, ['income', 'expense'])) {
        jsonResponse(false, null, "Type must be 'income' or 'expense'");
    }
}

// Validate amount
function validateAmount($amount) {
    if (!is_numeric($amount) || $amount <= 0) {
        jsonResponse(false, null, "Amount must be a positive number");
    }
}

// Validate date format
function validateDate($date) {
    $d = DateTime::createFromFormat('Y-m-d', $date);
    if (!$d || $d->format('Y-m-d') !== $date) {
        jsonResponse(false, null, "Date must be in YYYY-MM-DD format");
    }
}
?>