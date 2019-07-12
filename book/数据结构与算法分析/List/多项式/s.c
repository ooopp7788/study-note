#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#define MaxDegree 50

typedef struct Pol
{
  int CoeffArray[MaxDegree + 1];
  int HighPower;
} *Polynomlial;

void
ZeroPolynomlial(Polynomlial Poly)
{
  int i;
  for(i = 0; i <= MaxDegree; i++ )
    Poly -> CoeffArray[i] = 0;
  Poly -> HighPower = 0;
}

void
AddPolynomlial(
  const Polynomlial Poly1,
  const Polynomlial Poly2,
  Polynomlial PolySum)
{
  ZeroPolynomlial(PolySum);
  PolySum -> HighPower = Max(Poly1 -> HighPower, Poly2 -> HighPower);
  int i;
  for(i = PolySum -> HighPower; i >= 0; i-- )
    PolySum -> CoeffArray[i] = Poly1 -> CoeffArray[i] + Poly2 -> CoeffArray[i];
}

void
MultPolynomlial(
  const Polynomlial Poly1,
  const Polynomlial Poly2,
  Polynomlial PolyProd)
{
  PolyProd -> HighPower = Max(Poly1 -> HighPower, Poly2 -> HighPower);
  int i, j;
  for(i = Poly1 -> HighPower; i >= 0; i-- )
    for(j = Poly2 -> HighPower; j >= 0; j-- )
      PolyProd -> CoeffArray[i + j] = Poly1 -> CoeffArray[i] * Poly2 -> CoeffArray[j] + PolyProd -> CoeffArray[i + j];
}