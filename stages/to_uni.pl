#!/usr/bin/perl

use Encode;
use utf8;

$GrA = "44|4B|69|49|DB|70|50|5F|43|6C|4C|4F|76|68|48|79|59|63|D9|75|4A|4D|3C|6D|23|25|24|4E|3E|56|A1|A2|A7|A9|AB|BB|C0|C3|C4|C5|D5|D8|DF|E3|E5|E7|EA|EB|F2|F8|FF|153|152|178|203A";
%GrA_a=('44'=>'a',
'4B'=>'kh',
'69'=>'g',
'49'=>'gh',
'DB'=>'c',
'70'=>'j',
'50'=>'jh',
'5F'=>'~n',
'43'=>'.n',
'6C'=>'t',
'4C'=>'th',
'4F'=>'dh',
'76'=>'n',
'68'=>'p',
'48'=>'p',
'79'=>'b',
'59'=>'bh',
'63'=>'m',
'D9'=>'y',
'75'=>'l',
'4A'=>'v',
'4D'=>'"s',
'3C'=>'.s',
'6D'=>'s',
'23'=>'k.s',
'25'=>'j~n',
'24'=>'tr',
'4E'=>'rX',
'3E'=>'n',
'56'=>'nn',
'A1'=>'khr',
'A2'=>'hy',
'A7'=>'"sc',
'A9'=>'dm',
'AB'=>'gr',
'BB'=>'jr',
'C0'=>'~nj',
'C3'=>'~nc',
'C4'=>'vn',
'C5'=>'dy',
'D5'=>'"sv',
'D8'=>'pr',
'DF'=>'"sr',
'E3'=>'jhr',
'E5'=>'',
'E7'=>'"s',
'EA'=>'l',
'EB'=>'"s',
'F2'=>'tt',
'F8'=>'pr',
'FF'=>'hm',
'153'=>'sr',
'152'=>'str',
'178'=>'Y',
'203A'=>'Xr');

$GrB = "46|54|53|2A|DA|161|22|5B|7B|6F|6A|6E|55|7D|A5|AA|B0|BA|BF|C1|C6|C8|C9|D1|D6|DC|E6|F1|F3|F4|F5|F6|FA|FB|2030|2026|201E|201D|201C|2039|A3";
%GrB_a = (
'46'=>'i',
'54'=>'U',
'53'=>'e',
'2A'=>'"n',
'DA'=>'ch',
'161'=>'.t',
'22'=>'.th',
'5B'=>'.d',
'7B'=>'.dh',
'6F'=>'d',
'6A'=>'r',
'6E'=>'h',
'55'=>'L',
'7D'=>'l',
'A5'=>'hl',
'AA'=>'.t.th',
'B0'=>'.s.t',
'BA'=>'.d.dh',
'BF'=>'"nk,',
'C1'=>'"ng',
'C6'=>'dbh',
'C8'=>'"nkh',
'C9'=>'dv',
'D1'=>'.dh.dh',
'D6'=>'hn',
'DC'=>'hr',
'E6'=>'ddh',
'F1'=>'.d.d',
'F3'=>'.t.t',
'F4'=>'db',
'F5'=>'dr',
'F6'=>'dd',
'FA'=>'.th.th',
'FB'=>'dg',
'2030'=>'.s.th',
'2026'=>'.s.th',
'201E'=>'.s.t',
'201D'=>'"ng',
'201C'=>'"nkh',
'2039'=>'"ngh',
'A3'=>'hv');

$GrC = "6B|D7";
%GrC_a = (
'6B'=>'k',
'D7'=>'kk'
);

$GrD = "A4|47|AE|3BC|C2|D3|D4|E0|E8|F9|160|3A|21|27|28|29|2C|2D|2E|2F|3B|3F|60|7E|2013|2018|2019|2020|2021";
%GrD_a = (
'47'=>'u',
'A4'=>'rU', #doubt whether it is sU or rU
'AE'=>'ru',
'3BC'=>'*',
'C2'=>'d.r',
'D3'=>'.a',
'D4'=>'.o',
'E0'=>'L',
'E8'=>'l.r',
'F9'=>'h.r',
'160'=>'.h',
'3A'=>'.h',
'21'=>'!',
'27'=>'\'',
'28'=>'(',
'29'=>')',
'2C'=>',',
'2D'=>'-',
'2E'=>'. ',
'2F'=>'/',
'3B'=>';',
'3F'=>'?',
'60'=>'`',
'7E'=>'|',
'2013'=>'-',
'2018'=>'`',
'2019'=>'\'',
'2020'=>'†',
'2021'=>'‡'
);

