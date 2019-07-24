#include <iostream>

const int Max = 5;
int main(void) {
  using namespace std;

  double fish[Max];
  cout << "Enter weights of your fish.\n";
  cout << "You may enter up to " << Max
          << " fish <q to terminate>\n";
  cout << "fish #1: ";
  int i = 0;
  while(i < Max && cin >> fish[i]) {
    if (++i < Max) {
      cout << "fish #" << i+1 << ": ";
    }
  }

  double total = 0.0;
  for (int j = 0; j < i; j++) {
    total += fish[j];
  }
  if (i == 0) {
    cout << "No fish.\n";
  }
  else {
    cout << "average weight of " << i << " fish: " << total / i << ".\n";
  }
  cout << "DONE;\n";
  return 0;
}