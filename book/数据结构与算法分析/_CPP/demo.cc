#include <iostream>
#include <vector>
#include <cstdlib>
#include <string>
#include <stdexcept>

using namespace std;
int main(void) {
  int i = 100;
  int *p = (int*) 10;
  cout << p << '\n';
  p = & i;
  cout << p;
}
