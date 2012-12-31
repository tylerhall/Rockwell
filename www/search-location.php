<?PHP
	require 'includes/master.inc.php';
	$Auth->requireUser();
	
	if(isset($_GET['sw']))
	{
		list($swLat, $swLng) = explode(',', $_GET['sw']);
		list($neLat, $neLng) = explode(',', $_GET['ne']);
		$results = array();
		$updates = DBObject::glob('update', "SELECT * FROM updates
											WHERE user_id = '{$Auth->id}' AND
											($swLat <= latitude) AND (latitude <= $neLat) AND
											($swLng <= longitude) AND (longitude <= $neLng)
			 								ORDER BY dt ASC");
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
			var bounds = map.getBounds();
			var url = 'search-location.php?sw=' +
						bounds.getSouthWest().lat() + ',' +
						bounds.getSouthWest().lng() + '&ne=' +
						bounds.getNorthEast().lat() + ',' +
						bounds.getNorthEast().lng();
			realReloadData(url);
		}

	</script>
</head>
<body>
	<h1>Welcome to <a href="index.php">Rockwell</a></h1>

	<h2>Search By Location</h2>
	<p>Drag the map to the area you wish to search and click <input type="submit" name="btnShow" value="Show Markers" id="btnShow"></p>
	<div id="map_canvas" style="width:100%; height:500px;"></div>
</body>
</html>