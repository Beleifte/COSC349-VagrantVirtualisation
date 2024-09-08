<?php
// Start the session
session_start();

// Unset all session variables
session_unset();

// Destroy the session
session_destroy();

// Redirect to the homepage
header('Location: http://127.0.0.1:8080/index.php');
exit;
?>