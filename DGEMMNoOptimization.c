#include<stdio.h>

/*
Calculate C = C + AB, where A, B, and C are matrices. This version uses 2D square arrays of n rows
and n cols.
*/
void dgemm( int n, long c[n][n], long a[n][n], long b[n][n]) {

	for (int i = 0; i < n; i++) {

		for (int j = 0; j < n; j++) {

			for (int k = 0; k < n; k++) {
			
				c[i][j] = c[i][j] + a[i][k] * b[k][j];

			}

		}

	}

}

int main() {
	
	int n = 1024;
	
	long a[n][n];
	long b[n][n];
	long c[n][n];
	
	for (int i = 0; i < n; i++) {
	
		for (int j = 0; j < n; j++) {
		
			a[i][j] = i + j;
			b[i][j] = i - j;
			c[i][j] = i << 2;
		
		}
	
	}
	
	dgemm(n, c, a, b);

}
