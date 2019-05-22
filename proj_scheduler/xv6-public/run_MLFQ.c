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
extern struct MLFQ mlfq;

int
getlev(void){
	return myproc()->level;
}

int
run_MLFQ(void)
{
	if(!h.has_mlfq)
		init_MLFQ();
	struct proc *p = myproc();
	if(p->kind == NORMAL)
		h.normal_num--;
	if(p->kind == SHARE){
		h.total_share -= p->portion;
		p->portion = 0;
	}
	int i, norm_ticket;
	p->pass = mlfq.mlfq_pass;
	p->kind = MLFQ;
	p->level = 0;
	p->quantom = 0;
	p->ticket = TOTAL_TICKET / 5;
	push_MLFQ(p);
	norm_ticket = TOTAL_TICKET * (100 - h.total_share - h.has_mlfq) / 100;
	for(i = 1; i <= h.size; i++){
		if(h.proc_list[i]->kind == NORMAL)
		  h.proc_list[i]->ticket = norm_ticket / h.normal_num;
		
		else if(h.proc_list[i]->kind == SHARE)
		  h.proc_list[i]->ticket = TOTAL_TICKET * h.proc_list[i]->portion / 100;
	}

	return 0;
}

// Wrapper for my_syscall
int
sys_getlev(void){
	return getlev();
}

int
sys_run_MLFQ(void)
{
	if(run_MLFQ() < 0)
		return -1;
	return 0;
}