$GrE = "30|31|32|33|34|35|36|37|38|39";
%GrE_a = ('30'=>'0',
'31'=>'1',
'32'=>'2',
'33'=>'3',
'34'=>'4',
'35'=>'5',
'36'=>'6',
'37'=>'7',
'38'=>'8',
'39'=>'9');

$GrF = "26|3D|B8|40|41|42|45|51|52|57|58|5A|5C|5D|5E|61|62|64|66|67|71|72|73|74|77|78|7A|7C|C7|CA|CB|CC|CD|CE|CF|D2|E9|EA|EF|FC";
%GrF_a = (
'26'=>'r',
'3D'=>'.r',
'B8'=>'.R',
'40'=>'~a',
'41'=>'rxI.m',
'42'=>'/',
'45'=>'xi.m',
'51'=>'ai.m',
'52'=>'I.m',
'57'=>'e.m',
'58'=>'rxe.m',
'5A'=>'rxai.m',
'5C'=>'rxi.m',
'5D'=>'',
'5E'=>'r',
'61'=>'rxI',
'62'=>'.m',
'64'=>'&',
'66'=>'xi',
'67'=>'u',
'71'=>'xi',
'72'=>'I',
'73'=>'e',
'74'=>'U',
'77'=>'ai',
'78'=>'rxe',
'7A'=>'rxai',
'7C'=>'rxi',
'C7'=>'r',
'CA'=>'',
'CB'=>'rx.m',
'CC'=>'R',
'CD'=>'',
'CE'=>'',
'CF'=>'',
'D2'=>'U',
'E9'=>'',
'EA'=>'',
'EF'=>'',
'FC'=>'r');

$final_str = "";
$devtex = "";
$danda = 0;
$chap = 0;

if(@ARGV != 2)
{
	print "USAGE: perl to_uni.pl <inputFile> <outputFile>\n";
	exit(1);	
}

$filename = $ARGV[0];
$unifile = $ARGV[1];

#~ print $filename . "->" . $unifile . "\n";
#~ exit(1)
#~ $filename = "/home/sriranga/projects/Nagpur_Ashram_ebook/books/H201/text/index.txt";
#~ $unifile = "/home/sriranga/Desktop/tmp.txt";
open(IN,"<:utf8","$filename") or die "Can't open $filename";
open(OUT,">$unifile") or die "Can't open $unifile";



#~ $inputString = $ARGV[0];
#~ print $inputString;

$line = <IN>;

$final_str = "";
$devtex = "";
$danda = 0;
$chap = 0;			

while($line)
{
	chop($line);
	
	$line = doGlobalSearch($line);	
	$line = convert_string($line);

	print OUT $line . "\n";			

	$final_str = "";
	$devtex = "";
	$danda = 0;
	$myline = "";

	$line = <IN>;
}

close(IN);
close(OUT);				

sub doGlobalSearch(){

	my($string) = @_;

	$string =~ s/Ë/&b/g;
	$string =~ s/™/¤/g;
	
	return $string;
}

