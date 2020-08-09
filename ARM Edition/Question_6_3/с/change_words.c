int seek_symb(char* str, char symb, int start);
void change_chars(char* str, int start, int end);

void change_words(char* str)
{
	int sofw = 0;
	int eofw = 0;
	int eofstr = seek_symb(str, '\0', 0);
	change_chars(str, 0, eofstr);
	while(str[eofw+1]!= '\0')
	{
		eofw = seek_symb(str, ' ', sofw);
		change_chars(str, sofw, eofw);
		sofw = eofw+2;
	}
}

int seek_symb(char* str, char symb, int i)
{
	while((str[i]!= symb)&&(str[i]!= '\0'))
	{
		i++;
	}
	return i-1;
}

void change_chars(char* str, int i, int j)
{
	char temp;
	while (j > i)
	{
		temp = str[i];
		str[i] = str[j];
		str[j] = temp;
		i++;
		j--;		
	}
}
