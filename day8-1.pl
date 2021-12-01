#/usr/bin/perl
use warnings;
use strict;

my @program;

while (my $line = <>) {
    chomp $line;
    my ($op, $arg) = split / /, $line;
    push @program, [$op, $arg];
}

use Data::Dumper;
#print Dumper(\@program);

sub run {
    my ($alter) = @_;
    my ($accumulator, $ip, %ips) = (0, 0);
    while (1) {
        if ($ip >= @program) {
            print $accumulator, "\n";
            exit;
        }
        last if $ips{$ip};
        $ips{$ip} = 1;
        my ($op, $arg) = @{$program[$ip]};

        if ($ip == $alter) {
            $op = 'nop' eq $op ? 'jmp' : 'nop';
        }
        if ($op eq 'nop') {
            $ip ++;
        } elsif ($op eq 'jmp') {
            $ip += $arg;
        } elsif ($op eq 'acc') {
            $accumulator += $arg;
            $ip ++;
        }
    }
}

for my $i (0..$#program) {
    run($i) if $program[$i][0] =~ /nop|jmp/;
}