sub convert_string()
{
	my($str_ansi) = @_;
	$str_ansi =~ s/&lt;/</g;
	$str_ansi =~ s/&gt;/>/g;
	$str_ansi =~ s/&quot;/"/g;
	$str_ansi =~ s/&amp;/&/g;

	@list = split(//,$str_ansi);
	$final_str = "";
	$devtex = "";
	$danda = 0;
	for($i=0;$i<@list;$i++)
	{
		$hex = DecToNumBase(ord($list[$i]), 16);
		$decimal = ord($list[$i]);
		if($list[$i] eq " ")
		{
			replace_reg();
			$final_str = $final_str . " ";
		}
		else
		{
			Convert_to_Devnag($hex);
		}
	}
	replace_reg();
	print_line();
	return $final_str;	
}


sub Convert_to_Devnag()
{
	my($hex) = @_;
	
	if(is_GRA($hex))
	{
		#printdev();
		#print $hex . "->" . $list[$i] . "->A\n"; 
		if($prev == 6 && $devtex !~ /xi/ && $devtex !~ /ra$/)
		{
			replace_reg();
			$devtex = $devtex . $GrA_a{$hex} . "x";
		}
		elsif(($prev == 6) && ($danda == 1))
		{
			#printdev();
			$devtex =~ s/a$/A/;
			replace_reg();
			$devtex = $devtex . $GrA_a{$hex} . "x";
		}
		elsif($prev == 99)
		{
			$devtex =~ s/x/$GrA_a{$hex}x/;
		}
		elsif(($devtex ne "") && ($danda > 1))
		{
			$devtex =~ s/a/A/;
			replace_reg();
			$devtex = $devtex . $GrA_a{$hex} . "x";
		}
		elsif(($devtex ne "") && ($prev == 2) && ($danda == 0) && ($devtex !~ /^e/))
		{
			replace_reg();	
			$devtex = $devtex . $GrA_a{$hex} . "x";
		}
		elsif(($devtex ne "") && ($prev =~ /1|2/) && ($danda == 0) && ($devtex !~ /^e/))
		{
			$devtex =~ s/x/$GrA_a{$hex}x/;
		}
		elsif( ($devtex ne "") && ($devtex =~ /x/) && ($danda == 0) && ($devtex =~ /^e/))
		{
			replace_reg();
			$devtex = $devtex . $GrA_a{$hex} . "x";
		}
		elsif( ($devtex ne "") && ($devtex =~ /x/) && ($danda == 0) )
		{
			$devtex =~ s/x/$GrA_a{$hex}x/;			
			#printdev();
		}
		elsif(($devtex ne "") && ($prev =~ /1|2/))
		{
			#printdev();
			if( ($devtex =~ /x/) && $hex eq "3E" ) #Added this condition to match gna
			{
				$devtex =~ s/x/$GrA_a{$hex}/;
				#printdev();
			}
			elsif($devtex eq "Xrxa" ) #Added this condition to match vra or kra
			{
				$devtex =~ s/^X/v/;
				replace_reg();
				$devtex = $devtex . $GrA_a{$hex} . "x";
				#printdev();
			}
			else
			{
				#printdev();
				replace_reg();
				$devtex = $devtex . $GrA_a{$hex} . "x";
				#printdev();
			}			
			#printdev();
		}
		else
		{
			#printdev();
			replace_reg();
			$devtex = $devtex . $GrA_a{$hex} . "x";
			#printdev();
		}
		$prev = 1;
		#printdev();
	}
	elsif(is_GRB($hex))
	{
		#printdev();
		#print $hex . "->" . $list[$i] . "->B\n";			
		if($prev == 99)
		{
			if($devtex =~ /x/)
			{
				$devtex =~ s/x/$GrB_a{$hex}x/;
				#printdev();
			}
			else
			{
				$devtex =~ s/(.)(.*)/$1$GrB_a{$hex}$2/;
			}
		}		
		elsif($prev == 6 && $devtex !~ /xi/)
		{
			if($devtex =~ /R/ && $hex =~ /5B/)
			{
				#do nothing because already R is there
				#printdev();
			}
			elsif($devtex =~ /R/ && $hex =~ /7B/)
			{
				$devtex =~ s/R/R$GrB_a{$hex}/;
				#printdev();
			}
			else
			{
				replace_reg();
				$devtex = $devtex . $GrB_a{$hex} . "xa";
				#printdev();
			}
		}
		elsif(($devtex ne "") && ($prev =~ /1/) && ($danda == 0))
		{
			if($devtex =~ /xi/)
			{
				$devtex =~ s/xi/$GrB_a{$hex}i/;
			}
			elsif($devtex =~ /x/)
			{
				$devtex =~ s/x/$GrB_a{$hex}xa/;
			}
			else
			{
				$devtex = $devtex . $GrB_a{$hex} . "xa";
			}
		}
		elsif(($devtex ne "") && ($prev == 2) && ($danda == 1))
		{
			$devtex =~ s/a/A/;
			replace_reg();
			$devtex = $devtex . $GrB_a{$hex} . "xa";
			#printdev();
		}		
		elsif(($devtex ne "") && ($prev =~ /1|2/))
		{
			#~ printdev();
			if( ($danda == 0) && ($devtex =~ /x/) )
			{
				$devtex =~ s/x$/a/;	
			}
			replace_reg();
			$devtex = $devtex . $GrB_a{$hex} . "xa";
			#printdev();
		}
		elsif( ($devtex ne "") && ($devtex =~ /x/) )
		{
			#print $devtex . "\n";
			$devtex =~ s/x/$GrB_a{$hex}/;
			#printdev();
		}
		elsif(($devtex ne "") && ($prev == 4))
		{
			replace_reg();
			$devtex = $devtex . $GrB_a{$hex} . "xa";
			#print $devtex . "\n";
		}			
		else
		{
			$devtex = $devtex . $GrB_a{$hex} . "xa";
			#printdev();
		}	
		$prev = 2;
		#printdev();
		#~ print $devtex . "\n";
		#printdev();
	}
	elsif(is_GRC($hex))
	{
		#print $hex . "->" . $list[$i] . "->B\n";
		if(($devtex ne "") && ($prev == 2) && ($danda == 0) && ($devtex !~ /^e/))
		{
			replace_reg();	
			$devtex = $devtex . $GrC_a{$hex} . "x";
		}		
		elsif(($devtex ne "") && ($prev =~ /1|2/) && ($danda == 0) && ($devtex !~ /^e/))
		{
			$devtex =~ s/x/$GrC_a{$hex}x/;
		}
		elsif(($devtex ne "") && ($prev =~ /1|2/))
		{
			replace_reg();
			$devtex = $devtex . $GrC_a{$hex} . "x";
		}
		elsif( ($devtex ne "") && ($devtex =~ /x/) && ($danda == 0))
		{
			#print $devtex . "\n";
			$devtex =~ s/x/$GrC_a{$hex}/;
		}
		else
		{
			replace_reg();
			$devtex = $devtex . $GrC_a{$hex} . "x" ;
			#printdev();			
		}		
		$prev = 1;
	}
	elsif(is_GRD($hex))
	{
		#print $hex . "->" . $list[$i] . "->D\n";
		if($devtex ne "")
		{
			replace_reg();
			$devtex = $devtex . $GrD_a{$hex};
			if($list[$i] =~ /[–!`(),.\/;?'|‘’-]/)
			{
				replace_reg();
			}
			#print $devtex."\n";
		}
		elsif( ($list[$i] =~ /[–!`(),.\/;?'|‘’-]/) )
		{
			$devtex = $devtex . $GrD_a{$hex};
			replace_reg();
		}
		else
		{
			$devtex = $devtex . $GrD_a{$hex};
			#print $devtex."\n";
		}
		$prev = 4;
	}
	elsif(is_GRE($hex))
	{
		#print $hex . "->" . $list[$i] . "->E\n";			
		$devtex = $devtex . $GrE_a{$hex};		
		$prev = 5;
		#printdev();
	}
	elsif(is_GRF($hex))
	{
		#printdev();
		#print $hex . "->" . $list[$i] . "->F\n";
		if( ($prev == 2) && ($devtex =~ /^i/) && ($list[$i] eq "&"))
		{
			$devtex =~ s/ixa/I/; 
		}
		elsif($list[$i] eq "&")
		{			
			$devtex = "r" . $devtex;
			#printdev();
		}
		elsif($hex eq "CB")
		{			
			$tmp_str = $devtex;
			$devtex = $GrF_a{$hex};
			$devtex =~ s/x/$tmp_str/;
			replace_reg();
			$tmp_str;
			$danda = 0;
		}
		elsif($hex eq "41")
		{			
			$tmp_str = $devtex;
			$tmp_str =~ s/(a|A)//;
			$devtex = $GrF_a{$hex};
			$devtex =~ s/x/$tmp_str/;
			replace_reg();
			$tmp_str = "";
			$danda = 0;
		}
		elsif($hex eq "58")
		{			
			$tmp_str = $devtex;
			if($tmp_str =~ /^"/)
			{
				$tmp_str =~ s/^"(.)(.*)/"$1/;
				#print $tmp_str . "\n";
			}
			elsif($tmp_str =~ /^\./)
			{
				$tmp_str =~ s/\.(.)(.*)/.$1/;
				#print $tmp_str . "\n";
			}
			else
			{
				$tmp_str =~ s/(.)(.*)/$1/;
				#print $tmp_str . "\n";
			}
			#print $tmp_str . "\n";
			$devtex = $GrF_a{$hex};
			$devtex =~ s/x/$tmp_str/;
			#printdev();
			if($danda == 2)
			{
				$devtex =~ s/e\.m/o.m/;
			}
			replace_reg();
			$tmp_str = "";
			$danda = 0;
		}
		elsif($hex eq "78")
		{
			$tmp_str = $devtex;
			if($tmp_str =~ /x/)
			{
				$tmp_str =~ s/(.*)x(.*)/$1/;
			}
			else
			{
				$tmp_str =~ s/(.*).$/$1/;
			}
			$devtex = $GrF_a{$hex};
			$devtex =~ s/x/$tmp_str/;
			if( (($prev == 1) && ($danda == 2)) || (($prev == 2) && ($danda == 1)))
			{
				$devtex =~ s/e$/o/;
			}
			replace_reg();
			$tmp_str = "";
			$danda = 0;
		}
		elsif($hex eq "7A")
		{
			$tmp_str = $devtex;
			$tmp_str =~ s/(.*)x(.*)/$1/;
			$devtex = $GrF_a{$hex};
			$devtex =~ s/x/$tmp_str/;			
			replace_reg();
			$tmp_str = "";
			$danda = 0;
		}
		elsif(($hex eq "40") && ($devtex =~ /x/))
		{
			#print $devtex . "\n";			
			if( ($danda == 1) && ($prev == 2) )
			{
				$devtex =~ s/.$/~o/;
			}
			elsif($devtex =~ /ax/)
			{
				$devtex =~ s/ax/~a/;
			}
			else
			{
				$devtex =~ s/.$/~a/;
			}
			replace_reg();
			$danda = 0;
		}
		elsif(($hex eq "40") && ($devtex !~ /^(a|A)/))
		{			
			$devtex =~ s/a$/~a/;
			$devtex =~ s/A$/~o/;
			replace_reg();
			$danda = 0;
		}
		elsif(($hex eq "40") && ($devtex =~ /^(a|A)/) && ($danda > 1))
		{			
			$devtex =~ s/^(a|A)/~o/;
			replace_reg();
			$danda = 0;
		}
		elsif(($hex eq "40") && ($devtex =~ /^(a|A)/) && ($danda == 1))
		{			
			$devtex =~ s/^(a|A)/~a/;
			replace_reg();
			$danda = 0;
		}
		elsif($hex eq "52")
		{			
			$devtex =~ s/(a|A)$/$GrF_a{$hex}/;
			replace_reg();
			$danda = 0;
		}
		elsif($list[$i] eq "a")
		{			
			$devtex = "r" . $devtex;
			$devtex =~ s/A/I/;
		}
		elsif( ($prev == 2) && ($devtex =~ /^e/) && ($list[$i] eq "s") && ($danda == 0))
		{
			$devtex =~ s/exa/ai/; 
		}
		elsif( ($prev == 1) && ($devtex =~ /^a/) && ($list[$i] eq "s") && ($danda == 2))
		{
			$devtex =~ s/a/o/; 
			$danda = 0;
		}
		elsif( ($prev == 1) && ($devtex =~ /^a/) && ($list[$i] eq "w") && ($danda == 2))
		{
			$devtex =~ s/a/au/; 
			$danda = 0;
		}
		elsif( ($danda >=1) && ($list[$i] =~ /[Efq|\\]/) )
		{
			#printdev();
			if( ($devtex ne "") && ($devtex =~ /A$/) && ($danda == 2))
			{
				if($prev != 2)
				{
					$devtex =~ s/A$/a/;
				}
				$danda--;
				#printdev();
			}
			elsif( ($devtex ne "") && ($devtex =~ /A$/) && ($danda == 1) && ($prev == 2))
			{
				$devtex =~ s/A$/a/;
				$danda--;
			}
			elsif(($devtex =~ /^dr/) && ($danda == 1))
			{
				$devtex =~ s/A$/a/;
			}
			$danda--;
			#printdev();
			replace_reg();
			$devtex = $GrF_a{$hex};
			#printdev();
			$danda = 0;
		}
		elsif( ($prev == 1) && ($list[$i] eq "r"))
		{
			$devtex =~ s/x//;
			$devtex =~ s/(a|A)$/I/;
			$danda = 0;
		}
		elsif( ($prev == 2) && ($list[$i] eq "r"))
		{
			$devtex =~ s/x//;
			$devtex =~ s/(a|A)$/I/;
			$danda = 0;
			#printdev();
		}
		elsif( ($prev == 6) && ($list[$i] eq "r"))
		{
			$devtex =~ s/(a|A)$/I/;
			$danda = 0;
		}
		elsif( ($prev == 1) && ($list[$i] eq "g") )
		{
			#print $devtex . "\n";
			$devtex =~ s/x//;
			$devtex =~ s/a$/u/;
			$danda = 0;
		}
		elsif( ($prev == 2) && ($list[$i] eq "g"))
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/u/;
			$danda = 0;
		}	
		elsif( ($prev == 6) && ($list[$i] eq "g"))
		{
			$devtex =~ s/x//;
			$devtex =~ s/a/u/; #newly added
			$danda = 0;
			#printdev();
		}			
		elsif( ($prev == 1) && ($list[$i] =~ /t|Ò/) )
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/U/;
			$danda = 0;
		}
		elsif( ($prev == 2) && ($list[$i] =~ /t|Ò/))
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/U/;
			$danda = 0;
		}		
		elsif( ($prev == 6) && ($list[$i] =~ /t|Ò/))
		{
			$devtex =~ s/x//;
			$devtex =~ s/a/U/; #changed a$ to a
			$danda = 0;
			#printdev();
		}		
		elsif( ($prev == 1) && ($list[$i] eq "=") )
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/.r/;
			$danda = 0;
		}
		elsif( ($prev == 2) && ($list[$i] eq "="))
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/.r/;
			$danda = 0;
		}
		elsif( ($prev == 1) && ($list[$i] eq "s") && ($danda == 1))
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/e/;
			$danda = 0;
		}
		elsif( ($prev == 2) && ($list[$i] eq "s") && ($danda == 0))
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/e/;
			$danda = 0;
		}
		elsif( ($prev == 1) && ($list[$i] eq "s") && ($danda == 2))
		{
			$devtex =~ s/x//;
			$devtex =~ s/(a|A)$/o/;
			$danda = 0;
		}
		elsif( ($prev == 2) && ($list[$i] eq "s") && ($danda == 1))
		{
			$devtex =~ s/.$/o/;
			$devtex =~ s/x//;
			$danda = 0;
		}
		elsif( ($prev == 6) && ($list[$i] eq "s") && ($danda == 0) )
		{
			$devtex =~ s/(a|A)$/e/;
			$danda = 0;
		}		
		elsif( ($prev == 6) && ($list[$i] eq "s") && ($danda == 2) )
		{
			$devtex =~ s/A/o/; ##this is to handle the case like Ceebs -> णों
			$danda = 0;
		}		
		elsif( ($prev == 1) && ($list[$i] eq "w") && ($danda == 1))
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/ai/;
			$danda = 0;
		}
		elsif( ($prev == 2) && ($list[$i] eq "w") && ($danda == 0) )
		{
			$devtex =~ s/x//;
			$devtex =~ s/a$/ai/;
			$danda = 0;
		}
		elsif( ($prev == 1) && ($list[$i] eq "w") && ($danda == 2))
		{
			$devtex =~ s/x//;
			$devtex =~ s/(a|A)$/au/;
			$danda = 0;
		}
		elsif( ($prev == 2) && ($list[$i] eq "w") && ($danda == 1))
		{
			$devtex =~ s/x//;
			$devtex =~ s/(a|A)$/au/;
			$danda = 0;
		}
		elsif($hex =~ /C7|FC/)
		{
			$devtex =~ s/x/$GrF_a{$hex}/;
			$danda = 0;
			#printdev();
		}
		elsif( ($GrF_a{$hex} eq ".R") && ($prev == 1) )
		{
			$devtex =~ s/xa$/$GrF_a{$hex}/;
			$danda = 0;
			#printdev();
		}
		elsif( ($GrF_a{$hex} eq "/") && ($prev == 2) && ($danda == 0))
		{
			$devtex = $devtex . $GrF_a{$hex}; #like hxa/ (हूँ)
			#printdev();
		}
		#~ elsif($list[$i] =~ /b|\[/)
		#~ {
			#~ $devtex = $devtex . $GrF_a{$hex};
			#~ replace_reg();
		#~ }
		else
		{
			#printdev();
			if($GrF_a{$hex} eq "u")
			{
				$devtex =~ s/a$/u/;
			}
			elsif( ($GrF_a{$hex} eq "R") && ($devtex =~ /^x/))
			{
				#~ if($devtex =~ /(a|A|u|U)$/)
				#~ {
					#~ replace_reg();
					#~ $devtex = $devtex . $GrF_a{$hex} . "xa"; #this case is added to handle dot below vyanjana.
				#~ }
				#~ else
				#~ {
					#~ $devtex =~ s/x/R/;
				#~ }
				#print $devtex . "->" . $danda . "\n";
				$devtex =~ s/x/R/;
				#printdev();
			}
			elsif( ($GrF_a{$hex} eq ".m") && ($prev == 1))
			{
				$devtex = $devtex . $GrF_a{$hex};
				#printdev();				
			}
			elsif( ($GrF_a{$hex} eq ".m") && ($prev == 2) && ($devtex =~ /^h/) && ($danda == 0) )
			{
				$devtex = $devtex . $GrF_a{$hex};
			}
			elsif( ($GrF_a{$hex} eq "e.m") && ($prev == 1))
			{
				#printdev();
				if($danda == 1)
				{
					$devtex =~ s/.$/e.m/;
				}
				elsif($danda == 2)
				{
					$devtex =~ s/.$/o.m/;
				}
			}
			elsif( ($GrF_a{$hex} eq "e.m") && (($prev == 2) || ($prev == 6)))
			{
				if($danda == 1)
				{
					$devtex =~ s/.$/o.m/;
				}
				elsif( ($danda == 0) && ($devtex =~ /^e/) )
				{
					$devtex =~ s/.$/.m/;
					$devtex =~ s/^e/ai/;
				}
				else
				{
					$devtex =~ s/.$/e.m/;
				}
			}
			elsif( ($GrF_a{$hex} eq "ai.m") && ($prev == 1))
			{
				if($danda == 1)
				{
					$devtex =~ s/.$/ai.m/;
				}
				elsif($danda == 2)
				{
					$devtex =~ s/.$/au.m/;
				}
			}
			elsif( ($GrF_a{$hex} eq "ai.m") && ($prev == 2))
			{
				if($danda == 1)
				{
					$devtex =~ s/.$/au.m/;
				}
				else
				{
					$devtex =~ s/.$/ai.m/;
				}
			}
			elsif(($hex eq "5E") && ($devtex =~ /x/))
			{
				$devtex =~ s/x/$GrF_a{$hex}/;
			}
			elsif(($hex eq "5E") && ($devtex =~ /i$/))
			{
				$devtex =~ s/i/$GrF_a{$hex}i/;
			}
			elsif(($hex eq "73") && ($devtex =~ /a\.m/))
			{
				$devtex =~ s/xa\.m/e.m/;
			}
			else
			{
				$devtex = $devtex . $GrF_a{$hex};
				#printdev();
				replace_reg();
				#printdev();
			}
		}
		$prev = 6;
		#printdev();
	}
	elsif(($hex eq "65") || ($hex eq "ED"))
	{
		#printdev();
		$danda++;
		if(($danda == 1) && ($prev == 1) && ($devtex !~ /^a/) && ($devtex !~ /i|\.m/))
		{			
			$devtex = $devtex . "a";
			#printdev();
		}
		elsif(($danda == 2) && ($prev == 1))
		{			
			$devtex =~ s/x//;
			$devtex =~ s/a$/A/;
			#printdev();
		}
		elsif(($danda == 1) && ($prev == 2))
		{
			$devtex =~ s/a$/A/;
			#printdev();
		}
		elsif(($danda == 1) && ($prev == 6))
		{
			$devtex =~ s/a$/A/;
			#printdev();
		}
		#$prev = 7;
		#print "e->" . $danda . "\n";
		#printdev();
	}
	elsif($hex eq "E2")
	{
		if($devtex =~ /^(k)/)
		{
		}
		elsif($devtex =~ /^(p)/)
		{
			$devtex =~ s/p/ph/;
			#print "\n" . $devtex . "\n";
		}
		elsif($devtex =~ /^X/)
		{
			$devtex =~ s/X/k/;
			#print "\n" . $devtex . "\n";
			#printdev();
		}
		else
		{
			if($devtex =~ /^(tt)x(a|A|i|u|e|o)/)
			{
				$devtex =~ s/(tt)x(a|i)/k\1x\2/;
				$devtex =~ s/p/ph/;
			}
			elsif($devtex !~ /^r(k|p)/)
			{
				$devtex =~ s/x/$1x/;				
				$devtex =~ s/p/ph/;
			}
			else
			{
				$devtex =~ s/p/ph/;
			}
		}
		#printdev();
	}
	elsif($hex eq "2B")
	{
		if($devtex =~ /^tr/)
		{
			$devtex = ".r";
		}
	}
	elsif($hex eq "E4")
	{
		if($devtex =~ /^(k|p)/)
		{
			$prev = 99;
			$devtex =~ s/a$//;
			$devtex =~ s/p/ph/;
			$danda--;
			#printdev();
		}
	}
}

