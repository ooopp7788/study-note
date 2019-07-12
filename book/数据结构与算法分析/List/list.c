#include <stdio.h>
#include <stdlib.h>
#include "list.h"

struct Node {
  ElementType Element;
  Position    Next;
};

int IsEmpty( List L ) {
  return L -> Next == NULL;
}

int IsLast( Position P, List L ) {
  return P -> Next == NULL;
}

Position Find( ElementType X, List L ) {
  Position P;
  P = L -> Next;
  while ( P != NULL && X != P -> Element)
  {
    P = L -> Next;
  }
  return P;
}

Position FindPrevious( ElementType X, List L) {
  Position P;
  P = L -> Next;
  while ( P != NULL && X != P -> Next -> Element)
  {
    P = L -> Next;
  }
  return P;
}
void Delete( ElementType X, List L ) {
  Position P, Temp;
  P = FindPrevious(X, L);
  if (!IsLast(X, L)) {
    Temp = P -> Next;
    P -> Next = Temp -> Next;
    free( Temp );
  }
}
