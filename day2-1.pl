#/usr/bin/perl

use warnings;
use strict;

my $count = 0;
while(my $line = <> ){
    my ($min, $max, $letter, $str) = $line =~ /(\d+)-(\d+)\s(\w):\s(.+)/;

    my @num = $str =~ /$letter/g;
    $count ++ if @num >= $min && @num <= $max;
}

print $count, "\n";

