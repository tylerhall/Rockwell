<?PHP
	require 'includes/master.inc.php';

	if(isset($_POST['btnShare']))
	{
		$Auth->requireUser();

		$letters = 'abcdefghjkmnpqrstuvwxyz23456789';
		$slug = '';
		for($i = 0; $i < 5; $i++)
			$slug .= substr($letters, rand(0, strlen($letters) - 1), 1);

		$s = new Share();
		$s->user_id = $Auth->id;
		$s->slug = $slug;
		$s->nickname = $_POST['nickname'];
		$s->format = $_POST['format'];
		$s->accuracy = $_POST['accuracy'];
		$s->dt = gmdate('Y-m-d H:i:s');
		$s->insert();
		redirect('share.php?id=' . $s->slug);
	}

	if(isset($_GET['id']))
	{
		$db = Database::getDatabase();
		$share = $db->getRow("SELECT * FROM shares WHERE slug = " . $db->quote($_GET['id']));

		if($share === false) exit;

		$update = $db->getRow("SELECT * FROM updates WHERE user_id = '" . $share['user_id'] . "' ORDER BY dt DESC LIMIT 1");
		if($update === false) exit;
		
		if($share['accuracy'] == 0)
		{
			if($share['format'] == 'text')
				echo $update['latitude'] . ',' . $update['longitude'];
			
			if($share['format'] == 'json')
				echo json_encode(array('dt' => $update['dt'], 'latitude' => $update['latitude'], 'longitude' => $update['longitude']));
				
			exit;
		}

		$results_str = geturl("http://where.yahooapis.com/geocode?location=" . $update['latitude'] . "+" . $update['longitude'] . "&gflags=R&appid=aKMt.vjV34G5RhPhDrQcKU3gcmqyIKn_AvAAyfwCLQo3_yyuZneprghFfgC98LAhLg--&flags=J");
		$results = json_decode($results_str);
		$loc_data = $results->ResultSet->Results[0];

		if($share['format'] == 'text')
		{
			if($share['accuracy'] == 10)
				echo $loc_data->city . ', ' . $loc_data->state;
			if($share['accuracy'] == 20)
				echo $loc_data->state;
			if($share['accuracy'] == 30)
				echo $loc_data->country;
		}
		
		if($share['format'] == 'json')
		{
			if($share['accuracy'] == 10)
				echo json_encode(array('dt' => $update['dt'], 'city' => $loc_data->city, 'state' => $loc_data->state, 'country' => $loc_data->country));
			if($share['accuracy'] == 20)
				echo json_encode(array('dt' => $update['dt'], 'state' => $loc_data->state, 'country' => $loc_data->country));
			if($share['accuracy'] == 30)
				echo json_encode(array('dt' => $update['dt'], 'country' => $loc_data->country));
		}
	}
