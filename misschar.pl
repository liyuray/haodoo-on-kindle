use strict;
use warnings;
$SIG{__DIE__}  = sub { Carp::confess(@_) };
$SIG{__WARN__} = sub { Carp::cluck(@_) };

binmode STDOUT, ":utf8";

my %hash;

while (<>) {
	next unless /input str: <(....)>/;
	my $code = $1;
	$hash{$code}++;
}

for my $code (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
	print "$code $hash{$code}", chr(hex($code)),$/;
}
