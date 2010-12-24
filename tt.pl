use strict;
use warnings;
#use HTML::FormatText;
#use HTML::Parse;
use Encode;
#use Encode::HanConvert;
use utf8;

$SIG{__DIE__}  = sub { Carp::confess(@_) };
$SIG{__WARN__} = sub { Carp::cluck(@_) };

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
	$plain_text =~ s/｜/―/g;
	$plain_text =~ s/•/・/g;
	$plain_text =~ s/‧/・/g;
	$plain_text =~ s/值/値/g;
	$plain_text =~ s/剎/刹/g;
	$plain_text =~ s/污/汚/g;
	$plain_text =~ s/夠/彀/g;
	$plain_text =~ s/拋/抛/g;
	$plain_text =~ s/查/査/g;
	$plain_text =~ s/鄉/郷/g;
	$plain_text =~ s/躲/躱/g;
	$plain_text =~ s/喻/喩/g;
	$plain_text =~ s/拋/抛/g;
	$plain_text =~ s/啟/啓/g;

#	$plain_text = simp_to_trad($plain_text);
	print $/,'\newpage',$/;
	print
		encode($text_encoding, decode($plain_encoding,
									  encode(
										  $plain_encoding,
										  $plain_text,
										  #			Encode::FB_PERLQQ
										  sub { sprintf "\\UTF{%X}",$_[0]	}
									  )
								  ));
#	print $plain_text;
}
