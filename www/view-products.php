<?php
session_start();
$db_host   = '192.168.56.12';
$db_name   = 'mydatabase';
$db_user   = 'admin';
$db_passwd = 'admin_pw';

try {
    // Create a new PDO instance
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_passwd);
    // Set the PDO error mode to exception
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}

// Function to fetch products based on category
function getProductsByCategory($pdo, $category) {
    if ($category == 'All' || empty($category)) {
        $stmt = $pdo->query("SELECT * FROM product");
    } else {
        $stmt = $pdo->prepare("SELECT * FROM product WHERE category = :category");
        $stmt->bindParam(':category', $category);
        $stmt->execute();
    }
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Function to get all categories
function getCategories($pdo) {
    $stmt = $pdo->query("SELECT DISTINCT category FROM product");
    return $stmt->fetchAll(PDO::FETCH_COLUMN);
}

// Get the category from the query parameter
$selectedCategory = $_GET['category'] ?? 'All';

// Get products based on the selected category
$products = getProductsByCategory($pdo, $selectedCategory);

// Get all categories for the filter
$categories = getCategories($pdo);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <title>Bernice's Products</title>
</head>
<body>
    <main>
        <?php include 'navigation.php'; ?>

        <h1>Products</h1>

        <table>
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Stock Left</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($products as $product): ?>
                <tr>
                    <td><?php echo htmlspecialchars($product['name']); ?></td>
                    <td><?php echo htmlspecialchars($product['description']); ?></td>
                    <td><?php echo htmlspecialchars($product['listPrice']); ?></td>
                    <td><?php echo htmlspecialchars($product['quantityInStock']); ?></td>
                    <td><button type="button">Buy</button></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>

        <a class="nav" href="index.php">Home</a>
        <a href="view-products.php?category=All"><button>All</button></a>

        <?php foreach ($categories as $category): ?>
        <a href="view-products.php?category=<?php echo urlencode($category); ?>"><button><?php echo htmlspecialchars($category); ?></button></a>
        <?php endforeach; ?>
    </main>
</body>
</html>
