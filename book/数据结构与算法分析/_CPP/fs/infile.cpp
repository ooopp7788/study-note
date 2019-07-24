#include <iostream>
#include <fstream>

int main() {
  using namespace std;

  char automobile[50];
  int year;
  double a_price;
  double b_price;

  ifstream inFile;
  inFile.open("info.txt");

  if(!inFile.is_open()) {
    cout << "Cound not open file";
  }
  string value;
  inFile >> value;
  while(inFile.good()) {
    inFile >> value;
    cout << "value: " << value << "\n";
  }
  // cout << "value: " << value << "\n";
}