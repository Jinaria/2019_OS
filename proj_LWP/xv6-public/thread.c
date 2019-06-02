#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

extern struct{
	struct spinlock lock;
	struct proc proc[NPROC];
} ptable;

extern struct heap h;
extern int push_heap(struct heap *h, struct proc *p);
extern void swap(struct proc **a, struct proc **b);
extern struct proc * pop_heap(struct heap *h);
extern struct proc * allocproc(void);
extern void wakeup1(void *chan);	
extern void print_heap(struct heap *h);

int
thread_create(thread_t *thread, void *(*start_routine)(void*), void *arg)
{
	// cprintf("thread_create\n");
	// int k;
	int i, norm_ticket;
	struct proc *tp;
	struct proc *curproc = myproc();
	uint sp = 0, ustack[3];

	if((tp = allocproc()) == 0){
		cprintf("allocproc error\n");
		return -1;
	}

	acquire(&ptable.lock);
	for(i = 1; i < NPROC; i++){
		if(curproc->used[i] == 0){
			curproc->used[i] = 1;
			sp = curproc->thread[i];
			memset((void*)(sp - PGSIZE), 0, PGSIZE);
			break;
		}
	}
	release(&ptable.lock);
	// for(k = 0; k < NPROC; k++)
	// 	cprintf("thread %d : %d\n", k, curproc->thread[k]);
	// cprintf("in thd create sp %d i %d \n", sp, i);

	if(i == NPROC){
		tp->state = UNUSED;
		cprintf("NPROC error\n");
		return -1;
	}

	ustack[0] = 0xffffffff;
	ustack[1] = (uint)arg;
	ustack[2] = 0;
	sp = sp - sizeof(ustack);
	// for(k = 0; k < NPROC; k++){
	// 	cprintf("thread%d sp %d\n", k, curproc->thread[k]);
	// }
	if(copyout(curproc->pgdir, sp, ustack, sizeof(ustack)) < 0){
		curproc->used[i] = 0;
		tp->state = UNUSED;
		cprintf("copyout error %d\n", (int)arg);
		cprintf("sp %d\n", curproc->thread[i]);
		return -1;
	}
	tp->tid = i;

	tp->pgdir = curproc->pgdir;
	tp->sz = curproc->sz;
	*tp->tf = *curproc->tf;
	tp->tf->esp = sp;

	for(i = 0; i < NOFILE; i++){
		if(curproc->ofile[i])
			tp->ofile[i] = filedup(curproc->ofile[i]);
	}
	tp->cwd = idup(curproc->cwd);

	safestrcpy(tp->name, curproc->name, sizeof(curproc->name));

	tp->pid = curproc->pid;
	*thread = tp->tid;
	tp->parent = curproc;
	tp->tf->eip = (uint)start_routine;
	// tp->chan = 
	acquire(&ptable.lock);

	tp->pass = h.min_pass;
	push_heap(&h, tp);
	norm_ticket = TOTAL_TICKET * (100 - h.total_share - h.has_mlfq) / 100;

	for(i = 1; i <= h.size; i++){
	if(h.proc_list[i]->kind == NORMAL)
	  h.proc_list[i]->ticket = norm_ticket / h.normal_num;

	else if(h.proc_list[i]->kind == SHARE)
	  h.proc_list[i]->ticket = TOTAL_TICKET * h.proc_list[i]->portion / 100;
	}

	tp->state = RUNNABLE;
	
	release(&ptable.lock);


	return 0;
}

