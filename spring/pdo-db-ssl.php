#!/usr/bin/php
<?php
try{$dbuser = 'shah';
$dbpass = 'shah123';
$host = 'localhost';
$port = '5432';
$dbname = 'testing';
$sslcert = '/tmp/CERTS/client-cert.pem';
$sslkey = '/tmp/CERTS/client-userkey.pem';
$sslrootcert = '/tmp/CERTS/bundle.pem';

#$conn = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);
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
