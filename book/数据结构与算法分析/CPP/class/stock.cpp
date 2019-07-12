#include <iostream>
#include "stock.h"

Stock::Stock() {
  std::cout << "default constructor called.\n";
  company = "no names";
  shares = 0;
  share_val = 0.0;
  total_val = 0.0;
}

Stock::Stock(const std::string & co, long n, double pr) {
  std::cout << "Constructor using" << co << " called.\n";
  company = co;
  shares = n;
  share_val = pr;
  set_tot();
}

Stock::~Stock() {
  std::cout << "Bye, " << company << "!\n";
}

void Stock::buy(long num, double price) {
  shares += num;
  share_val = price;
  set_tot();
}

void Stock::sell(long num, double price) {
  
}