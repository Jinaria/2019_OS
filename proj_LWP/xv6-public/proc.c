#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"


struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

struct MLFQ mlfq;

struct heap h;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

void wakeup1(void *chan);
int cnt = 0;

// heap function
void init_heap(struct heap *h){
  h->size = 0;
  h->normal_num = 0;
  h->total_share = 0;
  h->min_pass = 0;
  h->has_mlfq = 0;
  h->mlfq_num = 0;
}

void swap(struct proc **a, struct proc **b){
  struct proc *temp = *a;
  *a = *b;
  *b = temp;
}

void print_heap(struct heap *h){
  int i;
  for(i = 1; i <= h->size; i++){
    cprintf("%d : pid %d tid %d, ", i, h->proc_list[i]->pid, h->proc_list[i]->tid);
  }
  cprintf("\n");
}

void build_heap(struct heap *h){
  int idx;

  for(idx = h->size; idx > 1; idx--){
    if(h->proc_list[idx >> 1]->pass < h->proc_list[idx]->pass) continue;
    swap(&h->proc_list[idx >> 1], &h->proc_list[idx]);
    int t = idx;
    while(t + t <= h->size){
      if (t + t + 1 <= h->size && h->proc_list[t + t + 1]->pass < h->proc_list[t + t]->pass &&
       h->proc_list[t + t + 1]->pass < h->proc_list[t]->pass){
          swap(&h->proc_list[t], &h->proc_list[t + t + 1]);
          t = t + t + 1;
      }
      else if (h->proc_list[t + t]->pass < h->proc_list[t]->pass){
          swap(&h->proc_list[t], &h->proc_list[t + t]);
          t <<= 1;
      }
      else break;
    }
  }
  // cnt++;
  // if(h->size > 2 && cnt % 10000 == 0)
  //   print_heap(h);
}

int push_heap(struct heap *h, struct proc *p){
  if (h->size >= 64){
    cprintf("proc heap is full\n");
    return -1;
  }
  h->proc_list[++h->size] = p;
  build_heap(h);
  if(p->kind == NORMAL)
    ++h->normal_num;  

  if(h->proc_list[1]->state == SLEEPING)
    h->min_pass = 0;
  else
    h->min_pass = h->proc_list[1]->pass;
  
  return 0;
}

struct proc* pop_heap(struct heap *h){
  if (h->size <= 0){
    cprintf("proc heap is empty\n");
    return 0;
  }
  struct proc *ret = h->proc_list[1];
  h->proc_list[1] = h->proc_list[h->size];
  --h->size;
  if(ret->kind == NORMAL)
    h->normal_num--;
  build_heap(h);
  if(h->proc_list[1]->state == SLEEPING)
    h->min_pass = 0;
  else
    h->min_pass = h->proc_list[1]->pass;

  return ret;
}
// heap function

// mlfq function
void init_MLFQ(){
  mlfq.b_tick = 0;
  
  int i;
  for(i = 0; i < 3; i++){
    mlfq.start[i] = 0;
    mlfq.end[i] = -1;
    mlfq.size[i] = 0;
  }
  h.has_mlfq = 20;
  mlfq.mlfq_pass = h.min_pass;
  mlfq.proc_allot[0] = 1;
  mlfq.proc_allot[1] = 2;
  mlfq.proc_allot[2] = 4;
  mlfq.level_allot[0] = 5;
  mlfq.level_allot[1] = 10;
  mlfq.level_allot[2] = 100;
  mlfq.mlfq_ticket = TOTAL_TICKET / 5;
}

int push_MLFQ(struct proc *p){
  if(mlfq.size[p->level] >= 64){
    cprintf("queue %d is full\n", p->level);
    return -1;
  }
  mlfq.q[p->level][(++mlfq.end[p->level]) % 64] = p;
  mlfq.size[p->level]++;
  h.mlfq_num++;
  p->quantom = 0;
  p->pass = mlfq.mlfq_pass;

  return 0;
}

struct proc* pop_MLFQ(){
  int i;
  for(i = 0; i < 3; i++){
    if(mlfq.size[i] == 0)
      continue;
    mlfq.size[i]--;
    h.mlfq_num--;
    return mlfq.q[i][(mlfq.start[i]++) % 64];
  }
  cprintf("queue is empty\n");
  return 0;
}

void priority_boost(){
  struct proc *p;
  for(int i = 1; i < 3; i++){
      while(mlfq.size[i]){
        p = pop_MLFQ();
        p->level = 0;
        p->tick = 0;
        push_MLFQ(p);
      }
    }
}

