// Question 6.4 
#include <iostream>
#include <string>
#include <cstddef>



int seek_one(unsigned int number);


int main()
{
	unsigned int number;
	std::cout << "Enter some number, please ";
	std::cin >> number;
	
	std::cout << "number of one: " << seek_one(number) << "!\n";
}

int seek_one(unsigned int number)
{
	int i = 0;
	int result = 0;
	while(i < 32)
	{
		if((1 << i)&number)
			result++;
		i++;
	}
	return result;
}










