// Question 6.3 
#include <iostream>
#include <string>
#include <cstddef>


void print_string(char* string);
void shitty_func(char* string);
void reverse(char* chars, int start, int end);


int main()
{
	char str[] = "Wubba Lubba Dub Dub";
	char test[] = {0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x77, 0x6F, 0x72 , 0x6C, 0x64, 0x00};
	print_string(str);
	shitty_func(str);
	print_string(str);
	print_string(test);
}

void print_string(char* string)
{
	int i = 0;
	while(string[i] != 0)
	{
		std::cout <<string[i];
		i++;
	}
	std::cout << "\n";
}

void shitty_func(char* string)
{
	int eofstr = 0;
	int eofword = 0;
	int sofword = 0;
	while(string[eofstr] != 0)
	{
		eofstr++;
	}
	reverse(string, 0, eofstr - 1);
	while(string[eofword] != 0)
	{
		while((string[eofword] != ' ') && (string[eofword] != 0))
		{
			eofword++;
		}
		reverse(string, sofword, eofword - 1);
		eofword++;
		sofword = eofword;
	}
}

void reverse(char* array, int j, int i)
{
	char tmp;
	while (i > j) 
	{
		tmp = array[i];
		array[i] = array[j];
		array[j] = tmp;
		i = i-1;
		j = j+1;
	}
}









