#include <iostream>
#include <vector>
#include <cstdlib>
#include <string>
#include <stdexcept>

using namespace std;
int main(void) {
  double dval = 10.9;
  double *p = & dval;
  long int iresult;
  cout << p << endl;
  iresult = reinterpret_cast<long int> (&p);
  cout << iresult << endl;
}
