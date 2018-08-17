<?php

require_once 'constants.php';
require_once 'incorporate.php';

$incorporate = new Incorporate();

$id = $argv[1];

$incorporate->rectifyUnicodeSRC($id);

?>
