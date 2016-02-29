package BridgeDealer;

#
#  genhcp.al
#
#  Part of:
#  BridgeDealer - hand dealing system
#  Copyright (c) 2000 Michal J. Kubski
#  All rights reserved.
#
#  Presets hand of a player by putting
#  there random honoured cards to match
#  specified rules.
#
#

sub genhcp {
    my $context = shift;
    my $player = shift;
    my $minpoints = shift;
    my $maxpoints = shift;
    my @tab = @_;
    my @st;
    my $hcp;
    do {
        $hcp = 0;
        for (my $i=0; $i<4; $i++) {
            my ($p,$r,$s,$t);
            my ($min, $max)=(@tab[$i*2], @tab[$i*2+1]);
            do {            
                $t = int (rand()*16);
                $p = 0;
                $r = 0;
                $s = "";
                if ($t & 1) { $p+=4; $r+= 1; $s.="A" };
                if ($t & 2) { $p+=3; $r+= 1; $s.="K" };
                if ($t & 4) { $p+=2; $r+= 1; $s.="Q" };
                if ($t & 8) { $p+=1; $r+= 1; $s.="J" };                
            } until $r>=$min && $r<=$max;
            $hcp += $p;
            $st[$i]=$s;
        }
    } until $hcp>=$minpoints && $hcp<=$maxpoints;
    $context->sethand ($player,$st[0],$st[1],$st[2],$st[3]);
}

1;