sub print_line()
{
	$uniTXTFile = "uni.txt";
	$uniOUTFile = "uni1.txt";
	$tecFile = "velthuis_1.tec";
	$final_str =~ s/[\s]*\.h-[\s]*/:-/g;	
	$final_str =~ s/[\s]+\.h[\s]+/ : /g;	
	$final_str =~ s/R\.d/R/g;	
	$final_str =~ s/aY/y/g;	
	$final_str =~ s/aai/ai/g;	
	$final_str =~ s/ttk/kt/g;	
	$final_str =~ s/tkk/tk/g;	
	$final_str =~ s/ktt/kt/g;	
	$final_str =~ s/a&/&/g;
	$final_str =~ s/ni&(k|gh|k\.s)(t|r)a/n\1\2i/g; #this pattern has to be expanded for all possibilities
	$final_str =~ s/ni&(gh|k\.s)a/n\1i/g;
	open(TMP,">$uniTXTFile") or die "can't open $uniTXTFile";
	print TMP $final_str;
	close(TMP);
	system("txtconv -t $tecFile -i $uniTXTFile -o $uniOUTFile");
	open(TMP,"$uniOUTFile") or die "can't open $uniOUTFile";
	$final_str = <TMP>;	
	close(TMP);	
	#print $final_str . "\n";
}

