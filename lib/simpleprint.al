package BridgeDealer;

#
#  simpleprint.al
#
#  Part of:
#  BridgeDealer - hand dealing system
#  Copyright (c) 2000 Michal J. Kubski
#  All rights reserved.
#
#  Prints deal in a crude format.
#
#

    sub simpleprint
    {
        my $context = shift;
        my $gethand = sub {
            my $context = shift;
            my $p = shift;
            my @h=($context->hand($p,0),$context->hand($p,1),
                   $context->hand($p,2),$context->hand($p,3));
            my $o="";
            for (my $i=0; $i<4; $i++) {
                $h[$i] ="-" if length($h[$i])==0;
                $h[$i].=" " if $i<3;
                $o.=$h[$i];
            }
            $o;
        };
        printf "\t\t\t%s\n",&$gethand($context,0);
        printf "\t%s\t\t%s\n",&$gethand($context,3),&$gethand($context,1);
        printf "\t\t\t%s\n",&$gethand($context,2);
    }

1;