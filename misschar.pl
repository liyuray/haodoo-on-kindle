use strict;
use warnings;

binmode STDOUT, ":utf8";

while (<>) {
	next unless /input str: <(....)>/;
	my $code = hex($1);
	print "$code, ",chr($code), $/;
}
