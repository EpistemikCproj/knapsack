/*
	File:		knapsack.c
	Author:	Mark Sattolo
	Date:		9 March 2003

Best-First Search with Branch-and-Bound Pruning Algorithm
 for the 0-1 Knapsack Problem

see p.235 of "Foundatins of Algorithms: with C++ pseudocode", 2nd Ed. 1998,
 by Richard Neapolitan & Kumarss Naimipour, Jones & Bartlett, ISBN 0-7637-0620-5

Problem: Let n items be given, where each item has a weight and a profit.

*/

#include <string.h>
#include "node.h"

#define MAX_NAME_LEN 64
