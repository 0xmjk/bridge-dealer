package BridgeDealer;

#
#  sethand.al
#
#  Part of:
#  BridgeDealer - hand dealing system
#  Copyright (c) 2000 Michal J. Kubski
#  All rights reserved.
#
#  Presets hand of player by putting
#  there specified cards.
#

sub sethand {	
        my $context = shift;
	my $player = shift;
	my @st = @_;	
	if (length(@st)>13) {
		croak ("Hey, you gave too many cards to one of players!");
	}	
	for (my $suit=0; $suit<4; $suit++) {
		my $hnd = $st[$suit];
		for (my $i=0;$i<length($hnd);$i++) {
			my $s = substr ($hnd,$i,1);
			my $num;
		        my $ret = switch ($s,
				"A" => sub { $num = 0 },
				"K" => sub { $num = 1 },
				"Q" => sub { $num = 2 },
				"J" => sub { $num = 3 },
				"T" => sub { $num = 4 },
				"9" => sub { $num = 5 },
				"8" => sub { $num = 6 },
				"7" => sub { $num = 7 },
				"6" => sub { $num = 8 },
				"5" => sub { $num = 9 },
				"4" => sub { $num = 10 },
				"3" => sub { $num = 11 },
				"2" => sub { $num = 12 }
				);
			if ($ret==-1) {
				croak ("Hey, what is \"",$s,"\"?");
			}
			$context->setdeck ($player,$suit,$num);
	        }    
	}
}

1;