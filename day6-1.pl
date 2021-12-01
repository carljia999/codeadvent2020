#/usr/bin/perl

use warnings;
use strict;

local $/ = '';
my $count = 0;

while (my $para = <>) {
    chomp $para;
    my %yes;
    for my $l (split //, $para) {
        next if $l eq "\n";
        $yes{$l} = 1;
    }
    last unless %yes;
    print "keys: ", keys %yes,"\n";
    $count += keys %yes;
}

print $count, "\n";
