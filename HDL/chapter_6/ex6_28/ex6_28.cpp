#include <iostream>
#include <string>

int func(int n, int k) {
int b;
b = k + 2;
if (n == 0) b = 10;
else b = b + (n * n) + func(n - 1, k + 1);
return b * k;
}


int main()
{
	int n, k;
	std::cout << "Please enter n ";
	std::cin >> n;
	std::cout << "Please enter k ";
	std::cin >> k;
	std::cout << "\nResult - " << func(n, k);
}

