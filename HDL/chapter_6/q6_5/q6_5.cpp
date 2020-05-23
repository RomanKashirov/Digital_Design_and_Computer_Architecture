// Question 6.5 
#include <iostream>
#include <string>
#include <cstddef>



unsigned int reverse_bits(unsigned int number);


int main()
{
	unsigned int number;
	std::cout << "Enter some number, please ";
	std::cin >> number;
	
	std::cout << "number after reverse bits: " << reverse_bits(number) << "!\n";
}

unsigned int reverse_bits(unsigned int number)
{
	int i = 0;
	int result = 0;
	while(i < 16)
	{
    	result = result | (((1 << i)&number)<<(31-i*2));
		result = result | (((1 << (31-i))&number)>>(31-i*2));
		i++;
	}
	return result;
}










