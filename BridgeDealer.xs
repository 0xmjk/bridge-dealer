/*
 *
 *  BridgeDealer.xs
 *
 *  Part of:
 *  BridgeDealer - hand dealing system
 *  Copyright (c) 2000 Michal J. Kubski
 *  All rights reserved.
 *
 */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "dealer.h"

typedef Dealer * BridgeDealer;

MODULE = BridgeDealer		PACKAGE = BridgeDealer

PROTOTYPES: DISABLE

BridgeDealer
new(packname = "BridgeDealer")
        char *  packname
    CODE:
        {
            RETVAL = new Dealer();
        }
    OUTPUT:
        RETVAL

void
DESTROY(context)
        BridgeDealer      context
    CODE:
        {
            delete context;
        }

void
deal(context)
        BridgeDealer      context
	CODE:
	{
	    context->Deal();
	}

char *
hand(context,player,suit)
        BridgeDealer     context
	int player
	int suit
	CODE:
	{
	    char *s=context->GetHand(player,suit);
            ST(0) = sv_2mortal(newSVpv(s,strlen(s)));
	    delete s;
	}

char *
shape(context,player)
        BridgeDealer     context
	int player
	CODE:
	{
	    char *s=context->GetShape(player);
            ST(0) = sv_2mortal(newSVpv(s,strlen(s)));
	    delete s;
	}

char *
pattern(context,player)
        BridgeDealer     context
	int player
	CODE:
	{
	    char *s=context->GetPattern(player);
            ST(0) = sv_2mortal(newSVpv(s,strlen(s)));
	    delete s;
	}

int
hcp(context, player)
        BridgeDealer     context
        int player
        CODE:
        {
                RETVAL = context->GetHCP(player);
        }
        OUTPUT:
                RETVAL

void
cleandeck(context)
        BridgeDealer     context
        CODE:
        {
		context->CleanDeck();
        }

void
setdeck(context,player,suit,value)
        BridgeDealer     context
        int player
        int suit
        int value
        CODE:
        {
        char s[40];
        char CARDS[14] = "AKQJT98765432";
        char SUITS[5] = "SHDC";
        char PLAYERS[5] = "NESW";
        if ((player < 0) || (player > 4))
                croak("Hey, player must be from 0 to 3!");
        if ((suit < 0) || (suit > 4))
                croak("Hey, suit must be from 0 to 3!");
        if ((value < 0) || (value > 13))
                croak("Hey, value must be from 0 to 13!");

        if (context->SetDeck(player,suit,value)!=0) {
                sprintf (s, "Hey, card %c %c belongs to another player, or you did not clean the deck!",
                        CARDS[value], SUITS[suit]);
                croak (s);
        }
        }
