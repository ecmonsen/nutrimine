<?php 

isset($_GET['str']) or die ('str is not set');

include("properties.php");

$p = Properties::getInstance();

$str = str_replace('%', '', $_GET['str']) . '%';

// Connecting, selecting database
$mysqli = new mysqli($p->db_host, $p->db_user, $p->db_pass, $p->db_name, $p->db_port)
    or die('Could not connect: ' . mysqli_connect_error());


if($stmt = $mysqli->prepare("SELECT Long_Desc FROM FoodDescription where Long_Desc like ? order by length(Long_Desc) asc limit 25")) {
  $stmt->bind_param("s", $str); // TODO remove % from str
  if($stmt->execute()) {

   /* store result */
    $stmt->store_result();

    $stmt->bind_result($longdesc);

    $arr=array();
    while($stmt->fetch()){ 
      array_push($arr,$longdesc);
    }
	
    header('Content-Type: application/json');
    echo(json_encode($arr));
  }
  else {
    header('HTTP/1.1 500 Internal Server Error');
    echo( "Problem with execute: " . $stmt->error());
  }
  /* free result */
  $stmt->free_result();
  $stmt->close();

} else {
  header('HTTP/1.1 500 Internal Server Error');
  echo("Problem with prepare: ");
  if($mysqli->connect_errno) {
    echo("Connect error: " . $mysqli->connect_error . "(" . $mysqli->connect_errno . ")");
  } else if($mysqli->errno) {
    echo("MySQL error: " . $mysqli->error . "(" . $mysqli->errno . ")");
  }
echo "<br />";
var_dump($mysqli);
}


$mysqli->close();

?>