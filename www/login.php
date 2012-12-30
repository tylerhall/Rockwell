<?PHP
    require 'includes/master.inc.php';

    if($Auth->loggedIn()) redirect('index.php');

    if(!empty($_POST['username']))
    {
        if($Auth->login($_POST['username'], $_POST['password']))
        {
            if(isset($_REQUEST['r']) && strlen($_REQUEST['r']) > 0)
                redirect($_REQUEST['r']);
            else
                redirect('index.php');
        }
        else
            $Error->add('username', "We're sorry, you have entered an incorrect username and password. Please try again.");
    }

    // Clean the submitted username before redisplaying it.
    $username = isset($_POST['username']) ? htmlspecialchars($_POST['username']) : '';
?>
<form action="<?PHP echo $_SERVER['PHP_SELF']; ?>" method="post">
    <?PHP echo $Error; ?>
    <p><label for="username">Username:</label> <input type="text" name="username" value="<?PHP echo $username;?>" id="username" /></p>
    <p><label for="password">Password:</label> <input type="password" name="password" value="" id="password" /></p>
    <p><input type="submit" name="btnlogin" value="Login" id="btnlogin" /></p>
    <input type="hidden" name="r" value="<?PHP echo htmlspecialchars(@$_REQUEST['r']); ?>" id="r">
</form>
