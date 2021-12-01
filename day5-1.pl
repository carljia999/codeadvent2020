#/usr/bin/perl

use warnings;
use strict;
#use List::Util qw(max);

my @seats;
while(my $line = <> ) {
    chomp($line);
    $line =~ tr/FBLR/0101/;
    my $num = oct "0b$line";
    push @seats, $num;
    #print $num, "\n";
}

#print max(@seats), "\n";

@seats = sort {$a <=> $b} @seats;

my $gap;
for my $i (0..$#seats) {
    if (!defined $gap) {
        $gap = $seats[$i] - $i;
    } elsif ($gap != $seats[$i] - $i) {
        print $seats[$i] - 1, "\n";
        last;
    }
}

