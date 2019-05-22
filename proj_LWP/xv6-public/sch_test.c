/**
 * This program runs various workloads cuncurrently.
 */


#include "types.h"
#include "stat.h"
#include "user.h"

const int THD_NUM = 5;

int a = 0;
void * fn(void * arg){
	int i = (int)arg;
	printf(1, "in thread fn!\n");
	a++;
	printf(1, "thread%d : %d\n", i, a);
	thread_exit((void*)i);

	return 0;
	// exit();
}

int main(int argc, char *argv[]){
	thread_t t[THD_NUM];
	int i = 0;
	printf(1, "in main!\n");
	for(i = 0; i < THD_NUM; i++)
		thread_create(&t[i], fn, (void*)i);
	for(i = 0; i < THD_NUM; i++)
		thread_join(t[i], 0);
	
	printf(1, "a : %d\n", a);
	exit();
}