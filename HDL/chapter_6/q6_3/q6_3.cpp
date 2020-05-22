// Question 6.3 
#include <iostream>
#include <string>
#include <cstddef>


void print_string(char* string);
void shitty_func(char* string);
void rev_chars(char* chars, int start, int end);


int main()
{
	char str[] = "Wubba Lubba Dub Dub";
	print_string(str);
	shitty_func(str);
	print_string(str);
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

	rev_chars(string, 0, eofstr - 1);
	
	
	while(string[eofword] != 0)
	{
        
		while((string[eofword] != ' ') && (string[eofword] != 0))
		{
			eofword++;
		}
	
		rev_chars(string, sofword, eofword - 1);
		eofword++;
		sofword = eofword;
	
	}
}

void rev_chars(char* chars, int start, int end)
{
	int half = (end - start) >> 1;
	char tmp;
	for (int i = 0; i <= half; i++)
	{
		tmp = chars[start + i];
		chars[start + i] = chars[end - i];
		chars[end - i] = tmp;
	}
}









