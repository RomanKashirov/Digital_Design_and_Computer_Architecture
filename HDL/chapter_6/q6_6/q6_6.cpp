// Question 6.6 
#include <iostream>
#include <string>
#include <cstddef>



int check_overflow(unsigned int a, unsigned int b);


int main()
{
	unsigned int a;
	unsigned int b;
	std::cout << "Enter some unsigned integer, please a = ";
	std::cin >> a;
	std::cout << "Enter some unsigned integer, please b = ";
	std::cin >> b;
	
	if(check_overflow(a, b))
		std::cout << "FUCK YOU, ASSHOLE ";
	else std::cout << "a + b = " << a + b;
	
	
}

int check_overflow(unsigned int a, unsigned int b)
{	
	int i = 31;
	while ( ((a & (1 << i)) | (b & (1 << i))) && (i >= 0))
	{
		if((a & (1 << i)) & (b & (1 << i)))
			return 1;
		i = i - 1;
	}
	return 0;
}










