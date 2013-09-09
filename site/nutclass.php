<?php
include_once('properties.php');

class NutrientData {

  private $mysqli;
  private $props;

  public function __construct() {
    $this->props = Properties::getInstance();
  }

  private function connect() {
    if (!isset($this->mysqli)) {
      $this->mysqli = new mysqli(
                      $this->props->db_host, $this->props->db_user, $this->props->db_pass, $this->props->db_name, $this->props->db_port)
              or die('Could not connect: ' . mysqli_connect_error());
    }
  }

  public function showNutrientData($str, $weight_seq = 1) {
    $this->connect();

    $query = "select NutrDesc, Units, Nutr_Val_Edible "
    . "from view_nutrients where Long_Desc=? "
    . "order by SR_Order;";

    if ($stmt = $this->mysqli->prepare($query)) {
      $stmt->bind_param("s", $str); // TODO remove % from str
      if ($stmt->execute()) {

        /* store result */
        $stmt->store_result();

        $stmt->bind_result($nutr, $units, $val);

        $arr = array();
        echo(' <div class="food">' . $str . '</div><div class="info">Nutrient values per 100 g</div><dl class="table-display">');
        while ($stmt->fetch()) {
          ?><dt><?= $nutr ?></dt><dd><?php echo number_format($val, 2) ?><?php echo " $units" ?></dd><?
        }
        echo("</dl>");
      } else {
        header('HTTP/1.1 500 Internal Server Error');
        echo( "Problem with execute: " . $stmt->error());
      }
      /* free result */
      $stmt->free_result();
      $stmt->close();
    } else {
      header('HTTP/1.1 500 Internal Server Error');
      echo("Problem with prepare: " . $this->mysqli->error);
    }
  }

  public function showNutrientDataByWeight() {
    
  }

  public function __destruct() {
    if (isset($this->mysqli))
      $this->mysqli->close();
  }

}
