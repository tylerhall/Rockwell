<?PHP
	require 'includes/master.inc.php';
	$Auth->requireUser();

	$accuracy_text = array(0 => 'coordinates', 10 => 'city', 20 => 'state', 30 => 'country');
	$shares = DBObject::glob('share', 'SELECT * FROM shares WHERE user_id = ' . $Auth->id);
	
	if(isset($_GET['delete_share']))
	{
		$s = new Share($_GET['delete_share']);
		$s->delete();
		redirect('index.php');
	}
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
	<form action="share.php" method="POST">
		<p>Accuracy:
			<select name="accuracy" id="accuracy">
				<option value="0">Coordinates</option>
				<option value="10">City</option>
				<option value="20">State / Territory</option>
				<option value="30">Country</option>
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
				<td>&nbsp;</td>
			</tr>
		</thead>
		<tbody>
			<?PHP foreach($shares as $s) : ?>
			<tr>
				<td><?PHP echo $s->nickname; ?></td>
				<td><?PHP echo $accuracy_text[$s->accuracy]; ?></td>
				<td><?PHP echo $s->format; ?></td>
				<td><?PHP echo $s->dt; ?></td>
				<td><a href="index.php?delete_share=<?PHP echo $s->id; ?>">Delete</a></td>
			</tr>
			<?PHP endforeach; ?>
		</tbody>
	</table>
</body>
</html>