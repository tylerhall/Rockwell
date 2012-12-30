<?PHP
	if(isset($_POST['btnCreateUser']))
	{
		require '../includes/master.inc.php';
		$db = Database::getDatabase();
		$username = $db->escape($_POST['username']);
		Auth::createNewUser($username, $_POST['password']);
		die('All done. You can now delete the <strong><code>install</code></strong> directory.');
	}
?>
<h1>Rockwell Install</h1>

<h2>Step 1</h2>
<p>Create a new MySQL database using the command line or your favorite database tool. Then, import the contents of <strong><code>install/mysql.sql</code></strong>.

<h2>Step 2</h2>
<p>Rename <strong><code>includes/class.config-sample.php</code></strong> to <strong><code>includes/class.config.php</code></strong>.</p>

<h2>Step 3</h2>
<p>Fill in the appropriate database settings in <strong><code>class.config.php</code></strong>. They are located midway through the file in the <strong><code>production()</code></strong> function. When complete, they should look similar to...</p>

<pre>
    $this->dbReadHost      = 'localhost';
    $this->dbWriteHost     = 'localhost';
    $this->dbName          = 'rockwell';
    $this->dbReadUsername  = 'root';
    $this->dbWriteUsername = 'root';
    $this->dbReadPassword  = 'your-password';
    $this->dbWritePassword = 'your-password';
</pre>

<h2>Step 4</h2>
<p>Fill in the form below and click submit to create your first user.</p>
<form action="" method="POST">
	<p><label for="username">Username:</label> <input type="text" name="username" id="username" value="<?PHP echo $username;?>" class="text"></p>
	<p><label for="password">Password:</label> <input type="text" name="password" id="password" value="<?PHP echo $password;?>" class="text"></p>
	<p><input type="submit" name="btnCreateUser" value="Create User" id="btnCreateUser"></p>
</form>