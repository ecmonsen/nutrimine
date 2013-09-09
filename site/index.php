<?php 
include_once('properties.php');
      include_once('nutclass.php');
$siteUrl = Properties::getInstance()->siteUrl;
?>
<html>
<head>
	<title>Nutrients</title>
	<meta charset="UTF-8" />
			<link type="text/css" rel="Stylesheet" href="jquery-ui.css" /> 
			<link type="text/css" rel="Stylesheet" href="styles.css" />
			<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
			<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.7/jquery-ui.min.js"></script>
			<script type="text/javascript">
				var baseUrl = '<?php echo($siteUrl); ?>/autocomplete.php';
				var nutUrl = '<?php echo($siteUrl); ?>/nut.php';
			    if (!window.console) {
			        window.console = {
			            log : function(arg) {
			                // no op
			            }
			        }
			    }
            </script>
</head>
<body>
<div id="wrapper">
<div id="header">
</div>
<div id="main">
<h2>Nutrients</h2>
<p>This page will display the nutrient values in 100g of a given food.</p>
<form id="form1" method="get">
<span>Start typing the name of a food:</span>
<input type="text" id="autocompleteme" name="str" />

<input type="hidden" name="limit" value="10" />
<input type="submit" name="Find Nutrients" />

</form>
<div id="nutrients">
<?php
if(array_key_exists('str', $_GET)) {
     $str = $_GET['str'];
      $nuts = new NutrientData();
      $nuts->showNutrientData($str);
   }
?>
</div>
<!-- <p>Coming soon: Better autocomplete (search by keyword), per-serving nutrients. Enjoy!</p> -->
</div>
<div id="footer"></div>
</div>
<script type="text/javascript">
$(function() {
	$('#autocompleteme').autocomplete(
		{ source : function(request, response) {
		  	console.log("autocompleting");
			var queryString = $('#form1').serialize(); // TODO + '&cb=' XSS
			console.log("queryString = " + queryString);
			$.ajax({url:baseUrl+'?'+queryString,
				dataType:'json',
				success: function(data) {
					// returned data is an array of strings
				// get all "string" properties
					console.log("get callback");
					var strings = [];
					$.each(data, function(i, res) {
						console.log(res);
						strings[i] = res;
					});
					response(strings);
				},
				error:function() {
				 console.log("Error!");
				}
			});
		  }
		});
console.log("jQuery loaded");
});
</script>
</body>
</html>
