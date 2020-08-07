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

int seek_symb(char* str, char symb, int start)
{
	int i = start;
	while((str[i]!= symb)&&(str[i]!= '\0'))
	{
		i++;
	}
	return i-1;
}

void change_chars(char* str, int start, int end)
{
	int c = (end-start)>>1;
	
	for(int i = 0; i <= c; i++)
	{
		char t;
		t = str[start+i];
		str[start+i] = str[end-i];
		str[end-i] = t;
	}
}
