<?php
session_start();

// Check if the user is logged in by checking the session variable
$customer = isset($_SESSION['customer']) ? $_SESSION['customer'] : null;
?>
<nav>
    <a class="nav" href="http://127.0.0.1:8080/index.php">Home</a>
    <a href="http://127.0.0.1:8080/view-products.php">Browse Products</a>
    <?php if ($customer): ?>
        <p id="customer">Welcome Valued Customer</p>
        <form action="customer-sign-out.php" method="get" id="signoutForm">
            <button type="submit" id="signout">Sign Out</button>
        </form>
        <button type="submit" id="cart">View Cart</button>
    <?php else: ?>
        <a href="http://127.0.0.1:8081/add-customer.php">Create a new Account</a>
        <a href="http://127.0.0.1:8081/customer-sign-in.php">Sign in</a>
    <?php endif; ?>
</nav>