void convert2bin(int num, char binarray[])
{
  int i;
  char tmp, val = 31;
  for (i=0; i<32; i++) {
    tmp = (num >> val) & 1; 
    binarray[i] = tmp;
    val--;
  }
}