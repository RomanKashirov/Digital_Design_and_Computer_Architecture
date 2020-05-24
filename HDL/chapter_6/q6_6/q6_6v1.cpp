// Question 6.6 версия для отбитых
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
// Если два старших бита - 1, значит будет переполнение. 
// Если один из старших бит - 1 и сумма 30:0 бит дает перенос, значит тоже будет переполнение
int check_overflow(unsigned int a, unsigned int b)
{	
	if( ((a&0x80000000)&(b&0x80000000)) | (((a&0x80000000)|(b&0x80000000)) & ( ((a&0x7FFFFFFF)+(b&0x7FFFFFFF))&0x80000000) ) )
	return 1;
	else return 0;
}











