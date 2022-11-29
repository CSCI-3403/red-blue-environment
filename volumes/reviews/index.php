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
						<h3 class="subtitle">Submit review</h3>
						<form action="review.php" method="post" enctype="multipart/form-data" class="box">
							<div class="field">
								<label for="name">Name</label>
								<input class="input" type="text" name="name" id="name">
							</div>
							<div class="field">
								<label for="message">Review</label>
								<input class="input" type="text" name="message" id="message">
							</div>
							<div class="field">
								<label for="attachment">[Optional] Include attachment:</label>
								<input class="input"  type="file" name="attachment" id="attachment">
							</div>
							<input class="input"  type="submit" value="Post review" name="submit">
						</form>

						<h3 class="subtitle">Other user reviews</h3>
						<ul>
						<?php
						$host = "10.10.10.8";
						$db_name = "hatdb";
						$db_username = "dbadmin";
						$db_password = "dbaccess";

						$conn = new mysqli($host, $db_username, $db_password, $db_name);
						if ($conn->connect_error) {
							die("Connection failed: " . $conn->connect_error);
						}

						$query = "SELECT name, message, attachment FROM reviews";
						$result = $conn->query($query);
						while ($row = $result->fetch_assoc()) {
							echo "<li class='box'>";
							printf("<b>%s:</b>", $row["name"]);
							printf("<pre>%s</pre>", $row["message"]);
							if ($row["attachment"] != "") {
								printf("<img class='image' src='%s'>\n", $row["attachment"]);
							}
							echo "</li>";
						}
						?>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>


</body>
</html>