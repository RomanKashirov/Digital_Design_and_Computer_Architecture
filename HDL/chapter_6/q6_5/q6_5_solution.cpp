// Question 6.5 solution
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
unsigned int swap(unsigned int number, int shamt, unsigned int mask);
unsigned int reverse_bits(unsigned int number)
{
	number = swap(number, 1, 0x55555555);  // swap bits
	number = swap(number, 2, 0x33333333);  // swap pairs
	number = swap(number, 4, 0x0F0F0F0F);  // swap nibbles
	number = swap(number, 8, 0x00FF00FF);  // swap bytes
	number = swap(number, 16, 0xFFFFFFFF); // swap halves
	return number;
}


// swap masked bits
unsigned int swap(unsigned int number, int shamt, unsigned int mask) 
{
	return ((number >> shamt) & mask) |
			((number & mask) << shamt);
}







