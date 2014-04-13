<?PHP
	require 'includes/master.inc.php';
	$Auth->requireUser();

	$updates = DBObject::glob('Update', "SELECT * FROM updates WHERE user_id = '{$Auth->user->id}' AND fs_id <> '' ORDER BY dt DESC");
	
	foreach($updates as $u)
	{
		$dt = strtotime($u->dt) + $Auth->user->tz_offset;
		echo dater($dt, 'n/j/y g:ia') . ' - ' . $u->fs_name . '<br>';
	}