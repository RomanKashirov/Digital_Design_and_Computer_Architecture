// Question 6.7
#include <iostream>
#include <string>
#include <cstddef>



int palindrome(char* string);
void shitty_func(char* string);
void reverse(char* array, int j, int i);


int main()
{
	char str[] = "racecar";
	
	std::cout << "String \""<< str;
	if(palindrome(str)) std::cout<<"\" is palindrome!";
	else std::cout<<"\" isn't palindrome!";
}


int palindrome(char* string)
{
	int sofstr = 0;
	int eofstr = 0;
	// find length of string
	while(string[eofstr] != 0)
	{
		eofstr++;
	}
	eofstr = eofstr - 1; // index of last char
	while (eofstr > sofstr) 
	{
		if(string[sofstr] != string[eofstr])
		{
			return false;
		}
		eofstr = eofstr - 1;
		sofstr = sofstr + 1;
	}
	
	return true;
}