sub replace_reg()
{
	#print "$devtex($danda)\n";
	if($danda == 2 && ($devtex !~ /^a/))
	{
		$devtex =~ s/^a/A/;
	}
	elsif($danda == 2 && ($devtex =~ /^a/))
	{
		$devtex =~ s/a/A/;
	}
	elsif($danda == 1 && ($prev == 2))
	{
		$devtex =~ s/a/A/;
	}
	elsif($danda > 2)
	{
		$devtex =~ s/a/A/;
	}

	$devtex =~ s/^X/v/;
	$devtex =~ s/x//;
	$devtex =~ s/^ea/e/;
	$devtex =~ s/^ia/i/;
	$devtex =~ s/^ua/u/;
	$devtex =~ s/^Ua/U/;
	$final_str = $final_str . $devtex;
	$devtex = "";
	$danda = 0;
	$prev = 0;
}

sub is_GRA()
{
	my($hex) = @_;

	if($hex =~ /$GrA/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_GRB()
{
	my($hex) = @_;

	if($hex =~ /$GrB/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_GRC()
{
	my($hex) = @_;

	if($hex =~ /$GrC/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_GRD()
{
	my($hex) = @_;

	if($hex =~ /$GrD/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_GRE()
{
	my($hex) = @_;

	if($hex =~ /$GrE/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_GRF()
{
	my($hex) = @_;

	if($hex =~ /$GrF/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub DecToNumBase()
{
  my $decNumber = $_[0];
  my $numBase = $_[1];
  my $numNumber = '';

  while($decNumber ne 'end') 
  {
    # divide the decimal number by $numBase and 
    # store the remainder (modulus function) in 
    # the temporary variable $temp
    my $temp = $decNumber % $numBase;
    if($temp > 9) 
    {
      $temp = chr($temp + 55);
    }
    $numNumber = $temp . $numNumber;
    $decNumber = int($decNumber / $numBase);
    if($decNumber < $numBase) 
    {
      if($decNumber > 9) 
      {
        $decNumber = chr($decNumber + 55);
      }
      $numNumber = $decNumber . $numNumber;
      $decNumber = 'end'; 
    } 
  }
  return $numNumber;
}

sub printdev()
{
	print $devtex . "($danda-$prev)\n";
	
}
