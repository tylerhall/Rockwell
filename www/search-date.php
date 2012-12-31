<?PHP
	require 'includes/master.inc.php';
	$Auth->requireUser();
	
	if(isset($_GET['date']))
	{
		$date = dater($_GET['date'], 'Y-m-d'); // Sanitize date
		$results = array();
		$updates = DBObject::glob('update', "SELECT * FROM updates WHERE user_id = '{$Auth->id}' AND DATE(dt) = '$date' ORDER BY dt ASC");
		foreach($updates as $u)
			$results[] = array('dt' => $u->dt, 'latitude' => $u->latitude, 'longitude' => $u->longitude);
		die(json_encode($results));
	}
?>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBKfrkBYBGuh_YVnxxXWUd7yribyiPuLLc&sensor=false"></script>
	<script type="text/javascript" src="js/rockwell.js"></script>
	<script type="text/javascript">
		function reloadData() {
			var url = 'search-date.php?date=' + $('#year').val() + '-' + $('#month').val() + '-' + $('#day').val();
			realReloadData(url);
		}
	</script>
</head>
<body>
	<h1>Welcome to <a href="index.php">Rockwell</a></h1>

	<h2>Search By Date</h2>
	<?PHP echo mdy(); ?>
	<input type="submit" name="btnGo" value="Go" id="btnGo">
	<div id="map_canvas" style="width:100%; height:500px;"></div>
</body>
</html>