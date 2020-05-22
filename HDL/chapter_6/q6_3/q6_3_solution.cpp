// Question 6.3 
#include <iostream>
#include <string>
#include <cstddef>


void print_string(char* string);
void reversewords(char* array);
void reverse(char* array, int i, int j);


int main()
{
	char str[] = "Wubba Lubba Dub Dub";
	print_string(str);
	reversewords(str);
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



// high-level algorithm
void reversewords(char* array) 
{
	int i, j, length;
// find length of string
	for (i = 0; array[i] != 0; i = i + 1) ;
		length = i;
 
 // reverse characters in string
	reverse(array, length-1, 0);
// reverse words in string
	i = 0; j = 0;
 // check for spaces
	while (i <= length) 
	{
		if ( (i != length) && (array[i] != 0x20) ) 
		{
			i = i + 1;
		}
		else 
		{
			reverse(array, i-1, j);
			i = i + 1; // j and i at start of next word
			j = i;
		}
	}
}
void reverse(char* array, int i, int j)
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