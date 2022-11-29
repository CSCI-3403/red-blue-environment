<?php
$attachment = 0;


if(isset($_POST["submit"])) {
    $target_file = null;

    if(file_exists($_FILES['attachment']['tmp_name']) && is_uploaded_file($_FILES['attachment']['tmp_name'])) {
        $target_dir = "attachments/";
        $target_file = $target_dir . basename($_FILES["attachment"]["name"]);
        $uploadOk = 1;

        // Check if file already exists
        if (file_exists($target_file)) {
            echo "Sorry, an attachment with that name already exists.";
            $uploadOk = 0;
        }
        
        // Check file size
        if ($_FILES["attachment"]["size"] > 500000) {
            echo "Sorry, that attachment is too large.";
            $uploadOk = 0;
        }
        
        // Check if $uploadOk is set to 0 by an error
        if ($uploadOk == 0) {
            echo "Sorry, we could not process your review.";
            // if everything is ok, try to upload file
        } else {
            if (!move_uploaded_file($_FILES["attachment"]["tmp_name"], $target_file)) {
                echo "Sorry, there was an error uploading your attachment.";
            }
        }
    }
    
    $host = "10.10.10.8";
    $db_name = "hatdb";
    $db_username = "dbadmin";
    $db_password = "dbaccess";
    
    $conn = new mysqli($host, $db_username, $db_password, $db_name);
    if ($conn->connect_error) {
        die("Database connection failed: " . $conn->connect_error);
    }
    
    $query = "INSERT INTO reviews VALUES('" . $_POST['name'] . "', '" . $_POST['message'] . "', '" . $target_file . "');";
    $conn->multi_query($query);

    echo "Thank you for your feedback!";
}
?>