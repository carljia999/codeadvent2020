#/usr/bin/perl
use warnings;
use strict;

use Data::Dumper;

my $preamble_count = 25;
my @preamble;
my (@read, $invalid);

while (my $line = <>) {
    chomp $line;
    push @read, $line;
    if (@preamble < $preamble_count) {
        push @preamble, $line;
        next;
    }

    my $found = 0;
    OUTER:
    for my $i (0..$#preamble-1) {
        for my $j ($i+1..$#preamble) {
            if($preamble[$i]+$preamble[$j] == $line) {
                $found = 1;
                last OUTER;
            }
        }
    }

    if(!$found) {
        print $line, "\n";
        $invalid = $line;
        last;
    }

    shift @preamble;
    push @preamble, $line;
}

use List::Util qw(min max);
for my $i (0..$#read-1) {
    my $sum = $read[$i];
    for my $j ($i+1..$#read) {
        $sum += $read[$j];
        if ($sum == $invalid) {
            print "result:", min(@read[$i..$j])+max(@read[$i..$j]), "\n";
            exit;
        } elsif ($sum > $invalid) {
            last;
        }
    }
}


