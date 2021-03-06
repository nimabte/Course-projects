#include <stdio.h>
#include <omp.h>
#include <math.h>

// integrate sin x dx from x=0 to pi


double f(double x) {
    return sin(x);
}

void main() {
    double dx = 0.00000001;
    double x1 = 0;
    double x2 = 3.14;

    int n = (x2 - x1) / dx;
    double s = 0;
    
    #pragma omp parallel num_threads(2) 
    {
        double local_s = 0;

        #pragma omp for
        for(int i=0; i<n; i++) {
            local_s = local_s + f(x1 + i*dx) * dx;        
        }

        #pragma omp atomic
        s += local_s;
    }

    printf("S: %.10f\n", s);
}