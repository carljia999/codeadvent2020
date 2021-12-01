#/usr/bin/perl

use warnings;
use strict;

my $count = 0;
while(my $line = <> ){
    my ($pos1, $pos2, $letter, $str) = $line =~ /(\d+)-(\d+)\s(\w):\s(.+)/;

    my @str = split "", $str;
    $count ++ if $str[$pos1-1] eq $letter && $str[$pos2-1] ne $letter;
    $count ++ if $str[$pos1-1] ne $letter && $str[$pos2-1] eq $letter;
}

print $count, "\n";

