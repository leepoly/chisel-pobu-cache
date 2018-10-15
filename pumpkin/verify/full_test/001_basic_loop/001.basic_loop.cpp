#ifdef x64
	#include <iostream>
	using namespace std;
#endif

#define limit 10

int main()
{
	long long int result_sum = 0;
	
	for(long long int i = 0 ; i<(limit); i++)
	{
		result_sum += i;
	}
	
#ifdef x64
	cout << result_sum << endl;
#endif	
	return 0;
}
