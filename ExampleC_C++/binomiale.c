#include <stdio.h>

long long int Fattoriale(int val)
{
  int i;
  long long int fatt = 1;
  for (i = 1; i <= val; i++)
    fatt = fatt * i;
  return fatt;
}

int Binomiale(int n, int k)
{
  return Fattoriale(n)/(Fattoriale(n-k) * Fattoriale(k));
}

int main()
{
  int a, b;

  printf("Inserisci i due numeri : ");
  scanf("%d%d",&a,&b);

  printf("Il coefficente binomiale C_(%d,%d) e' %d\n",a,b,Binomiale(a,b));
  return 0;
}
