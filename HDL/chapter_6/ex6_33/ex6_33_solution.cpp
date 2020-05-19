// Exercise 6.33 solution
#include <iostream>
#include <string>
#include <cstddef>



void print_array(char* array, int n)
{
	for(int i = 0; i <= n; i++)
	{
		std::cout <<array[i];
	}
	std::cout << "\n";
}

void little2big(int* array)
{
  int i;
  for (i = 0; i < 3; i = i + 1) 
  {
    array[i] = ((array[i] & 0xFF) << 24) | 
                ((array[i] & 0xFF00) << 8)|
                ((array[i] & 0xFF0000) >> 8) |
               ((array[i] >> 24) & 0xFF);
  }
}

int main()
{
	char arr[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B'};
	print_array(arr, sizeof(arr));
	little2big((int*)(arr));
	print_array(arr, sizeof(arr));
}
