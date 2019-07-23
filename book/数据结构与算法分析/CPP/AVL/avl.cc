#include <iostream>
using namespace std;

struct AvlNode {
  int element;
  AvlNode *left;
  AvlNode *right;
  int height;

  AvlNode(const int e, AvlNode *lt, AvlNode *rt, int h = 0)
    : element(e), left(lt), right(rt), height(h) {};
};

int max(int a, int b) {
  return a > b ? a : b;
}

int height(AvlNode *N) {
  if (N == NULL)
    return -1;
  return N -> height;
};

void insert(const int X, AvlNode * N) {
  if (N == NULL)
    N = new AvlNode(X, NULL, NULL);
  else if (X < N -> element)
    insert(X, N -> left);
    if ( height(N -> left) - height(N -> right) == 2 )
      if (X < N -> element)
        rotateWithLeftChild(N);
      else
        rotateWithLeftChild(N);
  else if (X > N -> element)
    insert(X, N -> right);
    if ( height(N -> right) - height(N -> left) == 2 )
      if (X < N -> element)
        rotateWithRightChild(N);
      else
        rotateWithRightChild(N);
  else
  N -> height = max( height(N -> left), height(N -> right) ) + 1;
};

void rotateWithLeftChild(AvlNode * k2) {
  AvlNode *k1 = k2 -> left;
  k2 -> left = k1 -> right;
  k1 -> right = k2;
  k2 = k1;
}

void rotateWithRightChild(AvlNode * k2) {
  AvlNode *k1 = k2 -> right;
  k2 -> right = k1 -> left;
  k2 -> left = k1;
  k2 = k1;
}

void doubleWithLeftChild(AvlNode * k3) {
  
}

void doubleWithRightChild(AvlNode * k3) {
  rotateWithLeftChild(k3 -> left);
  rotateWithRightChild(k3);
}

int main() {
  return 0;
};