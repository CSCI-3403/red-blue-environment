<?php
$host = "10.10.10.8";
$db_name = "hatdb";
$db_username = "dbadmin";
$db_password = "dbaccess";

$conn = new mysqli($host, $db_username, $db_password, $db_name);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$query = "INSERT INTO contact VALUES('" . $_POST['name'] . "', '" . $_POST['email'] . "', '" . $_POST['message'] . "');";
$conn->multi_query($query);
// do {
//     /* store the result set in PHP */
//     if ($result = $mysqli->store_result()) {
//         while ($row = $result->fetch_row()) {
//             printf("%s\n", $row[0]);
//         }
//     }
//     /* print divider */
//     if ($mysqli->more_results()) {
//         printf("-----------------\n");
//     }
// } while ($mysqli->next_result());
?>

<!DOCTYPE HTML>
<!--
	Dimension by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Dimension by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<link rel="stylesheet" href="assets/css/custom.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<div class="logo">
							<span class="fas fa-hat-cowboy"></span>
						</div>
						<div class="content">
							<div class="inner">
								<h1>Hattitude</h1>
								<p>Thank you for your interest! We will reach out to you shortly.</p>
							</div>
						</div>
						<nav>
							<ul>
								<li><a href="/#products">Products</a></li>
								<li><a href="/#about">About Us</a></li>
								<li><a href="/#contact">Contact</a></li>
							</ul>
						</nav>
					</header>

				<!-- Footer -->
					<footer id="footer">
						<p class="copyright">&copy; Hattitude, with help from <a href="https://html5up.net">HTML5 UP</a>.</p>
					</footer>

			</div>

		<!-- BG -->
			<div id="bg"></div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>