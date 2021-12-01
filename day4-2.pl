#/usr/bin/perl
use v5.12;
use warnings;
use strict;

package Passport {
  use Moo;
  use Types::Common::Numeric qw( IntRange );
  use Types::Standard qw( Any Enum StrMatch Tuple );
  use Type::Utils;
  use namespace::autoclean;

  has byr => (
    is       => 'ro',
    isa      => IntRange[1920, 2002],
    required => 1,
  );
  has iyr => (
    is       => 'ro',
    isa      => IntRange[2010, 2020],
    required => 1,
  );
  has eyr => (
    is       => 'ro',
    isa      => IntRange[2020, 2030],
    required => 1,
  );
  has hgt => (
    is       => 'ro',
    isa      => union([
        StrMatch[
            qr{^([0-9]+)cm$},
            Tuple[
                IntRange[150,193],
            ],
        ], StrMatch[
            qr{^([0-9]+)in$},
            Tuple[
                IntRange[59,76],
            ],
        ],
    ]),
    required => 1,
  );
  has hcl => (
    is       => 'ro',
    isa      => StrMatch[qr/^#[0-9a-f]{6}$/],
    required => 1,
  );
  has ecl => (
    is       => 'ro',
    isa      => Enum[qw( amb blu brn gry grn hzl oth )],
    required => 1,
  );
  has pid => (
    is       => 'ro',
    isa      => StrMatch[qr/^\d{9}$/],
    required => 1,
  );
  has cid => (
    is       => 'ro',
    isa      => Any,
    required => 0,
  );
}
 
package main;

sub get_para {
    my %passport;
    while(my $line = <>) {
        chomp($line);
        last unless $line;
        $passport{$1} = $2 while $line =~ /(\w{3}):(\S+)/g;
    }
    return %passport;
}

my $count = 0;
while (my %passport = get_para()) {
    last unless %passport;

    eval {
        Passport->new(%passport)
    };

    if ($@) {
        print $@;
    } else {
        $count ++;
    }
}

print $count, "\n";



