<?php

require_once 'constants.php';
require_once 'dumpjunk.php';

$id = $argv[1];
$stage = 1;

$dumpjunk = new Dumpjunk();

$files = $dumpjunk->extractJunk($id);




	

?>
