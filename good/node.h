/*!***************************************************
	 Mark Sattolo (mhsatto@po.cse)
	-----------------------------------------------
	  File: @(#)node.h
	  Version: 1.18
	  Last Update: 03/03/20 11:16:25

***************************************************!*/

#ifndef MHS_NODE_H
#define MHS_NODE_H

// need this line OR ensure that 'MFC compatibility' is NOT selected
// in Options/Project/Compiler/Source
//#undef __MFC_COMPAT__ // Declaration syntax error at string.h line 207 w/o this

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define KNAP_MAX_NAME_LEN 64

typedef enum boolean { False, True } BOOLEAN ;

typedef struct _node
{
  char  *name   ;
  int    level  ; // in the state space tree
  int    profit ;
  int    weight ;
  float  pw     ; // profit to weight ratio
  float  bound  ; // i.e. potential max profit of each node

  struct _node *next ;
}
 node;

typedef node *nodePtr ;

///// MEMORY MANAGEMENT ////////////////////////////////////////////////////////

BOOLEAN GetNode( nodePtr* );
void ReturnNode( nodePtr* );
BOOLEAN MemCheck( );

///// NODE FUNCTIONS ///////////////////////////////////////////////////////////

BOOLEAN setName( nodePtr, const char* );
BOOLEAN appendName( nodePtr, const char* );
void displayNode( nodePtr );
BOOLEAN copyNode( nodePtr, const nodePtr );

///////// PRIORITY_QUEUE ///////////////////////////////////////////////////////

typedef struct _pq
{
  nodePtr nodes ;
  int size ;
}
 PriorityQueue;

typedef PriorityQueue *PqPtr ;

void initQueue( PqPtr );
BOOLEAN isEmptyQueue( PqPtr );
void insertNode( PqPtr, nodePtr );
void displayQueue( PqPtr );
void removeNode( PqPtr, nodePtr );
void deleteQueue( PqPtr );

///////// NODE ARRAY ///////////////////////////////////////////////////////////

typedef node *nodeArray ;

BOOLEAN initNodeArray( nodeArray*, const int );
void displayNodeArray( const nodeArray, const int );
void deleteNodeArray( nodeArray, const int );
int compareNode( const void*, const void* );


#endif // MHS_NODE_H
