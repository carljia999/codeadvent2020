#/usr/bin/perl

use warnings;
use strict;

my @map;
while(my $line = <> ) {
    chomp($line);
    my @str = split "", $line;
    push @map, \@str;
}

#use Data::Dumper;
#print Dumper(\@map);
my ($i, $j, $count, $width);
$width = scalar @{$map[0]};
for $i (1..$#map) {
    $j += 3;
    $count ++ if $map[$i][$j % $width] eq '#';
}

print $count, "\n";
