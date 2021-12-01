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

my $result=0;

while(my $line = <>) {
    chomp($line);
    $result += eval_part($line);
}

print $result, "\n";






