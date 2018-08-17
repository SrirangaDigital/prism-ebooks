<?php 

class Incorporate{

	public function __construct() {
		
	}

	private $report = '';
	private $error = '';

	public function rectifyUnicodeSRC($bookID) {

		// Get hitlist file
		$hitList = file_get_contents(RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.hitlist.txt');
		$hitList = explode("\n", $hitList);
		// $report = '';
		// $error = '';

		$hitList = array_map(
			function($value){

				$count = strlen(preg_replace('/[^\s]/', '', $value));
				return sprintf("%02d", $count) . ' <--> ' . $value;
			}, $hitList);
		rsort($hitList);

		$before = [];
		$after = [];

		// Get unicde-src files (starting with a number)
		$unicodeFiles = $this->getAllFiles($bookID);

		// foreach hitList line in each file 
		foreach ($hitList as $hitListRow) {
			
			$hitListRow = preg_replace('/.* <--> (.*)/', "$1", $hitListRow);

			if(!preg_match('/ --> /', $hitListRow)) continue;

			$fragments = explode(' --> ', $hitListRow);

			$beforeValue = $fragments[0];
			$beforeValueRegex = '/' . str_replace(' ', '([\-><a-zA-Z\/\s]+)', preg_quote($fragments[0])) . '/u';
			$afterValue = $fragments[1];
			$afterValueRegex = '/' . str_replace(' ', '[\-><a-zA-Z\/\s]+', preg_quote($fragments[1])) . '/u';

			$status = false;
			foreach ($unicodeFiles as $file) {

				$contents = file_get_contents($file);

				// remove 200c character
				$contents = str_replace('‌', '', $contents);

				if(preg_match($beforeValueRegex, $contents)) {

					$contents = preg_replace_callback($beforeValueRegex,
						function ($matches) use ($beforeValue, $afterValue){

							$fullMatch = array_shift($matches);
							
							foreach ($matches as $match) {
								
								$afterValue = preg_replace('/(.+?) (.+)/', "$1" . str_replace(' ', 'zzz', $match) . "$2", $afterValue);
							}
							$afterValue = str_replace('zzz', ' ', $afterValue);
							$this->report .= $fullMatch . ' --> ' . $afterValue . "\n";

	            			return $afterValue;
    					}, $contents);
					$status = true;
				}
				elseif(preg_match($afterValueRegex, $contents)){

					$this->report .= $beforeValue . ' --> ' . $afterValue . "\n";
					$status = true;
				}

				// save file
				file_put_contents($file, $contents);
			}
			if(!$status) $this->error .= $beforeValue . ' --> ' . $afterValue . "\n";
		}

		file_put_contents(RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.success.txt', $this->report);
		file_put_contents(RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.error.txt', $this->error);
	}

	public function getAllFiles($bookID) {

		$allFiles = [];
		
		$folderPath = UNICODE_SRC . $bookID . '/';
		
	    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($folderPath));

	    foreach($iterator as $file => $object) {
	    	
	    	if(preg_match('/.*' . $bookID . '\/\d.*\.xhtml$/',$file)) array_push($allFiles, $file);
	    }

	    sort($allFiles);

		return $allFiles;
	}
}
?>