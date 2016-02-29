package BridgeDealer;

#
#  vector.al
#
#  Part of:
#  BridgeDealer - hand dealing system
#  Copyright (c) 2000 Michal J. Kubski
#  All rights reserved.
#
#  Computes value of hand or suit of player
#  using a table.
#

sub vector {	
        my $context = $_[0];
	my $player = $_[1];
	my @vc = @{$_[2]};	
	my $suit = $_[3];	
	
	my $hnd;
	my $sum=0;

	if (length($suit)!=0) {
		$hnd = $context->hand($player,$suit);
	} else {
	        $hnd = $context->hand($player,$SPADES).
	               $context->hand($player,$HEARTS).
        	       $context->hand($player,$DIAMONDS).
	               $context->hand($player,$CLUBS);	
	}

	for (my $i=0;$i<length($hnd);$i++) {
		my $s = substr ($hnd,$i,1);
		my $num;
	        switch ($s,
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
		 if ($num<=$#vc) {$sum+=$vc[$num]};
        }    
	$sum;
}

1;