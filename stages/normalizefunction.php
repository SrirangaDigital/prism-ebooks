<?php

	function getAllFiles($bookID) {

		$allFiles = [];
		
		$folderPath = UNICODE_SRC . $bookID . '/';
		
	    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($folderPath));

	    foreach($iterator as $file => $object) {
	    	if(preg_match('/.*\.xhtml?$/',$file)) array_push($allFiles, $file);
	    }

	    sort($allFiles);

		return $allFiles;
	}
	
	function process($bookID, $file) {
		
		$contents = file_get_contents($file);
		//~ $contents = preg_replace('/(.*)\n/', '$1', $contents);
		//~ $contents = str_replace('', '', $contents);
		file_put_contents($file,$contents);
	
	}
?>
