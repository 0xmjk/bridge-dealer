/*
 *
 *  dealer.cc
 *
 *  Part of:
 *  BridgeDealer - hand dealing system
 *  Copyright (c) 2000,2008 Michal J. Kubski
 *  All rights reserved.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#include "dealer.h"

#ifdef WIN32 
#include <windows.h>
DWORD WINAPI GetTickCount(void);
#  define drand48() (((float) rand())/((float) RAND_MAX))
#  define srand48(x) (srand((x)))
#endif

Dealer::Dealer()
{
    init_rand();
    CleanDeck();
}

Dealer::~Dealer()
{

}

int Dealer::Deal()
{
    int i, p, s, v;

    ull decktest = 0ULL;
    ull hndk[4];
    ull j;

    int cards[4];

    char CARDS[14] = "AKQJT98765432";

    memset(&cards, 0, sizeof(int[4]));
    memset(&hcps, 0, sizeof(int[4]));
    memset(&hndk, 0, sizeof(ull[4]));

    for (i = 0; i < 52; i++) {
	if ((p = setdeck[i]) != -1) {
	    decktest |= 1ULL << i;
	    hndk[p] |= 1ULL << i;
	    cards[p]++;
	}
    }

    for (p = 0; p < 4; p++) {
	for (i = cards[p]; i < 13; i++) {
	    while (decktest & (j = 1ULL << rndcard()));
	    decktest |= j;
	    hndk[p] |= j;
	}
	for (s = 0; s < 4; s++) {
	    for (v = 0, i = 0; v < 13; v++)
		if (hndk[p] & (1ULL << (s * 13 + v))) {
		    hand[p][s][i++] = CARDS[v];
		    if (v < 4)
			hcps[p] += 4 - v;
		}
	    hand[p][s][i] = '\0';
	}
    }
}

char *Dealer::GetHand(int player, int suit)
{
    char *s = new char[strlen(hand[player][suit])];
    strcpy(s, hand[player][suit]);
    return s;
}


/* FYI: (from Linux Programmer's Manual)

 * #include <stdlib.h> 
 *
 * double drand48(void);
 * void srand48(long int seedval);
 *
 * drand48,  erand48,  lrand48,  nrand48,  mrand48,  jrand48,
 * srand48, seed48, lcong48 - generate uniformly  distributed
 * pseudo-random numbers
 *
 */

int Dealer::init_rand()
{
    int fd;
    int a;

/* FYI: (from Linux Programmer's Manual)

 *      The  srand48(),  seed48() and lcong48() functions are ini­
 *      tialization functions,  one  of  which  should  be  called
 *      before using drand48(), lrand48() or mrand49().  The func­
 *      tions erand48(), nrand48() and jrand48() do not require an
 *      initialization function to be called first.
 */


#ifndef WIN32
    if ((fd = open("/dev/random", O_RDONLY)) == -1) {
	perror("open random");
	return -1;
    }
    read(fd, &a, 4);
    
    srand48(a);

    close(fd);
#else
    srand48(GetTickCount());
#endif

    return 0;
}

int Dealer::rndcard()
{

/* FYI: (from Linux Programmer's Manual)

 * The  drand48() and erand48() functions return non-negative
 * double-precision  floating-point  values  uniformly   dis­
 * tributed between [0.0, 1.0).
 */
    return (int) (52 * drand48());
}

int Dealer::GetLength(int player, int suit)
{
    return strlen(hand[player][suit]);
}

char *Dealer::GetShape(int player)
{
    char *shp = new char[12];
    sprintf(shp, "%d %d %d %d", GetLength(player, SPADES), GetLength(player, HEARTS), GetLength(player, DIAMONDS), GetLength(player, CLUBS));
    return shp;
}

char *Dealer::GetPattern(int player)
{
    int k[4];
    int z = 0, i, j, t, n = 0;
    char *ptrn = new char[12];

    k[SPADES] = GetLength(player, SPADES);
    k[HEARTS] = GetLength(player, HEARTS);
    k[DIAMONDS] = GetLength(player, DIAMONDS);
    k[CLUBS] = GetLength(player, CLUBS);
    while (1) {
	n++;
	for (i = 0, z = 0; i < 3; i++) {
	    if (k[i] < k[(j = i + 1)]) {
		t = k[i];
		k[i] = k[j];
		k[j] = t;
		z = 1;
	    }
	}
	if (z == 0)
	    break;
    }
    sprintf(ptrn, "%d %d %d %d", k[0], k[1], k[2], k[3]);
    return ptrn;
}

int Dealer::GetHCP(int player)
{
    return hcps[player];
}

void Dealer::CleanDeck()
{
    int i;
    for (i=0;i<52;i++)
        setdeck[i]=-1;
}

int Dealer::SetDeck(int player, int suit, int value)
{
    int e;
    e=suit*13+value;
    if (setdeck[e]!=-1)
	return -1;
    setdeck[e]=player;
    return 0;
}
