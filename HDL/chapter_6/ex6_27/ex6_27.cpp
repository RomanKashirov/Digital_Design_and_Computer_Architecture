#include <iostream>
#include <string>

int sub(int a, int b) {
	return a - b;
}

int compare(int a, int b) {
	if (sub(a, b) >= 0)
		return 1;
	else
		return 0;
}

void setArray(int num) {
	int array[10];
    for (int i = 0; i < 10; i = i + 1) {
		array[i] = compare(num, i);
	}
	for (int i = 0; i < 10; i++) {
		std::cout << array[i] << " ";
	}
	std::cout << "\n";
}

int main()
{
	int n;
	std::cout << "Please enter number ";
	std::cin >> n;
	setArray(n);
}