#!env perl
use warnings;
use strict;
use Data::Dumper;

local $/ = '';
my $result = 1;
my %tiles;
my %edges;
my @map;

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
            push $edges{$rev}->@*, $tile;
        } else {
            push $edges{$_}->@*, $tile;
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
# corners;
my @corners;
for my $tile (values %tiles) {
    my $connected;
    for ($tile->{edges}->@*) {
        my $rev = reverse;
        my $num = ($edges{$_} || $edges{$rev})->@*;
        $connected ++ if $num == 2;
    }
    $tile->{connected} = $connected;

    push (@corners, $tile) if $connected == 2;
}

my $width = sqrt(keys %tiles);

print "width: $width\n";

# fix top left

push $map[0]->@*, shift(@corners);
delete $tiles{$map[0][0]->{id}};

# sovle the puzzle
for my $i (0..$width-1) {
    for my $j (0..$width-1) {
        next if $i == 0 && $j == 0; # already done
        my $left_edge, $top_edge;
        if ($i == 0 || $i == $width-1) {
        } else {
            $left_edge = 
        }
    }
}
print $result, "\n";

