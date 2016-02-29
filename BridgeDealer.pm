package BridgeDealer;

#  BridgeDealer.pm
#
#  Part of:
#  BridgeDealer - hand dealing system
#  Copyright (c) 2000 Michal J. Kubski
#  All rights reserved.

BEGIN {
$SIG{'__WARN__'} = sub { warn $_[0] if $_[0] !~ /Use of uninit/ };
require DynaLoader;
require Exporter;

@ISA = (DynaLoader,Exporter);

bootstrap BridgeDealer;

@EXPORT = qw (switch);

use Carp;

$SPADES = 0;
$HEARTS = 1;
$DIAMONDS = 2;
$CLUBS = 3;

$NORTH = 0;
$EAST = 1;
$SOUTH = 2;
$WEST = 3;

};

sub switch (%) {
        my $expr = shift;
        my %hash = @_;
        if (length($hash{$expr})==0)
        {
                return -1;
        }
        &{$hash{$expr}};
        return 0;
}

END { }

1;