#!env perl
use warnings;
use strict;

my $result=0;
my %rules;
my %depends;                            # HoH key1 depends on keys2 

my @data;
while(my $line = <>) {
    chomp($line);
    next unless $line;
    if ($line =~ /^[ab]/) {
        # data section
        push @data, $line;
    } elsif ($line =~ /^(\d+):\s(.+)/) {
        $rules{$1} = $2;
        my ($pre,@posts) = $line =~ /(\d+)/g;
        for my $post (@posts){
            $depends{$post} //= {};
            $depends{$pre}{$post}=1;
        }
    }
}

use Data::Dumper;
#print Dumper(\%rules);

sub show {
    print join(",", map {;ref $_ ? Dumper($_) : $_} @_), "\n";
}

#show("Input", \%depends);

#--- delete free elements (i.e. w/o dependencies)
#my $loop_count;
my (@free,@result);
while ( @free = grep { ! %{ $depends{$_} } } keys %depends ) {
  push   @result, @free;
  delete @depends{@free};
  delete @$_{@free} for values %depends;
  #show("Phase: " . $loop_count++, \@free, \%depends);
}

#show("sorted: ", @result);

my %expanded;
sub expand_rule {
    my $rule = shift;

    if ($rule =~ /"([ab])"/) {
        return $1;
    } elsif ($rule =~ /([^|]+)[|]([^|]+)/) {
        my ($left, $right) = ($1, $2);
        return "(?:" . expand_rule($left) . "|" . expand_rule($right) . ")";
    } else {
        my @subs = $rule =~ /(\d+)/g;
        return join("", @expanded{@subs});
    }
}

for my $rid (@result) {
    $expanded{$rid} = expand_rule($rules{$rid});
}

#show("expanded: ", \%expanded);
#print $expanded{0}, "\n";

my $aa = $expanded{0};

for my $msg (@data) {
    $result ++ if $msg =~ /^$aa$/;
}

print "$result\n";
