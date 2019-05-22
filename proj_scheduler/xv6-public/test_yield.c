#include "types.h"
#include "stat.h"
#include "user.h"

int main(void){
	int pid = fork();
	if(pid == 0){
		int i;
		for(i = 0; i < 10; i++){
			printf(1, "child\n");
			yield();
		}
	}
	else if(pid > 0){
		int i;
		for(i = 0; i < 9; i++){
			printf(1, "parent\n");
			yield();
		}
	}
	wait();
	exit();
}