void
thread_exit(void *retval)
{
	// cprintf("thread_exit\n");
	struct proc *curproc = myproc();
	// struct proc *p;
	int fd, i, norm_ticket;
	// struct proc *p;
	// int trash;

	if(curproc->tid == 0){
		// for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
		// 	if(p->pid == curproc->pid && p->tid != 0)
		// 		thread_exit((void*)trash);
		exit();
	}
	curproc->used[0] = (int)retval;

	for(fd = 0; fd < NOFILE; fd++){
		if(curproc->ofile[fd]){
		  fileclose(curproc->ofile[fd]);
		  curproc->ofile[fd] = 0;
		}
	}
	begin_op();
	iput(curproc->cwd);
	end_op();
	curproc->cwd = 0;

	acquire(&ptable.lock);

  // Parent might be sleeping in wait().
	wakeup1(curproc->parent);

	// // Pass abandoned children to init.
	// for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
	// 	if(p->parent == curproc){
	// 		p->parent = initproc;
	// 		if(p->state == ZOMBIE)
	//   			wakeup1(initproc);
	// 	}
	// }

	// Jump into the scheduler, never to return.
		
	curproc->state = ZOMBIE;
	if(curproc->kind != MLFQ){
		curproc->pass = -1;
		build_heap(&h);
		for(i = 1; i <= h.size; i++)
			if(h.proc_list[i]->pid == curproc->pid)
				break;
		
		swap(&h.proc_list[i], &h.proc_list[1]);
		pop_heap(&h);
		if(curproc->kind == SHARE)
			h.total_share -= curproc->portion;
		norm_ticket = TOTAL_TICKET * (100 - h.total_share - h.has_mlfq) / 100;
		for(i = 1; i <= h.size; i++){
			if(h.proc_list[i]->kind == NORMAL)
		  		h.proc_list[i]->ticket = norm_ticket / h.normal_num;
		  
			else if(h.proc_list[i]->kind == SHARE)
		    	h.proc_list[i]->ticket = TOTAL_TICKET * h.proc_list[i]->portion / 100;

		}
	}
	else{
		curproc->pass = -1;
		build_heap(&h);
		for(i = 1; i <= h.size; i++)
			if(h.proc_list[i]->pid == curproc->pid)
				break;

		if(h.mlfq_num == 0)
			h.has_mlfq = 0;
		swap(&h.proc_list[i], &h.proc_list[1]);
		pop_heap(&h);
	}
		
	
	sched();
	panic("zombie exit");

}

int
thread_join(thread_t thread, void **retval)
{
	// cprintf("thread_join\n");
	int i;
	struct proc *curproc = myproc();
	struct proc *p;

	acquire(&ptable.lock);

	for(;;){
		// if(curproc->used[thread] == 0){
		// 	*retval = 0;
		// 	release(&ptable.lock);
		// 	return 0;
		// }
		for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
			if(p->pid == curproc->pid && p->tid == thread)
				break;
		if(p == &ptable.proc[NPROC]){
			release(&ptable.lock);
			return -1;
		}

		if(p->state == ZOMBIE){
			if(retval != 0)
				*retval = (void*)p->used[0];
	        kfree(p->kstack);
	        p->kstack = 0;
	        p->pid = 0;
	        p->parent = 0;
	        p->name[0] = 0;
	        p->killed = 0;
	        p->state = UNUSED;
	        p->tick = 0;
	        p->pass = 0;
	        p->ticket = 0;
	        p->portion = 0;
	        p->kind = NORMAL;
	        
	        curproc->used[p->tid] = 0;
	        p->tid = 0;
	        for(i = 0; i < NPROC; i++){
	        	p->thread[i] = p->used[i] = 0;
	        }

	        release(&ptable.lock);

	        return 0;
		}

		if(p->killed || curproc->killed){
			release(&ptable.lock);
			return -1;
		}

		sleep(curproc, &ptable.lock);
	}	
}

int
sys_thread_create(void)
{
	int thread, fn, arg;
	if(argint(0, &thread) < 0)
		return -1;
	if(argint(1, &fn) < 0)
		return -1;
	if(argint(2, &arg) < 0)
		return -1;
	return thread_create((thread_t*)thread, (void*)fn, (void*)arg);
}

int
sys_thread_exit(void)
{
	int retval;
	if(argint(0, &retval) < 0)
		return -1;
	thread_exit((void*)retval);
	return 0;
}

int
sys_thread_join(void)
{
	int thread, retval;
	if(argint(0, &thread) < 0)
		return -1;
	if(argint(1, &retval) < 0)
		return -1;
	return thread_join((thread_t)thread, (void**)retval);
}