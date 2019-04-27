#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

// Simple system call

#define TOTAL_TICKET 6400

extern struct heap h;

int
cpu_share(int portion)
{
	struct proc *p = myproc();
	// acquire(&ptable.lock);
	int i, norm_ticket;
	if(h.total_share + portion > 20){
		// release(&ptable.lock);
		return -1;
	}
	p->kind = SHARE;
	p->portion = portion;
	norm_ticket = TOTAL_TICKET * (100 - h.total_share) / 100;

	for(i = 1; i <= h.size; i++){

		if(h.proc_list[i]->kind == NORMAL)
		  h.proc_list[i]->ticket = norm_ticket / h.normal_num;
		else
		  h.proc_list[i]->ticket = TOTAL_TICKET * h.proc_list[i]->portion / 100;
	}
	h.normal_num--;
	// release(&ptable.lock);

	return 0;
}

// Wrapper for my_syscall
int
sys_cpu_share(void)
{
	int n;
	if(argint(0, &n) < 0)
		return -1;
	if(cpu_share(n) < 0){
		cprintf("cpu_share failed\n");
		return -1;
	}
	return 0;
}