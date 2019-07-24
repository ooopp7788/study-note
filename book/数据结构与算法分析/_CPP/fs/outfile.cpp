#include <iostream>
#include <fstream>

int main() {
  using namespace std;

  char automobile[50];
  int year;
  double a_price;
  double b_price;

  ofstream outFile;
  outFile.open("info.txt");

  cout << "Enter automobile: ";
  cin.getline(automobile, 50);
  cout << "Enter year: ";
  cin >> year;
  cout << "Enter price: ";
  cin >> a_price;
  outFile << "automobile: " << automobile << "\n";
  outFile << "year: " << year << "\n";
  outFile << "price: " << a_price << "\n";
}