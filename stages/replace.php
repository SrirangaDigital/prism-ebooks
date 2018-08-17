<?
$dir = opendir('../unicode-src');
while ($book = readdir($dir))
{
	if(!($book == '.' || $book == '..'))
	{
		$files = glob('../unicode-src/' . $book . '/*.xhtml');
		foreach($files as $file)
		{
			$content = file_get_contents($file);
			$content = preg_replace('/<span>(.*?)<\/span>/', "$1", $content);
			file_put_contents($file, $content);
		}
	}
}
closedir($dir);
?>
