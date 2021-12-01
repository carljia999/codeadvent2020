#/usr/bin/perl

use warnings;
use strict;

local $/ = '';
my $count = 0;

while (my $para = <>) {
    chomp $para;
    my %yes;
    my $lines = 1;
    for my $l (split //, $para) {
        $lines++, next if $l eq "\n";
        $yes{$l}++;
    }
    #print "keys: ", keys %yes,"length: $lines\n";
    $count += grep {$yes{$_} == $lines} keys %yes;
}

print $count, "\n";
