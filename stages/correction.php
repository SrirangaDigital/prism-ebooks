<?php

require_once 'constants.php';
require_once 'replacetext.php';

$replacetext = new Replacetext();

$id = $argv[1];
$stage = 1;

$diffFiles = $replacetext->getDiffFiles($id);
$replacetext->normalizeDiffFiles($diffFiles,$id);
$replacetext->putCorrections($id);
$replacetext->generateBookHitList($id);
$replacetext->generateValidityReport($id);



?>
