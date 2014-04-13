<?PHP
	require 'includes/master.inc.php';

	if($_GET['action'] == 'login')
	{
		if($Auth->login($_GET['username'], $_GET['password']))
		{
			echo json_encode(array('result' => 'success', 'token' => $Auth->user->token));
			exit;
		}
		else
		{
			echo json_encode(array('result' => 'failure'));
			exit;
		}
	}

	$db = Database::getDatabase();
	$user_id = $db->getValue('SELECT id FROM users WHERE token = ' . $db->quote($_GET['token']));
	if($user_id === false)
	{
		echo json_encode(array('result' => 'failure'));
		exit;
	}
	$Auth->impersonateUser($user_id);

	if($_GET['action'] == 'update')
	{
		$u = new Update();
		$u->user_id = $Auth->id;
		$u->dt = gmdate('Y-m-d H:i:s');
		$u->latitude = $_GET['latitude'];
		$u->longitude = $_GET['longitude'];		
		$u->insert();
		echo json_encode(array('result' => 'success'));	
	}
