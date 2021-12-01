#/usr/bin/perl

use warnings;
use strict;

my @list1 = sort {$a <=> $b} <>;
#print @list1; 

my @list2 = reverse @list1;
#print @list2; 

for my $int1 (@list1) {
	for my $int2 (@list2) {
		my $sum = $int1 + $int2;
		if ($sum == 2020) {
			print $int1, $int2, "i * j", $int1*$int2, "\n";
			exit;
		} elsif ($sum < 2020) {
			last;
		}	
	}
}
