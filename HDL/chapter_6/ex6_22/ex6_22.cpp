#include <iostream>
#include <string>

int fib(int n)
{	
	int result = 1;
	int x = 0;
	
	if ( n == 0 ) return 0;
	    else if ( n == 1) return 1; 
	for ( int i = 1; i < n; i++ )
    {
		result = result + x;
		x = result - x;
	}
    return result;
}

int main()
{
  int n;
  std::cout << "Please enter number ";
  std::cin >> n;
  std::cout << "Fibonacci numbers\n";
  for (int i = 0; i <= n; i++)
	std::cout << i << "\t";
  std::cout << "\n";
  for (int i = 0; i <= n; i++)
	  std::cout << fib(i) << "\t";
}