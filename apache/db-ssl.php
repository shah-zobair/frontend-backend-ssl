<?php
try{$dbuser = 'shah';
$dbpass = 'shah123';
#$host = 'localhost';
$host = 'backend';
$port = '5432';
$dbname = 'testing';
$sslcert = '/tmp/certs/postgresql.crt';
$sslkey = '/tmp/postgresql-user.key';
$sslrootcert = '/tmp/certs/root.crt';

$conn = new PDO("pgsql:host=$host;dbname=$dbname;port=$port;sslmode=require;sslcert=$sslcert;sslkey=$sslkey;sslrootcert=$sslrootcert", $dbuser, $dbpass);

}
catch (PDOException $e)
{
echo "Error : " . $e->getMessage() . "<br/>";
die();
} 

$sql = 'SELECT * FROM dummy';

foreach ($conn->query($sql) as $row) {
        print $row['name'] . "\t";
        print $row['id'] . "\n";
    }

?>
