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
my $width = scalar @{$map[0]};
my @slopes = (
    [1,1],
    [3,1],
    [5,1],
    [7,1],
    [1,2],
);

my $result = 1;
for my $slope (@slopes) {
    my ($i, $j, $count)= (0,) x 3;
    while ($i < $#map) {
        $i += $slope->[1];
        $j += $slope->[0];
        last if $i > $#map;
        $count ++ if $map[$i][$j % $width] eq '#';
    }
    print $count, "\n";
    $result *= $count;
}

print $result, "\n";



