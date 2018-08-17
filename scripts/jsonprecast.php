<?php

class Jsonprecast {

	public $publisher = 'Ramakrishna Math, Nagpur';

	public function __construct() {
		
	}

	public function getCSVFiles() {

		$allFiles = [];
		
	    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator(ROOT_DIRECTORY . 'scripts'));

	    foreach($iterator as $file => $object) {
	    	
	    	if(preg_match('/.*\.csv$/',$file)) array_push($allFiles, $file);
	    }

	    sort($allFiles);

		return $allFiles;
	}

	public function generateBookDetailsFromCSV($csvFiles){

		$allBooksDetails['books'] = [];
		$bookDetails = "";

		$jsonFilePath = JSON_PRECAST . 'book-details.json';

		foreach ($csvFiles as $csvFile) {

			$fileContents = file_get_contents($csvFile);

			$lines = preg_split("/\n/", $fileContents);
			array_shift($lines);
			// var_dump($lines);
			foreach ($lines as $line) {

				$fields = explode('|', $line);
				// var_dump($fields);
				// echo sizeof($fields) . "\n";

				if(sizeof($fields) != 37) continue;

				$bookCode = (preg_match('/^m/', $fields[11]))? 'M' . sprintf('%03d', $fields[18]) :  'H' . sprintf('%03d', $fields[18]);
				$bookDetails[$bookCode]["language"] = (preg_match('/^m/', $fields[11]))? 'mr' : 'hi';
				$bookDetails[$bookCode]["identifier"] = "Nagpur_eBooks/" . $bookCode;

				echo $bookCode . "\n";

				$bookDetails[$bookCode]["isbn"] = (isset($fields[0]))? str_replace('ISBN:', '', $fields[0]) : 'ISBN';
				$bookDetails[$bookCode]["title"] = (isset($fields[5]))? trim($fields[5]) : '';				

				$fields[9] = str_replace('[Commentary writer]', '[commentator]', $fields[9]);
				$contributors = explode(';', $fields[9]);
				// var_dump($contributors);
				foreach($contributors as $contributor){

					$contributorName = trim(preg_replace('/(.*?)\s\[(.*?)\]/', "$1", $contributor));
					$contributorRole = strtolower(trim(preg_replace('/(.*?)\s\[(.*)\]/', "$2", $contributor)));

					if($contributorRole != 'publisher'){
						if(isset($bookDetails[$bookCode]["creators"][$contributorRole]))
							$bookDetails[$bookCode]["creators"][$contributorRole] .= ';' . $contributorName;
						else
							$bookDetails[$bookCode]["creators"][$contributorRole] = $contributorName;
					}

				}
			
				if(isset($bookDetails[$bookCode]["creators"]))
					$bookDetails[$bookCode]["creators"] = array_filter($bookDetails[$bookCode]["creators"]);
	
				if(empty($bookDetails[$bookCode]["creators"]))
					unset($bookDetails[$bookCode]["creators"]);


				$bookDetails[$bookCode]["publisher"] = $this->publisher;
				$bookDetails[$bookCode]["pages"] = (isset($fields[16]))? trim($fields[16]) : '';

				$bookDetails[$bookCode]["description"] = (isset($fields[14]))? strip_tags(trim($fields[14])) : '';
			}

		}


		$allBooksDetails['books'] = $bookDetails;
		$jsonData = json_encode($allBooksDetails,JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
		if($jsonData) file_put_contents($jsonFilePath, $jsonData);
	}
}

?>
