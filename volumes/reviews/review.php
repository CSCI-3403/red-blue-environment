<!DOCTYPE html>
<html>
<head>
	<title>Hattitude Reviews</title>
	<link rel="stylesheet" href="style.css" />
	<link rel="stylesheet" href="bulma.min.css" />
</head>
<body>
	<section class="hero is-primary is-fullheight">
		<div class="hero-body">
			<div class="container">
				<div class="columns is-centered">
					<div class="column is-four-fifths">
						<h1 class="title">Hattitude Reviews</h1>
                        <?php
                            $attachment = 0;


                            if(isset($_POST["submit"])) {
                                $target_file = null;
                                $uploadOk = 1;

                                if(file_exists($_FILES['attachment']['tmp_name']) && is_uploaded_file($_FILES['attachment']['tmp_name'])) {
                                    $target_dir = "attachments/";
                                    $target_file = $target_dir . basename($_FILES["attachment"]["name"]);

                                    // Check if file already exists
                                    if (file_exists($target_file)) {
                                        echo "<h3 class='subtitle'>Sorry, an attachment with that name already exists.</h3>";
                                        $uploadOk = 0;
                                    } else if ($_FILES["attachment"]["size"] > 500000) {
                                        echo "<h3 class='subtitle'>Sorry, that attachment is too large.</h3>";
                                        $uploadOk = 0;
                                    } else {
                                        if (!move_uploaded_file($_FILES["attachment"]["tmp_name"], $target_file)) {
                                            echo "<h3 class='subtitle'>Sorry, there was an error uploading your attachment.</h3>";
                                            $uploadOk = 0;
                                        }
                                    }
                                }
                                
                                if ($uploadOk == 1) {
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
    
                                    echo "<h3 class='subtitle'>Thank you for your feedback!</h3>";
                                }
                            }
                        ?>
						<a href="/index.php"><button class="button success">Back</button></a>
					</div>
				</div>
			</div>
		</div>
	</section>


</body>
</html>