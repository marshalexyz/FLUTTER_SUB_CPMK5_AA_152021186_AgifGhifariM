<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "ewallet_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        $id = isset($_GET['id']) ? $_GET['id'] : '';
        if ($id != '') {
            $sql = "SELECT * FROM wallets WHERE id = $id";
        } else {
            $sql = "SELECT * FROM wallets";
        }
        $result = $conn->query($sql);
        $data = [];

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        echo json_encode($data);
        break;

    case 'POST':
        $name = $_POST['name'];
        $balance = $_POST['balance'];

        $sql = "INSERT INTO wallets (name, balance) VALUES ('$name', $balance)";
        $conn->query($sql);

        echo json_encode(['message' => 'Data added successfully']);
        break;

    case 'PUT':
        parse_str(file_get_contents('php://input'), $put_vars);
        $id = $put_vars['id'];
        $name = $put_vars['name'];
        $balance = $put_vars['balance'];

        $sql = "UPDATE wallets SET name='$name', balance=$balance WHERE id=$id";
        $conn->query($sql);

        echo json_encode(['message' => 'Data updated successfully']);
        break;

    case 'DELETE':
        parse_str(file_get_contents('php://input'), $delete_vars);
        $id = $delete_vars['id'];

        $sql = "DELETE FROM wallets WHERE id=$id";
        $conn->query($sql);

        echo json_encode(['message' => 'Data deleted successfully']);
        break;

    default:
        break;
}

$conn->close();
?>