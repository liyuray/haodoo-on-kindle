use strict;
use warnings;
#use HTML::FormatText;
#use HTML::Parse;
use Encode;
#use Encode::HanConvert;
use utf8;

my $text_encoding = "euc-jp";
my $plain_encoding = "sjis";
#my $encoding = "ascii";
#binmode STDOUT, ':utf8';
binmode STDOUT, ':raw';
for (1..15) {
	open my $fh, "<", "$_.txt" or die $!;
#	binmode $fh, ':encoding(utf16-le)';
	binmode $fh, ':encoding(UTF-16)';

	my $plain_text = do { local $/ = <$fh> };
	close $fh;

	$plain_text =~ s/^\x{3000}\x{3000}//gms;
	$plain_text =~ s/.*\-\-\-\-\-$//xmsg;
	$plain_text =~ s/^.*cunshang.*$//gmx;
	$plain_text =~ s/&nbsp;//g;
	$plain_text =~ s/&/\\&/g;
	$plain_text =~ s/}/\\}/g;
	$plain_text =~ s/{/\\{/g;
	$plain_text =~ s/\?/\？/g;
	$plain_text =~ s/\!!/\‼/g;
	$plain_text =~ s/\!/\！/g;
	$plain_text =~ s/\“/\「/g;
	$plain_text =~ s/\”/\」/g;
	$plain_text =~ s/－－/――/g;
	$plain_text =~ s/——/――/g;
	$plain_text =~ s/｜｜/――/g;
	$plain_text =~ s/•/・/g;
#	$plain_text = simp_to_trad($plain_text);
	print $/,'\newpage',$/;
	print
		encode($text_encoding, decode($plain_encoding,
									  encode(
										  $plain_encoding,
										  $plain_text,
										  #			Encode::FB_PERLQQ
										  sub { sprintf "\\UTFT{%X}",$_[0]	}
									  )
								  ));
#	print $plain_text;
}
