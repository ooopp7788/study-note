#ifndef _Stack_H
#define Stack_H_

struct Node;
typedef struct Node *PtrToNode;
typedef PtrToNode Stack;

int IsEmpty( Stack S );
Stack CreateStack( void );
void MakeEmpty( Stack S );
void DisposeStack( Stack S);
void Pop( Stack S );
void Push( Stack S );
ElementType Top( Stack S );

#endif