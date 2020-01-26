#include <stdio.h>

extern countMines(int* array, int i, int m, int n);

int arr[1000];

void printArray(int* a, int n, int m);

int main()
{
	int m = 4, n = 4, k = 3;
	//puting bombs
	int x = 1, y = 1;
	arr[(x + 1)*(n + 2) + 1 + y] = -1;
	x = 1, y = 3;
	arr[(x + 1)*(n + 2) + 1 + y] = -1;
	x = 3, y = 3;
	arr[(x + 1)*(n + 2) + 1 + y] = -1;

	printf("You put bombs like this:\n");
	printArray(arr, n, m);

	//traverse the array
	for (int i = 0; i < (m + 2)*(n + 2); i++)
	{
		/*continue if we are in invalid elements of matrix*/
		if (i % (n + 2) == 0 || i % (n + 2) == (n + 1)) //if i is in invalid columns.
			continue;
		else if ((i < n + 3) || (i > ((m-1 + 1) * (n + 2) + (1 + n-1)))) //if i is in invalid rows. 
			continue;
		else
		{
			countMines(&arr[i], i, m, n); //count mines in adjacent elements of a[i]
		}
	}

	printf("Now each element of matrix shows the number of bombs in its adjacent elements:\n");
	printArray(arr, n, m);
	int c;
	scanf_s("%d", &c); // so the command prompt will wait.
	return 0;
}

void printArray(int *a, int n, int m)
{
	for (int i = 0; i < (m + 2)*(n + 2); i++)
	{
		/*continue if we are in invalid elements of matrix*/
		if (i % (n + 2) == 0 || i % (n + 2) == (n + 1)) //if i is in invalid columns.
			continue;
		else if ((i < n + 3) || (i > ((m - 1 + 1) * (n + 2) + (1 + n - 1)))) //if i is in invalid rows. 
			continue;
		else
		{
			if (i % (n + 2) == 1)
				printf("\n");
			if (arr[i] == -1)
				printf("  *");
			else
				printf("%3d", arr[i]);
		}
	}
	printf("\n");
	printf("\n");
}