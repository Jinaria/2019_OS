#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

#define TOTAL_TICKET 6400

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

// struct {

// } mlfq;
struct heap h;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);


// heap function
void init_heap(struct heap *h){
  h->size = 0;
  h->normal_num = 0;
  h->total_share = 0;
  h->min_pass = 0;
}

void swap(struct proc **a, struct proc **b){
  struct proc *temp = *a;
  *a = *b;
  *b = temp;
}

int push_heap(struct heap *h, struct proc *p){
  if (h->size >= 64){
    cprintf("proc heap is full\n");
    return -1;
  }
  h->proc_list[++h->size] = p;
  ++h->normal_num;  
  int idx = h->size;
  while (idx / 2 >= 1) {
    int parent = idx / 2;

    if (h->proc_list[parent]->pass < h->proc_list[idx]->pass)
      break;

    swap(&h->proc_list[parent], &h->proc_list[idx]);
    idx = parent;
  }

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
  int idx = 1;
  // int mid = h->size / 2 + 1;
  // for(idx = 1; idx <= mid; idx++){
    while (idx * 2 <= h->size) {
      int child = idx * 2;

      if (child + 1 <= h->size && h->proc_list[child]->pass > h->proc_list[child + 1]->pass)
        child += 1;
      if (h->proc_list[child]->pass > h->proc_list[idx]->pass)
        break;
      swap(&h->proc_list[child], &h->proc_list[idx]);

      idx = child;
    }
  // }
  if(h->proc_list[1]->state == SLEEPING)
    h->min_pass = 0;
  else
    h->min_pass = h->proc_list[1]->pass;

  return ret;
}
// heap function


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
static struct proc*
allocproc(void)
{

  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
    

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->tick = 0;
  p->pass = 2000000000;
  p->kind = NORMAL;
  
  // cprintf("push heap h address %d\n", &h);
  
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
  int norm_ticket, i;

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
  norm_ticket = TOTAL_TICKET * (100 - h.total_share) / 100;
  
  for(i = 1; i <= h.size; i++){

    if(h.proc_list[i]->kind == NORMAL)
      h.proc_list[i]->ticket = norm_ticket / h.normal_num;
    else
      h.proc_list[i]->ticket = TOTAL_TICKET * h.proc_list[i]->portion / 100;
  }
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

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
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

  // if(curproc->kind == SHARE){

  // }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

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
  norm_ticket = TOTAL_TICKET * (100 - h.total_share) / 100;
  
  for(i = 1; i <= h.size; i++){

    if(h.proc_list[i]->kind == NORMAL)
      h.proc_list[i]->ticket = norm_ticket / h.normal_num;
    else
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
  struct proc *p;
  int fd, i;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
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

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  curproc->pass = -1;
  for(i = 1; i <= h.size; i++){
    if(h.proc_list[i]->pid == curproc->pid)
      break;
  }
  swap(&h.proc_list[i], &h.proc_list[1]);
  pop_heap(&h);

  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // cprintf("wait!!!!\n");
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
        p->temp_pass = 0;
        p->portion = 0;
        p->kind = NORMAL;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // cprintf("into the sleep\n");
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
  struct cpu *c = mycpu();
  
  c->proc = 0;
  int count = 0;
  // int i;

  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    // acquire(&ptable.lock);
    // for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    //   if(p->state != RUNNABLE)
    //     continue;

    //   // Switch to chosen process.  It is the process's job
    //   // to release ptable.lock and then reacquire it
    //   // before jumping back to us.
    //   c->proc = p;
    //   switchuvm(p);
    //   p->state = RUNNING;

    //   swtch(&(c->scheduler), p->context);
    //   switchkvm();

    //   // Process is done running for now.
    //   // It should have changed its p->state before coming back.
    //   c->proc = 0;
    // }
    // int checked = 0;
    
   	acquire(&ptable.lock);
    // cprintf("h size : %d\n", h.size);
    // cprintf("h address : %d\n", &h);
    // while(checked < h.size){
      if(count % 300000 == 0){
        // for(i = 1; i <= h.size; i++){
        //   cprintf("pid %d pass %d, ",h.proc_list[i]->pid, h.proc_list[i]->pass);
        // }
        // cprintf("\n");
        // procdump();

      }
      count++;
      // checked++;
      p = pop_heap(&h);
      // cprintf("pid %d\n", p->pid);
      // for(i = 1; i <= h.size; i++){
      //   cprintf("(%d) %d ", h.proc_list[i]->pid, h.proc_list[i]->pass);
      // }
      // cprintf("\nppid %d state %d size %d\n", p->pid, p->state, h.size);

      if (p->state != RUNNABLE){
        push_heap(&h, p);
        release(&ptable.lock);  
        continue;
      }
      // cprintf("(%d) pass %d, ticket %d\n", p->pid, p->pass, p->ticket);
			p->pass += TOTAL_TICKET / p->ticket;
      push_heap(&h, p);
      // for(i = 1; i <= h.size; i++){
      //   cprintf("(%d) %d ", h.proc_list[i]->pid, h.proc_list[i]->pass);
      // }
      // cprintf("\nppid %d state %d size %d\n", p->pid, p->state, h.size);
      // cprintf("h size %d\n", h.size);
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      c->proc = 0;

    // }
    

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

  p->temp_pass = p->pass;

  p->pass = 2000000000;
  for(i = 1; i <= h.size; i++)
    if(h.proc_list[i]->pid == p->pid)
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
static void
wakeup1(void *chan)
{
  struct proc *p;
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan){
      p->pass = h.min_pass;
      p->temp_pass = 0;
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

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
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
    cprintf("%d %s %s %d", p->pid, state, p->name, p->pass);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
