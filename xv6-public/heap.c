#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"

#define TOTAL_TICKET 6400

struct heap{
	uint size;
	uint normal_num;
	uint total_share;
	struct proc (*proc_list)[NPROCS + 1];
};

void init_heap(struct heap *h){
	h->size = 0;
	h->normal_num = 0;
	total_share = 0;
}

void swap(struct proc **a, struct proc **b){
	struct proc *temp = **a;
	**a = **b;
	**b = temp;
}

void heapify(struct heap *h, int is_pop){
	struct proc *p;
	int i, norm_ticket = 0;

	if (is_pop) {
		int idx = 1;
		while (idx * 2 <= h->size) {
			int child = idx * 2;
			if (idx * 2 + 1 <= h->size && h->proc_list[idx * 2]->pass > h->proc_list[idx * 2 + 1]->pass)
				child = idx * 2 + 1;
	
			if (h->proc_list[child]->pass > h->proc_list[idx]->pass)
				break;
	
			swap(&h->proc_list[child], &h->proc_list[idx]);
			idx = child;
		}
	}
	else {
		int idx = h->size;
		while (idx / 2 >= 1) {
			int parent = idx / 2;
			if (h->proc_list[parent]->pass > h->proc_list[idx]->pass)
				swap(&h->proc_list[parent], &h->proc_list[idx]);

			idx = parent;
			
		}
	}
	
}

int push_heap(struct heap *h, struct proc *p){
	if (h->size >= NPROCS){
		printf(1, "proc heap is full\n");
		return -1;
	}
	h->proc_list[++h->size] = p;
	++h->normal_num;
	heapify(h, 0);

	return 0;
}

struct proc* pop_heap(struct heap *h){
	if (h->size <= 0){
		printf(1, "proc heap is empty\n");
		return NULL;
	}
	struct proc *ret = h->proc_list[1];
	h->proc_list[1] = h->proc_list[h->size--];
	if(ret->kind == NORMAL)
		h->normal_num--;
	heapify(h, 1);

	return ret;
}
