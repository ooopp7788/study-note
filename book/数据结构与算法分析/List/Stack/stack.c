#include <stdio.h>
#include <stdlib.h>
#include "stack.h"

struct Node {
  ElementType Element;
  PtrToNode    Next;
};

int IsEmpty( Stack S ) {
  return S -> Next == NULL;
}

void MakeEmpty( Stack S ) {
  while( !IsEmpty( S ) ) {
    Pop( S );
  }
}

Stack CareteStack( void ) {
  Stack S;
  S = malloc( sizeof (struct Node) );
  if ( S == NULL )
    FatalError('out of space');
  S -> Next = NULL;
  MakeEmpty( S );
  return S;
}

void Pop( Stack S ) {
  
}
