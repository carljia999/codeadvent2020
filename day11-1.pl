#!env perl
use warnings;
use strict;

my @map;
while(my $line = <>) {
    chomp($line);
    my @str = split "", $line;
    push @map, \@str;
}

sub dump_map {
    print @$_,"\n" for @map;
}

use Data::Dumper;
#dump_map();

my $width = scalar @{$map[0]};
my $height = @map;

my $changes = 1;

my @neighbours = grep { $_->[0] != 0 || $_->[1] != 0 }
                 map { my $i = $_; map {[$i, $_]} (-1..1) }
                 (-1..1);

#print Dumper(\@neighbours);

do {
    $changes = 0;
    my @changes;
    for my $i (0..$height-1) {
        for my $j (0..$width-1) {
            next if $map[$i][$j] eq '.';

            my $occupied = grep {
                $map[$_->[0]][$_->[1]] eq '#'
            }
            grep {
                $_->[0] >=0 && $_->[0] < $height
                &&
                $_->[1] >=0 && $_->[1] < $width
            } map {
                [$i + $_->[0], $j + $_->[1]]
            } @neighbours;

            if ($map[$i][$j] eq 'L' && !$occupied) {
                push @changes, [$i, $j, '#'];
            } elsif ($map[$i][$j] eq '#' && $occupied>=4 ) {
                push @changes, [$i, $j, 'L'];
            }
        }
    }
    $changes = scalar @changes;
    for my $c (@changes) {
        $map[$c->[0]][$c->[1]] = $c->[2];
    }
    #print "-------------------after round---------------\n";
    #dump_map();
} while ($changes);

my $result = 0;

for my $i (0..$height-1) {
    for my $j (0..$width-1) {
        $result ++ if $map[$i][$j] eq '#';
    }
}

print $result, "\n";



