#include <iostream>
#include <random>
#include <algorithm>
#include <thread>
#include <mutex>
#include <chrono>
#include <fstream>
#define MIN(a,b) ((a) < (b) ? a : b)

using arr_type = double;

const auto nelem = 960000;
const auto maxrand = 10000000;
const auto nruns = 10;

static auto rand_gen()
{
    static std::random_device rnd_dev;
    static std::mt19937 mersenne_engine{rnd_dev()};
    static std::uniform_int_distribution<int> dist{1, maxrand};
    return dist(mersenne_engine);
}

void InsertionSort(arr_type a[])
{
    int j, k, temp;
    for(j = 1; j < nelem; j++)
    {
        for(k = j-1; k >= 0; k--)
        {
            // If value at higher index is greater, then break the loop.
            if(a[(k+1)] >= a[k])
                break;
            // Switch the values otherwise.
            else
            {
                temp = a[k];
                a[k] = a[(k+1)];
                a[(k+1)] = temp;
            }
        }
    }
}

void InsertionSort(arr_type a[], int n, int gap)
{
    int j, k, temp;
    for(j = 1; j < n; j++)
    {
        for(k = j-1; k >= 0; k--)
        {
            // If value at higher index is greater, then break the loop.
            if(a[(k+1)*gap] >= a[k*gap])
                break;
            // Switch the values otherwise.
            else
            {
                temp = a[k*gap];
                a[k*gap] = a[(k+1)*gap];
                a[(k+1)*gap] = temp;
            }
        }
    }
}

void shell_sort_test(arr_type a[])
{
    int i, j, k, temp;
    // Gap 'i' between index of the element to be compared, initially n/2.
    for(i = (int)(nelem/2); i > 0; i = (int)(i/2))
    {
        for(j = i; j < nelem; j++)
        {
            for(k = j-i; k >= 0; k = k-i)
            {
                // If value at higher index is greater, break the loop.
                if(a[k+i] >= a[k])
                    break;
                // Switch the values otherwise.
                else
                {
                    temp = a[k];
                    a[k] = a[k+i];
                    a[k+i] = temp;
                }
            }
        }
    }
}

static void shell_sort(int thr_id,int gap,int max_threads, arr_type arr[])
{
	// calculate the length of the array for insertion sort with gap 
    auto length =nelem-thr_id+gap-1; 
    InsertionSort(&arr[thr_id],(int)(length/gap),gap);

	// calculate howmany insertion sort each thread should do
	// it depends on howmany element we have in each gape
	// if it's less than the number of our threads we just use 
	// as many threads as we need.
	// if there are more, each thread has to perform gap/max_threads
	// insertion sort (some one more)
    auto g = gap - max_threads - thr_id;
    auto k = 1;
    while(g > 0)
    {
        InsertionSort(&(arr[thr_id + max_threads*k]),
		    (int)((length - max_threads * k)/gap),gap);
        g -= max_threads;
        g++;
    }
}

void parallel_shellsort(arr_type arr[],auto max_threads)
{
	// create array of threads
    std::thread threads[max_threads];
    for(auto gap = (unsigned int)(nelem/2); gap > 1; gap = gap/2)
    {
		// to decide howmany threads is needed for this gap
        auto t_num = MIN(gap,max_threads);
        for (auto thr_id = 0u ; thr_id < t_num ; thr_id++ )
        {
            threads[thr_id]=
                std::thread{shell_sort, thr_id, gap, max_threads, arr};
        }
        for (auto t = 0u; t < t_num; t++)
            threads[t].join();
    }
	// when gap equals to 1 whe have one thread and we have to do
	// one insertion sort, so i put it here.
    InsertionSort(arr);
}
int main()
{
    arr_type arr[nelem];
	
	// define max_tthread based one the number of cores of the system.
    const auto max_threads = std::thread::hardware_concurrency();

    auto get_time = std::chrono::steady_clock::now;
    decltype(get_time()) start, end;

    /// Serial
    start = get_time();
    for (auto i = 0; i < nruns; i++)
    {
        std::generate(arr, arr+nelem-1, rand_gen);
        shell_sort_test(arr);
    }
    end = get_time();

    auto elapsed = std::chrono::duration_cast
                   <std::chrono::milliseconds>(end - start).count();
    auto ser_time = double(elapsed) / nruns;

    std::cout << "Serial time: " << ser_time << "ms" << std::endl;

    /// Parallel
    std::cout << "Paralel time: " << std::endl;
    std::ofstream speedupfile{"speedup"};
    if (!speedupfile.is_open())
    {
        std::cerr << "can't open file" << std::endl;
        return 1;
    }

    for (auto nthr = 2u; nthr <= max_threads; nthr++)
    {
        start = get_time();

        for (auto i = 0; i < nruns; i++)
        {
            std::generate(arr, arr+nelem-1, rand_gen);
            parallel_shellsort(arr, nthr);
        }
        end = get_time();
        elapsed = std::chrono::duration_cast
                  <std::chrono::milliseconds>(end - start).count();
        auto par_time = double(elapsed) / nruns;
        std::cout << "Using " << nthr << " threads: "  << "elapsed time "
                  << par_time << "ms _ speedup " << ser_time / par_time << std::endl;
        speedupfile << nthr << "\t" << ser_time / par_time << std::endl;
    }
    speedupfile.close();
    return 0;
}
