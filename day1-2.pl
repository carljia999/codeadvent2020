#/usr/bin/perl

use warnings;
use strict;

my @list1 = sort {$a <=> $b} map {chomp; $_} <>;

my @list2 = reverse @list1;

for my $int0 (@list1) {
	my $target = 2020 - $int0;
	for my $int1 (@list1) {
		for my $int2 (@list2) {
			my $sum = $int1 + $int2;
			if ($sum == $target) {
				print $int0, $int1, $int2, "i * j *k", $int0*$int1*$int2, "\n";
				exit;
			} elsif ($sum < $target) {
				last;
			}
		}
	}
}

