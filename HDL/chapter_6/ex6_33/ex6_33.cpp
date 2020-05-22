// Exercise 6.33 
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

void change_endian(char* array, int n)
{
	char temp;
	int j = n >> 1;
	for( int i = 0; i <= j; i++)
	{
		temp = array[i];
		array[i] = array[n-i];
		array[n-i] = temp;
	}
}

int main()
{
	char arr[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
	print_array(arr, sizeof(arr));
	change_endian(arr, sizeof(arr));
	print_array(arr, sizeof(arr));
}
