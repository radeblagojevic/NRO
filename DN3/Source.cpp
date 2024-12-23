#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>

using namespace std;

double calcAtan(double x, int steps)
{
	int n = 0;
	double out = 0;

	while (n <= steps)
	{
		out += pow(-1, n) * ((pow(x, 2 * n + 1)) / (2 * n + 1));
		
		n++;
	}
	return out;
}
double fun(double x, int steps)
{
	double out;
	out = exp(3 * x) * calcAtan(x / 2, steps);
	return out;
}
int main()
{
	double a = 0;
	double b = M_PI / 4;
	
	int steps = 1000;
	int n = 1000;
	double dx = (b - a) / n;
	double sum = fun(a, steps) + fun(b, steps);
	for (int i = 1; i < n; i++)
	{
		
		sum += 2 * fun(i * dx, steps);
	}
	double out = (dx / 2) * sum;
	cout << "Rezultat:" << out << endl;
	
	return 0;
}