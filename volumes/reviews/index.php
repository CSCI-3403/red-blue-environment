<!DOCTYPE html>
<html>
<body>

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
	printf("%s: %s", $row["name"], $row["message"]);
	if (!is_null($row["attachment"])) {
		printf("Attachment:\n");
		printf("<img class='icon' src='%s'>\n", $row["attachment"]);
	}
}
?>

<form action="review.php" method="post" enctype="multipart/form-data">
	<label for="name">Name</label>
	<input type="text" name="name" id="name">
	<label for="message">Review</label>
	<input type="text" name="message" id="message">
	<label for="attachment">[Optional] Include attachment:</label>
	<input type="file" name="attachment" id="attachment">
	<input type="submit" value="Post review" name="submit">
</form>

</body>
</html>