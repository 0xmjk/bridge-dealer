package BridgeDealer;

#
#  tableprint.al
#
#  Part of:
#  BridgeDealer - hand dealing system
#  Copyright (c) 2000 Michal J. Kubski
#  All rights reserved.
#
#  Prints deal formatted into a nice table.
#
#

sub tableprint {
    my $context = shift;
    my @vid;
    my @h;
    my ($a,$b,$c);

    my $puthand = sub {
        my $x = shift;
        my $y = shift;
        my $p = shift;
        my $vid = shift;
        my (@h,@hl,$i,$j);
        for ($i=0;$i<4;$i++) {
            $h[$i]=$context->hand($p,$i);
            $h[$i]="---" if (length($h[$i])==0);
            $hl[$i]=length($h[$i]);
        }
        my $max = shift(@hl);
        my $foo;
        foreach $foo (@hl) {
            $max = $foo if $max < $foo;
        }
        for ($j=0; $j<4; $j++) {
            for ($i=0; $i<length($h[$j]); $i++) {
                $$vid[($x+$j)*45+$y+$i]=substr($h[$j],$i,1);
            }
        }
        return $max;
    };

    $a=&$puthand(4,0,3,\@vid)+1;        
    $b=&$puthand(0,$a,0,\@vid)+1;
    $c=&$puthand(8,$a,2,\@vid)+1;
    if ($b<$c) { $b=$c; };
    &$puthand(4,$b+$a,1,\@vid);                

    for ($i=0; $i<12; $i++) {
        for ($j=0; $j<45; $j++) {
	    my $r="";
            $r=@vid[$i*45+$j];
            $r=" " if (($r cmp "")==0);
            print $r;
        }
        print "\n";
    }
}

1;