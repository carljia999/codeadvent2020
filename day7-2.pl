#/usr/bin/perl

use warnings;
use strict;

my %candidates;
my %graph;

while (my $line = <>) {
    chomp $line;
    my $outer;
    while ($line =~ /(?:(\d+)\s)?(\w+\s\w+) bags?/g) {
        my $color = $2;
        next if $color eq 'no other';
        if (!$outer) {
            $outer = $color;
        } else {
            push @{$graph{$outer}}, [$1, $color];
        }
    }
}

use Data::Dumper;
#print Dumper(\%graph);

sub visit_bag {
    my ($quan, $color) = @_;
    $candidates{$color} += $quan;
    return unless exists $graph{$color};
    for my $outer (@{$graph{$color}}) {
        visit_bag($outer->[0]*$quan, $outer->[1]);
    }
}

visit_bag(1, 'shiny gold');

#print Dumper(\%candidates);

use List::Util qw(sum);
my $count = sum(values %candidates)-1;
print $count, "\n";


