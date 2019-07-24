#include <iostream>
#include "heap.h"

template <typename Comparable>
void insert(const Comparable & x) {
  if (currentSize == array.size() - 1)
    array.resize(array.size() * 2);
  int hole = ++currentSize();
  for ( ; hole > 1 && x < array[hole / 2]; hole /= 2)
    array[hole] = array[hole / 2];
  array[hole] = x;
}

template <typename Comparable>
void BinaryHeap<Comparable>::deleteMin() {
  int hole = 1;
  array[hole] = array[currentSize--];
  percolateDown(hole);
}

template <typename Comparable>
template void BinaryHeap<Comparable>::percolateDown(int hole) {
  int child;
  Comparable tmp = array[hole];

  for ( ; hole * 2 <= currentSize; hole = child ) {
    child = hole * 2;
    if (child != currentSize && array[child + 1] < array[child])
      child ++;
    if (array[child] < array[hole])
      array[hole] = array[child];
    else
      break;
  }
  array[hole] = temp;
}