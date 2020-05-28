#include <omp.h>
#include <stdio.h>

long fib(int n) {
    int f[n+2];
    
    f[0] = 0;
    f[1] = 1;

    for(int i=2; i<=n; i++) {
        f[i] = f[i-1] + f[i-2];
    }

    return f[n];
}

void main() {
    long s = fib(7);
    
    printf("S: %ld\n", s);
}