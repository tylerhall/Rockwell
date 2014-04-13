<?PHP
	require 'includes/master.inc.php';
	$Auth->requireUser();
	
	if(isset($_POST['btnSubmit']))
	{
		$id       = Config::get('fsClientID');
		$secret   = Config::get('fsClientSecret');
		$lat      = $_POST['lat'];
		$lng      = $_POST['lng'];
		$json_str = geturl("https://api.foursquare.com/v2/venues/search?client_id=$id&client_secret=$secret&v=20130815&ll=$lat,$lng&query=");
		$json     = json_decode($json_str);
		$venues = $json->response->venues;
	}
	
	if($_GET['act'] == 'save')
	{
		$lat  = $_GET['lat'];
		$lng  = $_GET['lng'];
		$id   = $_GET['id'];
		$name = $_GET['name'];
		
		$u            = new Update();
		$u->user_id   = $Auth->id;
		$u->dt        = gmdate('Y-m-d H:i:s');
		$u->latitude  = $lat;
		$u->longitude = $lng;
		$u->fs_id     = $id;
		$u->fs_name   = $name;
		$u->insert();
		echo "OK";
	}
?>
<html>
<form action="checkin.php" method="POST">
	<input type="text" name="lat" id="lat">
	<input type="text" name="lng" id="lng">
	<input type="submit" name="btnSubmit" value="Lookup" id="btnSubmit">
</form>
<?PHP if(isset($venues)) : ?>
<?PHP foreach($venues as $v) : ?>
<a href="checkin.php?act=save&amp;lat=<?PHP echo $lat; ?>&amp;lng=<?PHP echo $lng; ?>&amp;id=<?PHP echo $v->id; ?>&amp;name=<?PHP echo htmlspecialchars($v->name); ?>"><?PHP echo $v->name; ?></a>
<br>
<?PHP endforeach; ?>
<?PHP endif; ?>
<script type="text/javascript" charset="utf-8">
	window.onload = function() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				document.getElementById('lat').value = position.coords.latitude;
				document.getElementById('lng').value = position.coords.longitude;
			});
		}
	};
</script>
</html>
