<?php
$dir = opendir('../raw-src');
while ($book = readdir($dir))
{
	if(!($book == '.' || $book == '..'))
	{
		$files = glob('../raw-src/' . $book . '/Stage4/*');

		foreach($files as $file)
		{
			
			$content = file_get_contents($file);
			$pattern = '/<sup><a epub:type="noteref" href="999-aside.xhtml#id-">(.*?)<\/a><\/sup>/';
			$count = 1;
			$content = preg_replace_callback(  $pattern
                            ,   function($match) use (&$count) {
                                    $str = "<sup><a epub:type=\"noteref\" href=\"999-aside.xhtml#id-a$count\">{$match[1]}</a></sup>";
                                    $count++;
                                    return $str;
                                }
                            ,   $content
                            );

			//~ $content = preg_replace('/<sup>(.*?)<\/sup>/', "$1", $content);
			
			file_put_contents($file, $content);
		}
	}
}
closedir($dir);
?>
