#!/usr/bin/perl

$count = 15;


for($i=1;$i<=$count;$i++)
{
	if($i < 10)
	{
		$a = "00" . $i;
	}
	elsif($i < 100)
	{
		$a = "0" . $i;
	}
	else
	{
		$a = $i;
	}
	print $a . "\n";
	$outputFile = "$a-chapter$a.xhtml";
	open(OUT, ">$outputFile") or die "can't open $outputFile\n";
	print OUT "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
	print OUT "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\" xmlns:epub=\"http://www.idpf.org/2007/ops\">\n";
	print OUT "<head>\n" ;
	print OUT "\t<title>ಸೋಲೊಪ್ಪಲಾರೆ</title>\n";
	print OUT "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\" />\n";
	print OUT "</head>\n";
	print OUT "<body class=\"maintext\">\n";
	print OUT "\t<section class=\"level1 numbered\" epub:type=\"chapter\" role=\"doc-chapter\" id=\"id-$i\">
		<h1 class=\"level1-title\" epub:type=\"title\"><span class=\"num\"></span>:: </h1>
		<section class=\"level2 numbered\" id=\"id-$i.1\">
			<h2 class=\"level2-title\" epub:type=\"title\"></h2>\n";
	print OUT "\t\t</section>\n";
	print OUT "\t</section>\n";
	print OUT "</body>\n";
	print OUT "</html>\n";
}

