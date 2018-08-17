#!/usr/bin/perl

@list1 = `ls -v ../raw-src`;
for($i=0;$i<@list1;$i++)
{
	chop ($list1[$i]);
	$vol = $list1[$i];

	@list2 = `ls -v ../raw-src/$vol`;
	for($j=0;$j<@list2;$j++)
	{
		chop($list2[$j]);
		$stages = $list2[$j];
		
		$dirPath = "/home/sriranga/Desktop/nagpur/Nagpur_ebooks/raw-src/$vol/Stage4";
		
		if(!(-d $dirPath))
		{
			system("mkdir ../raw-src/$vol/Stage4");
		}
		@list3 = `ls -v ../raw-src/$vol/Stage3a`;
		for($k=0;$k<@list3;$k++)
		{
			chop($list3[$k]);
			$file = $list3[$k];
			
			$inputFile = "../raw-src/$vol/Stage3a/$file";
			$outputFile = "../raw-src/$vol/Stage4/$file";
			
			open(IN, "$inputFile") or die "Can't open $inputFile";
			open(OUT, ">$outputFile") or die "can't open $outputFile\n";

			$line = <IN>;
			$count = 1;
			$id = 1;
			$fl = 1;
			while($line)
			{
				chop($line);
				
				if($line =~ /<\?xml version=\"1.0\"\?>/)
				{
					print OUT "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" . "\n";
				}
				elsif($line =~ /<HTML>/)
				{
					print OUT "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\" xmlns:epub=\"http://www.idpf.org/2007/ops\">" . "\n";
					print OUT "<head>" . "\n";
					print OUT "<title>Nagpur Ashram</title>" . "\n";
					print OUT "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\" />" . "\n";
					print OUT "</head>" . "\n";
				}
				elsif($line =~ /<\/HTML>/)
				{
					print OUT "</html>" . "\n";
				}
				elsif($line =~ /<BODY>/)
				{
					print OUT "<body>" . "\n";
				}
				elsif($line =~ /<\/BODY>/)
				{
					print OUT "</body>" . "\n";
				}
				elsif($line =~ /(.*)DOCTYPE html(.*)/)
				{
					
				}
				elsif($line =~ /<BODY>/)
				{
					
				}
				elsif($line =~ /<SECTION>/)
				{
					
				}
				elsif($line =~ /<H1>(.*)<\/H1>/)
				{
					$title = $1;
					$title = replace_tags($title);
					if($fl == 1)
					{
						print OUT "<section class=\"level1 numbered\" epub:type=\"chapter\" role=\"doc-chapter\" id=\"id-$id\">" . "\n";
						print OUT "<h1 class=\"level1-title\" epub:type=\"title\">$title</h1>" . "\n";
						$fl = 0;
					}
					else
					{
						print OUT "<section class=\"level1 numbered\" epub:type=\"chapter\" role=\"doc-chapter\" id=\"id-$id\">" . "\n";
						print OUT "<h1 class=\"level1-title\" epub:type=\"title\">$title</h1>" . "\n";
						$id++;
					}
					
				}
				elsif($line =~ /<H2>(.*)<\/H2>/)
				{
					$title1 = $1;
					$title1 = replace_tags($title1);
					print OUT "<section class=\"level1 numbered\" epub:type=\"chapter\" role=\"doc-chapter\" id=\"id-$id\">" . "\n";
					print OUT "<h1 class=\"level1-title\" epub:type=\"title\">$title1</h1>" . "\n";
					$id++;
					$count = 1;
				}
				elsif($line =~ /<H[3|4]>(.*)<\/H[3|4]>/)
				{
					if($id != 1)
					{
						$id--;
					}
					$subTitle = $1;
					$subTitle = replace_tags($subTitle);
					print OUT "<section class=\"level2 numbered\" id=\"id-$id.$count\">" . "\n";
					print OUT "<h2 class=\"level2-title\" epub:type=\"title\">$subTitle</h2>" . "\n";
					$count++;
					$id++;
				}
				elsif($line =~ /<H([0-9]+)>/)
				{
					$head = $1;
				}
				
				elsif($line =~ /<strong>(.*?)<\/strong>/)
				{
					if($head == 'H1')
					{
						print OUT replace_tags($line) . "\n";
					}
					else
					{
						if($id != 1)
						{
							$id--;
						}
						$subTitle1 = $1;
						$subTitle1 = replace_tags($subTitle1);
						print OUT "<section class=\"level2 numbered\" id=\"id-$id.$count\">" . "\n";
						print OUT "<h2 class=\"level2-title\" epub:type=\"title\">$subTitle1</h2>" . "\n";
						$count++;
						$id++;
					}
					$head = '';
				}
				elsif($line =~ /<\/H([0-9]+)>/)
				{
					
				}
				else
				{
					print OUT replace_tags($line) . "\n";
				}
				$line = <IN>;
				
			}
			close(IN);
			close(OUT);
		}
	}
}

sub replace_tags()
{
	my($text) = @_;

	$text =~ s/^[\s]+//g;
	$text =~ s/^[\t]+//g;
	$text =~ s/<SPAN><Sup>(.*?)<\/Sup><\/SPAN>/<sup><a epub:type="noteref" href="999-aside.xhtml#id-">\1<\/a><\/sup>/g;
	$text =~ s/<Sup>(.*?)<\/Sup>/<sup><a href="epub:type="noteref" 999-aside.xhtml#id-">\1<\/a><\/sup>/g;
	$text =~ s/<Sup class="en">(.*?)<\/Sup>/<sup><a epub:type="noteref" href="999-aside.xhtml#id-">\1<\/a><\/sup>/g;
	$text =~ s/<Sub>/<sub>/g;
	#~ $text =~ s/<SPAN>(.*)<\/SPAN>/\1/g;
	#~ $text =~ s/<SPAN><strong>/<strong>/g;
	#~ $text =~ s/<\/strong><\/SPAN>/<\/strong>/g;
	$text =~ s/<\/Sub>/<\/sub>/g;
	$text =~ s/<LI>/<li>/g;
	$text =~ s/<\/LI>/<\/li>/g;
	$text =~ s/<\/SECTION>/<\/section>/g;
	$text =~ s/<P>[\s]+<\/P>//g;
	$text =~ s/[\s]*<P>/<p>/g;
	$text =~ s/<\/P>/<\/p>/g;
	$text =~ s/SPAN/span/g;
	$text =~ s/[\s]*<DL>/<dl>/g;
	$text =~ s/[\s]*<dl>/<dl>/g;
	$text =~ s/<\/DL>/<\/dl>/g;
	$text =~ s/[\s]*<\/dl>/<\/dl>/g;
	$text =~ s/[\s]*<DT>/<dt>/g;
	$text =~ s/<\/DT>/<\/dt>/g;
	$text =~ s/[\s]*<DD>/<dd>/g;
	$text =~ s/<\/DD>/<\/dd>/g;
	$text =~ s/<P\/>/<p\/>/g;

	return $text; 
}
