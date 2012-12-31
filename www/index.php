<?PHP
	require 'includes/master.inc.php';
	$Auth->requireUser();
?>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<h1>Welcome to Rockwell</h1>

	<p>You are logged in as <?PHP echo $Auth->username;?>. <a href="logout.php">Logout</a>.</p>

	<h2>Search Your Location History</h2>
	<ul>
		<li><a href="search-date.php">Search by Date</a></li>
		<li><a href="search-location.php">Search by Location</a></li>
	</ul>

	<h2>Share Your Current Location</h2>
	<p><em>This section isn't working yet.</em></p>
	<form action="share.php" method="POST">
		<p>Accuracy:
			<select name="accuracy" id="accuracy">
				<option value="coordinates">Coordinates</option>
				<option value="city">City</option>
				<option value="state">State / Territory</option>
				<option value="country">Country</option>
			</select>
		</p>
		<p>Format:
			<select name="format" id="format">
				<option value="text">Plain Text</option>
				<option value="json">JSON</option>
			</select>
		</p>
		<p><label for="nickname">Nickname:</label> <input type="text" name="nickname" id="nickname" value="<?PHP echo $nickname;?>" class="text"></p>
		<p><input type="submit" name="btnShare" value="Create Share" id="btnShare"></p>
	</form>

	<table>
		<thead>
			<tr>
				<td><strong>Nickname</strong></td>
				<td><strong>Accuracy</strong></td>
				<td><strong>Format</strong></td>
				<td><strong>Created</strong></td>
			</tr>
		</thead>
	</table>
</body>
</html>