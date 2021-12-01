#!env perl
use warnings;
use strict;

my $operand = qr/
    (?:
        (                   # start of capture group 1
        \(                  # match an opening brace bracket
            (?:
                [^()]++     # one or more non brace brackets, non backtracking
                  |
                (?-1)       # found ( or ), so recurse to capture group 1
            )+
        \)                  # match a closing brace bracket
        )                   # end of capture group 1
    |(\d+))
/x;

my $oper = qr/\s*([*+])\s*/;

sub eval_part {
    my $exp = shift;
    #print "input: $exp \n";
    return $exp if ($exp !~ m/$oper/);

    $exp = handle_precedence($exp);
    #print "preprocessed: $exp \n";

    $exp =~ m/^$operand/g;
    my $op1 = $1 // $2;
    #print "op1: $op1\n";
    if ($1) {
        $op1 =~ s/^.//;
        $op1 =~ s/.$//;
        $op1 = eval_part($op1);
    }
    while(1) {
        last unless $exp =~ m/\G$oper/g;
        my $op = $1;
        #print "op: $op\n";
        $exp =~ m/\G$operand/g;
        my $op2 = $1 // $2;
        #print "op2: $op2\n";
        if ($1) {
            $op2 =~ s/^.//;
            $op2 =~ s/.$//;
            $op2 = eval_part($op2);
        }
        #print "exec: $op1 $op $op2\n";
        $op1 = eval "$op1 $op $op2";
    }
    return $op1;
}

sub handle_precedence {
    my $exp = shift;

    my @parts;
    $exp =~ m/^$operand/g;
    my $op1 = $1 // $2;
    push @parts, $op1;
    while(1) {
        last unless $exp =~ m/\G$oper/g;
        my $op = $1;
        push @parts, $op;
        $exp =~ m/\G$operand/g;
        my $op2 = $1 // $2;
        push @parts, $op2;

        if ($op eq '+' ) {
            my ($new_op1) = splice @parts, -3;
            push @parts, "($new_op1 + $op2)";
        }
    }

    if (@parts == 1) {
        $parts[0] =~ s/^\((.+)\)$/$1/;
    } 

    $exp = join " ", @parts;

    return $exp;
}

my $result=0;

while(my $line = <>) {
    chomp($line);
    #my $v = eval_part($line);
    #print "$v\n";
    $result += eval_part($line);
}

print $result, "\n";






