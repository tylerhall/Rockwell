<?PHP
	require 'includes/master.inc.php';

	if($_GET['action'] == 'login')
	{
		if($Auth->login($_GET['username'], $_GET['password']))
		{
			echo json_encode(array('result' => 'success', 'token' => $Auth->user->token));
		}
		else
		{
			echo json_encode(array('result' => 'failure'));
		}
	}