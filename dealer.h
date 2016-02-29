/*
 *
 *  dealer.h
 *
 *  Part of:
 *  BridgeDealer - hand dealing system
 *  Copyright (c) 2000 Michal J. Kubski
 *  All rights reserved.
 *
 */

#define fA 0			/* flags for fcolour */
#define fK 1
#define fQ 2
#define fJ 3
#define fT 4
#define f9 5
#define f8 6
#define f7 7
#define f6 8
#define f5 9
#define f4 10
#define f3 11
#define f2 12

#define SPADES 0
#define HEARTS 1
#define DIAMONDS 2
#define CLUBS 3

#define NORTH 0
#define EAST 1
#define SOUTH 2
#define WEST 3

class Dealer {
    public:

    Dealer();			/* constructor */
    ~Dealer();			/* destructor */

    int Deal();
    char *GetHand(int player, int suit);	/* returns pointer to hand in a string */

    int GetLength(int player, int suit);
    char *GetShape(int player);
    char *GetPattern(int player);
    int GetHCP(int player);
    void CleanDeck();
    int SetDeck(int player, int suit, int value);    
     private:

    typedef unsigned long long int ull;

    int setdeck[52];
    int hcps[4];		/* hcp table 'hcps[player]' */
    char hand[4][4][14];	/* hands table 'hand[player][suit]=(string)' */

    int init_rand();
    int rndcard();
};
