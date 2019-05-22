/**
 * This program runs various workloads cuncurrently.
 */


#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
	int i = 0;
	for(;;){
		i++;
		if(i == 1000000000){
			i = 0;
			yield();

		}
	}
	printf(1, "end!\n");
	exit();
}