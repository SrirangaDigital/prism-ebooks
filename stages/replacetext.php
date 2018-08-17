<?php 

class Replacetext{

	public function __construct() {
		
	}

	public function getDiffFiles($bookID) {

		$allFiles = [];
		
		$folderPath = RAW_SRC . $bookID . '/Stage3a/';
		
	    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($folderPath));

	    foreach($iterator as $file => $object) {
	    	
	    	if(preg_match('/.*\.diff$/',$file)) array_push($allFiles, $file);
	    }

	    sort($allFiles);

		return $allFiles;
	}	

	public function getHtmlFiles($bookID) {

		$allFiles = [];
		
		$folderPath = RAW_SRC . $bookID . '/Stage3/';
		
	    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($folderPath));

	    foreach($iterator as $file => $object) {
	    	
	    	if(preg_match('/.*\.htm[l]?$/',$file)) array_push($allFiles, $file);
	    }

	    sort($allFiles);

		return $allFiles;
	}	

	public function normalizeDiffFiles($diffFiles,$bookID){

		$contents = [];

		foreach ($diffFiles as $diffFile) {

			 $fileNameAdd = preg_replace('/\.diff$/', '.log1.txt', $diffFile);
			 $fileNameInt = preg_replace('/\.diff$/', '.int.txt', $diffFile);

			 $contents = $this->reformatDiffLines(file_get_contents($diffFile), $fileNameAdd);		
			 $contents = array_unique($contents);
			 sort($contents);
	  		 $contents = implode("\n", $contents);
		     file_put_contents($fileNameInt, $contents);
		}
	}

	public function reformatDiffLines($diffContents,$addDiffFile){

		$diffLines = preg_split('/\n/', $diffContents);
		$FileInStage3aLog1Handle = fopen($addDiffFile, 'w');

		$prev = 0;
		$line = "";
		$rfDiffLines = [];

		foreach ($diffLines as $key => $value) {

			if(preg_match('/\d+/', $value)){

				if($prev == 3) fwrite($FileInStage3aLog1Handle, $line . "\n");
				elseif($line != '') array_push($rfDiffLines, $line);

				$line = '';
				$prev = 0;
			}
			elseif (preg_match('/^< (.*)/', $value, $matches)) {

				$line = ($prev == 1)? $line . ' ' . $matches[1] : $line . $matches[1]; 
				$prev = 1;	
			}			
			elseif (preg_match('/^> (.*)/', $value, $matches)) {

				if($prev == 2){

					$line = $line . ' ' . $matches[1];
				}
				else{

					if($line == '' || $prev == 3) {
					
						$line = $line . ' ' . $matches[1];
						$prev = 3;
					}
					else{

						$line = $line . ' --> ' . $matches[1];
						$prev = 2;
					} 			
				}				 
			}	
		}

		if($line != '') array_push($rfDiffLines, $line);
		fclose($FileInStage3aLog1Handle);

		return $rfDiffLines;
	}


	public function putCorrections($bookID){

		$allFiles = [];

		$filesInStage3 = $this->getHtmlFiles($bookID);

		foreach($filesInStage3 as $file){

			$diffPath = RAW_SRC . $bookID . '/Stage3a/' . basename($file) . '.int.txt';
			//var_dump($file . '->' . $diffPath . "\n");
			$diffContents = file_get_contents($diffPath);
			$diffFileLines = explode("\n", $diffContents);

			$this->processWords($bookID,$file,$diffFileLines);

		}

	}

	public function processWords($bookID,$file,$diffFileLines){

		$fileInStage3 = RAW_SRC . $bookID . '/Stage3/' . basename($file);
		$contents3 = file_get_contents($fileInStage3);

		$fileInStage3a = RAW_SRC . $bookID . '/Stage3a/' . basename($file);
		$contents3a = file_get_contents($fileInStage3a);

		// var_dump($fileInStage3 . "\n" . $fileInStage3a);

		$FileInStage3Left = RAW_SRC . $bookID . '/Stage3a/' . basename($file) . '.left.txt';
		$FileInStage3Log = RAW_SRC . $bookID . '/Stage3a/' . basename($file) . '.log2.txt';

		$strings3 = [];
		$strings3Log = [];

		foreach($diffFileLines as $value){

			$diffLine = preg_split('/ --> /', $value);

			if(sizeof($diffLine) == 2){

				$phrase = str_replace(' ', '[\-><a-zA-Z\/\s]+', preg_quote($diffLine[0]));
				if(preg_match_all('/([\s[:punct:]][^\s[:punct:]]+[\s[:punct:]]+)('. $phrase . ')([\s[:punct:]]+[^\s[:punct:]]+[\s[:punct:]])/u', $contents3, $matches,PREG_SET_ORDER)){

					for($i = 0; $i<sizeof($matches); $i++){

						$neighbourhood = strip_tags($matches[$i][1]) . "ZZZ" . strip_tags($matches[$i][2]) . "ZZZ" . strip_tags($matches[$i][3]);
						// $neighbourhood = trim($neighbourhood, " ><।॥०१२३४५६७८९");
						$neighbourhood = preg_replace('/^[ ><।॥०१२३४५६७८९]*/u', '', $neighbourhood);
						$neighbourhood = preg_replace('/[ ><।॥०१२३४५६७८९]*$/u', '', $neighbourhood);
						$neighbourhood = preg_replace('/\s+/', ' ', $neighbourhood);
						array_push($strings3, $value . " AAAAAA " . $neighbourhood);
					}
				}
				else{

					array_push($strings3Log, '/([\s[:punct:]][^\s[:punct:]]+[\s[:punct:]]+)('. $phrase . ')([\s[:punct:]]+[^\s[:punct:]]+[\s[:punct:]])/u');
				}
			} 	
		}

		file_put_contents($FileInStage3Left, implode("\n", $strings3));
		file_put_contents($FileInStage3Log, implode("\n", $strings3Log));

		$FileInStage3aReplaceList = fopen(RAW_SRC . $bookID . '/Stage3a/' . basename($file) . '.replist.txt', 'w');
		$FileInStage3aHitList = fopen(RAW_SRC . $bookID . '/Stage3a/' . basename($file) . '.hitlist.txt', 'w');
		$FileInStage3aLogList = RAW_SRC . $bookID . '/Stage3a/' . basename($file) . '.log3.txt';
		$FileInStage3aLogListHandle = fopen($FileInStage3aLogList, 'w');

		foreach ($strings3 as $value) {
			
			$diffLine1 = preg_split('/ AAAAAA /', $value);
			$wordsList = preg_split('/ --> /', $diffLine1[0]);
			$wordGroup = preg_split('/ZZZ/', $diffLine1[1]);
			
			$beforeText = strip_tags($wordGroup[0]) . $wordGroup[1] . strip_tags($wordGroup[2]);
			$afterText = strip_tags($wordGroup[0]) . $wordsList[1] . strip_tags($wordGroup[2]);

			$searchPattern = preg_quote(strip_tags($wordGroup[0]) . $wordsList[1] . strip_tags($wordGroup[2]));
			fwrite($FileInStage3aReplaceList, $beforeText . " --> " . $afterText . "\n");
			// var_dump($searchPattern);

			if((!preg_match('/[\s\-,]/', $beforeText)) && (strlen($beforeText) < 10)) {
			
				fwrite($FileInStage3aLogListHandle, $wordGroup[1] . " --> " . $wordsList[1] . "\n");
				continue;
			}

			$searchPattern = str_replace(' ', '[\-><a-zA-Z\/\s]+', $searchPattern);
			if((preg_match_all('/('. $searchPattern . ')/u', $contents3a, $matches)) && ((!preg_match_all('/('. preg_quote($beforeText) . ')/u', $contents3a, $matches)))){

				fwrite($FileInStage3aHitList, $beforeText . " --> " . $afterText . "\n");
			}
			else{

				fwrite($FileInStage3aLogListHandle, $wordGroup[1] . " --> " . $wordsList[1] . "\n");	
			}

		}

		fclose($FileInStage3aReplaceList);
		fclose($FileInStage3aHitList);
		fclose($FileInStage3aLogListHandle);

		exec('uniq ' . $FileInStage3aLogList . ' ' . $FileInStage3aLogList . '.a');
		exec('mv ' . $FileInStage3aLogList . '.a ' . $FileInStage3aLogList);

		$log3Text = file_get_contents($FileInStage3aLogList);
		$log3TextList = explode("\n", $log3Text);

		$hitListFile = RAW_SRC . $bookID . '/Stage3a/' . basename($file) . '.hitlist.txt';
		$hitListText = file_get_contents($hitListFile);

		$modifiedLog = [];
		foreach ($log3TextList as $line) {
			
			$left = preg_replace('/ --> .*/', '', $line);
			if((strlen($left) > 10) && (preg_match('/' . $left . '.* --> .*/', $hitListText)) && (!preg_match('/ --> .*' . $left . '.*/', $hitListText))) {

				file_put_contents($hitListFile, $line . "\n", FILE_APPEND);
			}
			else{

				array_push($modifiedLog, $line);
			}
		}

		file_put_contents($FileInStage3aLogList, implode("\n", $modifiedLog));
	}


	public function getHitListFiles($bookID) {

		$allFiles = [];
		
		$folderPath = RAW_SRC . $bookID . '/Stage3a/';
		
	    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($folderPath));

	    foreach($iterator as $file => $object) {
	    	
	    	if(preg_match('/.*\.hitlist\.txt$/',$file)) array_push($allFiles, $file);
	    }

	    sort($allFiles);

		return $allFiles;
	}

	public function generateBookHitList($bookID){

		//get hitlist from stage3a
		$histListFiles = $this->getHitListFiles($bookID);
		$contents = [];

		foreach ($histListFiles as  $file) {

			$array = explode("\n",file_get_contents($file));
			$contents = array_merge($contents, $array);
		}

		$contents = array_filter($contents);
		sort($contents);
		$contents = array_unique($contents);
		var_dump(sizeof($contents));

		$contents = array_filter($contents);

		$allXhtmlFiles = $this->getAllFiles($bookID);

		// $XhtmlHitListFile = fopen($folderPath = RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.hitlist.txt', 'w');
		// $XhtmlHitLogFile = 	fopen($folderPath = RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.log.txt', 'w');
		$XhtmlHitListFile = $folderPath = RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.hitlist.txt';
		$XhtmlHitLogFile = 	$folderPath = RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.log.txt';

		$hitListArray = [];
		$logListArray = [];

		foreach($allXhtmlFiles as $xhtmlFile){

			$xhtmlFileContents = file_get_contents($xhtmlFile);

			// remove 200c character
			$xhtmlFileContents = str_replace('‌', '', $xhtmlFileContents);

			foreach ($contents as $content) {
				
				$leftContents = preg_split('/ --> /', $content);
				$wrongData = preg_quote($leftContents[0]);
				$rightData = preg_quote($leftContents[1]);
				
				$wrongData = str_replace(' ', '[\-><a-zA-Z\/\s]+', $wrongData);
				$rightData = str_replace(' ', '[\-><a-zA-Z\/\s]+', $rightData);
				if(preg_match_all('/('. $wrongData . ')/u', $xhtmlFileContents, $matches)){

					array_push($hitListArray,$content);
				}
				elseif(preg_match_all('/('. $rightData . ')/u', $xhtmlFileContents, $matches)){

					array_push($hitListArray, $content);
					array_push($logListArray, 'done --> ' . $content);
				}
				else{

					array_push($logListArray,$content);
				}				
			}
		}

		sort($hitListArray);
		sort($logListArray);

		//$arrayDiff = array_diff($hitListArray,$logListArray);
		$fullDiff = array_merge(array_diff($hitListArray, $logListArray), array_diff($logListArray, $hitListArray));
		sort($fullDiff);

		$hitListArray = array_unique($hitListArray);
		$logListArray = array_unique($logListArray);
		$fullDiff = array_unique($fullDiff);



		file_put_contents($XhtmlHitListFile,implode("\n",$hitListArray));
		file_put_contents($XhtmlHitLogFile, implode("\n",$fullDiff));
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

	public function generateValidityReport($bookID) {

		$hitList = file_get_contents(RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.hitlist.txt');

		$hitList = explode("\n", $hitList);

		$hitList = array_map(
			function($value){

				$count = strlen(preg_replace('/ --> .*/', '', $value));
				return sprintf("%03d", $count) . ' <--> ' . $value;
			}, $hitList);

		sort($hitList);

		file_put_contents(RAW_SRC . $bookID . '/Stage3a/' . $bookID . '.hitlist.validity.txt', implode("\n", $hitList));
	}



}
?>