int adjust_level(struct proc *p){
  if(mlfq.b_tick >= 100){
    priority_boost();
    return 1;
  }
  if(p->level < 2 && p->tick > mlfq.level_allot[p->level]){
    p->level++;
    p->tick = 0;
    return 0;
  }
  return -1;
}
// mlfq function


void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
struct proc*
allocproc(void)
{

  struct proc *p;
  char *sp;
  int i;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
    

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->pass = 2000000000;
  p->kind = NORMAL;
  p->tid = 0;
  for(i = 0; i < NPROC; i++){
    p->thread[i] = 0;
    p->used[i] = 0;
  }


  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  int norm_ticket;

  init_heap(&h);

  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->pass = h.min_pass;
  push_heap(&h, p);
  // cprintf("adsfejfkef\n");  
  norm_ticket = TOTAL_TICKET * (100 - h.total_share - h.has_mlfq) / 100;
  
  p->ticket = norm_ticket;
  p->state = RUNNABLE;
  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();
  struct proc *p;
  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->pid == curproc->pid)
      p->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid, norm_ticket;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  for(i = 0; i < NPROC; i++){
    np->thread[i] = curproc->thread[i];
  }
  np->sz = curproc->sz;
  if(curproc->tid > 0){
    np->parent = curproc->parent;
    np->parent_thread = curproc;
  }
  else np->parent = curproc;
  *np->tf = *curproc->tf;
  np->tid = 0;
  for(i = 1; i < NPROC; i++)
    np->used[i] = 0;
  np->used[0] = 1;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->pass = h.min_pass;
  push_heap(&h, np);
  norm_ticket = TOTAL_TICKET * (100 - h.total_share - h.has_mlfq) / 100;
  
  for(i = 1; i <= h.size; i++){
    if(h.proc_list[i]->kind == NORMAL)
      h.proc_list[i]->ticket = norm_ticket / h.normal_num;
    
    else if(h.proc_list[i]->kind == SHARE)
      h.proc_list[i]->ticket = TOTAL_TICKET * h.proc_list[i]->portion / 100;
  }
  
  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *mainthread;
  struct proc *p;
  int fd, i, norm_ticket;
  // cprintf("pid == %d, tid == %d\n", curproc->pid, curproc->tid);
  if(curproc == initproc)
    panic("init exiting");

  if(curproc->tid > 0) mainthread = curproc->parent;
  else mainthread = curproc;

  // Close all open files.

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == curproc->pid){
      for(fd = 0; fd < NOFILE; fd++){
        if(p->ofile[fd]){
          fileclose(p->ofile[fd]);
          p->ofile[fd] = 0;
        }
      }
      begin_op();
      iput(p->cwd);
      end_op();
      p->cwd = 0;
    }
  }

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  if(curproc->parent_thread != 0)
    wakeup1(curproc->parent_thread);
  else
    wakeup1(mainthread->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == curproc->pid){
      p->state = ZOMBIE;
      if(p->kind != MLFQ){
        p->pass = -1;
        build_heap(&h);
        for(i = 1; i <= h.size; i++){
          if(h.proc_list[i]->pid == p->pid)
            break;
        }
        swap(&h.proc_list[i], &h.proc_list[1]);
        pop_heap(&h);
        if(p->kind == SHARE)
          h.total_share -= p->portion;
        norm_ticket = TOTAL_TICKET * (100 - h.total_share - h.has_mlfq) / 100;
        for(i = 1; i <= h.size; i++){
          if(h.proc_list[i]->kind == NORMAL)
            h.proc_list[i]->ticket = norm_ticket / h.normal_num;
          
          else if(h.proc_list[i]->kind == SHARE)
            h.proc_list[i]->ticket = TOTAL_TICKET * h.proc_list[i]->portion / 100;
        
        }
      }
      else{
        p->pass = -1;
        build_heap(&h);
        for(i = 1; i <= h.size; i++)
          if(h.proc_list[i]->pid == p->pid)
            break;
        
        if(h.mlfq_num == 0)
          h.has_mlfq = 0;
        swap(&h.proc_list[i], &h.proc_list[1]);
        pop_heap(&h);
      }
    }
  }
  // cprintf("pid %d tid %d upsched\n", curproc->pid, curproc->tid);
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p, *t;
  int havekids, pid;
  struct proc *curproc = myproc();
  int i;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc && p->parent_thread != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        p->tick = 0;
        p->pass = 0;
        p->ticket = 0;
        p->portion = 0;
        p->quantom = 0;
        p->tick = 0;
        p->level = 0;
        p->kind = NORMAL;
        for(t = ptable.proc; t < &ptable.proc[NPROC]; t++){
          if(t->pid == pid && t->state == ZOMBIE){
            kfree(t->kstack);
            t->kstack = 0;
            t->pid = 0;
            t->parent = 0;
            t->name[0] = 0;
            t->killed = 0;
            t->state = UNUSED;
            t->tick = 0;
            t->pass = 0;
            t->ticket = 0;
            t->portion = 0;
            t->quantom = 0;
            t->tick = 0;
            t->level = 0;
            t->kind = NORMAL;
            t->parent_thread = 0;
            t->tid = 0;
            for(i = 0; i < NPROC; i++)
              p->thread[i] = p->used[i] = 0;
          }
        }
        p->parent_thread = 0;
        for(i = 0; i < NPROC; i++)
          p->thread[i] = p->used[i] = 0;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct proc *mlfq_p;
  struct cpu *c = mycpu();
  
  c->proc = 0;
  int i;
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    
   	acquire(&ptable.lock);
    // for(i = 1; i <= h.size; i++){
    //   cprintf("(%d)%d ", h.proc_list[i]->pid, h.proc_list[i]->pass);
    // }
    // cprintf("\n");
    p = pop_heap(&h);
    // cprintf("pid %d ", p->pid);
    
    if (p->state != RUNNABLE){
      push_heap(&h, p);
      release(&ptable.lock);
      continue;
    }
    if (p->kind == MLFQ){
      push_heap(&h, p);
      mlfq_p = pop_MLFQ();
      
      if(p->state != RUNNABLE){
        push_heap(&h, p);
        push_MLFQ(mlfq_p);
        release(&ptable.lock);
        continue;
      }

      SWITCH:
      // for(i = 1; i <= h.size; i++)
      //   cprintf("(%d)%d,%d ", h.proc_list[i]->pid, h.proc_list[i]->pass, h.proc_list[i]->kind);
      // cprintf("\n\n");
      c->proc = mlfq_p;
      switchuvm(mlfq_p);
      mlfq_p->state = RUNNING;

      swtch(&(c->scheduler), mlfq_p->context);
      switchkvm();
      
      c->proc = 0;
      mlfq.b_tick += mlfq_p->quantom;
      if(mlfq_p->state != RUNNABLE){
        release(&ptable.lock);
        continue;
      }
      if(mlfq_p->kind == MLFQ){
        if(mlfq_p->tick > mlfq.level_allot[mlfq_p->level])
          adjust_level(p);

        if(mlfq_p->quantom <= mlfq.proc_allot[mlfq_p->level])
          goto SWITCH;
        else{
          mlfq.mlfq_pass += TOTAL_TICKET / mlfq.mlfq_ticket * mlfq_p->quantom;
          for(i = 1; i <= h.size; i++)
            if(h.proc_list[i]->kind == MLFQ)
              h.proc_list[i]->pass = mlfq.mlfq_pass;
          push_MLFQ(mlfq_p);
        }
        
      }

    }
    else {
      p->pass += TOTAL_TICKET / p->ticket;
      push_heap(&h, p);
      // for(i = 1; i <= h.size; i++)
      //   cprintf("(%d)%d,%d ", h.proc_list[i]->pid, h.proc_list[i]->pass, h.proc_list[i]->kind);
      // cprintf("\n\n");

      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      c->proc = 0;  
    }

    release(&ptable.lock);

  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();
  

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  // cprintf("pid %d, tid %d\n", p->pid, p->tid);
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{

  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  int i;
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  p->pass = 2000000000;
  for(i = 1; i <= h.size; i++)
    if(h.proc_list[i]->pid == p->pid && h.proc_list[i]->tid == p->tid)
      break;
  while(i * 2 <= h.size){
    int child = i * 2;
    if(child + 1 <= h.size && h.proc_list[child]->pass > h.proc_list[child + 1]->pass)
      child += 1;
    if(h.proc_list[child]->pass > h.proc_list[i]->pass)
      break;
    swap(&h.proc_list[child], &h.proc_list[i]);
    i = child;
  }

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
void
wakeup1(void *chan)
{
  struct proc *p;
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan){
      if(p->kind == MLFQ)
        p->pass = mlfq.mlfq_pass;
      else
        p->pass = h.min_pass;
      
      p->state = RUNNABLE;
    }

}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;
  int flag = 0;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      if(flag == 0) flag = 1;
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
    }
  }
  release(&ptable.lock);
  if(flag) return 0;
  else return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED/* || p->state == SLEEPING*/)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";

    cprintf("%d %d %s %s %d", p->pid, p->tid, state, p->name, p->pass);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
  print_heap(&h);
}
