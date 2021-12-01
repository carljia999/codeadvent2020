#/usr/bin/perl

use warnings;
use strict;

my %candidates;
my %graph;

while (my $line = <>) {
    chomp $line;
    my $outer;
    while ($line =~ /(\w+\s\w+) bags?/g) {
        my $color = $1;
        if (!$outer) {
            $outer = $color;
        } else {
            push @{$graph{$color}}, $outer;
        }
    }
}

sub visit_bag {
    my $color = shift;
    return if $candidates{$color};
    $candidates{$color} = 1;
    return unless exists $graph{$color};
    for my $outer (@{$graph{$color}}) {
        visit_bag($outer);
    }
}

visit_bag('shiny gold');

my $count = (keys %candidates) - 1;
print $count, "\n";


