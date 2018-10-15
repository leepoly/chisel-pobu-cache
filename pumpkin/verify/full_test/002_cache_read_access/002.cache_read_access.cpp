#ifdef x64
	#include <iostream>
    #include <cstdlib>
	using namespace std;
#endif

typedef unsigned long long int uint64;
#define CACHE_LINE_SIZE_LOG2            (6)
#define CACHE_LINE_SIZE_IN_BYTES        (64)
#define CACHE_ASSOCIATIVITY             (16)
#define CACHE_SIZE_IN_BYTES             (1024 * 1024 * 2)
#define CACHE_SET                       (CACHE_SIZE_IN_BYTES / CACHE_ASSOCIATIVITY / CACHE_LINE_SIZE_IN_BYTES)

#define LOOP_TIME                       1
#define VICTIM_SIZE                     ((uint64)1024 * 1024 * 1024 * 4)

unsigned char victim[VICTIM_SIZE];

int main()
{
    volatile uint64 result_sum = 0;
    volatile uint64 loop_counter = LOOP_TIME;

    #ifdef x64
        cout << "start execution" << endl;
        memset(victim, 1, sizeof(unsigned char) * VICTIM_SIZE);
    #endif
    
    while(loop_counter--)
    {
        for(uint64 set_index_counter = 0; set_index_counter < CACHE_SET; set_index_counter++)
        {
            for(uint64 way_index_counter = 0; way_index_counter < CACHE_ASSOCIATIVITY; way_index_counter++)
            {
                volatile uint64 offset = (set_index_counter << CACHE_LINE_SIZE_LOG2) +
                                         (way_index_counter << 20);
                result_sum += victim[offset];

                #ifdef x64
                    cout << "pointer is " << hex << offset << endl;
                #endif
            }
        }
    }
	
#ifdef x64
	cout << result_sum << endl;
#endif	
	return 0;
}