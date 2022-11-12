<?php
require("class_DevCoder.inc");
use DevCoder\DotEnv;
(new DotEnv('/var/www/.env'))->load();

// Get environment variables
$dbhost = $_ENV['DBHOST'];
$dbuser = $_ENV['DBUSER'];
$dbpass = $_ENV['DBPASS'];
$db = $_ENV['DBNAME'];
$table = $_ENV['DBTABLE'];

$con = mysqli_connect($dbhost,$dbuser,$dbpass,$db);

if (mysqli_connect_errno()) {
   echo "Error: connecting DB: ".gethostbyname($dbhost);
   exit;
}

$sql = "SELECT user_sort,server_ip,server_check,server_check FROM ".$table." WHERE server_test=1 ORDER BY server_check";
$data='';

if ($result = mysqli_query($con,$sql)) {
    $i = 1;
    while($row = mysqli_fetch_array($result))
    {
        $data .= '<br>' . $i .' User: ' . $row['user_sort'] .' ServerIP: '. $row['server_ip'] . ' Time: ' . $row['server_check'];
        $i++;
    }
}
mysqli_close($con);
echo $data;