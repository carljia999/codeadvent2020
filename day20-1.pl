#!env perl
use warnings;
use strict;
use Data::Dumper;

local $/ = '';
my $result = 1;
my %tiles;
my %edges;

sub find_edges {
    my $tile = shift;
    # top, right, bottom, left
    push $tile->{edges}->@*,
        $tile->{rows}->[0],
        join('', map {substr $_, -1} $tile->{rows}->@*),
        $tile->{rows}->[-1],
        join('', map {substr $_, 0, 1} $tile->{rows}->@*);

    for ($tile->{edges}->@*) {
        my $rev = reverse;
        if (exists $edges{$rev}) {
            $edges{$rev} ++;
        } else {
            $edges{$_} ++;
        }
    }
}

while (my $para = <>) {
    chomp $para;
    my ($id, @rows, @edges);
    for my $l (split /\n/, $para) {
        next unless $l;
        if ($l =~ /^Tile (\d+)/) {
            $id = $1;
        } else {
            push @rows, $l;
        }
    }

    my $tile = {
        id => $id,
        rows => \@rows,
        edges => [],
    };

    find_edges($tile);

    #print Dumper($tile);
    $tiles{$id} = $tile;
}

#print Dumper(\%edges);

# find number of edges with neighbours
for my $tile (values %tiles) {
    my $connected;
    for ($tile->{edges}->@*) {
        my $rev = reverse;
        my $num = $edges{$_} || $edges{$rev};
        $connected ++ if $num == 2;
    }
    $tile->{connected} = $connected;

    do { print $tile->{id}, "\n"; $result *= $tile->{id} } if $connected == 2;
}

print $result, "\n";

