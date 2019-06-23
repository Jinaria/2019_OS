
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 20 32 10 80       	mov    $0x80103220,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 72 10 80       	push   $0x801072a0
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 25 45 00 00       	call   80104580 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 72 10 80       	push   $0x801072a7
80100097:	50                   	push   %eax
80100098:	e8 b3 43 00 00       	call   80104450 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 f7 45 00 00       	call   801046e0 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 29 46 00 00       	call   80104790 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 43 00 00       	call   80104490 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 2d 23 00 00       	call   801024b0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ae 72 10 80       	push   $0x801072ae
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 7d 43 00 00       	call   80104530 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 e7 22 00 00       	jmp    801024b0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 72 10 80       	push   $0x801072bf
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 3c 43 00 00       	call   80104530 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 ec 42 00 00       	call   801044f0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 d0 44 00 00       	call   801046e0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 2f 45 00 00       	jmp    80104790 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 72 10 80       	push   $0x801072c6
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 9b 16 00 00       	call   80101920 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 4f 44 00 00       	call   801046e0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002a6:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 a0 ff 10 80       	push   $0x8010ffa0
801002bd:	e8 2e 3e 00 00       	call   801040f0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 69 38 00 00       	call   80103b40 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 a5 10 80       	push   $0x8010a520
801002e6:	e8 a5 44 00 00       	call   80104790 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 4d 15 00 00       	call   80101840 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 45 44 00 00       	call   80104790 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 ed 14 00 00       	call   80101840 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 22 27 00 00       	call   80102ab0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 cd 72 10 80       	push   $0x801072cd
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 17 7c 10 80 	movl   $0x80107c17,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 e3 41 00 00       	call   801045a0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 e1 72 10 80       	push   $0x801072e1
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 31 5a 00 00       	call   80105e50 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 78 59 00 00       	call   80105e50 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 6c 59 00 00       	call   80105e50 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 60 59 00 00       	call   80105e50 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 77 43 00 00       	call   80104890 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 b2 42 00 00       	call   801047e0 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 e5 72 10 80       	push   $0x801072e5
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 10 73 10 80 	movzbl -0x7fef8cf0(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 0c 13 00 00       	call   80101920 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 c0 40 00 00       	call   801046e0 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 44 41 00 00       	call   80104790 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 eb 11 00 00       	call   80101840 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 a5 10 80       	push   $0x8010a520
8010070d:	e8 7e 40 00 00       	call   80104790 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 f8 72 10 80       	mov    $0x801072f8,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 a5 10 80       	push   $0x8010a520
801007c8:	e8 13 3f 00 00       	call   801046e0 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 ff 72 10 80       	push   $0x801072ff
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 20 a5 10 80       	push   $0x8010a520
80100803:	e8 d8 3e 00 00       	call   801046e0 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100836:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 a5 10 80       	push   $0x8010a520
80100868:	e8 23 3f 00 00       	call   80104790 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801008f1:	68 a0 ff 10 80       	push   $0x8010ffa0
801008f6:	e8 a5 39 00 00       	call   801042a0 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010090d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100934:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 14 3a 00 00       	jmp    80104390 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 08 73 10 80       	push   $0x80107308
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 cb 3b 00 00       	call   80104580 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009b5:	58                   	pop    %eax
801009b6:	5a                   	pop    %edx
801009b7:	6a 00                	push   $0x0
801009b9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bb:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009c2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009cc:	02 10 80 
  cons.locking = 1;
801009cf:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009d6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009d9:	e8 82 1c 00 00       	call   80102660 <ioapicenable>
}
801009de:	83 c4 10             	add    $0x10,%esp
801009e1:	c9                   	leave  
801009e2:	c3                   	ret    
801009e3:	66 90                	xchg   %ax,%ax
801009e5:	66 90                	xchg   %ax,%ax
801009e7:	66 90                	xchg   %ax,%ax
801009e9:	66 90                	xchg   %ax,%ax
801009eb:	66 90                	xchg   %ax,%ax
801009ed:	66 90                	xchg   %ax,%ax
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009fc:	e8 3f 31 00 00       	call   80103b40 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a07:	e8 04 25 00 00       	call   80102f10 <begin_op>

  if((ip = namei(path)) == 0){
80100a0c:	83 ec 0c             	sub    $0xc,%esp
80100a0f:	ff 75 08             	pushl  0x8(%ebp)
80100a12:	e8 69 18 00 00       	call   80102280 <namei>
80100a17:	83 c4 10             	add    $0x10,%esp
80100a1a:	85 c0                	test   %eax,%eax
80100a1c:	0f 84 9c 01 00 00    	je     80100bbe <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a22:	83 ec 0c             	sub    $0xc,%esp
80100a25:	89 c3                	mov    %eax,%ebx
80100a27:	50                   	push   %eax
80100a28:	e8 13 0e 00 00       	call   80101840 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a33:	6a 34                	push   $0x34
80100a35:	6a 00                	push   $0x0
80100a37:	50                   	push   %eax
80100a38:	53                   	push   %ebx
80100a39:	e8 d2 12 00 00       	call   80101d10 <readi>
80100a3e:	83 c4 20             	add    $0x20,%esp
80100a41:	83 f8 34             	cmp    $0x34,%eax
80100a44:	74 22                	je     80100a68 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	53                   	push   %ebx
80100a4a:	e8 71 12 00 00       	call   80101cc0 <iunlockput>
    end_op();
80100a4f:	e8 2c 25 00 00       	call   80102f80 <end_op>
80100a54:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5f:	5b                   	pop    %ebx
80100a60:	5e                   	pop    %esi
80100a61:	5f                   	pop    %edi
80100a62:	5d                   	pop    %ebp
80100a63:	c3                   	ret    
80100a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a68:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a6f:	45 4c 46 
80100a72:	75 d2                	jne    80100a46 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a74:	e8 67 65 00 00       	call   80106fe0 <setupkvm>
80100a79:	85 c0                	test   %eax,%eax
80100a7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a81:	74 c3                	je     80100a46 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a83:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a8a:	00 
80100a8b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a91:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a98:	00 00 00 
80100a9b:	0f 84 c5 00 00 00    	je     80100b66 <exec+0x176>
80100aa1:	31 ff                	xor    %edi,%edi
80100aa3:	eb 18                	jmp    80100abd <exec+0xcd>
80100aa5:	8d 76 00             	lea    0x0(%esi),%esi
80100aa8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aaf:	83 c7 01             	add    $0x1,%edi
80100ab2:	83 c6 20             	add    $0x20,%esi
80100ab5:	39 f8                	cmp    %edi,%eax
80100ab7:	0f 8e a9 00 00 00    	jle    80100b66 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100abd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ac3:	6a 20                	push   $0x20
80100ac5:	56                   	push   %esi
80100ac6:	50                   	push   %eax
80100ac7:	53                   	push   %ebx
80100ac8:	e8 43 12 00 00       	call   80101d10 <readi>
80100acd:	83 c4 10             	add    $0x10,%esp
80100ad0:	83 f8 20             	cmp    $0x20,%eax
80100ad3:	75 7b                	jne    80100b50 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ad5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100adc:	75 ca                	jne    80100aa8 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100ade:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ae4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aea:	72 64                	jb     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100aec:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af2:	72 5c                	jb     80100b50 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100af4:	83 ec 04             	sub    $0x4,%esp
80100af7:	50                   	push   %eax
80100af8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100afe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b04:	e8 27 63 00 00       	call   80106e30 <allocuvm>
80100b09:	83 c4 10             	add    $0x10,%esp
80100b0c:	85 c0                	test   %eax,%eax
80100b0e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b14:	74 3a                	je     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b16:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b1c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b21:	75 2d                	jne    80100b50 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b23:	83 ec 0c             	sub    $0xc,%esp
80100b26:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b2c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b32:	53                   	push   %ebx
80100b33:	50                   	push   %eax
80100b34:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b3a:	e8 31 62 00 00       	call   80106d70 <loaduvm>
80100b3f:	83 c4 20             	add    $0x20,%esp
80100b42:	85 c0                	test   %eax,%eax
80100b44:	0f 89 5e ff ff ff    	jns    80100aa8 <exec+0xb8>
80100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b50:	83 ec 0c             	sub    $0xc,%esp
80100b53:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b59:	e8 02 64 00 00       	call   80106f60 <freevm>
80100b5e:	83 c4 10             	add    $0x10,%esp
80100b61:	e9 e0 fe ff ff       	jmp    80100a46 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b66:	83 ec 0c             	sub    $0xc,%esp
80100b69:	53                   	push   %ebx
80100b6a:	e8 51 11 00 00       	call   80101cc0 <iunlockput>
  end_op();
80100b6f:	e8 0c 24 00 00       	call   80102f80 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b74:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b7a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b7d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b87:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b8d:	52                   	push   %edx
80100b8e:	50                   	push   %eax
80100b8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b95:	e8 96 62 00 00       	call   80106e30 <allocuvm>
80100b9a:	83 c4 10             	add    $0x10,%esp
80100b9d:	85 c0                	test   %eax,%eax
80100b9f:	89 c6                	mov    %eax,%esi
80100ba1:	75 3a                	jne    80100bdd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ba3:	83 ec 0c             	sub    $0xc,%esp
80100ba6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bac:	e8 af 63 00 00       	call   80106f60 <freevm>
80100bb1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb9:	e9 9e fe ff ff       	jmp    80100a5c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bbe:	e8 bd 23 00 00       	call   80102f80 <end_op>
    cprintf("exec: fail\n");
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 21 73 10 80       	push   $0x80107321
80100bcb:	e8 90 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd8:	e9 7f fe ff ff       	jmp    80100a5c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bdd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100be3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	31 ff                	xor    %edi,%edi
80100be8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bea:	50                   	push   %eax
80100beb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bf1:	e8 8a 64 00 00       	call   80107080 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bf9:	83 c4 10             	add    $0x10,%esp
80100bfc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c02:	8b 00                	mov    (%eax),%eax
80100c04:	85 c0                	test   %eax,%eax
80100c06:	74 79                	je     80100c81 <exec+0x291>
80100c08:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c0e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c14:	eb 13                	jmp    80100c29 <exec+0x239>
80100c16:	8d 76 00             	lea    0x0(%esi),%esi
80100c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c20:	83 ff 20             	cmp    $0x20,%edi
80100c23:	0f 84 7a ff ff ff    	je     80100ba3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	50                   	push   %eax
80100c2d:	e8 ee 3d 00 00       	call   80104a20 <strlen>
80100c32:	f7 d0                	not    %eax
80100c34:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c39:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c3a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c40:	e8 db 3d 00 00       	call   80104a20 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 9a 65 00 00       	call   801071f0 <copyout>
80100c56:	83 c4 20             	add    $0x20,%esp
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	0f 88 42 ff ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c61:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c64:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c6b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c74:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c77:	85 c0                	test   %eax,%eax
80100c79:	75 a5                	jne    80100c20 <exec+0x230>
80100c7b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c88:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c8a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c91:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c95:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c9c:	ff ff ff 
  ustack[1] = argc;
80100c9f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca5:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100ca7:	83 c0 0c             	add    $0xc,%eax
80100caa:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cac:	50                   	push   %eax
80100cad:	52                   	push   %edx
80100cae:	53                   	push   %ebx
80100caf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbb:	e8 30 65 00 00       	call   801071f0 <copyout>
80100cc0:	83 c4 10             	add    $0x10,%esp
80100cc3:	85 c0                	test   %eax,%eax
80100cc5:	0f 88 d8 fe ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cce:	0f b6 10             	movzbl (%eax),%edx
80100cd1:	84 d2                	test   %dl,%dl
80100cd3:	74 19                	je     80100cee <exec+0x2fe>
80100cd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cd8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100cdb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cde:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ce1:	0f 44 c8             	cmove  %eax,%ecx
80100ce4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ce7:	84 d2                	test   %dl,%dl
80100ce9:	75 f0                	jne    80100cdb <exec+0x2eb>
80100ceb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cee:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cf4:	50                   	push   %eax
80100cf5:	6a 10                	push   $0x10
80100cf7:	ff 75 08             	pushl  0x8(%ebp)
80100cfa:	89 f8                	mov    %edi,%eax
80100cfc:	83 c0 6c             	add    $0x6c,%eax
80100cff:	50                   	push   %eax
80100d00:	e8 db 3c 00 00       	call   801049e0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d05:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d0b:	89 f8                	mov    %edi,%eax
80100d0d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d10:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d12:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d15:	89 c1                	mov    %eax,%ecx
80100d17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1d:	8b 40 18             	mov    0x18(%eax),%eax
80100d20:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d23:	8b 41 18             	mov    0x18(%ecx),%eax
80100d26:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d29:	89 0c 24             	mov    %ecx,(%esp)
80100d2c:	e8 af 5e 00 00       	call   80106be0 <switchuvm>
  freevm(oldpgdir);
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 27 62 00 00       	call   80106f60 <freevm>
  return 0;
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	31 c0                	xor    %eax,%eax
80100d3e:	e9 19 fd ff ff       	jmp    80100a5c <exec+0x6c>
80100d43:	66 90                	xchg   %ax,%ax
80100d45:	66 90                	xchg   %ax,%ax
80100d47:	66 90                	xchg   %ax,%ax
80100d49:	66 90                	xchg   %ax,%ax
80100d4b:	66 90                	xchg   %ax,%ax
80100d4d:	66 90                	xchg   %ax,%ax
80100d4f:	90                   	nop

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d56:	68 2d 73 10 80       	push   $0x8010732d
80100d5b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d60:	e8 1b 38 00 00       	call   80104580 <initlock>
}
80100d65:	83 c4 10             	add    $0x10,%esp
80100d68:	c9                   	leave  
80100d69:	c3                   	ret    
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d79:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d7c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d81:	e8 5a 39 00 00       	call   801046e0 <acquire>
80100d86:	83 c4 10             	add    $0x10,%esp
80100d89:	eb 10                	jmp    80100d9b <filealloc+0x2b>
80100d8b:	90                   	nop
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d99:	74 25                	je     80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100da2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100da5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dac:	68 c0 ff 10 80       	push   $0x8010ffc0
80100db1:	e8 da 39 00 00       	call   80104790 <release>
      return f;
80100db6:	89 d8                	mov    %ebx,%eax
80100db8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dbe:	c9                   	leave  
80100dbf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100dc0:	83 ec 0c             	sub    $0xc,%esp
80100dc3:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc8:	e8 c3 39 00 00       	call   80104790 <release>
  return 0;
80100dcd:	83 c4 10             	add    $0x10,%esp
80100dd0:	31 c0                	xor    %eax,%eax
}
80100dd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dd5:	c9                   	leave  
80100dd6:	c3                   	ret    
80100dd7:	89 f6                	mov    %esi,%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 10             	sub    $0x10,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	68 c0 ff 10 80       	push   $0x8010ffc0
80100def:	e8 ec 38 00 00       	call   801046e0 <acquire>
  if(f->ref < 1)
80100df4:	8b 43 04             	mov    0x4(%ebx),%eax
80100df7:	83 c4 10             	add    $0x10,%esp
80100dfa:	85 c0                	test   %eax,%eax
80100dfc:	7e 1a                	jle    80100e18 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dfe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e01:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100e04:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e07:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e0c:	e8 7f 39 00 00       	call   80104790 <release>
  return f;
}
80100e11:	89 d8                	mov    %ebx,%eax
80100e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	68 34 73 10 80       	push   $0x80107334
80100e20:	e8 4b f5 ff ff       	call   80100370 <panic>
80100e25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 28             	sub    $0x28,%esp
80100e39:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e41:	e8 9a 38 00 00       	call   801046e0 <acquire>
  if(f->ref < 1)
80100e46:	8b 47 04             	mov    0x4(%edi),%eax
80100e49:	83 c4 10             	add    $0x10,%esp
80100e4c:	85 c0                	test   %eax,%eax
80100e4e:	0f 8e 9b 00 00 00    	jle    80100eef <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e54:	83 e8 01             	sub    $0x1,%eax
80100e57:	85 c0                	test   %eax,%eax
80100e59:	89 47 04             	mov    %eax,0x4(%edi)
80100e5c:	74 1a                	je     80100e78 <fileclose+0x48>
    release(&ftable.lock);
80100e5e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e68:	5b                   	pop    %ebx
80100e69:	5e                   	pop    %esi
80100e6a:	5f                   	pop    %edi
80100e6b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e6c:	e9 1f 39 00 00       	jmp    80104790 <release>
80100e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e78:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e7c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e7e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e81:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e84:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e8a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e8d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e90:	68 c0 ff 10 80       	push   $0x8010ffc0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e95:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e98:	e8 f3 38 00 00       	call   80104790 <release>

  if(ff.type == FD_PIPE)
80100e9d:	83 c4 10             	add    $0x10,%esp
80100ea0:	83 fb 01             	cmp    $0x1,%ebx
80100ea3:	74 13                	je     80100eb8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100ea5:	83 fb 02             	cmp    $0x2,%ebx
80100ea8:	74 26                	je     80100ed0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ead:	5b                   	pop    %ebx
80100eae:	5e                   	pop    %esi
80100eaf:	5f                   	pop    %edi
80100eb0:	5d                   	pop    %ebp
80100eb1:	c3                   	ret    
80100eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100eb8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ebc:	83 ec 08             	sub    $0x8,%esp
80100ebf:	53                   	push   %ebx
80100ec0:	56                   	push   %esi
80100ec1:	e8 ea 27 00 00       	call   801036b0 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ed0:	e8 3b 20 00 00       	call   80102f10 <begin_op>
    iput(ff.ip);
80100ed5:	83 ec 0c             	sub    $0xc,%esp
80100ed8:	ff 75 e0             	pushl  -0x20(%ebp)
80100edb:	e8 90 0a 00 00       	call   80101970 <iput>
    end_op();
80100ee0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ee6:	5b                   	pop    %ebx
80100ee7:	5e                   	pop    %esi
80100ee8:	5f                   	pop    %edi
80100ee9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eea:	e9 91 20 00 00       	jmp    80102f80 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 3c 73 10 80       	push   $0x8010733c
80100ef7:	e8 74 f4 ff ff       	call   80100370 <panic>
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f00 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	53                   	push   %ebx
80100f04:	83 ec 04             	sub    $0x4,%esp
80100f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f0d:	75 31                	jne    80100f40 <filestat+0x40>
    ilock(f->ip);
80100f0f:	83 ec 0c             	sub    $0xc,%esp
80100f12:	ff 73 10             	pushl  0x10(%ebx)
80100f15:	e8 26 09 00 00       	call   80101840 <ilock>
    stati(f->ip, st);
80100f1a:	58                   	pop    %eax
80100f1b:	5a                   	pop    %edx
80100f1c:	ff 75 0c             	pushl  0xc(%ebp)
80100f1f:	ff 73 10             	pushl  0x10(%ebx)
80100f22:	e8 b9 0d 00 00       	call   80101ce0 <stati>
    iunlock(f->ip);
80100f27:	59                   	pop    %ecx
80100f28:	ff 73 10             	pushl  0x10(%ebx)
80100f2b:	e8 f0 09 00 00       	call   80101920 <iunlock>
    return 0;
80100f30:	83 c4 10             	add    $0x10,%esp
80100f33:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	57                   	push   %edi
80100f54:	56                   	push   %esi
80100f55:	53                   	push   %ebx
80100f56:	83 ec 0c             	sub    $0xc,%esp
80100f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f5f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f66:	74 60                	je     80100fc8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f68:	8b 03                	mov    (%ebx),%eax
80100f6a:	83 f8 01             	cmp    $0x1,%eax
80100f6d:	74 41                	je     80100fb0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f6f:	83 f8 02             	cmp    $0x2,%eax
80100f72:	75 5b                	jne    80100fcf <fileread+0x7f>
    ilock(f->ip);
80100f74:	83 ec 0c             	sub    $0xc,%esp
80100f77:	ff 73 10             	pushl  0x10(%ebx)
80100f7a:	e8 c1 08 00 00       	call   80101840 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f7f:	57                   	push   %edi
80100f80:	ff 73 14             	pushl  0x14(%ebx)
80100f83:	56                   	push   %esi
80100f84:	ff 73 10             	pushl  0x10(%ebx)
80100f87:	e8 84 0d 00 00       	call   80101d10 <readi>
80100f8c:	83 c4 20             	add    $0x20,%esp
80100f8f:	85 c0                	test   %eax,%eax
80100f91:	89 c6                	mov    %eax,%esi
80100f93:	7e 03                	jle    80100f98 <fileread+0x48>
      f->off += r;
80100f95:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f98:	83 ec 0c             	sub    $0xc,%esp
80100f9b:	ff 73 10             	pushl  0x10(%ebx)
80100f9e:	e8 7d 09 00 00       	call   80101920 <iunlock>
    return r;
80100fa3:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fa6:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fab:	5b                   	pop    %ebx
80100fac:	5e                   	pop    %esi
80100fad:	5f                   	pop    %edi
80100fae:	5d                   	pop    %ebp
80100faf:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fb0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fb3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	5b                   	pop    %ebx
80100fba:	5e                   	pop    %esi
80100fbb:	5f                   	pop    %edi
80100fbc:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fbd:	e9 8e 28 00 00       	jmp    80103850 <piperead>
80100fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fcd:	eb d9                	jmp    80100fa8 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	68 46 73 10 80       	push   $0x80107346
80100fd7:	e8 94 f3 ff ff       	call   80100370 <panic>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 1c             	sub    $0x1c,%esp
80100fe9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fec:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fef:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff6:	8b 45 10             	mov    0x10(%ebp),%eax
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100ffc:	0f 84 aa 00 00 00    	je     801010ac <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101002:	8b 06                	mov    (%esi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c2 00 00 00    	je     801010cf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d8 00 00 00    	jne    801010ee <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101019:	31 ff                	xor    %edi,%edi
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 34                	jg     80101053 <filewrite+0x73>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101028:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010102b:	83 ec 0c             	sub    $0xc,%esp
8010102e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101031:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101034:	e8 e7 08 00 00       	call   80101920 <iunlock>
      end_op();
80101039:	e8 42 1f 00 00       	call   80102f80 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101041:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101044:	39 d8                	cmp    %ebx,%eax
80101046:	0f 85 95 00 00 00    	jne    801010e1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010104c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010104e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101051:	7e 6d                	jle    801010c0 <filewrite+0xe0>
      int n1 = n - i;
80101053:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101056:	b8 00 06 00 00       	mov    $0x600,%eax
8010105b:	29 fb                	sub    %edi,%ebx
8010105d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101063:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101066:	e8 a5 1e 00 00       	call   80102f10 <begin_op>
      ilock(f->ip);
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	ff 76 10             	pushl  0x10(%esi)
80101071:	e8 ca 07 00 00       	call   80101840 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101076:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101079:	53                   	push   %ebx
8010107a:	ff 76 14             	pushl  0x14(%esi)
8010107d:	01 f8                	add    %edi,%eax
8010107f:	50                   	push   %eax
80101080:	ff 76 10             	pushl  0x10(%esi)
80101083:	e8 88 0d 00 00       	call   80101e10 <writei>
80101088:	83 c4 20             	add    $0x20,%esp
8010108b:	85 c0                	test   %eax,%eax
8010108d:	7f 99                	jg     80101028 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010108f:	83 ec 0c             	sub    $0xc,%esp
80101092:	ff 76 10             	pushl  0x10(%esi)
80101095:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101098:	e8 83 08 00 00       	call   80101920 <iunlock>
      end_op();
8010109d:	e8 de 1e 00 00       	call   80102f80 <end_op>

      if(r < 0)
801010a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a5:	83 c4 10             	add    $0x10,%esp
801010a8:	85 c0                	test   %eax,%eax
801010aa:	74 98                	je     80101044 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801010b4:	5b                   	pop    %ebx
801010b5:	5e                   	pop    %esi
801010b6:	5f                   	pop    %edi
801010b7:	5d                   	pop    %ebp
801010b8:	c3                   	ret    
801010b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010c0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010c3:	75 e7                	jne    801010ac <filewrite+0xcc>
  }
  panic("filewrite");
}
801010c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c8:	89 f8                	mov    %edi,%eax
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010cf:	8b 46 0c             	mov    0xc(%esi),%eax
801010d2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010dc:	e9 6f 26 00 00       	jmp    80103750 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010e1:	83 ec 0c             	sub    $0xc,%esp
801010e4:	68 4f 73 10 80       	push   $0x8010734f
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 55 73 10 80       	push   $0x80107355
801010f6:	e8 75 f2 ff ff       	call   80100370 <panic>
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101109:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010110f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101112:	85 c9                	test   %ecx,%ecx
80101114:	0f 84 85 00 00 00    	je     8010119f <balloc+0x9f>
8010111a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101121:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101124:	83 ec 08             	sub    $0x8,%esp
80101127:	89 f0                	mov    %esi,%eax
80101129:	c1 f8 0c             	sar    $0xc,%eax
8010112c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101132:	50                   	push   %eax
80101133:	ff 75 d8             	pushl  -0x28(%ebp)
80101136:	e8 95 ef ff ff       	call   801000d0 <bread>
8010113b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010113e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101143:	83 c4 10             	add    $0x10,%esp
80101146:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101149:	31 c0                	xor    %eax,%eax
8010114b:	eb 2d                	jmp    8010117a <balloc+0x7a>
8010114d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101150:	89 c1                	mov    %eax,%ecx
80101152:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101157:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010115a:	83 e1 07             	and    $0x7,%ecx
8010115d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010115f:	89 c1                	mov    %eax,%ecx
80101161:	c1 f9 03             	sar    $0x3,%ecx
80101164:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101169:	85 d7                	test   %edx,%edi
8010116b:	74 43                	je     801011b0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010116d:	83 c0 01             	add    $0x1,%eax
80101170:	83 c6 01             	add    $0x1,%esi
80101173:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101178:	74 05                	je     8010117f <balloc+0x7f>
8010117a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010117d:	72 d1                	jb     80101150 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	ff 75 e4             	pushl  -0x1c(%ebp)
80101185:	e8 56 f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010118a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101191:	83 c4 10             	add    $0x10,%esp
80101194:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101197:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010119d:	77 82                	ja     80101121 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010119f:	83 ec 0c             	sub    $0xc,%esp
801011a2:	68 5f 73 10 80       	push   $0x8010735f
801011a7:	e8 c4 f1 ff ff       	call   80100370 <panic>
801011ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011b0:	09 fa                	or     %edi,%edx
801011b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011b5:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011bc:	57                   	push   %edi
801011bd:	e8 2e 1f 00 00       	call   801030f0 <log_write>
        brelse(bp);
801011c2:	89 3c 24             	mov    %edi,(%esp)
801011c5:	e8 16 f0 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011ca:	58                   	pop    %eax
801011cb:	5a                   	pop    %edx
801011cc:	56                   	push   %esi
801011cd:	ff 75 d8             	pushl  -0x28(%ebp)
801011d0:	e8 fb ee ff ff       	call   801000d0 <bread>
801011d5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011da:	83 c4 0c             	add    $0xc,%esp
801011dd:	68 00 02 00 00       	push   $0x200
801011e2:	6a 00                	push   $0x0
801011e4:	50                   	push   %eax
801011e5:	e8 f6 35 00 00       	call   801047e0 <memset>
  log_write(bp);
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 fe 1e 00 00       	call   801030f0 <log_write>
  brelse(bp);
801011f2:	89 1c 24             	mov    %ebx,(%esp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801011fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fd:	89 f0                	mov    %esi,%eax
801011ff:	5b                   	pop    %ebx
80101200:	5e                   	pop    %esi
80101201:	5f                   	pop    %edi
80101202:	5d                   	pop    %ebp
80101203:	c3                   	ret    
80101204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010120a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101210 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101218:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010121a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010121f:	83 ec 28             	sub    $0x28,%esp
80101222:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101225:	68 e0 09 11 80       	push   $0x801109e0
8010122a:	e8 b1 34 00 00       	call   801046e0 <acquire>
8010122f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101232:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101235:	eb 1b                	jmp    80101252 <iget+0x42>
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101240:	85 f6                	test   %esi,%esi
80101242:	74 44                	je     80101288 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101244:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010124a:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101250:	74 4e                	je     801012a0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101252:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101255:	85 c9                	test   %ecx,%ecx
80101257:	7e e7                	jle    80101240 <iget+0x30>
80101259:	39 3b                	cmp    %edi,(%ebx)
8010125b:	75 e3                	jne    80101240 <iget+0x30>
8010125d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101260:	75 de                	jne    80101240 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101262:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101265:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101268:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010126a:	68 e0 09 11 80       	push   $0x801109e0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010126f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101272:	e8 19 35 00 00       	call   80104790 <release>
      return ip;
80101277:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101288:	85 c9                	test   %ecx,%ecx
8010128a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010128d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101293:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101299:	75 b7                	jne    80101252 <iget+0x42>
8010129b:	90                   	nop
8010129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 2d                	je     801012d1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012a4:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012a7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012a9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012ac:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012b3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012ba:	68 e0 09 11 80       	push   $0x801109e0
801012bf:	e8 cc 34 00 00       	call   80104790 <release>

  return ip;
801012c4:	83 c4 10             	add    $0x10,%esp
}
801012c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	68 75 73 10 80       	push   $0x80107375
801012d9:	e8 92 f0 ff ff       	call   80100370 <panic>
801012de:	66 90                	xchg   %ax,%ax

801012e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c6                	mov    %eax,%esi
801012e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a, *b, *c, bn1;
  struct buf *bp;

  if(bn < NDIRECT){
801012eb:	83 fa 09             	cmp    $0x9,%edx
801012ee:	77 20                	ja     80101310 <bmap+0x30>
801012f0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801012f3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801012f6:	85 c0                	test   %eax,%eax
801012f8:	0f 84 42 01 00 00    	je     80101440 <bmap+0x160>
      }
      brelse(bp);
      return addr;
  }
  panic("bmap: out of range");
}
801012fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101301:	5b                   	pop    %ebx
80101302:	5e                   	pop    %esi
80101303:	5f                   	pop    %edi
80101304:	5d                   	pop    %ebp
80101305:	c3                   	ret    
80101306:	8d 76 00             	lea    0x0(%esi),%esi
80101309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101310:	8d 5a f6             	lea    -0xa(%edx),%ebx

  if(bn < NINDIRECT){
80101313:	83 fb 7f             	cmp    $0x7f,%ebx
80101316:	77 48                	ja     80101360 <bmap+0x80>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101318:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
8010131e:	85 c0                	test   %eax,%eax
80101320:	0f 84 7a 01 00 00    	je     801014a0 <bmap+0x1c0>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101326:	83 ec 08             	sub    $0x8,%esp
80101329:	50                   	push   %eax
8010132a:	ff 36                	pushl  (%esi)
8010132c:	e8 9f ed ff ff       	call   801000d0 <bread>
80101331:	89 c7                	mov    %eax,%edi
      }
      brelse(bp);
      bp = bread(ip->dev, addr);
      b = (uint*)bp->data;
      bn1 = bn % NINDIRECT;
      if((addr = b[bn1]) == 0){
80101333:	8d 54 9f 5c          	lea    0x5c(%edi,%ebx,4),%edx
80101337:	83 c4 10             	add    $0x10,%esp
8010133a:	8b 1a                	mov    (%edx),%ebx
8010133c:	85 db                	test   %ebx,%ebx
8010133e:	0f 84 d0 00 00 00    	je     80101414 <bmap+0x134>
      bn1 = bn % NINDIRECT;
      if((addr = c[bn1]) == 0){
          c[bn1] = addr = balloc(ip->dev);
          log_write(bp);
      }
      brelse(bp);
80101344:	83 ec 0c             	sub    $0xc,%esp
80101347:	57                   	push   %edi
80101348:	e8 93 ee ff ff       	call   801001e0 <brelse>
8010134d:	83 c4 10             	add    $0x10,%esp
      return addr;
  }
  panic("bmap: out of range");
}
80101350:	8d 65 f4             	lea    -0xc(%ebp),%esp
      if((addr = c[bn1]) == 0){
          c[bn1] = addr = balloc(ip->dev);
          log_write(bp);
      }
      brelse(bp);
      return addr;
80101353:	89 d8                	mov    %ebx,%eax
  }
  panic("bmap: out of range");
}
80101355:	5b                   	pop    %ebx
80101356:	5e                   	pop    %esi
80101357:	5f                   	pop    %edi
80101358:	5d                   	pop    %ebp
80101359:	c3                   	ret    
8010135a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      log_write(bp);
    }
    brelse(bp);
    return addr;
  }
  bn -= NINDIRECT;
80101360:	8d 9a 76 ff ff ff    	lea    -0x8a(%edx),%ebx
  if(bn < NDOUBLEINDIRECT){ // doubly indirect
80101366:	81 fb ff 3f 00 00    	cmp    $0x3fff,%ebx
8010136c:	0f 86 e6 00 00 00    	jbe    80101458 <bmap+0x178>
          log_write(bp);
      }
      brelse(bp);
      return addr;
  }
  bn -= NDOUBLEINDIRECT;
80101372:	8d 9a 76 bf ff ff    	lea    -0x408a(%edx),%ebx
    // cprintf("tripple\n");
  if(bn < NTRIPLEINDIRECT){ // triple indirect
80101378:	81 fb ff ff 1f 00    	cmp    $0x1fffff,%ebx
8010137e:	0f 87 ee 01 00 00    	ja     80101572 <bmap+0x292>
      if((addr = ip->addrs[NDIRECT + 2]) == 0)
80101384:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010138a:	85 c0                	test   %eax,%eax
8010138c:	0f 84 ce 01 00 00    	je     80101560 <bmap+0x280>
          ip->addrs[NDIRECT + 2] = addr = balloc(ip->dev);
      bp = bread(ip->dev, addr);
80101392:	83 ec 08             	sub    $0x8,%esp
80101395:	50                   	push   %eax
80101396:	ff 36                	pushl  (%esi)
80101398:	e8 33 ed ff ff       	call   801000d0 <bread>
8010139d:	89 c2                	mov    %eax,%edx
      a = (uint*)bp->data;
      bn1 = bn / NDOUBLEINDIRECT;
      if((addr = a[bn1]) == 0){
8010139f:	89 d8                	mov    %ebx,%eax
801013a1:	83 c4 10             	add    $0x10,%esp
801013a4:	c1 e8 0e             	shr    $0xe,%eax
801013a7:	8d 4c 82 5c          	lea    0x5c(%edx,%eax,4),%ecx
801013ab:	8b 39                	mov    (%ecx),%edi
801013ad:	85 ff                	test   %edi,%edi
801013af:	0f 84 7b 01 00 00    	je     80101530 <bmap+0x250>
          a[bn1] = addr = balloc(ip->dev);
          log_write(bp);
      }
      brelse(bp);
801013b5:	83 ec 0c             	sub    $0xc,%esp
801013b8:	52                   	push   %edx
801013b9:	e8 22 ee ff ff       	call   801001e0 <brelse>
      bp = bread(ip->dev, addr);
801013be:	59                   	pop    %ecx
801013bf:	58                   	pop    %eax
801013c0:	57                   	push   %edi
801013c1:	ff 36                	pushl  (%esi)
801013c3:	e8 08 ed ff ff       	call   801000d0 <bread>
801013c8:	89 c7                	mov    %eax,%edi
      b = (uint*)bp->data;
      bn1 = (bn % NDOUBLEINDIRECT) / NINDIRECT;
      if((addr = b[bn1]) == 0){
801013ca:	89 d8                	mov    %ebx,%eax
801013cc:	83 c4 10             	add    $0x10,%esp
801013cf:	c1 e8 05             	shr    $0x5,%eax
801013d2:	25 fc 01 00 00       	and    $0x1fc,%eax
801013d7:	8d 54 07 5c          	lea    0x5c(%edi,%eax,1),%edx
801013db:	8b 02                	mov    (%edx),%eax
801013dd:	85 c0                	test   %eax,%eax
801013df:	0f 84 1b 01 00 00    	je     80101500 <bmap+0x220>
          b[bn1] = addr = balloc(ip->dev);
          log_write(bp);
      }
      brelse(bp);
801013e5:	83 ec 0c             	sub    $0xc,%esp
801013e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      bp = bread(ip->dev, addr);
      c = (uint*)bp->data;
      bn1 = bn % NINDIRECT;
      if((addr = c[bn1]) == 0){
801013eb:	83 e3 7f             	and    $0x7f,%ebx
      bn1 = (bn % NDOUBLEINDIRECT) / NINDIRECT;
      if((addr = b[bn1]) == 0){
          b[bn1] = addr = balloc(ip->dev);
          log_write(bp);
      }
      brelse(bp);
801013ee:	57                   	push   %edi
801013ef:	e8 ec ed ff ff       	call   801001e0 <brelse>
      bp = bread(ip->dev, addr);
801013f4:	58                   	pop    %eax
801013f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801013f8:	5a                   	pop    %edx
801013f9:	50                   	push   %eax
801013fa:	ff 36                	pushl  (%esi)
801013fc:	e8 cf ec ff ff       	call   801000d0 <bread>
      c = (uint*)bp->data;
      bn1 = bn % NINDIRECT;
      if((addr = c[bn1]) == 0){
80101401:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
80101405:	83 c4 10             	add    $0x10,%esp
      if((addr = b[bn1]) == 0){
          b[bn1] = addr = balloc(ip->dev);
          log_write(bp);
      }
      brelse(bp);
      bp = bread(ip->dev, addr);
80101408:	89 c7                	mov    %eax,%edi
      c = (uint*)bp->data;
      bn1 = bn % NINDIRECT;
      if((addr = c[bn1]) == 0){
8010140a:	8b 1a                	mov    (%edx),%ebx
8010140c:	85 db                	test   %ebx,%ebx
8010140e:	0f 85 30 ff ff ff    	jne    80101344 <bmap+0x64>
          c[bn1] = addr = balloc(ip->dev);
80101414:	8b 06                	mov    (%esi),%eax
80101416:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101419:	e8 e2 fc ff ff       	call   80101100 <balloc>
8010141e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
          log_write(bp);
80101421:	83 ec 0c             	sub    $0xc,%esp
      brelse(bp);
      bp = bread(ip->dev, addr);
      c = (uint*)bp->data;
      bn1 = bn % NINDIRECT;
      if((addr = c[bn1]) == 0){
          c[bn1] = addr = balloc(ip->dev);
80101424:	89 c3                	mov    %eax,%ebx
80101426:	89 02                	mov    %eax,(%edx)
          log_write(bp);
80101428:	57                   	push   %edi
80101429:	e8 c2 1c 00 00       	call   801030f0 <log_write>
8010142e:	83 c4 10             	add    $0x10,%esp
80101431:	e9 0e ff ff ff       	jmp    80101344 <bmap+0x64>
80101436:	8d 76 00             	lea    0x0(%esi),%esi
80101439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint addr, *a, *b, *c, bn1;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101440:	8b 06                	mov    (%esi),%eax
80101442:	e8 b9 fc ff ff       	call   80101100 <balloc>
80101447:	89 43 5c             	mov    %eax,0x5c(%ebx)
      }
      brelse(bp);
      return addr;
  }
  panic("bmap: out of range");
}
8010144a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010144d:	5b                   	pop    %ebx
8010144e:	5e                   	pop    %esi
8010144f:	5f                   	pop    %edi
80101450:	5d                   	pop    %ebp
80101451:	c3                   	ret    
80101452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
    return addr;
  }
  bn -= NINDIRECT;
  if(bn < NDOUBLEINDIRECT){ // doubly indirect
      if((addr = ip->addrs[NDIRECT + 1]) == 0)
80101458:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
8010145e:	85 c0                	test   %eax,%eax
80101460:	74 56                	je     801014b8 <bmap+0x1d8>
          ip->addrs[NDIRECT + 1] = addr = balloc(ip->dev);
      bp = bread(ip->dev, addr);
80101462:	83 ec 08             	sub    $0x8,%esp
80101465:	50                   	push   %eax
80101466:	ff 36                	pushl  (%esi)
80101468:	e8 63 ec ff ff       	call   801000d0 <bread>
8010146d:	89 c2                	mov    %eax,%edx
      a = (uint*)bp->data;
      bn1 = bn / NINDIRECT;
      if((addr = a[bn1]) == 0){
8010146f:	89 d8                	mov    %ebx,%eax
80101471:	83 c4 10             	add    $0x10,%esp
80101474:	c1 e8 07             	shr    $0x7,%eax
80101477:	8d 4c 82 5c          	lea    0x5c(%edx,%eax,4),%ecx
8010147b:	8b 39                	mov    (%ecx),%edi
8010147d:	85 ff                	test   %edi,%edi
8010147f:	74 4f                	je     801014d0 <bmap+0x1f0>
          a[bn1] = addr = balloc(ip->dev);
          log_write(bp);
      }
      brelse(bp);
80101481:	83 ec 0c             	sub    $0xc,%esp
      bp = bread(ip->dev, addr);
      b = (uint*)bp->data;
      bn1 = bn % NINDIRECT;
      if((addr = b[bn1]) == 0){
80101484:	83 e3 7f             	and    $0x7f,%ebx
      bn1 = bn / NINDIRECT;
      if((addr = a[bn1]) == 0){
          a[bn1] = addr = balloc(ip->dev);
          log_write(bp);
      }
      brelse(bp);
80101487:	52                   	push   %edx
80101488:	e8 53 ed ff ff       	call   801001e0 <brelse>
      bp = bread(ip->dev, addr);
8010148d:	58                   	pop    %eax
8010148e:	5a                   	pop    %edx
8010148f:	57                   	push   %edi
80101490:	ff 36                	pushl  (%esi)
80101492:	e8 39 ec ff ff       	call   801000d0 <bread>
80101497:	89 c7                	mov    %eax,%edi
80101499:	e9 95 fe ff ff       	jmp    80101333 <bmap+0x53>
8010149e:	66 90                	xchg   %ax,%ax
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014a0:	8b 06                	mov    (%esi),%eax
801014a2:	e8 59 fc ff ff       	call   80101100 <balloc>
801014a7:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
801014ad:	e9 74 fe ff ff       	jmp    80101326 <bmap+0x46>
801014b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return addr;
  }
  bn -= NINDIRECT;
  if(bn < NDOUBLEINDIRECT){ // doubly indirect
      if((addr = ip->addrs[NDIRECT + 1]) == 0)
          ip->addrs[NDIRECT + 1] = addr = balloc(ip->dev);
801014b8:	8b 06                	mov    (%esi),%eax
801014ba:	e8 41 fc ff ff       	call   80101100 <balloc>
801014bf:	89 86 88 00 00 00    	mov    %eax,0x88(%esi)
801014c5:	eb 9b                	jmp    80101462 <bmap+0x182>
801014c7:	89 f6                	mov    %esi,%esi
801014c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      bp = bread(ip->dev, addr);
      a = (uint*)bp->data;
      bn1 = bn / NINDIRECT;
      if((addr = a[bn1]) == 0){
          a[bn1] = addr = balloc(ip->dev);
801014d0:	8b 06                	mov    (%esi),%eax
801014d2:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801014d5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801014d8:	e8 23 fc ff ff       	call   80101100 <balloc>
          log_write(bp);
801014dd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
          ip->addrs[NDIRECT + 1] = addr = balloc(ip->dev);
      bp = bread(ip->dev, addr);
      a = (uint*)bp->data;
      bn1 = bn / NINDIRECT;
      if((addr = a[bn1]) == 0){
          a[bn1] = addr = balloc(ip->dev);
801014e0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
          log_write(bp);
801014e3:	83 ec 0c             	sub    $0xc,%esp
          ip->addrs[NDIRECT + 1] = addr = balloc(ip->dev);
      bp = bread(ip->dev, addr);
      a = (uint*)bp->data;
      bn1 = bn / NINDIRECT;
      if((addr = a[bn1]) == 0){
          a[bn1] = addr = balloc(ip->dev);
801014e6:	89 c7                	mov    %eax,%edi
801014e8:	89 01                	mov    %eax,(%ecx)
          log_write(bp);
801014ea:	52                   	push   %edx
801014eb:	e8 00 1c 00 00       	call   801030f0 <log_write>
801014f0:	83 c4 10             	add    $0x10,%esp
801014f3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014f6:	eb 89                	jmp    80101481 <bmap+0x1a1>
801014f8:	90                   	nop
801014f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      brelse(bp);
      bp = bread(ip->dev, addr);
      b = (uint*)bp->data;
      bn1 = (bn % NDOUBLEINDIRECT) / NINDIRECT;
      if((addr = b[bn1]) == 0){
          b[bn1] = addr = balloc(ip->dev);
80101500:	8b 06                	mov    (%esi),%eax
80101502:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101505:	e8 f6 fb ff ff       	call   80101100 <balloc>
8010150a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
          log_write(bp);
8010150d:	83 ec 0c             	sub    $0xc,%esp
      brelse(bp);
      bp = bread(ip->dev, addr);
      b = (uint*)bp->data;
      bn1 = (bn % NDOUBLEINDIRECT) / NINDIRECT;
      if((addr = b[bn1]) == 0){
          b[bn1] = addr = balloc(ip->dev);
80101510:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101513:	89 02                	mov    %eax,(%edx)
          log_write(bp);
80101515:	57                   	push   %edi
80101516:	e8 d5 1b 00 00       	call   801030f0 <log_write>
8010151b:	83 c4 10             	add    $0x10,%esp
8010151e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101521:	e9 bf fe ff ff       	jmp    801013e5 <bmap+0x105>
80101526:	8d 76 00             	lea    0x0(%esi),%esi
80101529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
          ip->addrs[NDIRECT + 2] = addr = balloc(ip->dev);
      bp = bread(ip->dev, addr);
      a = (uint*)bp->data;
      bn1 = bn / NDOUBLEINDIRECT;
      if((addr = a[bn1]) == 0){
          a[bn1] = addr = balloc(ip->dev);
80101530:	8b 06                	mov    (%esi),%eax
80101532:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101535:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101538:	e8 c3 fb ff ff       	call   80101100 <balloc>
          log_write(bp);
8010153d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
          ip->addrs[NDIRECT + 2] = addr = balloc(ip->dev);
      bp = bread(ip->dev, addr);
      a = (uint*)bp->data;
      bn1 = bn / NDOUBLEINDIRECT;
      if((addr = a[bn1]) == 0){
          a[bn1] = addr = balloc(ip->dev);
80101540:	8b 4d e0             	mov    -0x20(%ebp),%ecx
          log_write(bp);
80101543:	83 ec 0c             	sub    $0xc,%esp
          ip->addrs[NDIRECT + 2] = addr = balloc(ip->dev);
      bp = bread(ip->dev, addr);
      a = (uint*)bp->data;
      bn1 = bn / NDOUBLEINDIRECT;
      if((addr = a[bn1]) == 0){
          a[bn1] = addr = balloc(ip->dev);
80101546:	89 c7                	mov    %eax,%edi
80101548:	89 01                	mov    %eax,(%ecx)
          log_write(bp);
8010154a:	52                   	push   %edx
8010154b:	e8 a0 1b 00 00       	call   801030f0 <log_write>
80101550:	83 c4 10             	add    $0x10,%esp
80101553:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101556:	e9 5a fe ff ff       	jmp    801013b5 <bmap+0xd5>
8010155b:	90                   	nop
8010155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  bn -= NDOUBLEINDIRECT;
    // cprintf("tripple\n");
  if(bn < NTRIPLEINDIRECT){ // triple indirect
      if((addr = ip->addrs[NDIRECT + 2]) == 0)
          ip->addrs[NDIRECT + 2] = addr = balloc(ip->dev);
80101560:	8b 06                	mov    (%esi),%eax
80101562:	e8 99 fb ff ff       	call   80101100 <balloc>
80101567:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010156d:	e9 20 fe ff ff       	jmp    80101392 <bmap+0xb2>
          log_write(bp);
      }
      brelse(bp);
      return addr;
  }
  panic("bmap: out of range");
80101572:	83 ec 0c             	sub    $0xc,%esp
80101575:	68 85 73 10 80       	push   $0x80107385
8010157a:	e8 f1 ed ff ff       	call   80100370 <panic>
8010157f:	90                   	nop

80101580 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101580:	55                   	push   %ebp
80101581:	89 e5                	mov    %esp,%ebp
80101583:	56                   	push   %esi
80101584:	53                   	push   %ebx
80101585:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101588:	83 ec 08             	sub    $0x8,%esp
8010158b:	6a 01                	push   $0x1
8010158d:	ff 75 08             	pushl  0x8(%ebp)
80101590:	e8 3b eb ff ff       	call   801000d0 <bread>
80101595:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101597:	8d 40 5c             	lea    0x5c(%eax),%eax
8010159a:	83 c4 0c             	add    $0xc,%esp
8010159d:	6a 1c                	push   $0x1c
8010159f:	50                   	push   %eax
801015a0:	56                   	push   %esi
801015a1:	e8 ea 32 00 00       	call   80104890 <memmove>
  brelse(bp);
801015a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801015a9:	83 c4 10             	add    $0x10,%esp
}
801015ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015af:	5b                   	pop    %ebx
801015b0:	5e                   	pop    %esi
801015b1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801015b2:	e9 29 ec ff ff       	jmp    801001e0 <brelse>
801015b7:	89 f6                	mov    %esi,%esi
801015b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015c0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	56                   	push   %esi
801015c4:	53                   	push   %ebx
801015c5:	89 d3                	mov    %edx,%ebx
801015c7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801015c9:	83 ec 08             	sub    $0x8,%esp
801015cc:	68 c0 09 11 80       	push   $0x801109c0
801015d1:	50                   	push   %eax
801015d2:	e8 a9 ff ff ff       	call   80101580 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801015d7:	58                   	pop    %eax
801015d8:	5a                   	pop    %edx
801015d9:	89 da                	mov    %ebx,%edx
801015db:	c1 ea 0c             	shr    $0xc,%edx
801015de:	03 15 d8 09 11 80    	add    0x801109d8,%edx
801015e4:	52                   	push   %edx
801015e5:	56                   	push   %esi
801015e6:	e8 e5 ea ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801015eb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801015ed:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801015f3:	ba 01 00 00 00       	mov    $0x1,%edx
801015f8:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801015fb:	c1 fb 03             	sar    $0x3,%ebx
801015fe:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101601:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101603:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101608:	85 d1                	test   %edx,%ecx
8010160a:	74 27                	je     80101633 <bfree+0x73>
8010160c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010160e:	f7 d2                	not    %edx
80101610:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101612:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101615:	21 d0                	and    %edx,%eax
80101617:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010161b:	56                   	push   %esi
8010161c:	e8 cf 1a 00 00       	call   801030f0 <log_write>
  brelse(bp);
80101621:	89 34 24             	mov    %esi,(%esp)
80101624:	e8 b7 eb ff ff       	call   801001e0 <brelse>
}
80101629:	83 c4 10             	add    $0x10,%esp
8010162c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010162f:	5b                   	pop    %ebx
80101630:	5e                   	pop    %esi
80101631:	5d                   	pop    %ebp
80101632:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101633:	83 ec 0c             	sub    $0xc,%esp
80101636:	68 98 73 10 80       	push   $0x80107398
8010163b:	e8 30 ed ff ff       	call   80100370 <panic>

80101640 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	53                   	push   %ebx
80101644:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101649:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010164c:	68 ab 73 10 80       	push   $0x801073ab
80101651:	68 e0 09 11 80       	push   $0x801109e0
80101656:	e8 25 2f 00 00       	call   80104580 <initlock>
8010165b:	83 c4 10             	add    $0x10,%esp
8010165e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101660:	83 ec 08             	sub    $0x8,%esp
80101663:	68 b2 73 10 80       	push   $0x801073b2
80101668:	53                   	push   %ebx
80101669:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010166f:	e8 dc 2d 00 00       	call   80104450 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101674:	83 c4 10             	add    $0x10,%esp
80101677:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010167d:	75 e1                	jne    80101660 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010167f:	83 ec 08             	sub    $0x8,%esp
80101682:	68 c0 09 11 80       	push   $0x801109c0
80101687:	ff 75 08             	pushl  0x8(%ebp)
8010168a:	e8 f1 fe ff ff       	call   80101580 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010168f:	ff 35 d8 09 11 80    	pushl  0x801109d8
80101695:	ff 35 d4 09 11 80    	pushl  0x801109d4
8010169b:	ff 35 d0 09 11 80    	pushl  0x801109d0
801016a1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801016a7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801016ad:	ff 35 c4 09 11 80    	pushl  0x801109c4
801016b3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801016b9:	68 18 74 10 80       	push   $0x80107418
801016be:	e8 9d ef ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801016c3:	83 c4 30             	add    $0x30,%esp
801016c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016c9:	c9                   	leave  
801016ca:	c3                   	ret    
801016cb:	90                   	nop
801016cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016d0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	57                   	push   %edi
801016d4:	56                   	push   %esi
801016d5:	53                   	push   %ebx
801016d6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016d9:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801016e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801016e3:	8b 75 08             	mov    0x8(%ebp),%esi
801016e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016e9:	0f 86 91 00 00 00    	jbe    80101780 <ialloc+0xb0>
801016ef:	bb 01 00 00 00       	mov    $0x1,%ebx
801016f4:	eb 21                	jmp    80101717 <ialloc+0x47>
801016f6:	8d 76 00             	lea    0x0(%esi),%esi
801016f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101700:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101703:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101706:	57                   	push   %edi
80101707:	e8 d4 ea ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010170c:	83 c4 10             	add    $0x10,%esp
8010170f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101715:	76 69                	jbe    80101780 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101717:	89 d8                	mov    %ebx,%eax
80101719:	83 ec 08             	sub    $0x8,%esp
8010171c:	c1 e8 03             	shr    $0x3,%eax
8010171f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101725:	50                   	push   %eax
80101726:	56                   	push   %esi
80101727:	e8 a4 e9 ff ff       	call   801000d0 <bread>
8010172c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010172e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101730:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101733:	83 e0 07             	and    $0x7,%eax
80101736:	c1 e0 06             	shl    $0x6,%eax
80101739:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010173d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101741:	75 bd                	jne    80101700 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101743:	83 ec 04             	sub    $0x4,%esp
80101746:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101749:	6a 40                	push   $0x40
8010174b:	6a 00                	push   $0x0
8010174d:	51                   	push   %ecx
8010174e:	e8 8d 30 00 00       	call   801047e0 <memset>
      dip->type = type;
80101753:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101757:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010175a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010175d:	89 3c 24             	mov    %edi,(%esp)
80101760:	e8 8b 19 00 00       	call   801030f0 <log_write>
      brelse(bp);
80101765:	89 3c 24             	mov    %edi,(%esp)
80101768:	e8 73 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010176d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101770:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101773:	89 da                	mov    %ebx,%edx
80101775:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101777:	5b                   	pop    %ebx
80101778:	5e                   	pop    %esi
80101779:	5f                   	pop    %edi
8010177a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010177b:	e9 90 fa ff ff       	jmp    80101210 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101780:	83 ec 0c             	sub    $0xc,%esp
80101783:	68 b8 73 10 80       	push   $0x801073b8
80101788:	e8 e3 eb ff ff       	call   80100370 <panic>
8010178d:	8d 76 00             	lea    0x0(%esi),%esi

80101790 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101798:	83 ec 08             	sub    $0x8,%esp
8010179b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010179e:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017a1:	c1 e8 03             	shr    $0x3,%eax
801017a4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801017aa:	50                   	push   %eax
801017ab:	ff 73 a4             	pushl  -0x5c(%ebx)
801017ae:	e8 1d e9 ff ff       	call   801000d0 <bread>
801017b3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017b5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801017b8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017bc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017bf:	83 e0 07             	and    $0x7,%eax
801017c2:	c1 e0 06             	shl    $0x6,%eax
801017c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801017c9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017cc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017d0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801017d3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801017d7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801017db:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801017df:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801017e3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801017e7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801017ea:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017ed:	6a 34                	push   $0x34
801017ef:	53                   	push   %ebx
801017f0:	50                   	push   %eax
801017f1:	e8 9a 30 00 00       	call   80104890 <memmove>
  log_write(bp);
801017f6:	89 34 24             	mov    %esi,(%esp)
801017f9:	e8 f2 18 00 00       	call   801030f0 <log_write>
  brelse(bp);
801017fe:	89 75 08             	mov    %esi,0x8(%ebp)
80101801:	83 c4 10             	add    $0x10,%esp
}
80101804:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101807:	5b                   	pop    %ebx
80101808:	5e                   	pop    %esi
80101809:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010180a:	e9 d1 e9 ff ff       	jmp    801001e0 <brelse>
8010180f:	90                   	nop

80101810 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	53                   	push   %ebx
80101814:	83 ec 10             	sub    $0x10,%esp
80101817:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010181a:	68 e0 09 11 80       	push   $0x801109e0
8010181f:	e8 bc 2e 00 00       	call   801046e0 <acquire>
  ip->ref++;
80101824:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101828:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010182f:	e8 5c 2f 00 00       	call   80104790 <release>
  return ip;
}
80101834:	89 d8                	mov    %ebx,%eax
80101836:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101839:	c9                   	leave  
8010183a:	c3                   	ret    
8010183b:	90                   	nop
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101840 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	56                   	push   %esi
80101844:	53                   	push   %ebx
80101845:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101848:	85 db                	test   %ebx,%ebx
8010184a:	0f 84 b7 00 00 00    	je     80101907 <ilock+0xc7>
80101850:	8b 53 08             	mov    0x8(%ebx),%edx
80101853:	85 d2                	test   %edx,%edx
80101855:	0f 8e ac 00 00 00    	jle    80101907 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010185b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010185e:	83 ec 0c             	sub    $0xc,%esp
80101861:	50                   	push   %eax
80101862:	e8 29 2c 00 00       	call   80104490 <acquiresleep>

  if(ip->valid == 0){
80101867:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010186a:	83 c4 10             	add    $0x10,%esp
8010186d:	85 c0                	test   %eax,%eax
8010186f:	74 0f                	je     80101880 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101871:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101874:	5b                   	pop    %ebx
80101875:	5e                   	pop    %esi
80101876:	5d                   	pop    %ebp
80101877:	c3                   	ret    
80101878:	90                   	nop
80101879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101880:	8b 43 04             	mov    0x4(%ebx),%eax
80101883:	83 ec 08             	sub    $0x8,%esp
80101886:	c1 e8 03             	shr    $0x3,%eax
80101889:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010188f:	50                   	push   %eax
80101890:	ff 33                	pushl  (%ebx)
80101892:	e8 39 e8 ff ff       	call   801000d0 <bread>
80101897:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101899:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010189c:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010189f:	83 e0 07             	and    $0x7,%eax
801018a2:	c1 e0 06             	shl    $0x6,%eax
801018a5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801018a9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018ac:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801018af:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801018b3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801018b7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801018bb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801018bf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018c3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801018c7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801018cb:	8b 50 fc             	mov    -0x4(%eax),%edx
801018ce:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018d1:	6a 34                	push   $0x34
801018d3:	50                   	push   %eax
801018d4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801018d7:	50                   	push   %eax
801018d8:	e8 b3 2f 00 00       	call   80104890 <memmove>
    brelse(bp);
801018dd:	89 34 24             	mov    %esi,(%esp)
801018e0:	e8 fb e8 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
801018e5:	83 c4 10             	add    $0x10,%esp
801018e8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
801018ed:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018f4:	0f 85 77 ff ff ff    	jne    80101871 <ilock+0x31>
      panic("ilock: no type");
801018fa:	83 ec 0c             	sub    $0xc,%esp
801018fd:	68 d0 73 10 80       	push   $0x801073d0
80101902:	e8 69 ea ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101907:	83 ec 0c             	sub    $0xc,%esp
8010190a:	68 ca 73 10 80       	push   $0x801073ca
8010190f:	e8 5c ea ff ff       	call   80100370 <panic>
80101914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010191a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101920 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	56                   	push   %esi
80101924:	53                   	push   %ebx
80101925:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101928:	85 db                	test   %ebx,%ebx
8010192a:	74 28                	je     80101954 <iunlock+0x34>
8010192c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010192f:	83 ec 0c             	sub    $0xc,%esp
80101932:	56                   	push   %esi
80101933:	e8 f8 2b 00 00       	call   80104530 <holdingsleep>
80101938:	83 c4 10             	add    $0x10,%esp
8010193b:	85 c0                	test   %eax,%eax
8010193d:	74 15                	je     80101954 <iunlock+0x34>
8010193f:	8b 43 08             	mov    0x8(%ebx),%eax
80101942:	85 c0                	test   %eax,%eax
80101944:	7e 0e                	jle    80101954 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101946:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101949:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010194c:	5b                   	pop    %ebx
8010194d:	5e                   	pop    %esi
8010194e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010194f:	e9 9c 2b 00 00       	jmp    801044f0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101954:	83 ec 0c             	sub    $0xc,%esp
80101957:	68 df 73 10 80       	push   $0x801073df
8010195c:	e8 0f ea ff ff       	call   80100370 <panic>
80101961:	eb 0d                	jmp    80101970 <iput>
80101963:	90                   	nop
80101964:	90                   	nop
80101965:	90                   	nop
80101966:	90                   	nop
80101967:	90                   	nop
80101968:	90                   	nop
80101969:	90                   	nop
8010196a:	90                   	nop
8010196b:	90                   	nop
8010196c:	90                   	nop
8010196d:	90                   	nop
8010196e:	90                   	nop
8010196f:	90                   	nop

80101970 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	57                   	push   %edi
80101974:	56                   	push   %esi
80101975:	53                   	push   %ebx
80101976:	83 ec 38             	sub    $0x38,%esp
80101979:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquiresleep(&ip->lock);
8010197c:	8d 47 0c             	lea    0xc(%edi),%eax
8010197f:	50                   	push   %eax
80101980:	89 45 d0             	mov    %eax,-0x30(%ebp)
80101983:	e8 08 2b 00 00       	call   80104490 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101988:	8b 57 4c             	mov    0x4c(%edi),%edx
8010198b:	83 c4 10             	add    $0x10,%esp
8010198e:	85 d2                	test   %edx,%edx
80101990:	74 07                	je     80101999 <iput+0x29>
80101992:	66 83 7f 56 00       	cmpw   $0x0,0x56(%edi)
80101997:	74 31                	je     801019ca <iput+0x5a>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101999:	83 ec 0c             	sub    $0xc,%esp
8010199c:	ff 75 d0             	pushl  -0x30(%ebp)
8010199f:	e8 4c 2b 00 00       	call   801044f0 <releasesleep>

  acquire(&icache.lock);
801019a4:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801019ab:	e8 30 2d 00 00       	call   801046e0 <acquire>
  ip->ref--;
801019b0:	83 6f 08 01          	subl   $0x1,0x8(%edi)
  release(&icache.lock);
801019b4:	83 c4 10             	add    $0x10,%esp
801019b7:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801019be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019c1:	5b                   	pop    %ebx
801019c2:	5e                   	pop    %esi
801019c3:	5f                   	pop    %edi
801019c4:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801019c5:	e9 c6 2d 00 00       	jmp    80104790 <release>
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801019ca:	83 ec 0c             	sub    $0xc,%esp
801019cd:	68 e0 09 11 80       	push   $0x801109e0
801019d2:	e8 09 2d 00 00       	call   801046e0 <acquire>
    int r = ip->ref;
801019d7:	8b 5f 08             	mov    0x8(%edi),%ebx
    release(&icache.lock);
801019da:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801019e1:	e8 aa 2d 00 00       	call   80104790 <release>
    if(r == 1){
801019e6:	83 c4 10             	add    $0x10,%esp
801019e9:	83 fb 01             	cmp    $0x1,%ebx
801019ec:	75 ab                	jne    80101999 <iput+0x29>
801019ee:	8d 77 5c             	lea    0x5c(%edi),%esi
801019f1:	8d 9f 84 00 00 00    	lea    0x84(%edi),%ebx
  int i, j, k, l;
  struct buf *bp, *bp1, *bp2;
  uint *a, *b, *c;

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
801019f7:	8b 16                	mov    (%esi),%edx
801019f9:	85 d2                	test   %edx,%edx
801019fb:	74 0d                	je     80101a0a <iput+0x9a>
      bfree(ip->dev, ip->addrs[i]);
801019fd:	8b 07                	mov    (%edi),%eax
801019ff:	e8 bc fb ff ff       	call   801015c0 <bfree>
      ip->addrs[i] = 0;
80101a04:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101a0a:	83 c6 04             	add    $0x4,%esi
{
  int i, j, k, l;
  struct buf *bp, *bp1, *bp2;
  uint *a, *b, *c;

  for(i = 0; i < NDIRECT; i++){
80101a0d:	39 de                	cmp    %ebx,%esi
80101a0f:	75 e6                	jne    801019f7 <iput+0x87>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
80101a11:	8b 87 84 00 00 00    	mov    0x84(%edi),%eax
80101a17:	85 c0                	test   %eax,%eax
80101a19:	75 49                	jne    80101a64 <iput+0xf4>
    }
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }
  if(ip->addrs[NDIRECT + 1]){
80101a1b:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
80101a21:	85 c0                	test   %eax,%eax
80101a23:	0f 85 fc 01 00 00    	jne    80101c25 <iput+0x2b5>
      }
      brelse(bp);
      bfree(ip->dev, ip->addrs[NDIRECT + 1]);
      ip->addrs[NDIRECT + 1] = 0;
  }
  if(ip->addrs[NDIRECT + 2]){
80101a29:	8b 87 8c 00 00 00    	mov    0x8c(%edi),%eax
80101a2f:	85 c0                	test   %eax,%eax
80101a31:	0f 85 b9 00 00 00    	jne    80101af0 <iput+0x180>
      bfree(ip->dev, ip->addrs[NDIRECT + 2]);
      ip->addrs[NDIRECT + 2] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a37:	83 ec 0c             	sub    $0xc,%esp
      brelse(bp);
      bfree(ip->dev, ip->addrs[NDIRECT + 2]);
      ip->addrs[NDIRECT + 2] = 0;
  }

  ip->size = 0;
80101a3a:	c7 47 58 00 00 00 00 	movl   $0x0,0x58(%edi)
  iupdate(ip);
80101a41:	57                   	push   %edi
80101a42:	e8 49 fd ff ff       	call   80101790 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
80101a47:	31 c0                	xor    %eax,%eax
80101a49:	66 89 47 50          	mov    %ax,0x50(%edi)
      iupdate(ip);
80101a4d:	89 3c 24             	mov    %edi,(%esp)
80101a50:	e8 3b fd ff ff       	call   80101790 <iupdate>
      ip->valid = 0;
80101a55:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
80101a5c:	83 c4 10             	add    $0x10,%esp
80101a5f:	e9 35 ff ff ff       	jmp    80101999 <iput+0x29>
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a64:	83 ec 08             	sub    $0x8,%esp
80101a67:	50                   	push   %eax
80101a68:	ff 37                	pushl  (%edi)
80101a6a:	e8 61 e6 ff ff       	call   801000d0 <bread>
80101a6f:	89 c6                	mov    %eax,%esi
    a = (uint*)bp->data;
80101a71:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101a74:	8d 80 5c 02 00 00    	lea    0x25c(%eax),%eax
80101a7a:	83 c4 10             	add    $0x10,%esp
80101a7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
      if(a[j])
80101a80:	8b 13                	mov    (%ebx),%edx
80101a82:	85 d2                	test   %edx,%edx
80101a84:	74 07                	je     80101a8d <iput+0x11d>
        bfree(ip->dev, a[j]);
80101a86:	8b 07                	mov    (%edi),%eax
80101a88:	e8 33 fb ff ff       	call   801015c0 <bfree>
80101a8d:	83 c3 04             	add    $0x4,%ebx
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101a90:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80101a93:	75 eb                	jne    80101a80 <iput+0x110>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101a95:	83 ec 0c             	sub    $0xc,%esp
80101a98:	56                   	push   %esi
80101a99:	e8 42 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a9e:	8b 97 84 00 00 00    	mov    0x84(%edi),%edx
80101aa4:	8b 07                	mov    (%edi),%eax
80101aa6:	e8 15 fb ff ff       	call   801015c0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101aab:	c7 87 84 00 00 00 00 	movl   $0x0,0x84(%edi)
80101ab2:	00 00 00 
80101ab5:	83 c4 10             	add    $0x10,%esp
80101ab8:	e9 5e ff ff ff       	jmp    80101a1b <iput+0xab>
              }
              brelse(bp1);
              bfree(ip->dev, a[j]);
          }
      }
      brelse(bp);
80101abd:	83 ec 0c             	sub    $0xc,%esp
80101ac0:	ff 75 d8             	pushl  -0x28(%ebp)
80101ac3:	e8 18 e7 ff ff       	call   801001e0 <brelse>
      bfree(ip->dev, ip->addrs[NDIRECT + 1]);
80101ac8:	8b 07                	mov    (%edi),%eax
80101aca:	8b 97 88 00 00 00    	mov    0x88(%edi),%edx
80101ad0:	e8 eb fa ff ff       	call   801015c0 <bfree>
      ip->addrs[NDIRECT + 1] = 0;
  }
  if(ip->addrs[NDIRECT + 2]){
80101ad5:	8b 87 8c 00 00 00    	mov    0x8c(%edi),%eax
80101adb:	83 c4 10             	add    $0x10,%esp
              bfree(ip->dev, a[j]);
          }
      }
      brelse(bp);
      bfree(ip->dev, ip->addrs[NDIRECT + 1]);
      ip->addrs[NDIRECT + 1] = 0;
80101ade:	c7 87 88 00 00 00 00 	movl   $0x0,0x88(%edi)
80101ae5:	00 00 00 
  }
  if(ip->addrs[NDIRECT + 2]){
80101ae8:	85 c0                	test   %eax,%eax
80101aea:	0f 84 47 ff ff ff    	je     80101a37 <iput+0xc7>
      bp = bread(ip->dev, ip->addrs[NDIRECT + 2]);
80101af0:	83 ec 08             	sub    $0x8,%esp
80101af3:	50                   	push   %eax
80101af4:	ff 37                	pushl  (%edi)
80101af6:	e8 d5 e5 ff ff       	call   801000d0 <bread>
80101afb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
      a = (uint*)bp->data;
80101afe:	83 c0 5c             	add    $0x5c,%eax
80101b01:	83 c4 10             	add    $0x10,%esp
80101b04:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b07:	05 00 02 00 00       	add    $0x200,%eax
80101b0c:	89 45 c8             	mov    %eax,-0x38(%ebp)
80101b0f:	eb 17                	jmp    80101b28 <iput+0x1b8>
80101b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b18:	83 45 d8 04          	addl   $0x4,-0x28(%ebp)
80101b1c:	8b 45 d8             	mov    -0x28(%ebp),%eax
      for(j = 0; j < NINDIRECT; j++){
80101b1f:	3b 45 c8             	cmp    -0x38(%ebp),%eax
80101b22:	0f 84 d3 00 00 00    	je     80101bfb <iput+0x28b>
          if(a[j]){
80101b28:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2b:	8b 00                	mov    (%eax),%eax
80101b2d:	85 c0                	test   %eax,%eax
80101b2f:	74 e7                	je     80101b18 <iput+0x1a8>
              bp1 = bread(ip->dev, a[j]);
80101b31:	83 ec 08             	sub    $0x8,%esp
80101b34:	50                   	push   %eax
80101b35:	ff 37                	pushl  (%edi)
80101b37:	e8 94 e5 ff ff       	call   801000d0 <bread>
              b = (uint*)bp1->data;
80101b3c:	8d 48 5c             	lea    0x5c(%eax),%ecx
  if(ip->addrs[NDIRECT + 2]){
      bp = bread(ip->dev, ip->addrs[NDIRECT + 2]);
      a = (uint*)bp->data;
      for(j = 0; j < NINDIRECT; j++){
          if(a[j]){
              bp1 = bread(ip->dev, a[j]);
80101b3f:	89 45 cc             	mov    %eax,-0x34(%ebp)
80101b42:	05 5c 02 00 00       	add    $0x25c,%eax
80101b47:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101b4a:	83 c4 10             	add    $0x10,%esp
              b = (uint*)bp1->data;
80101b4d:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101b50:	eb 12                	jmp    80101b64 <iput+0x1f4>
80101b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101b58:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
80101b5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
              for(k = 0; k < NINDIRECT; k++){
80101b5f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80101b62:	74 6d                	je     80101bd1 <iput+0x261>
                  if(b[k]){
80101b64:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b67:	8b 00                	mov    (%eax),%eax
80101b69:	85 c0                	test   %eax,%eax
80101b6b:	74 eb                	je     80101b58 <iput+0x1e8>
                      bp2 = bread(ip->dev, b[k]);
80101b6d:	83 ec 08             	sub    $0x8,%esp
80101b70:	50                   	push   %eax
80101b71:	ff 37                	pushl  (%edi)
80101b73:	e8 58 e5 ff ff       	call   801000d0 <bread>
80101b78:	83 c4 10             	add    $0x10,%esp
80101b7b:	89 45 dc             	mov    %eax,-0x24(%ebp)
                      c = (uint*)bp2->data;
80101b7e:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101b81:	8d b0 5c 02 00 00    	lea    0x25c(%eax),%esi
80101b87:	eb 0e                	jmp    80101b97 <iput+0x227>
80101b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b90:	83 c3 04             	add    $0x4,%ebx
                      for(l = 0; l < NINDIRECT; l++){
80101b93:	39 de                	cmp    %ebx,%esi
80101b95:	74 14                	je     80101bab <iput+0x23b>
                          if(c[l])
80101b97:	8b 13                	mov    (%ebx),%edx
80101b99:	85 d2                	test   %edx,%edx
80101b9b:	74 f3                	je     80101b90 <iput+0x220>
                              bfree(ip->dev, c[l]);
80101b9d:	8b 07                	mov    (%edi),%eax
80101b9f:	83 c3 04             	add    $0x4,%ebx
80101ba2:	e8 19 fa ff ff       	call   801015c0 <bfree>
              b = (uint*)bp1->data;
              for(k = 0; k < NINDIRECT; k++){
                  if(b[k]){
                      bp2 = bread(ip->dev, b[k]);
                      c = (uint*)bp2->data;
                      for(l = 0; l < NINDIRECT; l++){
80101ba7:	39 de                	cmp    %ebx,%esi
80101ba9:	75 ec                	jne    80101b97 <iput+0x227>
                          if(c[l])
                              bfree(ip->dev, c[l]);
                      }
                      brelse(bp2);
80101bab:	83 ec 0c             	sub    $0xc,%esp
80101bae:	ff 75 dc             	pushl  -0x24(%ebp)
80101bb1:	e8 2a e6 ff ff       	call   801001e0 <brelse>
                      bfree(ip->dev, b[k]);
80101bb6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bb9:	8b 10                	mov    (%eax),%edx
80101bbb:	8b 07                	mov    (%edi),%eax
80101bbd:	e8 fe f9 ff ff       	call   801015c0 <bfree>
80101bc2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
80101bc6:	83 c4 10             	add    $0x10,%esp
80101bc9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      a = (uint*)bp->data;
      for(j = 0; j < NINDIRECT; j++){
          if(a[j]){
              bp1 = bread(ip->dev, a[j]);
              b = (uint*)bp1->data;
              for(k = 0; k < NINDIRECT; k++){
80101bcc:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80101bcf:	75 93                	jne    80101b64 <iput+0x1f4>
                      }
                      brelse(bp2);
                      bfree(ip->dev, b[k]);
                  }
              }
              brelse(bp1);
80101bd1:	83 ec 0c             	sub    $0xc,%esp
80101bd4:	ff 75 cc             	pushl  -0x34(%ebp)
80101bd7:	e8 04 e6 ff ff       	call   801001e0 <brelse>
              bfree(ip->dev, a[j]);
80101bdc:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bdf:	8b 10                	mov    (%eax),%edx
80101be1:	8b 07                	mov    (%edi),%eax
80101be3:	e8 d8 f9 ff ff       	call   801015c0 <bfree>
80101be8:	83 45 d8 04          	addl   $0x4,-0x28(%ebp)
80101bec:	83 c4 10             	add    $0x10,%esp
80101bef:	8b 45 d8             	mov    -0x28(%ebp),%eax
      ip->addrs[NDIRECT + 1] = 0;
  }
  if(ip->addrs[NDIRECT + 2]){
      bp = bread(ip->dev, ip->addrs[NDIRECT + 2]);
      a = (uint*)bp->data;
      for(j = 0; j < NINDIRECT; j++){
80101bf2:	3b 45 c8             	cmp    -0x38(%ebp),%eax
80101bf5:	0f 85 2d ff ff ff    	jne    80101b28 <iput+0x1b8>
              }
              brelse(bp1);
              bfree(ip->dev, a[j]);
          }
      }
      brelse(bp);
80101bfb:	83 ec 0c             	sub    $0xc,%esp
80101bfe:	ff 75 d4             	pushl  -0x2c(%ebp)
80101c01:	e8 da e5 ff ff       	call   801001e0 <brelse>
      bfree(ip->dev, ip->addrs[NDIRECT + 2]);
80101c06:	8b 97 8c 00 00 00    	mov    0x8c(%edi),%edx
80101c0c:	8b 07                	mov    (%edi),%eax
80101c0e:	e8 ad f9 ff ff       	call   801015c0 <bfree>
      ip->addrs[NDIRECT + 2] = 0;
80101c13:	c7 87 8c 00 00 00 00 	movl   $0x0,0x8c(%edi)
80101c1a:	00 00 00 
80101c1d:	83 c4 10             	add    $0x10,%esp
80101c20:	e9 12 fe ff ff       	jmp    80101a37 <iput+0xc7>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }
  if(ip->addrs[NDIRECT + 1]){
      bp = bread(ip->dev, ip->addrs[NDIRECT + 1]);
80101c25:	83 ec 08             	sub    $0x8,%esp
80101c28:	50                   	push   %eax
80101c29:	ff 37                	pushl  (%edi)
80101c2b:	e8 a0 e4 ff ff       	call   801000d0 <bread>
      a = (uint*)bp->data;
80101c30:	8d 48 5c             	lea    0x5c(%eax),%ecx
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }
  if(ip->addrs[NDIRECT + 1]){
      bp = bread(ip->dev, ip->addrs[NDIRECT + 1]);
80101c33:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c36:	05 5c 02 00 00       	add    $0x25c,%eax
80101c3b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101c3e:	83 c4 10             	add    $0x10,%esp
      a = (uint*)bp->data;
80101c41:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101c44:	eb 1a                	jmp    80101c60 <iput+0x2f0>
80101c46:	8d 76 00             	lea    0x0(%esi),%esi
80101c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101c50:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
80101c54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      for(j = 0; j < NINDIRECT; j++){
80101c57:	3b 45 dc             	cmp    -0x24(%ebp),%eax
80101c5a:	0f 84 5d fe ff ff    	je     80101abd <iput+0x14d>
          if(a[j]){
80101c60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c63:	8b 00                	mov    (%eax),%eax
80101c65:	85 c0                	test   %eax,%eax
80101c67:	74 e7                	je     80101c50 <iput+0x2e0>
              bp1 = bread(ip->dev, a[j]);
80101c69:	83 ec 08             	sub    $0x8,%esp
80101c6c:	50                   	push   %eax
80101c6d:	ff 37                	pushl  (%edi)
80101c6f:	e8 5c e4 ff ff       	call   801000d0 <bread>
80101c74:	83 c4 10             	add    $0x10,%esp
80101c77:	89 45 e0             	mov    %eax,-0x20(%ebp)
              b = (uint*)bp1->data;
80101c7a:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101c7d:	8d b0 5c 02 00 00    	lea    0x25c(%eax),%esi
80101c83:	eb 0a                	jmp    80101c8f <iput+0x31f>
80101c85:	8d 76 00             	lea    0x0(%esi),%esi
80101c88:	83 c3 04             	add    $0x4,%ebx
              for(k = 0; k < NINDIRECT; k++){
80101c8b:	39 f3                	cmp    %esi,%ebx
80101c8d:	74 14                	je     80101ca3 <iput+0x333>
                  if(b[k])
80101c8f:	8b 13                	mov    (%ebx),%edx
80101c91:	85 d2                	test   %edx,%edx
80101c93:	74 f3                	je     80101c88 <iput+0x318>
                  bfree(ip->dev, b[k]);
80101c95:	8b 07                	mov    (%edi),%eax
80101c97:	83 c3 04             	add    $0x4,%ebx
80101c9a:	e8 21 f9 ff ff       	call   801015c0 <bfree>
      a = (uint*)bp->data;
      for(j = 0; j < NINDIRECT; j++){
          if(a[j]){
              bp1 = bread(ip->dev, a[j]);
              b = (uint*)bp1->data;
              for(k = 0; k < NINDIRECT; k++){
80101c9f:	39 f3                	cmp    %esi,%ebx
80101ca1:	75 ec                	jne    80101c8f <iput+0x31f>
                  if(b[k])
                  bfree(ip->dev, b[k]);
              }
              brelse(bp1);
80101ca3:	83 ec 0c             	sub    $0xc,%esp
80101ca6:	ff 75 e0             	pushl  -0x20(%ebp)
80101ca9:	e8 32 e5 ff ff       	call   801001e0 <brelse>
              bfree(ip->dev, a[j]);
80101cae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101cb1:	8b 10                	mov    (%eax),%edx
80101cb3:	8b 07                	mov    (%edi),%eax
80101cb5:	e8 06 f9 ff ff       	call   801015c0 <bfree>
80101cba:	83 c4 10             	add    $0x10,%esp
80101cbd:	eb 91                	jmp    80101c50 <iput+0x2e0>
80101cbf:	90                   	nop

80101cc0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	53                   	push   %ebx
80101cc4:	83 ec 10             	sub    $0x10,%esp
80101cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101cca:	53                   	push   %ebx
80101ccb:	e8 50 fc ff ff       	call   80101920 <iunlock>
  iput(ip);
80101cd0:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101cd3:	83 c4 10             	add    $0x10,%esp
}
80101cd6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101cd9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101cda:	e9 91 fc ff ff       	jmp    80101970 <iput>
80101cdf:	90                   	nop

80101ce0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ce9:	8b 0a                	mov    (%edx),%ecx
80101ceb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101cee:	8b 4a 04             	mov    0x4(%edx),%ecx
80101cf1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101cf4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101cf8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101cfb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101cff:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101d03:	8b 52 58             	mov    0x58(%edx),%edx
80101d06:	89 50 10             	mov    %edx,0x10(%eax)
}
80101d09:	5d                   	pop    %ebp
80101d0a:	c3                   	ret    
80101d0b:	90                   	nop
80101d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d10 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101d10:	55                   	push   %ebp
80101d11:	89 e5                	mov    %esp,%ebp
80101d13:	57                   	push   %edi
80101d14:	56                   	push   %esi
80101d15:	53                   	push   %ebx
80101d16:	83 ec 1c             	sub    $0x1c,%esp
80101d19:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101d1f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d22:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101d27:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101d2a:	8b 7d 14             	mov    0x14(%ebp),%edi
80101d2d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101d30:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d33:	0f 84 a7 00 00 00    	je     80101de0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101d39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d3c:	8b 40 58             	mov    0x58(%eax),%eax
80101d3f:	39 f0                	cmp    %esi,%eax
80101d41:	0f 82 c1 00 00 00    	jb     80101e08 <readi+0xf8>
80101d47:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101d4a:	89 fa                	mov    %edi,%edx
80101d4c:	01 f2                	add    %esi,%edx
80101d4e:	0f 82 b4 00 00 00    	jb     80101e08 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101d54:	89 c1                	mov    %eax,%ecx
80101d56:	29 f1                	sub    %esi,%ecx
80101d58:	39 d0                	cmp    %edx,%eax
80101d5a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d5d:	31 ff                	xor    %edi,%edi
80101d5f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101d61:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d64:	74 6d                	je     80101dd3 <readi+0xc3>
80101d66:	8d 76 00             	lea    0x0(%esi),%esi
80101d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d70:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101d73:	89 f2                	mov    %esi,%edx
80101d75:	c1 ea 09             	shr    $0x9,%edx
80101d78:	89 d8                	mov    %ebx,%eax
80101d7a:	e8 61 f5 ff ff       	call   801012e0 <bmap>
80101d7f:	83 ec 08             	sub    $0x8,%esp
80101d82:	50                   	push   %eax
80101d83:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101d85:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d8a:	e8 41 e3 ff ff       	call   801000d0 <bread>
80101d8f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101d91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d94:	89 f1                	mov    %esi,%ecx
80101d96:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101d9c:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101d9f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101da2:	29 cb                	sub    %ecx,%ebx
80101da4:	29 f8                	sub    %edi,%eax
80101da6:	39 c3                	cmp    %eax,%ebx
80101da8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101dab:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
80101daf:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101db0:	01 df                	add    %ebx,%edi
80101db2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101db4:	50                   	push   %eax
80101db5:	ff 75 e0             	pushl  -0x20(%ebp)
80101db8:	e8 d3 2a 00 00       	call   80104890 <memmove>
    brelse(bp);
80101dbd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dc0:	89 14 24             	mov    %edx,(%esp)
80101dc3:	e8 18 e4 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101dc8:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101dcb:	83 c4 10             	add    $0x10,%esp
80101dce:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101dd1:	77 9d                	ja     80101d70 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101dd3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101dd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd9:	5b                   	pop    %ebx
80101dda:	5e                   	pop    %esi
80101ddb:	5f                   	pop    %edi
80101ddc:	5d                   	pop    %ebp
80101ddd:	c3                   	ret    
80101dde:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101de0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101de4:	66 83 f8 09          	cmp    $0x9,%ax
80101de8:	77 1e                	ja     80101e08 <readi+0xf8>
80101dea:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101df1:	85 c0                	test   %eax,%eax
80101df3:	74 13                	je     80101e08 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101df5:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101df8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dfb:	5b                   	pop    %ebx
80101dfc:	5e                   	pop    %esi
80101dfd:	5f                   	pop    %edi
80101dfe:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101dff:	ff e0                	jmp    *%eax
80101e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101e08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e0d:	eb c7                	jmp    80101dd6 <readi+0xc6>
80101e0f:	90                   	nop

80101e10 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101e10:	55                   	push   %ebp
80101e11:	89 e5                	mov    %esp,%ebp
80101e13:	57                   	push   %edi
80101e14:	56                   	push   %esi
80101e15:	53                   	push   %ebx
80101e16:	83 ec 1c             	sub    $0x1c,%esp
80101e19:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101e1f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e22:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101e27:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101e2a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101e2d:	8b 75 10             	mov    0x10(%ebp),%esi
80101e30:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e33:	0f 84 b7 00 00 00    	je     80101ef0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101e39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e3c:	39 70 58             	cmp    %esi,0x58(%eax)
80101e3f:	0f 82 eb 00 00 00    	jb     80101f30 <writei+0x120>
80101e45:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101e48:	89 f8                	mov    %edi,%eax
80101e4a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101e4c:	3d 00 14 81 40       	cmp    $0x40811400,%eax
80101e51:	0f 87 d9 00 00 00    	ja     80101f30 <writei+0x120>
80101e57:	39 c6                	cmp    %eax,%esi
80101e59:	0f 87 d1 00 00 00    	ja     80101f30 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e5f:	85 ff                	test   %edi,%edi
80101e61:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101e68:	74 78                	je     80101ee2 <writei+0xd2>
80101e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e70:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101e73:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101e75:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e7a:	c1 ea 09             	shr    $0x9,%edx
80101e7d:	89 f8                	mov    %edi,%eax
80101e7f:	e8 5c f4 ff ff       	call   801012e0 <bmap>
80101e84:	83 ec 08             	sub    $0x8,%esp
80101e87:	50                   	push   %eax
80101e88:	ff 37                	pushl  (%edi)
80101e8a:	e8 41 e2 ff ff       	call   801000d0 <bread>
80101e8f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101e91:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e94:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101e97:	89 f1                	mov    %esi,%ecx
80101e99:	83 c4 0c             	add    $0xc,%esp
80101e9c:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ea2:	29 cb                	sub    %ecx,%ebx
80101ea4:	39 c3                	cmp    %eax,%ebx
80101ea6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ea9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101ead:	53                   	push   %ebx
80101eae:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101eb1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101eb3:	50                   	push   %eax
80101eb4:	e8 d7 29 00 00       	call   80104890 <memmove>
    log_write(bp);
80101eb9:	89 3c 24             	mov    %edi,(%esp)
80101ebc:	e8 2f 12 00 00       	call   801030f0 <log_write>
    brelse(bp);
80101ec1:	89 3c 24             	mov    %edi,(%esp)
80101ec4:	e8 17 e3 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ec9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101ecc:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101ecf:	83 c4 10             	add    $0x10,%esp
80101ed2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ed5:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101ed8:	77 96                	ja     80101e70 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101eda:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101edd:	3b 70 58             	cmp    0x58(%eax),%esi
80101ee0:	77 36                	ja     80101f18 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ee2:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ee5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ee8:	5b                   	pop    %ebx
80101ee9:	5e                   	pop    %esi
80101eea:	5f                   	pop    %edi
80101eeb:	5d                   	pop    %ebp
80101eec:	c3                   	ret    
80101eed:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ef0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ef4:	66 83 f8 09          	cmp    $0x9,%ax
80101ef8:	77 36                	ja     80101f30 <writei+0x120>
80101efa:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101f01:	85 c0                	test   %eax,%eax
80101f03:	74 2b                	je     80101f30 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101f05:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101f08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f0b:	5b                   	pop    %ebx
80101f0c:	5e                   	pop    %esi
80101f0d:	5f                   	pop    %edi
80101f0e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101f0f:	ff e0                	jmp    *%eax
80101f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101f18:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101f1b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101f1e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101f21:	50                   	push   %eax
80101f22:	e8 69 f8 ff ff       	call   80101790 <iupdate>
80101f27:	83 c4 10             	add    $0x10,%esp
80101f2a:	eb b6                	jmp    80101ee2 <writei+0xd2>
80101f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f35:	eb ae                	jmp    80101ee5 <writei+0xd5>
80101f37:	89 f6                	mov    %esi,%esi
80101f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f40 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101f46:	6a 0e                	push   $0xe
80101f48:	ff 75 0c             	pushl  0xc(%ebp)
80101f4b:	ff 75 08             	pushl  0x8(%ebp)
80101f4e:	e8 bd 29 00 00       	call   80104910 <strncmp>
}
80101f53:	c9                   	leave  
80101f54:	c3                   	ret    
80101f55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f60 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	57                   	push   %edi
80101f64:	56                   	push   %esi
80101f65:	53                   	push   %ebx
80101f66:	83 ec 1c             	sub    $0x1c,%esp
80101f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101f6c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101f71:	0f 85 80 00 00 00    	jne    80101ff7 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101f77:	8b 53 58             	mov    0x58(%ebx),%edx
80101f7a:	31 ff                	xor    %edi,%edi
80101f7c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f7f:	85 d2                	test   %edx,%edx
80101f81:	75 0d                	jne    80101f90 <dirlookup+0x30>
80101f83:	eb 5b                	jmp    80101fe0 <dirlookup+0x80>
80101f85:	8d 76 00             	lea    0x0(%esi),%esi
80101f88:	83 c7 10             	add    $0x10,%edi
80101f8b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101f8e:	76 50                	jbe    80101fe0 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f90:	6a 10                	push   $0x10
80101f92:	57                   	push   %edi
80101f93:	56                   	push   %esi
80101f94:	53                   	push   %ebx
80101f95:	e8 76 fd ff ff       	call   80101d10 <readi>
80101f9a:	83 c4 10             	add    $0x10,%esp
80101f9d:	83 f8 10             	cmp    $0x10,%eax
80101fa0:	75 48                	jne    80101fea <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101fa2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fa7:	74 df                	je     80101f88 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101fa9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fac:	83 ec 04             	sub    $0x4,%esp
80101faf:	6a 0e                	push   $0xe
80101fb1:	50                   	push   %eax
80101fb2:	ff 75 0c             	pushl  0xc(%ebp)
80101fb5:	e8 56 29 00 00       	call   80104910 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101fba:	83 c4 10             	add    $0x10,%esp
80101fbd:	85 c0                	test   %eax,%eax
80101fbf:	75 c7                	jne    80101f88 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101fc1:	8b 45 10             	mov    0x10(%ebp),%eax
80101fc4:	85 c0                	test   %eax,%eax
80101fc6:	74 05                	je     80101fcd <dirlookup+0x6d>
        *poff = off;
80101fc8:	8b 45 10             	mov    0x10(%ebp),%eax
80101fcb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101fcd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101fd1:	8b 03                	mov    (%ebx),%eax
80101fd3:	e8 38 f2 ff ff       	call   80101210 <iget>
    }
  }

  return 0;
}
80101fd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fdb:	5b                   	pop    %ebx
80101fdc:	5e                   	pop    %esi
80101fdd:	5f                   	pop    %edi
80101fde:	5d                   	pop    %ebp
80101fdf:	c3                   	ret    
80101fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101fe3:	31 c0                	xor    %eax,%eax
}
80101fe5:	5b                   	pop    %ebx
80101fe6:	5e                   	pop    %esi
80101fe7:	5f                   	pop    %edi
80101fe8:	5d                   	pop    %ebp
80101fe9:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101fea:	83 ec 0c             	sub    $0xc,%esp
80101fed:	68 f9 73 10 80       	push   $0x801073f9
80101ff2:	e8 79 e3 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101ff7:	83 ec 0c             	sub    $0xc,%esp
80101ffa:	68 e7 73 10 80       	push   $0x801073e7
80101fff:	e8 6c e3 ff ff       	call   80100370 <panic>
80102004:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010200a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102010 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	57                   	push   %edi
80102014:	56                   	push   %esi
80102015:	53                   	push   %ebx
80102016:	89 cf                	mov    %ecx,%edi
80102018:	89 c3                	mov    %eax,%ebx
8010201a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010201d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102020:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80102023:	0f 84 53 01 00 00    	je     8010217c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102029:	e8 12 1b 00 00       	call   80103b40 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
8010202e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102031:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80102034:	68 e0 09 11 80       	push   $0x801109e0
80102039:	e8 a2 26 00 00       	call   801046e0 <acquire>
  ip->ref++;
8010203e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102042:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80102049:	e8 42 27 00 00       	call   80104790 <release>
8010204e:	83 c4 10             	add    $0x10,%esp
80102051:	eb 08                	jmp    8010205b <namex+0x4b>
80102053:	90                   	nop
80102054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80102058:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
8010205b:	0f b6 03             	movzbl (%ebx),%eax
8010205e:	3c 2f                	cmp    $0x2f,%al
80102060:	74 f6                	je     80102058 <namex+0x48>
    path++;
  if(*path == 0)
80102062:	84 c0                	test   %al,%al
80102064:	0f 84 e3 00 00 00    	je     8010214d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
8010206a:	0f b6 03             	movzbl (%ebx),%eax
8010206d:	89 da                	mov    %ebx,%edx
8010206f:	84 c0                	test   %al,%al
80102071:	0f 84 ac 00 00 00    	je     80102123 <namex+0x113>
80102077:	3c 2f                	cmp    $0x2f,%al
80102079:	75 09                	jne    80102084 <namex+0x74>
8010207b:	e9 a3 00 00 00       	jmp    80102123 <namex+0x113>
80102080:	84 c0                	test   %al,%al
80102082:	74 0a                	je     8010208e <namex+0x7e>
    path++;
80102084:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102087:	0f b6 02             	movzbl (%edx),%eax
8010208a:	3c 2f                	cmp    $0x2f,%al
8010208c:	75 f2                	jne    80102080 <namex+0x70>
8010208e:	89 d1                	mov    %edx,%ecx
80102090:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80102092:	83 f9 0d             	cmp    $0xd,%ecx
80102095:	0f 8e 8d 00 00 00    	jle    80102128 <namex+0x118>
    memmove(name, s, DIRSIZ);
8010209b:	83 ec 04             	sub    $0x4,%esp
8010209e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801020a1:	6a 0e                	push   $0xe
801020a3:	53                   	push   %ebx
801020a4:	57                   	push   %edi
801020a5:	e8 e6 27 00 00       	call   80104890 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
801020aa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
801020ad:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
801020b0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801020b2:	80 3a 2f             	cmpb   $0x2f,(%edx)
801020b5:	75 11                	jne    801020c8 <namex+0xb8>
801020b7:	89 f6                	mov    %esi,%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
801020c0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801020c3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801020c6:	74 f8                	je     801020c0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801020c8:	83 ec 0c             	sub    $0xc,%esp
801020cb:	56                   	push   %esi
801020cc:	e8 6f f7 ff ff       	call   80101840 <ilock>
    if(ip->type != T_DIR){
801020d1:	83 c4 10             	add    $0x10,%esp
801020d4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801020d9:	0f 85 7f 00 00 00    	jne    8010215e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
801020df:	8b 55 e0             	mov    -0x20(%ebp),%edx
801020e2:	85 d2                	test   %edx,%edx
801020e4:	74 09                	je     801020ef <namex+0xdf>
801020e6:	80 3b 00             	cmpb   $0x0,(%ebx)
801020e9:	0f 84 a3 00 00 00    	je     80102192 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801020ef:	83 ec 04             	sub    $0x4,%esp
801020f2:	6a 00                	push   $0x0
801020f4:	57                   	push   %edi
801020f5:	56                   	push   %esi
801020f6:	e8 65 fe ff ff       	call   80101f60 <dirlookup>
801020fb:	83 c4 10             	add    $0x10,%esp
801020fe:	85 c0                	test   %eax,%eax
80102100:	74 5c                	je     8010215e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80102102:	83 ec 0c             	sub    $0xc,%esp
80102105:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102108:	56                   	push   %esi
80102109:	e8 12 f8 ff ff       	call   80101920 <iunlock>
  iput(ip);
8010210e:	89 34 24             	mov    %esi,(%esp)
80102111:	e8 5a f8 ff ff       	call   80101970 <iput>
80102116:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102119:	83 c4 10             	add    $0x10,%esp
8010211c:	89 c6                	mov    %eax,%esi
8010211e:	e9 38 ff ff ff       	jmp    8010205b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102123:	31 c9                	xor    %ecx,%ecx
80102125:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80102128:	83 ec 04             	sub    $0x4,%esp
8010212b:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010212e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102131:	51                   	push   %ecx
80102132:	53                   	push   %ebx
80102133:	57                   	push   %edi
80102134:	e8 57 27 00 00       	call   80104890 <memmove>
    name[len] = 0;
80102139:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010213c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010213f:	83 c4 10             	add    $0x10,%esp
80102142:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80102146:	89 d3                	mov    %edx,%ebx
80102148:	e9 65 ff ff ff       	jmp    801020b2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
8010214d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102150:	85 c0                	test   %eax,%eax
80102152:	75 54                	jne    801021a8 <namex+0x198>
80102154:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80102156:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102159:	5b                   	pop    %ebx
8010215a:	5e                   	pop    %esi
8010215b:	5f                   	pop    %edi
8010215c:	5d                   	pop    %ebp
8010215d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
8010215e:	83 ec 0c             	sub    $0xc,%esp
80102161:	56                   	push   %esi
80102162:	e8 b9 f7 ff ff       	call   80101920 <iunlock>
  iput(ip);
80102167:	89 34 24             	mov    %esi,(%esp)
8010216a:	e8 01 f8 ff ff       	call   80101970 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
8010216f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102172:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80102175:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102177:	5b                   	pop    %ebx
80102178:	5e                   	pop    %esi
80102179:	5f                   	pop    %edi
8010217a:	5d                   	pop    %ebp
8010217b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
8010217c:	ba 01 00 00 00       	mov    $0x1,%edx
80102181:	b8 01 00 00 00       	mov    $0x1,%eax
80102186:	e8 85 f0 ff ff       	call   80101210 <iget>
8010218b:	89 c6                	mov    %eax,%esi
8010218d:	e9 c9 fe ff ff       	jmp    8010205b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80102192:	83 ec 0c             	sub    $0xc,%esp
80102195:	56                   	push   %esi
80102196:	e8 85 f7 ff ff       	call   80101920 <iunlock>
      return ip;
8010219b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
8010219e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
801021a1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
801021a3:	5b                   	pop    %ebx
801021a4:	5e                   	pop    %esi
801021a5:	5f                   	pop    %edi
801021a6:	5d                   	pop    %ebp
801021a7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
801021a8:	83 ec 0c             	sub    $0xc,%esp
801021ab:	56                   	push   %esi
801021ac:	e8 bf f7 ff ff       	call   80101970 <iput>
    return 0;
801021b1:	83 c4 10             	add    $0x10,%esp
801021b4:	31 c0                	xor    %eax,%eax
801021b6:	eb 9e                	jmp    80102156 <namex+0x146>
801021b8:	90                   	nop
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021c0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	57                   	push   %edi
801021c4:	56                   	push   %esi
801021c5:	53                   	push   %ebx
801021c6:	83 ec 20             	sub    $0x20,%esp
801021c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
801021cc:	6a 00                	push   $0x0
801021ce:	ff 75 0c             	pushl  0xc(%ebp)
801021d1:	53                   	push   %ebx
801021d2:	e8 89 fd ff ff       	call   80101f60 <dirlookup>
801021d7:	83 c4 10             	add    $0x10,%esp
801021da:	85 c0                	test   %eax,%eax
801021dc:	75 67                	jne    80102245 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801021de:	8b 7b 58             	mov    0x58(%ebx),%edi
801021e1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021e4:	85 ff                	test   %edi,%edi
801021e6:	74 29                	je     80102211 <dirlink+0x51>
801021e8:	31 ff                	xor    %edi,%edi
801021ea:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021ed:	eb 09                	jmp    801021f8 <dirlink+0x38>
801021ef:	90                   	nop
801021f0:	83 c7 10             	add    $0x10,%edi
801021f3:	39 7b 58             	cmp    %edi,0x58(%ebx)
801021f6:	76 19                	jbe    80102211 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021f8:	6a 10                	push   $0x10
801021fa:	57                   	push   %edi
801021fb:	56                   	push   %esi
801021fc:	53                   	push   %ebx
801021fd:	e8 0e fb ff ff       	call   80101d10 <readi>
80102202:	83 c4 10             	add    $0x10,%esp
80102205:	83 f8 10             	cmp    $0x10,%eax
80102208:	75 4e                	jne    80102258 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
8010220a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010220f:	75 df                	jne    801021f0 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80102211:	8d 45 da             	lea    -0x26(%ebp),%eax
80102214:	83 ec 04             	sub    $0x4,%esp
80102217:	6a 0e                	push   $0xe
80102219:	ff 75 0c             	pushl  0xc(%ebp)
8010221c:	50                   	push   %eax
8010221d:	e8 5e 27 00 00       	call   80104980 <strncpy>
  de.inum = inum;
80102222:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102225:	6a 10                	push   $0x10
80102227:	57                   	push   %edi
80102228:	56                   	push   %esi
80102229:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
8010222a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010222e:	e8 dd fb ff ff       	call   80101e10 <writei>
80102233:	83 c4 20             	add    $0x20,%esp
80102236:	83 f8 10             	cmp    $0x10,%eax
80102239:	75 2a                	jne    80102265 <dirlink+0xa5>
    panic("dirlink");

  return 0;
8010223b:	31 c0                	xor    %eax,%eax
}
8010223d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102240:	5b                   	pop    %ebx
80102241:	5e                   	pop    %esi
80102242:	5f                   	pop    %edi
80102243:	5d                   	pop    %ebp
80102244:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80102245:	83 ec 0c             	sub    $0xc,%esp
80102248:	50                   	push   %eax
80102249:	e8 22 f7 ff ff       	call   80101970 <iput>
    return -1;
8010224e:	83 c4 10             	add    $0x10,%esp
80102251:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102256:	eb e5                	jmp    8010223d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80102258:	83 ec 0c             	sub    $0xc,%esp
8010225b:	68 08 74 10 80       	push   $0x80107408
80102260:	e8 0b e1 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80102265:	83 ec 0c             	sub    $0xc,%esp
80102268:	68 fe 79 10 80       	push   $0x801079fe
8010226d:	e8 fe e0 ff ff       	call   80100370 <panic>
80102272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102280 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80102280:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102281:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80102283:	89 e5                	mov    %esp,%ebp
80102285:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102288:	8b 45 08             	mov    0x8(%ebp),%eax
8010228b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010228e:	e8 7d fd ff ff       	call   80102010 <namex>
}
80102293:	c9                   	leave  
80102294:	c3                   	ret    
80102295:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022a0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801022a0:	55                   	push   %ebp
  return namex(path, 1, name);
801022a1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
801022a6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801022a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801022ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
801022ae:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
801022af:	e9 5c fd ff ff       	jmp    80102010 <namex>
801022b4:	66 90                	xchg   %ax,%ax
801022b6:	66 90                	xchg   %ax,%ax
801022b8:	66 90                	xchg   %ax,%ax
801022ba:	66 90                	xchg   %ax,%ax
801022bc:	66 90                	xchg   %ax,%ax
801022be:	66 90                	xchg   %ax,%ax

801022c0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801022c0:	55                   	push   %ebp
  if(b == 0)
801022c1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801022c3:	89 e5                	mov    %esp,%ebp
801022c5:	56                   	push   %esi
801022c6:	53                   	push   %ebx
  if(b == 0)
801022c7:	0f 84 ad 00 00 00    	je     8010237a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801022cd:	8b 58 08             	mov    0x8(%eax),%ebx
801022d0:	89 c1                	mov    %eax,%ecx
801022d2:	81 fb 3f 9c 00 00    	cmp    $0x9c3f,%ebx
801022d8:	0f 87 8f 00 00 00    	ja     8010236d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022de:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022e3:	90                   	nop
801022e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022e8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022e9:	83 e0 c0             	and    $0xffffffc0,%eax
801022ec:	3c 40                	cmp    $0x40,%al
801022ee:	75 f8                	jne    801022e8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022f0:	31 f6                	xor    %esi,%esi
801022f2:	ba f6 03 00 00       	mov    $0x3f6,%edx
801022f7:	89 f0                	mov    %esi,%eax
801022f9:	ee                   	out    %al,(%dx)
801022fa:	ba f2 01 00 00       	mov    $0x1f2,%edx
801022ff:	b8 01 00 00 00       	mov    $0x1,%eax
80102304:	ee                   	out    %al,(%dx)
80102305:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010230a:	89 d8                	mov    %ebx,%eax
8010230c:	ee                   	out    %al,(%dx)
8010230d:	89 d8                	mov    %ebx,%eax
8010230f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102314:	c1 f8 08             	sar    $0x8,%eax
80102317:	ee                   	out    %al,(%dx)
80102318:	ba f5 01 00 00       	mov    $0x1f5,%edx
8010231d:	89 f0                	mov    %esi,%eax
8010231f:	ee                   	out    %al,(%dx)
80102320:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102324:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102329:	83 e0 01             	and    $0x1,%eax
8010232c:	c1 e0 04             	shl    $0x4,%eax
8010232f:	83 c8 e0             	or     $0xffffffe0,%eax
80102332:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80102333:	f6 01 04             	testb  $0x4,(%ecx)
80102336:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010233b:	75 13                	jne    80102350 <idestart+0x90>
8010233d:	b8 20 00 00 00       	mov    $0x20,%eax
80102342:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102343:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102346:	5b                   	pop    %ebx
80102347:	5e                   	pop    %esi
80102348:	5d                   	pop    %ebp
80102349:	c3                   	ret    
8010234a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102350:	b8 30 00 00 00       	mov    $0x30,%eax
80102355:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102356:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
8010235b:	8d 71 5c             	lea    0x5c(%ecx),%esi
8010235e:	b9 80 00 00 00       	mov    $0x80,%ecx
80102363:	fc                   	cld    
80102364:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102366:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102369:	5b                   	pop    %ebx
8010236a:	5e                   	pop    %esi
8010236b:	5d                   	pop    %ebp
8010236c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010236d:	83 ec 0c             	sub    $0xc,%esp
80102370:	68 74 74 10 80       	push   $0x80107474
80102375:	e8 f6 df ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010237a:	83 ec 0c             	sub    $0xc,%esp
8010237d:	68 6b 74 10 80       	push   $0x8010746b
80102382:	e8 e9 df ff ff       	call   80100370 <panic>
80102387:	89 f6                	mov    %esi,%esi
80102389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102390 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102396:	68 86 74 10 80       	push   $0x80107486
8010239b:	68 80 a5 10 80       	push   $0x8010a580
801023a0:	e8 db 21 00 00       	call   80104580 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801023a5:	58                   	pop    %eax
801023a6:	a1 00 2d 11 80       	mov    0x80112d00,%eax
801023ab:	5a                   	pop    %edx
801023ac:	83 e8 01             	sub    $0x1,%eax
801023af:	50                   	push   %eax
801023b0:	6a 0e                	push   $0xe
801023b2:	e8 a9 02 00 00       	call   80102660 <ioapicenable>
801023b7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023ba:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023bf:	90                   	nop
801023c0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023c1:	83 e0 c0             	and    $0xffffffc0,%eax
801023c4:	3c 40                	cmp    $0x40,%al
801023c6:	75 f8                	jne    801023c0 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023c8:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023cd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801023d2:	ee                   	out    %al,(%dx)
801023d3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023d8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023dd:	eb 06                	jmp    801023e5 <ideinit+0x55>
801023df:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801023e0:	83 e9 01             	sub    $0x1,%ecx
801023e3:	74 0f                	je     801023f4 <ideinit+0x64>
801023e5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801023e6:	84 c0                	test   %al,%al
801023e8:	74 f6                	je     801023e0 <ideinit+0x50>
      havedisk1 = 1;
801023ea:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
801023f1:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023f4:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023f9:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801023fe:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
801023ff:	c9                   	leave  
80102400:	c3                   	ret    
80102401:	eb 0d                	jmp    80102410 <ideintr>
80102403:	90                   	nop
80102404:	90                   	nop
80102405:	90                   	nop
80102406:	90                   	nop
80102407:	90                   	nop
80102408:	90                   	nop
80102409:	90                   	nop
8010240a:	90                   	nop
8010240b:	90                   	nop
8010240c:	90                   	nop
8010240d:	90                   	nop
8010240e:	90                   	nop
8010240f:	90                   	nop

80102410 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	57                   	push   %edi
80102414:	56                   	push   %esi
80102415:	53                   	push   %ebx
80102416:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102419:	68 80 a5 10 80       	push   $0x8010a580
8010241e:	e8 bd 22 00 00       	call   801046e0 <acquire>

  if((b = idequeue) == 0){
80102423:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102429:	83 c4 10             	add    $0x10,%esp
8010242c:	85 db                	test   %ebx,%ebx
8010242e:	74 34                	je     80102464 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102430:	8b 43 58             	mov    0x58(%ebx),%eax
80102433:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102438:	8b 33                	mov    (%ebx),%esi
8010243a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102440:	74 3e                	je     80102480 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102442:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102445:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102448:	83 ce 02             	or     $0x2,%esi
8010244b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010244d:	53                   	push   %ebx
8010244e:	e8 4d 1e 00 00       	call   801042a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102453:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102458:	83 c4 10             	add    $0x10,%esp
8010245b:	85 c0                	test   %eax,%eax
8010245d:	74 05                	je     80102464 <ideintr+0x54>
    idestart(idequeue);
8010245f:	e8 5c fe ff ff       	call   801022c0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102464:	83 ec 0c             	sub    $0xc,%esp
80102467:	68 80 a5 10 80       	push   $0x8010a580
8010246c:	e8 1f 23 00 00       	call   80104790 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102471:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102474:	5b                   	pop    %ebx
80102475:	5e                   	pop    %esi
80102476:	5f                   	pop    %edi
80102477:	5d                   	pop    %ebp
80102478:	c3                   	ret    
80102479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102480:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102485:	8d 76 00             	lea    0x0(%esi),%esi
80102488:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102489:	89 c1                	mov    %eax,%ecx
8010248b:	83 e1 c0             	and    $0xffffffc0,%ecx
8010248e:	80 f9 40             	cmp    $0x40,%cl
80102491:	75 f5                	jne    80102488 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102493:	a8 21                	test   $0x21,%al
80102495:	75 ab                	jne    80102442 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102497:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010249a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010249f:	ba f0 01 00 00       	mov    $0x1f0,%edx
801024a4:	fc                   	cld    
801024a5:	f3 6d                	rep insl (%dx),%es:(%edi)
801024a7:	8b 33                	mov    (%ebx),%esi
801024a9:	eb 97                	jmp    80102442 <ideintr+0x32>
801024ab:	90                   	nop
801024ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024b0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	53                   	push   %ebx
801024b4:	83 ec 10             	sub    $0x10,%esp
801024b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801024ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801024bd:	50                   	push   %eax
801024be:	e8 6d 20 00 00       	call   80104530 <holdingsleep>
801024c3:	83 c4 10             	add    $0x10,%esp
801024c6:	85 c0                	test   %eax,%eax
801024c8:	0f 84 ad 00 00 00    	je     8010257b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801024ce:	8b 03                	mov    (%ebx),%eax
801024d0:	83 e0 06             	and    $0x6,%eax
801024d3:	83 f8 02             	cmp    $0x2,%eax
801024d6:	0f 84 b9 00 00 00    	je     80102595 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801024dc:	8b 53 04             	mov    0x4(%ebx),%edx
801024df:	85 d2                	test   %edx,%edx
801024e1:	74 0d                	je     801024f0 <iderw+0x40>
801024e3:	a1 60 a5 10 80       	mov    0x8010a560,%eax
801024e8:	85 c0                	test   %eax,%eax
801024ea:	0f 84 98 00 00 00    	je     80102588 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	68 80 a5 10 80       	push   $0x8010a580
801024f8:	e8 e3 21 00 00       	call   801046e0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024fd:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102503:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102506:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010250d:	85 d2                	test   %edx,%edx
8010250f:	75 09                	jne    8010251a <iderw+0x6a>
80102511:	eb 58                	jmp    8010256b <iderw+0xbb>
80102513:	90                   	nop
80102514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102518:	89 c2                	mov    %eax,%edx
8010251a:	8b 42 58             	mov    0x58(%edx),%eax
8010251d:	85 c0                	test   %eax,%eax
8010251f:	75 f7                	jne    80102518 <iderw+0x68>
80102521:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102524:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102526:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010252c:	74 44                	je     80102572 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010252e:	8b 03                	mov    (%ebx),%eax
80102530:	83 e0 06             	and    $0x6,%eax
80102533:	83 f8 02             	cmp    $0x2,%eax
80102536:	74 23                	je     8010255b <iderw+0xab>
80102538:	90                   	nop
80102539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102540:	83 ec 08             	sub    $0x8,%esp
80102543:	68 80 a5 10 80       	push   $0x8010a580
80102548:	53                   	push   %ebx
80102549:	e8 a2 1b 00 00       	call   801040f0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010254e:	8b 03                	mov    (%ebx),%eax
80102550:	83 c4 10             	add    $0x10,%esp
80102553:	83 e0 06             	and    $0x6,%eax
80102556:	83 f8 02             	cmp    $0x2,%eax
80102559:	75 e5                	jne    80102540 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010255b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102562:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102565:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102566:	e9 25 22 00 00       	jmp    80104790 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010256b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102570:	eb b2                	jmp    80102524 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102572:	89 d8                	mov    %ebx,%eax
80102574:	e8 47 fd ff ff       	call   801022c0 <idestart>
80102579:	eb b3                	jmp    8010252e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010257b:	83 ec 0c             	sub    $0xc,%esp
8010257e:	68 8a 74 10 80       	push   $0x8010748a
80102583:	e8 e8 dd ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102588:	83 ec 0c             	sub    $0xc,%esp
8010258b:	68 b5 74 10 80       	push   $0x801074b5
80102590:	e8 db dd ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102595:	83 ec 0c             	sub    $0xc,%esp
80102598:	68 a0 74 10 80       	push   $0x801074a0
8010259d:	e8 ce dd ff ff       	call   80100370 <panic>
801025a2:	66 90                	xchg   %ax,%ax
801025a4:	66 90                	xchg   %ax,%ax
801025a6:	66 90                	xchg   %ax,%ax
801025a8:	66 90                	xchg   %ax,%ax
801025aa:	66 90                	xchg   %ax,%ax
801025ac:	66 90                	xchg   %ax,%ax
801025ae:	66 90                	xchg   %ax,%ax

801025b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801025b0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801025b1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801025b8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801025bb:	89 e5                	mov    %esp,%ebp
801025bd:	56                   	push   %esi
801025be:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801025bf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801025c6:	00 00 00 
  return ioapic->data;
801025c9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801025cf:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801025d2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801025d8:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801025de:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801025e5:	89 f0                	mov    %esi,%eax
801025e7:	c1 e8 10             	shr    $0x10,%eax
801025ea:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
801025ed:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801025f0:	c1 e8 18             	shr    $0x18,%eax
801025f3:	39 d0                	cmp    %edx,%eax
801025f5:	74 16                	je     8010260d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801025f7:	83 ec 0c             	sub    $0xc,%esp
801025fa:	68 d4 74 10 80       	push   $0x801074d4
801025ff:	e8 5c e0 ff ff       	call   80100660 <cprintf>
80102604:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010260a:	83 c4 10             	add    $0x10,%esp
8010260d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102610:	ba 10 00 00 00       	mov    $0x10,%edx
80102615:	b8 20 00 00 00       	mov    $0x20,%eax
8010261a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102620:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102622:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102628:	89 c3                	mov    %eax,%ebx
8010262a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102630:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102633:	89 59 10             	mov    %ebx,0x10(%ecx)
80102636:	8d 5a 01             	lea    0x1(%edx),%ebx
80102639:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010263c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010263e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102640:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102646:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010264d:	75 d1                	jne    80102620 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010264f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102652:	5b                   	pop    %ebx
80102653:	5e                   	pop    %esi
80102654:	5d                   	pop    %ebp
80102655:	c3                   	ret    
80102656:	8d 76 00             	lea    0x0(%esi),%esi
80102659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102660 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102660:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102661:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102667:	89 e5                	mov    %esp,%ebp
80102669:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010266c:	8d 50 20             	lea    0x20(%eax),%edx
8010266f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102673:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102675:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010267b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010267e:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102681:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102684:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102686:	a1 34 26 11 80       	mov    0x80112634,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010268b:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010268e:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102691:	5d                   	pop    %ebp
80102692:	c3                   	ret    
80102693:	66 90                	xchg   %ax,%ax
80102695:	66 90                	xchg   %ax,%ax
80102697:	66 90                	xchg   %ax,%ax
80102699:	66 90                	xchg   %ax,%ax
8010269b:	66 90                	xchg   %ax,%ax
8010269d:	66 90                	xchg   %ax,%ax
8010269f:	90                   	nop

801026a0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	53                   	push   %ebx
801026a4:	83 ec 04             	sub    $0x4,%esp
801026a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801026aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801026b0:	75 70                	jne    80102722 <kfree+0x82>
801026b2:	81 fb a8 54 11 80    	cmp    $0x801154a8,%ebx
801026b8:	72 68                	jb     80102722 <kfree+0x82>
801026ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801026c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801026c5:	77 5b                	ja     80102722 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801026c7:	83 ec 04             	sub    $0x4,%esp
801026ca:	68 00 10 00 00       	push   $0x1000
801026cf:	6a 01                	push   $0x1
801026d1:	53                   	push   %ebx
801026d2:	e8 09 21 00 00       	call   801047e0 <memset>

  if(kmem.use_lock)
801026d7:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801026dd:	83 c4 10             	add    $0x10,%esp
801026e0:	85 d2                	test   %edx,%edx
801026e2:	75 2c                	jne    80102710 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801026e4:	a1 78 26 11 80       	mov    0x80112678,%eax
801026e9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801026eb:	a1 74 26 11 80       	mov    0x80112674,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
801026f0:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
801026f6:	85 c0                	test   %eax,%eax
801026f8:	75 06                	jne    80102700 <kfree+0x60>
    release(&kmem.lock);
}
801026fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026fd:	c9                   	leave  
801026fe:	c3                   	ret    
801026ff:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102700:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102707:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010270a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010270b:	e9 80 20 00 00       	jmp    80104790 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102710:	83 ec 0c             	sub    $0xc,%esp
80102713:	68 40 26 11 80       	push   $0x80112640
80102718:	e8 c3 1f 00 00       	call   801046e0 <acquire>
8010271d:	83 c4 10             	add    $0x10,%esp
80102720:	eb c2                	jmp    801026e4 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102722:	83 ec 0c             	sub    $0xc,%esp
80102725:	68 06 75 10 80       	push   $0x80107506
8010272a:	e8 41 dc ff ff       	call   80100370 <panic>
8010272f:	90                   	nop

80102730 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102730:	55                   	push   %ebp
80102731:	89 e5                	mov    %esp,%ebp
80102733:	56                   	push   %esi
80102734:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102735:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102738:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010273b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102741:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102747:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010274d:	39 de                	cmp    %ebx,%esi
8010274f:	72 23                	jb     80102774 <freerange+0x44>
80102751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102758:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010275e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102761:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102767:	50                   	push   %eax
80102768:	e8 33 ff ff ff       	call   801026a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010276d:	83 c4 10             	add    $0x10,%esp
80102770:	39 f3                	cmp    %esi,%ebx
80102772:	76 e4                	jbe    80102758 <freerange+0x28>
    kfree(p);
}
80102774:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102777:	5b                   	pop    %ebx
80102778:	5e                   	pop    %esi
80102779:	5d                   	pop    %ebp
8010277a:	c3                   	ret    
8010277b:	90                   	nop
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102780 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	56                   	push   %esi
80102784:	53                   	push   %ebx
80102785:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102788:	83 ec 08             	sub    $0x8,%esp
8010278b:	68 0c 75 10 80       	push   $0x8010750c
80102790:	68 40 26 11 80       	push   $0x80112640
80102795:	e8 e6 1d 00 00       	call   80104580 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010279a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010279d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801027a0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801027a7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801027aa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027b0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027b6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027bc:	39 de                	cmp    %ebx,%esi
801027be:	72 1c                	jb     801027dc <kinit1+0x5c>
    kfree(p);
801027c0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801027c6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027cf:	50                   	push   %eax
801027d0:	e8 cb fe ff ff       	call   801026a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027d5:	83 c4 10             	add    $0x10,%esp
801027d8:	39 de                	cmp    %ebx,%esi
801027da:	73 e4                	jae    801027c0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
801027dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027df:	5b                   	pop    %ebx
801027e0:	5e                   	pop    %esi
801027e1:	5d                   	pop    %ebp
801027e2:	c3                   	ret    
801027e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801027e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027f0 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801027f0:	55                   	push   %ebp
801027f1:	89 e5                	mov    %esp,%ebp
801027f3:	56                   	push   %esi
801027f4:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801027f5:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801027f8:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801027fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102801:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102807:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010280d:	39 de                	cmp    %ebx,%esi
8010280f:	72 23                	jb     80102834 <kinit2+0x44>
80102811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102818:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010281e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102821:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102827:	50                   	push   %eax
80102828:	e8 73 fe ff ff       	call   801026a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010282d:	83 c4 10             	add    $0x10,%esp
80102830:	39 de                	cmp    %ebx,%esi
80102832:	73 e4                	jae    80102818 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102834:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010283b:	00 00 00 
}
8010283e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102841:	5b                   	pop    %ebx
80102842:	5e                   	pop    %esi
80102843:	5d                   	pop    %ebp
80102844:	c3                   	ret    
80102845:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102850 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102850:	55                   	push   %ebp
80102851:	89 e5                	mov    %esp,%ebp
80102853:	53                   	push   %ebx
80102854:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102857:	a1 74 26 11 80       	mov    0x80112674,%eax
8010285c:	85 c0                	test   %eax,%eax
8010285e:	75 30                	jne    80102890 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102860:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
80102866:	85 db                	test   %ebx,%ebx
80102868:	74 1c                	je     80102886 <kalloc+0x36>
    kmem.freelist = r->next;
8010286a:	8b 13                	mov    (%ebx),%edx
8010286c:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
80102872:	85 c0                	test   %eax,%eax
80102874:	74 10                	je     80102886 <kalloc+0x36>
    release(&kmem.lock);
80102876:	83 ec 0c             	sub    $0xc,%esp
80102879:	68 40 26 11 80       	push   $0x80112640
8010287e:	e8 0d 1f 00 00       	call   80104790 <release>
80102883:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102886:	89 d8                	mov    %ebx,%eax
80102888:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010288b:	c9                   	leave  
8010288c:	c3                   	ret    
8010288d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102890:	83 ec 0c             	sub    $0xc,%esp
80102893:	68 40 26 11 80       	push   $0x80112640
80102898:	e8 43 1e 00 00       	call   801046e0 <acquire>
  r = kmem.freelist;
8010289d:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801028a3:	83 c4 10             	add    $0x10,%esp
801028a6:	a1 74 26 11 80       	mov    0x80112674,%eax
801028ab:	85 db                	test   %ebx,%ebx
801028ad:	75 bb                	jne    8010286a <kalloc+0x1a>
801028af:	eb c1                	jmp    80102872 <kalloc+0x22>
801028b1:	66 90                	xchg   %ax,%ax
801028b3:	66 90                	xchg   %ax,%ax
801028b5:	66 90                	xchg   %ax,%ax
801028b7:	66 90                	xchg   %ax,%ax
801028b9:	66 90                	xchg   %ax,%ax
801028bb:	66 90                	xchg   %ax,%ax
801028bd:	66 90                	xchg   %ax,%ax
801028bf:	90                   	nop

801028c0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801028c0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c1:	ba 64 00 00 00       	mov    $0x64,%edx
801028c6:	89 e5                	mov    %esp,%ebp
801028c8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801028c9:	a8 01                	test   $0x1,%al
801028cb:	0f 84 af 00 00 00    	je     80102980 <kbdgetc+0xc0>
801028d1:	ba 60 00 00 00       	mov    $0x60,%edx
801028d6:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801028d7:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801028da:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801028e0:	74 7e                	je     80102960 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801028e2:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801028e4:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801028ea:	79 24                	jns    80102910 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801028ec:	f6 c1 40             	test   $0x40,%cl
801028ef:	75 05                	jne    801028f6 <kbdgetc+0x36>
801028f1:	89 c2                	mov    %eax,%edx
801028f3:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801028f6:	0f b6 82 40 76 10 80 	movzbl -0x7fef89c0(%edx),%eax
801028fd:	83 c8 40             	or     $0x40,%eax
80102900:	0f b6 c0             	movzbl %al,%eax
80102903:	f7 d0                	not    %eax
80102905:	21 c8                	and    %ecx,%eax
80102907:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010290c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010290e:	5d                   	pop    %ebp
8010290f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102910:	f6 c1 40             	test   $0x40,%cl
80102913:	74 09                	je     8010291e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102915:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102918:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010291b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010291e:	0f b6 82 40 76 10 80 	movzbl -0x7fef89c0(%edx),%eax
80102925:	09 c1                	or     %eax,%ecx
80102927:	0f b6 82 40 75 10 80 	movzbl -0x7fef8ac0(%edx),%eax
8010292e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102930:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102932:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102938:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010293b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010293e:	8b 04 85 20 75 10 80 	mov    -0x7fef8ae0(,%eax,4),%eax
80102945:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102949:	74 c3                	je     8010290e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010294b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010294e:	83 fa 19             	cmp    $0x19,%edx
80102951:	77 1d                	ja     80102970 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102953:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102956:	5d                   	pop    %ebp
80102957:	c3                   	ret    
80102958:	90                   	nop
80102959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102960:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102962:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102969:	5d                   	pop    %ebp
8010296a:	c3                   	ret    
8010296b:	90                   	nop
8010296c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102970:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102973:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102976:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102977:	83 f9 19             	cmp    $0x19,%ecx
8010297a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010297d:	c3                   	ret    
8010297e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102985:	5d                   	pop    %ebp
80102986:	c3                   	ret    
80102987:	89 f6                	mov    %esi,%esi
80102989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102990 <kbdintr>:

void
kbdintr(void)
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102996:	68 c0 28 10 80       	push   $0x801028c0
8010299b:	e8 50 de ff ff       	call   801007f0 <consoleintr>
}
801029a0:	83 c4 10             	add    $0x10,%esp
801029a3:	c9                   	leave  
801029a4:	c3                   	ret    
801029a5:	66 90                	xchg   %ax,%ax
801029a7:	66 90                	xchg   %ax,%ax
801029a9:	66 90                	xchg   %ax,%ax
801029ab:	66 90                	xchg   %ax,%ax
801029ad:	66 90                	xchg   %ax,%ax
801029af:	90                   	nop

801029b0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801029b0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801029b5:	55                   	push   %ebp
801029b6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801029b8:	85 c0                	test   %eax,%eax
801029ba:	0f 84 c8 00 00 00    	je     80102a88 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029c0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801029c7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029ca:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029cd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801029d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029d7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029da:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801029e1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801029e4:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029e7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801029ee:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801029f1:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029f4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801029fb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029fe:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a01:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102a08:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a0b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102a0e:	8b 50 30             	mov    0x30(%eax),%edx
80102a11:	c1 ea 10             	shr    $0x10,%edx
80102a14:	80 fa 03             	cmp    $0x3,%dl
80102a17:	77 77                	ja     80102a90 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a19:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102a20:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a23:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a26:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a2d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a30:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a33:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a3a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a3d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a40:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a47:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a4a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a4d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102a54:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a57:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a5a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102a61:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102a64:	8b 50 20             	mov    0x20(%eax),%edx
80102a67:	89 f6                	mov    %esi,%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a70:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102a76:	80 e6 10             	and    $0x10,%dh
80102a79:	75 f5                	jne    80102a70 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a7b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102a82:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a85:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102a88:	5d                   	pop    %ebp
80102a89:	c3                   	ret    
80102a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a90:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a97:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a9a:	8b 50 20             	mov    0x20(%eax),%edx
80102a9d:	e9 77 ff ff ff       	jmp    80102a19 <lapicinit+0x69>
80102aa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ab0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102ab0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102ab5:	55                   	push   %ebp
80102ab6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102ab8:	85 c0                	test   %eax,%eax
80102aba:	74 0c                	je     80102ac8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102abc:	8b 40 20             	mov    0x20(%eax),%eax
}
80102abf:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102ac0:	c1 e8 18             	shr    $0x18,%eax
}
80102ac3:	c3                   	ret    
80102ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102ac8:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
80102aca:	5d                   	pop    %ebp
80102acb:	c3                   	ret    
80102acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ad0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102ad0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102ad5:	55                   	push   %ebp
80102ad6:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102ad8:	85 c0                	test   %eax,%eax
80102ada:	74 0d                	je     80102ae9 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102adc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ae3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ae6:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102ae9:	5d                   	pop    %ebp
80102aea:	c3                   	ret    
80102aeb:	90                   	nop
80102aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102af0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102af0:	55                   	push   %ebp
80102af1:	89 e5                	mov    %esp,%ebp
}
80102af3:	5d                   	pop    %ebp
80102af4:	c3                   	ret    
80102af5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b00 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102b00:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b01:	ba 70 00 00 00       	mov    $0x70,%edx
80102b06:	b8 0f 00 00 00       	mov    $0xf,%eax
80102b0b:	89 e5                	mov    %esp,%ebp
80102b0d:	53                   	push   %ebx
80102b0e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b11:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b14:	ee                   	out    %al,(%dx)
80102b15:	ba 71 00 00 00       	mov    $0x71,%edx
80102b1a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b1f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b20:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b22:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b25:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b2b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b2d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102b30:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b33:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b35:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102b38:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b3e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102b43:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b49:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b4c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102b53:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b56:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b59:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b60:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b63:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b66:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b6c:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b6f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b75:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b78:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b7e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102b81:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b87:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102b8a:	5b                   	pop    %ebx
80102b8b:	5d                   	pop    %ebp
80102b8c:	c3                   	ret    
80102b8d:	8d 76 00             	lea    0x0(%esi),%esi

80102b90 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102b90:	55                   	push   %ebp
80102b91:	ba 70 00 00 00       	mov    $0x70,%edx
80102b96:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b9b:	89 e5                	mov    %esp,%ebp
80102b9d:	57                   	push   %edi
80102b9e:	56                   	push   %esi
80102b9f:	53                   	push   %ebx
80102ba0:	83 ec 4c             	sub    $0x4c,%esp
80102ba3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ba4:	ba 71 00 00 00       	mov    $0x71,%edx
80102ba9:	ec                   	in     (%dx),%al
80102baa:	83 e0 04             	and    $0x4,%eax
80102bad:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bb0:	31 db                	xor    %ebx,%ebx
80102bb2:	88 45 b7             	mov    %al,-0x49(%ebp)
80102bb5:	bf 70 00 00 00       	mov    $0x70,%edi
80102bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102bc0:	89 d8                	mov    %ebx,%eax
80102bc2:	89 fa                	mov    %edi,%edx
80102bc4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bc5:	b9 71 00 00 00       	mov    $0x71,%ecx
80102bca:	89 ca                	mov    %ecx,%edx
80102bcc:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102bcd:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd0:	89 fa                	mov    %edi,%edx
80102bd2:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102bd5:	b8 02 00 00 00       	mov    $0x2,%eax
80102bda:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bdb:	89 ca                	mov    %ecx,%edx
80102bdd:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102bde:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be1:	89 fa                	mov    %edi,%edx
80102be3:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102be6:	b8 04 00 00 00       	mov    $0x4,%eax
80102beb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bec:	89 ca                	mov    %ecx,%edx
80102bee:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102bef:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf2:	89 fa                	mov    %edi,%edx
80102bf4:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102bf7:	b8 07 00 00 00       	mov    $0x7,%eax
80102bfc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bfd:	89 ca                	mov    %ecx,%edx
80102bff:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102c00:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c03:	89 fa                	mov    %edi,%edx
80102c05:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102c08:	b8 08 00 00 00       	mov    $0x8,%eax
80102c0d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c0e:	89 ca                	mov    %ecx,%edx
80102c10:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102c11:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c14:	89 fa                	mov    %edi,%edx
80102c16:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102c19:	b8 09 00 00 00       	mov    $0x9,%eax
80102c1e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c1f:	89 ca                	mov    %ecx,%edx
80102c21:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102c22:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c25:	89 fa                	mov    %edi,%edx
80102c27:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102c2a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c2f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c30:	89 ca                	mov    %ecx,%edx
80102c32:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c33:	84 c0                	test   %al,%al
80102c35:	78 89                	js     80102bc0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c37:	89 d8                	mov    %ebx,%eax
80102c39:	89 fa                	mov    %edi,%edx
80102c3b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c3c:	89 ca                	mov    %ecx,%edx
80102c3e:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102c3f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c42:	89 fa                	mov    %edi,%edx
80102c44:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102c47:	b8 02 00 00 00       	mov    $0x2,%eax
80102c4c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c4d:	89 ca                	mov    %ecx,%edx
80102c4f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102c50:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c53:	89 fa                	mov    %edi,%edx
80102c55:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102c58:	b8 04 00 00 00       	mov    $0x4,%eax
80102c5d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c5e:	89 ca                	mov    %ecx,%edx
80102c60:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102c61:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c64:	89 fa                	mov    %edi,%edx
80102c66:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c69:	b8 07 00 00 00       	mov    $0x7,%eax
80102c6e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6f:	89 ca                	mov    %ecx,%edx
80102c71:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102c72:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c75:	89 fa                	mov    %edi,%edx
80102c77:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c7a:	b8 08 00 00 00       	mov    $0x8,%eax
80102c7f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c80:	89 ca                	mov    %ecx,%edx
80102c82:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102c83:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c86:	89 fa                	mov    %edi,%edx
80102c88:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c8b:	b8 09 00 00 00       	mov    $0x9,%eax
80102c90:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c91:	89 ca                	mov    %ecx,%edx
80102c93:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102c94:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c97:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102c9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c9d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ca0:	6a 18                	push   $0x18
80102ca2:	56                   	push   %esi
80102ca3:	50                   	push   %eax
80102ca4:	e8 87 1b 00 00       	call   80104830 <memcmp>
80102ca9:	83 c4 10             	add    $0x10,%esp
80102cac:	85 c0                	test   %eax,%eax
80102cae:	0f 85 0c ff ff ff    	jne    80102bc0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102cb4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102cb8:	75 78                	jne    80102d32 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102cba:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cbd:	89 c2                	mov    %eax,%edx
80102cbf:	83 e0 0f             	and    $0xf,%eax
80102cc2:	c1 ea 04             	shr    $0x4,%edx
80102cc5:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cc8:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ccb:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102cce:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102cd1:	89 c2                	mov    %eax,%edx
80102cd3:	83 e0 0f             	and    $0xf,%eax
80102cd6:	c1 ea 04             	shr    $0x4,%edx
80102cd9:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cdc:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cdf:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102ce2:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ce5:	89 c2                	mov    %eax,%edx
80102ce7:	83 e0 0f             	and    $0xf,%eax
80102cea:	c1 ea 04             	shr    $0x4,%edx
80102ced:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cf0:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cf3:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102cf6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cf9:	89 c2                	mov    %eax,%edx
80102cfb:	83 e0 0f             	and    $0xf,%eax
80102cfe:	c1 ea 04             	shr    $0x4,%edx
80102d01:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d04:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d07:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d0a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d0d:	89 c2                	mov    %eax,%edx
80102d0f:	83 e0 0f             	and    $0xf,%eax
80102d12:	c1 ea 04             	shr    $0x4,%edx
80102d15:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d18:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d1b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102d1e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d21:	89 c2                	mov    %eax,%edx
80102d23:	83 e0 0f             	and    $0xf,%eax
80102d26:	c1 ea 04             	shr    $0x4,%edx
80102d29:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d2c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d2f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102d32:	8b 75 08             	mov    0x8(%ebp),%esi
80102d35:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d38:	89 06                	mov    %eax,(%esi)
80102d3a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d3d:	89 46 04             	mov    %eax,0x4(%esi)
80102d40:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d43:	89 46 08             	mov    %eax,0x8(%esi)
80102d46:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d49:	89 46 0c             	mov    %eax,0xc(%esi)
80102d4c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d4f:	89 46 10             	mov    %eax,0x10(%esi)
80102d52:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d55:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102d58:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102d5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d62:	5b                   	pop    %ebx
80102d63:	5e                   	pop    %esi
80102d64:	5f                   	pop    %edi
80102d65:	5d                   	pop    %ebp
80102d66:	c3                   	ret    
80102d67:	66 90                	xchg   %ax,%ax
80102d69:	66 90                	xchg   %ax,%ax
80102d6b:	66 90                	xchg   %ax,%ax
80102d6d:	66 90                	xchg   %ax,%ax
80102d6f:	90                   	nop

80102d70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d70:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d76:	85 c9                	test   %ecx,%ecx
80102d78:	0f 8e 85 00 00 00    	jle    80102e03 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102d7e:	55                   	push   %ebp
80102d7f:	89 e5                	mov    %esp,%ebp
80102d81:	57                   	push   %edi
80102d82:	56                   	push   %esi
80102d83:	53                   	push   %ebx
80102d84:	31 db                	xor    %ebx,%ebx
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102d90:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102d95:	83 ec 08             	sub    $0x8,%esp
80102d98:	01 d8                	add    %ebx,%eax
80102d9a:	83 c0 01             	add    $0x1,%eax
80102d9d:	50                   	push   %eax
80102d9e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102da4:	e8 27 d3 ff ff       	call   801000d0 <bread>
80102da9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dab:	58                   	pop    %eax
80102dac:	5a                   	pop    %edx
80102dad:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102db4:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102dba:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dbd:	e8 0e d3 ff ff       	call   801000d0 <bread>
80102dc2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dc4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102dc7:	83 c4 0c             	add    $0xc,%esp
80102dca:	68 00 02 00 00       	push   $0x200
80102dcf:	50                   	push   %eax
80102dd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102dd3:	50                   	push   %eax
80102dd4:	e8 b7 1a 00 00       	call   80104890 <memmove>
    bwrite(dbuf);  // write dst to disk
80102dd9:	89 34 24             	mov    %esi,(%esp)
80102ddc:	e8 bf d3 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102de1:	89 3c 24             	mov    %edi,(%esp)
80102de4:	e8 f7 d3 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102de9:	89 34 24             	mov    %esi,(%esp)
80102dec:	e8 ef d3 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102df1:	83 c4 10             	add    $0x10,%esp
80102df4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102dfa:	7f 94                	jg     80102d90 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dff:	5b                   	pop    %ebx
80102e00:	5e                   	pop    %esi
80102e01:	5f                   	pop    %edi
80102e02:	5d                   	pop    %ebp
80102e03:	f3 c3                	repz ret 
80102e05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	53                   	push   %ebx
80102e14:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e17:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102e1d:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102e23:	e8 a8 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102e28:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102e2e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102e31:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102e33:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102e35:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102e38:	7e 1f                	jle    80102e59 <write_head+0x49>
80102e3a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102e41:	31 d2                	xor    %edx,%edx
80102e43:	90                   	nop
80102e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102e48:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102e4e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102e52:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102e55:	39 c2                	cmp    %eax,%edx
80102e57:	75 ef                	jne    80102e48 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102e59:	83 ec 0c             	sub    $0xc,%esp
80102e5c:	53                   	push   %ebx
80102e5d:	e8 3e d3 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102e62:	89 1c 24             	mov    %ebx,(%esp)
80102e65:	e8 76 d3 ff ff       	call   801001e0 <brelse>
}
80102e6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e6d:	c9                   	leave  
80102e6e:	c3                   	ret    
80102e6f:	90                   	nop

80102e70 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	53                   	push   %ebx
80102e74:	83 ec 2c             	sub    $0x2c,%esp
80102e77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102e7a:	68 40 77 10 80       	push   $0x80107740
80102e7f:	68 80 26 11 80       	push   $0x80112680
80102e84:	e8 f7 16 00 00       	call   80104580 <initlock>
  readsb(dev, &sb);
80102e89:	58                   	pop    %eax
80102e8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e8d:	5a                   	pop    %edx
80102e8e:	50                   	push   %eax
80102e8f:	53                   	push   %ebx
80102e90:	e8 eb e6 ff ff       	call   80101580 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102e95:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102e98:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102e9b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102e9c:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ea2:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ea8:	a3 b4 26 11 80       	mov    %eax,0x801126b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102ead:	5a                   	pop    %edx
80102eae:	50                   	push   %eax
80102eaf:	53                   	push   %ebx
80102eb0:	e8 1b d2 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102eb5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102eb8:	83 c4 10             	add    $0x10,%esp
80102ebb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102ebd:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102ec3:	7e 1c                	jle    80102ee1 <initlog+0x71>
80102ec5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102ecc:	31 d2                	xor    %edx,%edx
80102ece:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102ed0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102ed4:	83 c2 04             	add    $0x4,%edx
80102ed7:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102edd:	39 da                	cmp    %ebx,%edx
80102edf:	75 ef                	jne    80102ed0 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102ee1:	83 ec 0c             	sub    $0xc,%esp
80102ee4:	50                   	push   %eax
80102ee5:	e8 f6 d2 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102eea:	e8 81 fe ff ff       	call   80102d70 <install_trans>
  log.lh.n = 0;
80102eef:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102ef6:	00 00 00 
  write_head(); // clear the log
80102ef9:	e8 12 ff ff ff       	call   80102e10 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102efe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f01:	c9                   	leave  
80102f02:	c3                   	ret    
80102f03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f16:	68 80 26 11 80       	push   $0x80112680
80102f1b:	e8 c0 17 00 00       	call   801046e0 <acquire>
80102f20:	83 c4 10             	add    $0x10,%esp
80102f23:	eb 18                	jmp    80102f3d <begin_op+0x2d>
80102f25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f28:	83 ec 08             	sub    $0x8,%esp
80102f2b:	68 80 26 11 80       	push   $0x80112680
80102f30:	68 80 26 11 80       	push   $0x80112680
80102f35:	e8 b6 11 00 00       	call   801040f0 <sleep>
80102f3a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102f3d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102f42:	85 c0                	test   %eax,%eax
80102f44:	75 e2                	jne    80102f28 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102f46:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102f4b:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102f51:	83 c0 01             	add    $0x1,%eax
80102f54:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102f57:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102f5a:	83 fa 1e             	cmp    $0x1e,%edx
80102f5d:	7f c9                	jg     80102f28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102f5f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102f62:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102f67:	68 80 26 11 80       	push   $0x80112680
80102f6c:	e8 1f 18 00 00       	call   80104790 <release>
      break;
    }
  }
}
80102f71:	83 c4 10             	add    $0x10,%esp
80102f74:	c9                   	leave  
80102f75:	c3                   	ret    
80102f76:	8d 76 00             	lea    0x0(%esi),%esi
80102f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102f80:	55                   	push   %ebp
80102f81:	89 e5                	mov    %esp,%ebp
80102f83:	57                   	push   %edi
80102f84:	56                   	push   %esi
80102f85:	53                   	push   %ebx
80102f86:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102f89:	68 80 26 11 80       	push   $0x80112680
80102f8e:	e8 4d 17 00 00       	call   801046e0 <acquire>
  log.outstanding -= 1;
80102f93:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102f98:	8b 1d c0 26 11 80    	mov    0x801126c0,%ebx
80102f9e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102fa1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102fa4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102fa6:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102fab:	0f 85 23 01 00 00    	jne    801030d4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102fb1:	85 c0                	test   %eax,%eax
80102fb3:	0f 85 f7 00 00 00    	jne    801030b0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102fb9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102fbc:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102fc3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102fc6:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102fc8:	68 80 26 11 80       	push   $0x80112680
80102fcd:	e8 be 17 00 00       	call   80104790 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102fd2:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102fd8:	83 c4 10             	add    $0x10,%esp
80102fdb:	85 c9                	test   %ecx,%ecx
80102fdd:	0f 8e 8a 00 00 00    	jle    8010306d <end_op+0xed>
80102fe3:	90                   	nop
80102fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102fe8:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102fed:	83 ec 08             	sub    $0x8,%esp
80102ff0:	01 d8                	add    %ebx,%eax
80102ff2:	83 c0 01             	add    $0x1,%eax
80102ff5:	50                   	push   %eax
80102ff6:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ffc:	e8 cf d0 ff ff       	call   801000d0 <bread>
80103001:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103003:	58                   	pop    %eax
80103004:	5a                   	pop    %edx
80103005:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
8010300c:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103012:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103015:	e8 b6 d0 ff ff       	call   801000d0 <bread>
8010301a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
8010301c:	8d 40 5c             	lea    0x5c(%eax),%eax
8010301f:	83 c4 0c             	add    $0xc,%esp
80103022:	68 00 02 00 00       	push   $0x200
80103027:	50                   	push   %eax
80103028:	8d 46 5c             	lea    0x5c(%esi),%eax
8010302b:	50                   	push   %eax
8010302c:	e8 5f 18 00 00       	call   80104890 <memmove>
    bwrite(to);  // write the log
80103031:	89 34 24             	mov    %esi,(%esp)
80103034:	e8 67 d1 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103039:	89 3c 24             	mov    %edi,(%esp)
8010303c:	e8 9f d1 ff ff       	call   801001e0 <brelse>
    brelse(to);
80103041:	89 34 24             	mov    %esi,(%esp)
80103044:	e8 97 d1 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103049:	83 c4 10             	add    $0x10,%esp
8010304c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80103052:	7c 94                	jl     80102fe8 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103054:	e8 b7 fd ff ff       	call   80102e10 <write_head>
    install_trans(); // Now install writes to home locations
80103059:	e8 12 fd ff ff       	call   80102d70 <install_trans>
    log.lh.n = 0;
8010305e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80103065:	00 00 00 
    write_head();    // Erase the transaction from the log
80103068:	e8 a3 fd ff ff       	call   80102e10 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
8010306d:	83 ec 0c             	sub    $0xc,%esp
80103070:	68 80 26 11 80       	push   $0x80112680
80103075:	e8 66 16 00 00       	call   801046e0 <acquire>
    log.committing = 0;
    wakeup(&log);
8010307a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80103081:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80103088:	00 00 00 
    wakeup(&log);
8010308b:	e8 10 12 00 00       	call   801042a0 <wakeup>
    release(&log.lock);
80103090:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80103097:	e8 f4 16 00 00       	call   80104790 <release>
8010309c:	83 c4 10             	add    $0x10,%esp
  }
}
8010309f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030a2:	5b                   	pop    %ebx
801030a3:	5e                   	pop    %esi
801030a4:	5f                   	pop    %edi
801030a5:	5d                   	pop    %ebp
801030a6:	c3                   	ret    
801030a7:	89 f6                	mov    %esi,%esi
801030a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
801030b0:	83 ec 0c             	sub    $0xc,%esp
801030b3:	68 80 26 11 80       	push   $0x80112680
801030b8:	e8 e3 11 00 00       	call   801042a0 <wakeup>
  }
  release(&log.lock);
801030bd:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
801030c4:	e8 c7 16 00 00       	call   80104790 <release>
801030c9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
801030cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030cf:	5b                   	pop    %ebx
801030d0:	5e                   	pop    %esi
801030d1:	5f                   	pop    %edi
801030d2:	5d                   	pop    %ebp
801030d3:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
801030d4:	83 ec 0c             	sub    $0xc,%esp
801030d7:	68 44 77 10 80       	push   $0x80107744
801030dc:	e8 8f d2 ff ff       	call   80100370 <panic>
801030e1:	eb 0d                	jmp    801030f0 <log_write>
801030e3:	90                   	nop
801030e4:	90                   	nop
801030e5:	90                   	nop
801030e6:	90                   	nop
801030e7:	90                   	nop
801030e8:	90                   	nop
801030e9:	90                   	nop
801030ea:	90                   	nop
801030eb:	90                   	nop
801030ec:	90                   	nop
801030ed:	90                   	nop
801030ee:	90                   	nop
801030ef:	90                   	nop

801030f0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	53                   	push   %ebx
801030f4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801030f7:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801030fd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103100:	83 fa 1d             	cmp    $0x1d,%edx
80103103:	0f 8f 97 00 00 00    	jg     801031a0 <log_write+0xb0>
80103109:	a1 b8 26 11 80       	mov    0x801126b8,%eax
8010310e:	83 e8 01             	sub    $0x1,%eax
80103111:	39 c2                	cmp    %eax,%edx
80103113:	0f 8d 87 00 00 00    	jge    801031a0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103119:	a1 bc 26 11 80       	mov    0x801126bc,%eax
8010311e:	85 c0                	test   %eax,%eax
80103120:	0f 8e 87 00 00 00    	jle    801031ad <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103126:	83 ec 0c             	sub    $0xc,%esp
80103129:	68 80 26 11 80       	push   $0x80112680
8010312e:	e8 ad 15 00 00       	call   801046e0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103133:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80103139:	83 c4 10             	add    $0x10,%esp
8010313c:	83 fa 00             	cmp    $0x0,%edx
8010313f:	7e 50                	jle    80103191 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103141:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103144:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103146:	3b 0d cc 26 11 80    	cmp    0x801126cc,%ecx
8010314c:	75 0b                	jne    80103159 <log_write+0x69>
8010314e:	eb 38                	jmp    80103188 <log_write+0x98>
80103150:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80103157:	74 2f                	je     80103188 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103159:	83 c0 01             	add    $0x1,%eax
8010315c:	39 d0                	cmp    %edx,%eax
8010315e:	75 f0                	jne    80103150 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103160:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80103167:	83 c2 01             	add    $0x1,%edx
8010316a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80103170:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103173:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
8010317a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010317d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
8010317e:	e9 0d 16 00 00       	jmp    80104790 <release>
80103183:	90                   	nop
80103184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103188:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
8010318f:	eb df                	jmp    80103170 <log_write+0x80>
80103191:	8b 43 08             	mov    0x8(%ebx),%eax
80103194:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80103199:	75 d5                	jne    80103170 <log_write+0x80>
8010319b:	eb ca                	jmp    80103167 <log_write+0x77>
8010319d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
801031a0:	83 ec 0c             	sub    $0xc,%esp
801031a3:	68 53 77 10 80       	push   $0x80107753
801031a8:	e8 c3 d1 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
801031ad:	83 ec 0c             	sub    $0xc,%esp
801031b0:	68 69 77 10 80       	push   $0x80107769
801031b5:	e8 b6 d1 ff ff       	call   80100370 <panic>
801031ba:	66 90                	xchg   %ax,%ax
801031bc:	66 90                	xchg   %ax,%ax
801031be:	66 90                	xchg   %ax,%ax

801031c0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	53                   	push   %ebx
801031c4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801031c7:	e8 54 09 00 00       	call   80103b20 <cpuid>
801031cc:	89 c3                	mov    %eax,%ebx
801031ce:	e8 4d 09 00 00       	call   80103b20 <cpuid>
801031d3:	83 ec 04             	sub    $0x4,%esp
801031d6:	53                   	push   %ebx
801031d7:	50                   	push   %eax
801031d8:	68 84 77 10 80       	push   $0x80107784
801031dd:	e8 7e d4 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
801031e2:	e8 b9 28 00 00       	call   80105aa0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801031e7:	e8 b4 08 00 00       	call   80103aa0 <mycpu>
801031ec:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801031ee:	b8 01 00 00 00       	mov    $0x1,%eax
801031f3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801031fa:	e8 01 0c 00 00       	call   80103e00 <scheduler>
801031ff:	90                   	nop

80103200 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103200:	55                   	push   %ebp
80103201:	89 e5                	mov    %esp,%ebp
80103203:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103206:	e8 b5 39 00 00       	call   80106bc0 <switchkvm>
  seginit();
8010320b:	e8 b0 38 00 00       	call   80106ac0 <seginit>
  lapicinit();
80103210:	e8 9b f7 ff ff       	call   801029b0 <lapicinit>
  mpmain();
80103215:	e8 a6 ff ff ff       	call   801031c0 <mpmain>
8010321a:	66 90                	xchg   %ax,%ax
8010321c:	66 90                	xchg   %ax,%ax
8010321e:	66 90                	xchg   %ax,%ax

80103220 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103220:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103224:	83 e4 f0             	and    $0xfffffff0,%esp
80103227:	ff 71 fc             	pushl  -0x4(%ecx)
8010322a:	55                   	push   %ebp
8010322b:	89 e5                	mov    %esp,%ebp
8010322d:	53                   	push   %ebx
8010322e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010322f:	bb 80 27 11 80       	mov    $0x80112780,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103234:	83 ec 08             	sub    $0x8,%esp
80103237:	68 00 00 40 80       	push   $0x80400000
8010323c:	68 a8 54 11 80       	push   $0x801154a8
80103241:	e8 3a f5 ff ff       	call   80102780 <kinit1>
  kvmalloc();      // kernel page table
80103246:	e8 15 3e 00 00       	call   80107060 <kvmalloc>
  mpinit();        // detect other processors
8010324b:	e8 70 01 00 00       	call   801033c0 <mpinit>
  lapicinit();     // interrupt controller
80103250:	e8 5b f7 ff ff       	call   801029b0 <lapicinit>
  seginit();       // segment descriptors
80103255:	e8 66 38 00 00       	call   80106ac0 <seginit>
  picinit();       // disable pic
8010325a:	e8 31 03 00 00       	call   80103590 <picinit>
  ioapicinit();    // another interrupt controller
8010325f:	e8 4c f3 ff ff       	call   801025b0 <ioapicinit>
  consoleinit();   // console hardware
80103264:	e8 37 d7 ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80103269:	e8 22 2b 00 00       	call   80105d90 <uartinit>
  pinit();         // process table
8010326e:	e8 0d 08 00 00       	call   80103a80 <pinit>
  tvinit();        // trap vectors
80103273:	e8 88 27 00 00       	call   80105a00 <tvinit>
  binit();         // buffer cache
80103278:	e8 c3 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010327d:	e8 ce da ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
80103282:	e8 09 f1 ff ff       	call   80102390 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103287:	83 c4 0c             	add    $0xc,%esp
8010328a:	68 8a 00 00 00       	push   $0x8a
8010328f:	68 8c a4 10 80       	push   $0x8010a48c
80103294:	68 00 70 00 80       	push   $0x80007000
80103299:	e8 f2 15 00 00       	call   80104890 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010329e:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
801032a5:	00 00 00 
801032a8:	83 c4 10             	add    $0x10,%esp
801032ab:	05 80 27 11 80       	add    $0x80112780,%eax
801032b0:	39 d8                	cmp    %ebx,%eax
801032b2:	76 6f                	jbe    80103323 <main+0x103>
801032b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
801032b8:	e8 e3 07 00 00       	call   80103aa0 <mycpu>
801032bd:	39 d8                	cmp    %ebx,%eax
801032bf:	74 49                	je     8010330a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801032c1:	e8 8a f5 ff ff       	call   80102850 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801032c6:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
801032cb:	c7 05 f8 6f 00 80 00 	movl   $0x80103200,0x80006ff8
801032d2:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801032d5:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801032dc:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
801032df:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801032e4:	0f b6 03             	movzbl (%ebx),%eax
801032e7:	83 ec 08             	sub    $0x8,%esp
801032ea:	68 00 70 00 00       	push   $0x7000
801032ef:	50                   	push   %eax
801032f0:	e8 0b f8 ff ff       	call   80102b00 <lapicstartap>
801032f5:	83 c4 10             	add    $0x10,%esp
801032f8:	90                   	nop
801032f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103300:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103306:	85 c0                	test   %eax,%eax
80103308:	74 f6                	je     80103300 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010330a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103311:	00 00 00 
80103314:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010331a:	05 80 27 11 80       	add    $0x80112780,%eax
8010331f:	39 c3                	cmp    %eax,%ebx
80103321:	72 95                	jb     801032b8 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103323:	83 ec 08             	sub    $0x8,%esp
80103326:	68 00 00 00 8e       	push   $0x8e000000
8010332b:	68 00 00 40 80       	push   $0x80400000
80103330:	e8 bb f4 ff ff       	call   801027f0 <kinit2>
  userinit();      // first user process
80103335:	e8 36 08 00 00       	call   80103b70 <userinit>
  mpmain();        // finish this processor's setup
8010333a:	e8 81 fe ff ff       	call   801031c0 <mpmain>
8010333f:	90                   	nop

80103340 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103340:	55                   	push   %ebp
80103341:	89 e5                	mov    %esp,%ebp
80103343:	57                   	push   %edi
80103344:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103345:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010334b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010334c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010334f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103352:	39 de                	cmp    %ebx,%esi
80103354:	73 48                	jae    8010339e <mpsearch1+0x5e>
80103356:	8d 76 00             	lea    0x0(%esi),%esi
80103359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103360:	83 ec 04             	sub    $0x4,%esp
80103363:	8d 7e 10             	lea    0x10(%esi),%edi
80103366:	6a 04                	push   $0x4
80103368:	68 98 77 10 80       	push   $0x80107798
8010336d:	56                   	push   %esi
8010336e:	e8 bd 14 00 00       	call   80104830 <memcmp>
80103373:	83 c4 10             	add    $0x10,%esp
80103376:	85 c0                	test   %eax,%eax
80103378:	75 1e                	jne    80103398 <mpsearch1+0x58>
8010337a:	8d 7e 10             	lea    0x10(%esi),%edi
8010337d:	89 f2                	mov    %esi,%edx
8010337f:	31 c9                	xor    %ecx,%ecx
80103381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103388:	0f b6 02             	movzbl (%edx),%eax
8010338b:	83 c2 01             	add    $0x1,%edx
8010338e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103390:	39 fa                	cmp    %edi,%edx
80103392:	75 f4                	jne    80103388 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103394:	84 c9                	test   %cl,%cl
80103396:	74 10                	je     801033a8 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103398:	39 fb                	cmp    %edi,%ebx
8010339a:	89 fe                	mov    %edi,%esi
8010339c:	77 c2                	ja     80103360 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010339e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801033a1:	31 c0                	xor    %eax,%eax
}
801033a3:	5b                   	pop    %ebx
801033a4:	5e                   	pop    %esi
801033a5:	5f                   	pop    %edi
801033a6:	5d                   	pop    %ebp
801033a7:	c3                   	ret    
801033a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033ab:	89 f0                	mov    %esi,%eax
801033ad:	5b                   	pop    %ebx
801033ae:	5e                   	pop    %esi
801033af:	5f                   	pop    %edi
801033b0:	5d                   	pop    %ebp
801033b1:	c3                   	ret    
801033b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801033c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	57                   	push   %edi
801033c4:	56                   	push   %esi
801033c5:	53                   	push   %ebx
801033c6:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801033c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801033d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801033d7:	c1 e0 08             	shl    $0x8,%eax
801033da:	09 d0                	or     %edx,%eax
801033dc:	c1 e0 04             	shl    $0x4,%eax
801033df:	85 c0                	test   %eax,%eax
801033e1:	75 1b                	jne    801033fe <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
801033e3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801033ea:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801033f1:	c1 e0 08             	shl    $0x8,%eax
801033f4:	09 d0                	or     %edx,%eax
801033f6:	c1 e0 0a             	shl    $0xa,%eax
801033f9:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
801033fe:	ba 00 04 00 00       	mov    $0x400,%edx
80103403:	e8 38 ff ff ff       	call   80103340 <mpsearch1>
80103408:	85 c0                	test   %eax,%eax
8010340a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010340d:	0f 84 37 01 00 00    	je     8010354a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103413:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103416:	8b 58 04             	mov    0x4(%eax),%ebx
80103419:	85 db                	test   %ebx,%ebx
8010341b:	0f 84 43 01 00 00    	je     80103564 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103421:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103427:	83 ec 04             	sub    $0x4,%esp
8010342a:	6a 04                	push   $0x4
8010342c:	68 9d 77 10 80       	push   $0x8010779d
80103431:	56                   	push   %esi
80103432:	e8 f9 13 00 00       	call   80104830 <memcmp>
80103437:	83 c4 10             	add    $0x10,%esp
8010343a:	85 c0                	test   %eax,%eax
8010343c:	0f 85 22 01 00 00    	jne    80103564 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103442:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103449:	3c 01                	cmp    $0x1,%al
8010344b:	74 08                	je     80103455 <mpinit+0x95>
8010344d:	3c 04                	cmp    $0x4,%al
8010344f:	0f 85 0f 01 00 00    	jne    80103564 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103455:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010345c:	85 ff                	test   %edi,%edi
8010345e:	74 21                	je     80103481 <mpinit+0xc1>
80103460:	31 d2                	xor    %edx,%edx
80103462:	31 c0                	xor    %eax,%eax
80103464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103468:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010346f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103470:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103473:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103475:	39 c7                	cmp    %eax,%edi
80103477:	75 ef                	jne    80103468 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103479:	84 d2                	test   %dl,%dl
8010347b:	0f 85 e3 00 00 00    	jne    80103564 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103481:	85 f6                	test   %esi,%esi
80103483:	0f 84 db 00 00 00    	je     80103564 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103489:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010348f:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103494:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010349b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801034a1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034a6:	01 d6                	add    %edx,%esi
801034a8:	90                   	nop
801034a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034b0:	39 c6                	cmp    %eax,%esi
801034b2:	76 23                	jbe    801034d7 <mpinit+0x117>
801034b4:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
801034b7:	80 fa 04             	cmp    $0x4,%dl
801034ba:	0f 87 c0 00 00 00    	ja     80103580 <mpinit+0x1c0>
801034c0:	ff 24 95 dc 77 10 80 	jmp    *-0x7fef8824(,%edx,4)
801034c7:	89 f6                	mov    %esi,%esi
801034c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801034d0:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034d3:	39 c6                	cmp    %eax,%esi
801034d5:	77 dd                	ja     801034b4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801034d7:	85 db                	test   %ebx,%ebx
801034d9:	0f 84 92 00 00 00    	je     80103571 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801034df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801034e2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801034e6:	74 15                	je     801034fd <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034e8:	ba 22 00 00 00       	mov    $0x22,%edx
801034ed:	b8 70 00 00 00       	mov    $0x70,%eax
801034f2:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034f3:	ba 23 00 00 00       	mov    $0x23,%edx
801034f8:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034f9:	83 c8 01             	or     $0x1,%eax
801034fc:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801034fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103500:	5b                   	pop    %ebx
80103501:	5e                   	pop    %esi
80103502:	5f                   	pop    %edi
80103503:	5d                   	pop    %ebp
80103504:	c3                   	ret    
80103505:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103508:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010350e:	83 f9 07             	cmp    $0x7,%ecx
80103511:	7f 19                	jg     8010352c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103513:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103517:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010351d:	83 c1 01             	add    $0x1,%ecx
80103520:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103526:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010352c:	83 c0 14             	add    $0x14,%eax
      continue;
8010352f:	e9 7c ff ff ff       	jmp    801034b0 <mpinit+0xf0>
80103534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103538:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010353c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010353f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      p += sizeof(struct mpioapic);
      continue;
80103545:	e9 66 ff ff ff       	jmp    801034b0 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010354a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010354f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103554:	e8 e7 fd ff ff       	call   80103340 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103559:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010355b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010355e:	0f 85 af fe ff ff    	jne    80103413 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80103564:	83 ec 0c             	sub    $0xc,%esp
80103567:	68 a2 77 10 80       	push   $0x801077a2
8010356c:	e8 ff cd ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
80103571:	83 ec 0c             	sub    $0xc,%esp
80103574:	68 bc 77 10 80       	push   $0x801077bc
80103579:	e8 f2 cd ff ff       	call   80100370 <panic>
8010357e:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80103580:	31 db                	xor    %ebx,%ebx
80103582:	e9 30 ff ff ff       	jmp    801034b7 <mpinit+0xf7>
80103587:	66 90                	xchg   %ax,%ax
80103589:	66 90                	xchg   %ax,%ax
8010358b:	66 90                	xchg   %ax,%ax
8010358d:	66 90                	xchg   %ax,%ax
8010358f:	90                   	nop

80103590 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103590:	55                   	push   %ebp
80103591:	ba 21 00 00 00       	mov    $0x21,%edx
80103596:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010359b:	89 e5                	mov    %esp,%ebp
8010359d:	ee                   	out    %al,(%dx)
8010359e:	ba a1 00 00 00       	mov    $0xa1,%edx
801035a3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801035a4:	5d                   	pop    %ebp
801035a5:	c3                   	ret    
801035a6:	66 90                	xchg   %ax,%ax
801035a8:	66 90                	xchg   %ax,%ax
801035aa:	66 90                	xchg   %ax,%ax
801035ac:	66 90                	xchg   %ax,%ax
801035ae:	66 90                	xchg   %ax,%ax

801035b0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801035b0:	55                   	push   %ebp
801035b1:	89 e5                	mov    %esp,%ebp
801035b3:	57                   	push   %edi
801035b4:	56                   	push   %esi
801035b5:	53                   	push   %ebx
801035b6:	83 ec 0c             	sub    $0xc,%esp
801035b9:	8b 75 08             	mov    0x8(%ebp),%esi
801035bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801035bf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801035c5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801035cb:	e8 a0 d7 ff ff       	call   80100d70 <filealloc>
801035d0:	85 c0                	test   %eax,%eax
801035d2:	89 06                	mov    %eax,(%esi)
801035d4:	0f 84 a8 00 00 00    	je     80103682 <pipealloc+0xd2>
801035da:	e8 91 d7 ff ff       	call   80100d70 <filealloc>
801035df:	85 c0                	test   %eax,%eax
801035e1:	89 03                	mov    %eax,(%ebx)
801035e3:	0f 84 87 00 00 00    	je     80103670 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801035e9:	e8 62 f2 ff ff       	call   80102850 <kalloc>
801035ee:	85 c0                	test   %eax,%eax
801035f0:	89 c7                	mov    %eax,%edi
801035f2:	0f 84 b0 00 00 00    	je     801036a8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801035f8:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
801035fb:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103602:	00 00 00 
  p->writeopen = 1;
80103605:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010360c:	00 00 00 
  p->nwrite = 0;
8010360f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103616:	00 00 00 
  p->nread = 0;
80103619:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103620:	00 00 00 
  initlock(&p->lock, "pipe");
80103623:	68 f0 77 10 80       	push   $0x801077f0
80103628:	50                   	push   %eax
80103629:	e8 52 0f 00 00       	call   80104580 <initlock>
  (*f0)->type = FD_PIPE;
8010362e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103630:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103633:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103639:	8b 06                	mov    (%esi),%eax
8010363b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010363f:	8b 06                	mov    (%esi),%eax
80103641:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103645:	8b 06                	mov    (%esi),%eax
80103647:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010364a:	8b 03                	mov    (%ebx),%eax
8010364c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103652:	8b 03                	mov    (%ebx),%eax
80103654:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103658:	8b 03                	mov    (%ebx),%eax
8010365a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010365e:	8b 03                	mov    (%ebx),%eax
80103660:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103663:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103666:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103668:	5b                   	pop    %ebx
80103669:	5e                   	pop    %esi
8010366a:	5f                   	pop    %edi
8010366b:	5d                   	pop    %ebp
8010366c:	c3                   	ret    
8010366d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103670:	8b 06                	mov    (%esi),%eax
80103672:	85 c0                	test   %eax,%eax
80103674:	74 1e                	je     80103694 <pipealloc+0xe4>
    fileclose(*f0);
80103676:	83 ec 0c             	sub    $0xc,%esp
80103679:	50                   	push   %eax
8010367a:	e8 b1 d7 ff ff       	call   80100e30 <fileclose>
8010367f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103682:	8b 03                	mov    (%ebx),%eax
80103684:	85 c0                	test   %eax,%eax
80103686:	74 0c                	je     80103694 <pipealloc+0xe4>
    fileclose(*f1);
80103688:	83 ec 0c             	sub    $0xc,%esp
8010368b:	50                   	push   %eax
8010368c:	e8 9f d7 ff ff       	call   80100e30 <fileclose>
80103691:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103694:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103697:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010369c:	5b                   	pop    %ebx
8010369d:	5e                   	pop    %esi
8010369e:	5f                   	pop    %edi
8010369f:	5d                   	pop    %ebp
801036a0:	c3                   	ret    
801036a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801036a8:	8b 06                	mov    (%esi),%eax
801036aa:	85 c0                	test   %eax,%eax
801036ac:	75 c8                	jne    80103676 <pipealloc+0xc6>
801036ae:	eb d2                	jmp    80103682 <pipealloc+0xd2>

801036b0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
801036b3:	56                   	push   %esi
801036b4:	53                   	push   %ebx
801036b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801036bb:	83 ec 0c             	sub    $0xc,%esp
801036be:	53                   	push   %ebx
801036bf:	e8 1c 10 00 00       	call   801046e0 <acquire>
  if(writable){
801036c4:	83 c4 10             	add    $0x10,%esp
801036c7:	85 f6                	test   %esi,%esi
801036c9:	74 45                	je     80103710 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801036cb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036d1:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
801036d4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801036db:	00 00 00 
    wakeup(&p->nread);
801036de:	50                   	push   %eax
801036df:	e8 bc 0b 00 00       	call   801042a0 <wakeup>
801036e4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801036e7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801036ed:	85 d2                	test   %edx,%edx
801036ef:	75 0a                	jne    801036fb <pipeclose+0x4b>
801036f1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801036f7:	85 c0                	test   %eax,%eax
801036f9:	74 35                	je     80103730 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801036fb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801036fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103701:	5b                   	pop    %ebx
80103702:	5e                   	pop    %esi
80103703:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103704:	e9 87 10 00 00       	jmp    80104790 <release>
80103709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103710:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103716:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103719:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103720:	00 00 00 
    wakeup(&p->nwrite);
80103723:	50                   	push   %eax
80103724:	e8 77 0b 00 00       	call   801042a0 <wakeup>
80103729:	83 c4 10             	add    $0x10,%esp
8010372c:	eb b9                	jmp    801036e7 <pipeclose+0x37>
8010372e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103730:	83 ec 0c             	sub    $0xc,%esp
80103733:	53                   	push   %ebx
80103734:	e8 57 10 00 00       	call   80104790 <release>
    kfree((char*)p);
80103739:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010373c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010373f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103742:	5b                   	pop    %ebx
80103743:	5e                   	pop    %esi
80103744:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103745:	e9 56 ef ff ff       	jmp    801026a0 <kfree>
8010374a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103750 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	57                   	push   %edi
80103754:	56                   	push   %esi
80103755:	53                   	push   %ebx
80103756:	83 ec 28             	sub    $0x28,%esp
80103759:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010375c:	53                   	push   %ebx
8010375d:	e8 7e 0f 00 00       	call   801046e0 <acquire>
  for(i = 0; i < n; i++){
80103762:	8b 45 10             	mov    0x10(%ebp),%eax
80103765:	83 c4 10             	add    $0x10,%esp
80103768:	85 c0                	test   %eax,%eax
8010376a:	0f 8e b9 00 00 00    	jle    80103829 <pipewrite+0xd9>
80103770:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103773:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103779:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010377f:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103785:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103788:	03 4d 10             	add    0x10(%ebp),%ecx
8010378b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010378e:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103794:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010379a:	39 d0                	cmp    %edx,%eax
8010379c:	74 38                	je     801037d6 <pipewrite+0x86>
8010379e:	eb 59                	jmp    801037f9 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
801037a0:	e8 9b 03 00 00       	call   80103b40 <myproc>
801037a5:	8b 48 24             	mov    0x24(%eax),%ecx
801037a8:	85 c9                	test   %ecx,%ecx
801037aa:	75 34                	jne    801037e0 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801037ac:	83 ec 0c             	sub    $0xc,%esp
801037af:	57                   	push   %edi
801037b0:	e8 eb 0a 00 00       	call   801042a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037b5:	58                   	pop    %eax
801037b6:	5a                   	pop    %edx
801037b7:	53                   	push   %ebx
801037b8:	56                   	push   %esi
801037b9:	e8 32 09 00 00       	call   801040f0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037be:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801037c4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801037ca:	83 c4 10             	add    $0x10,%esp
801037cd:	05 00 02 00 00       	add    $0x200,%eax
801037d2:	39 c2                	cmp    %eax,%edx
801037d4:	75 2a                	jne    80103800 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
801037d6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801037dc:	85 c0                	test   %eax,%eax
801037de:	75 c0                	jne    801037a0 <pipewrite+0x50>
        release(&p->lock);
801037e0:	83 ec 0c             	sub    $0xc,%esp
801037e3:	53                   	push   %ebx
801037e4:	e8 a7 0f 00 00       	call   80104790 <release>
        return -1;
801037e9:	83 c4 10             	add    $0x10,%esp
801037ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801037f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037f4:	5b                   	pop    %ebx
801037f5:	5e                   	pop    %esi
801037f6:	5f                   	pop    %edi
801037f7:	5d                   	pop    %ebp
801037f8:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037f9:	89 c2                	mov    %eax,%edx
801037fb:	90                   	nop
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103800:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103803:	8d 42 01             	lea    0x1(%edx),%eax
80103806:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010380a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103810:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103816:	0f b6 09             	movzbl (%ecx),%ecx
80103819:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010381d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103820:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103823:	0f 85 65 ff ff ff    	jne    8010378e <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103829:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010382f:	83 ec 0c             	sub    $0xc,%esp
80103832:	50                   	push   %eax
80103833:	e8 68 0a 00 00       	call   801042a0 <wakeup>
  release(&p->lock);
80103838:	89 1c 24             	mov    %ebx,(%esp)
8010383b:	e8 50 0f 00 00       	call   80104790 <release>
  return n;
80103840:	83 c4 10             	add    $0x10,%esp
80103843:	8b 45 10             	mov    0x10(%ebp),%eax
80103846:	eb a9                	jmp    801037f1 <pipewrite+0xa1>
80103848:	90                   	nop
80103849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103850 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	57                   	push   %edi
80103854:	56                   	push   %esi
80103855:	53                   	push   %ebx
80103856:	83 ec 18             	sub    $0x18,%esp
80103859:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010385c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010385f:	53                   	push   %ebx
80103860:	e8 7b 0e 00 00       	call   801046e0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103865:	83 c4 10             	add    $0x10,%esp
80103868:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010386e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103874:	75 6a                	jne    801038e0 <piperead+0x90>
80103876:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010387c:	85 f6                	test   %esi,%esi
8010387e:	0f 84 cc 00 00 00    	je     80103950 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103884:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010388a:	eb 2d                	jmp    801038b9 <piperead+0x69>
8010388c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103890:	83 ec 08             	sub    $0x8,%esp
80103893:	53                   	push   %ebx
80103894:	56                   	push   %esi
80103895:	e8 56 08 00 00       	call   801040f0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010389a:	83 c4 10             	add    $0x10,%esp
8010389d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801038a3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801038a9:	75 35                	jne    801038e0 <piperead+0x90>
801038ab:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801038b1:	85 d2                	test   %edx,%edx
801038b3:	0f 84 97 00 00 00    	je     80103950 <piperead+0x100>
    if(myproc()->killed){
801038b9:	e8 82 02 00 00       	call   80103b40 <myproc>
801038be:	8b 48 24             	mov    0x24(%eax),%ecx
801038c1:	85 c9                	test   %ecx,%ecx
801038c3:	74 cb                	je     80103890 <piperead+0x40>
      release(&p->lock);
801038c5:	83 ec 0c             	sub    $0xc,%esp
801038c8:	53                   	push   %ebx
801038c9:	e8 c2 0e 00 00       	call   80104790 <release>
      return -1;
801038ce:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801038d1:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
801038d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801038d9:	5b                   	pop    %ebx
801038da:	5e                   	pop    %esi
801038db:	5f                   	pop    %edi
801038dc:	5d                   	pop    %ebp
801038dd:	c3                   	ret    
801038de:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801038e0:	8b 45 10             	mov    0x10(%ebp),%eax
801038e3:	85 c0                	test   %eax,%eax
801038e5:	7e 69                	jle    80103950 <piperead+0x100>
    if(p->nread == p->nwrite)
801038e7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801038ed:	31 c9                	xor    %ecx,%ecx
801038ef:	eb 15                	jmp    80103906 <piperead+0xb6>
801038f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038f8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801038fe:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103904:	74 5a                	je     80103960 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103906:	8d 70 01             	lea    0x1(%eax),%esi
80103909:	25 ff 01 00 00       	and    $0x1ff,%eax
8010390e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103914:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103919:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010391c:	83 c1 01             	add    $0x1,%ecx
8010391f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103922:	75 d4                	jne    801038f8 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103924:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010392a:	83 ec 0c             	sub    $0xc,%esp
8010392d:	50                   	push   %eax
8010392e:	e8 6d 09 00 00       	call   801042a0 <wakeup>
  release(&p->lock);
80103933:	89 1c 24             	mov    %ebx,(%esp)
80103936:	e8 55 0e 00 00       	call   80104790 <release>
  return i;
8010393b:	8b 45 10             	mov    0x10(%ebp),%eax
8010393e:	83 c4 10             	add    $0x10,%esp
}
80103941:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103944:	5b                   	pop    %ebx
80103945:	5e                   	pop    %esi
80103946:	5f                   	pop    %edi
80103947:	5d                   	pop    %ebp
80103948:	c3                   	ret    
80103949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103950:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103957:	eb cb                	jmp    80103924 <piperead+0xd4>
80103959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103960:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103963:	eb bf                	jmp    80103924 <piperead+0xd4>
80103965:	66 90                	xchg   %ax,%ax
80103967:	66 90                	xchg   %ax,%ax
80103969:	66 90                	xchg   %ax,%ax
8010396b:	66 90                	xchg   %ax,%ax
8010396d:	66 90                	xchg   %ax,%ax
8010396f:	90                   	nop

80103970 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103974:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103979:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010397c:	68 20 2d 11 80       	push   $0x80112d20
80103981:	e8 5a 0d 00 00       	call   801046e0 <acquire>
80103986:	83 c4 10             	add    $0x10,%esp
80103989:	eb 10                	jmp    8010399b <allocproc+0x2b>
8010398b:	90                   	nop
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103990:	83 c3 7c             	add    $0x7c,%ebx
80103993:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103999:	74 75                	je     80103a10 <allocproc+0xa0>
    if(p->state == UNUSED)
8010399b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010399e:	85 c0                	test   %eax,%eax
801039a0:	75 ee                	jne    80103990 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801039a2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801039a7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801039aa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
801039b1:	68 20 2d 11 80       	push   $0x80112d20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801039b6:	8d 50 01             	lea    0x1(%eax),%edx
801039b9:	89 43 10             	mov    %eax,0x10(%ebx)
801039bc:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
801039c2:	e8 c9 0d 00 00       	call   80104790 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801039c7:	e8 84 ee ff ff       	call   80102850 <kalloc>
801039cc:	83 c4 10             	add    $0x10,%esp
801039cf:	85 c0                	test   %eax,%eax
801039d1:	89 43 08             	mov    %eax,0x8(%ebx)
801039d4:	74 51                	je     80103a27 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801039d6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801039dc:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
801039df:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801039e4:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801039e7:	c7 40 14 f2 59 10 80 	movl   $0x801059f2,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801039ee:	6a 14                	push   $0x14
801039f0:	6a 00                	push   $0x0
801039f2:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
801039f3:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801039f6:	e8 e5 0d 00 00       	call   801047e0 <memset>
  p->context->eip = (uint)forkret;
801039fb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801039fe:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103a01:	c7 40 10 30 3a 10 80 	movl   $0x80103a30,0x10(%eax)

  return p;
80103a08:	89 d8                	mov    %ebx,%eax
}
80103a0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a0d:	c9                   	leave  
80103a0e:	c3                   	ret    
80103a0f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103a10:	83 ec 0c             	sub    $0xc,%esp
80103a13:	68 20 2d 11 80       	push   $0x80112d20
80103a18:	e8 73 0d 00 00       	call   80104790 <release>
  return 0;
80103a1d:	83 c4 10             	add    $0x10,%esp
80103a20:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a25:	c9                   	leave  
80103a26:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103a27:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103a2e:	eb da                	jmp    80103a0a <allocproc+0x9a>

80103a30 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103a36:	68 20 2d 11 80       	push   $0x80112d20
80103a3b:	e8 50 0d 00 00       	call   80104790 <release>

  if (first) {
80103a40:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103a45:	83 c4 10             	add    $0x10,%esp
80103a48:	85 c0                	test   %eax,%eax
80103a4a:	75 04                	jne    80103a50 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103a4c:	c9                   	leave  
80103a4d:	c3                   	ret    
80103a4e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103a50:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103a53:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103a5a:	00 00 00 
    iinit(ROOTDEV);
80103a5d:	6a 01                	push   $0x1
80103a5f:	e8 dc db ff ff       	call   80101640 <iinit>
    initlog(ROOTDEV);
80103a64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103a6b:	e8 00 f4 ff ff       	call   80102e70 <initlog>
80103a70:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103a73:	c9                   	leave  
80103a74:	c3                   	ret    
80103a75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a80 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103a80:	55                   	push   %ebp
80103a81:	89 e5                	mov    %esp,%ebp
80103a83:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103a86:	68 f5 77 10 80       	push   $0x801077f5
80103a8b:	68 20 2d 11 80       	push   $0x80112d20
80103a90:	e8 eb 0a 00 00       	call   80104580 <initlock>
}
80103a95:	83 c4 10             	add    $0x10,%esp
80103a98:	c9                   	leave  
80103a99:	c3                   	ret    
80103a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103aa0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	56                   	push   %esi
80103aa4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103aa5:	9c                   	pushf  
80103aa6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103aa7:	f6 c4 02             	test   $0x2,%ah
80103aaa:	75 5b                	jne    80103b07 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
80103aac:	e8 ff ef ff ff       	call   80102ab0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103ab1:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103ab7:	85 f6                	test   %esi,%esi
80103ab9:	7e 3f                	jle    80103afa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103abb:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103ac2:	39 d0                	cmp    %edx,%eax
80103ac4:	74 30                	je     80103af6 <mycpu+0x56>
80103ac6:	b9 30 28 11 80       	mov    $0x80112830,%ecx
80103acb:	31 d2                	xor    %edx,%edx
80103acd:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103ad0:	83 c2 01             	add    $0x1,%edx
80103ad3:	39 f2                	cmp    %esi,%edx
80103ad5:	74 23                	je     80103afa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103ad7:	0f b6 19             	movzbl (%ecx),%ebx
80103ada:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103ae0:	39 d8                	cmp    %ebx,%eax
80103ae2:	75 ec                	jne    80103ad0 <mycpu+0x30>
      return &cpus[i];
80103ae4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
80103aea:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aed:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
80103aee:	05 80 27 11 80       	add    $0x80112780,%eax
  }
  panic("unknown apicid\n");
}
80103af3:	5e                   	pop    %esi
80103af4:	5d                   	pop    %ebp
80103af5:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103af6:	31 d2                	xor    %edx,%edx
80103af8:	eb ea                	jmp    80103ae4 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
80103afa:	83 ec 0c             	sub    $0xc,%esp
80103afd:	68 fc 77 10 80       	push   $0x801077fc
80103b02:	e8 69 c8 ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103b07:	83 ec 0c             	sub    $0xc,%esp
80103b0a:	68 d8 78 10 80       	push   $0x801078d8
80103b0f:	e8 5c c8 ff ff       	call   80100370 <panic>
80103b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103b20 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103b26:	e8 75 ff ff ff       	call   80103aa0 <mycpu>
80103b2b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103b30:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103b31:	c1 f8 04             	sar    $0x4,%eax
80103b34:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103b3a:	c3                   	ret    
80103b3b:	90                   	nop
80103b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b40 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	53                   	push   %ebx
80103b44:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103b47:	e8 b4 0a 00 00       	call   80104600 <pushcli>
  c = mycpu();
80103b4c:	e8 4f ff ff ff       	call   80103aa0 <mycpu>
  p = c->proc;
80103b51:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b57:	e8 e4 0a 00 00       	call   80104640 <popcli>
  return p;
}
80103b5c:	83 c4 04             	add    $0x4,%esp
80103b5f:	89 d8                	mov    %ebx,%eax
80103b61:	5b                   	pop    %ebx
80103b62:	5d                   	pop    %ebp
80103b63:	c3                   	ret    
80103b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103b70 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	53                   	push   %ebx
80103b74:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103b77:	e8 f4 fd ff ff       	call   80103970 <allocproc>
80103b7c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
80103b7e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103b83:	e8 58 34 00 00       	call   80106fe0 <setupkvm>
80103b88:	85 c0                	test   %eax,%eax
80103b8a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b8d:	0f 84 bd 00 00 00    	je     80103c50 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b93:	83 ec 04             	sub    $0x4,%esp
80103b96:	68 2c 00 00 00       	push   $0x2c
80103b9b:	68 60 a4 10 80       	push   $0x8010a460
80103ba0:	50                   	push   %eax
80103ba1:	e8 4a 31 00 00       	call   80106cf0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103ba6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103ba9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103baf:	6a 4c                	push   $0x4c
80103bb1:	6a 00                	push   $0x0
80103bb3:	ff 73 18             	pushl  0x18(%ebx)
80103bb6:	e8 25 0c 00 00       	call   801047e0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bbb:	8b 43 18             	mov    0x18(%ebx),%eax
80103bbe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103bc3:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bc8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bcb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103bcf:	8b 43 18             	mov    0x18(%ebx),%eax
80103bd2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103bd6:	8b 43 18             	mov    0x18(%ebx),%eax
80103bd9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103bdd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103be1:	8b 43 18             	mov    0x18(%ebx),%eax
80103be4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103be8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103bec:	8b 43 18             	mov    0x18(%ebx),%eax
80103bef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103bf6:	8b 43 18             	mov    0x18(%ebx),%eax
80103bf9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c00:	8b 43 18             	mov    0x18(%ebx),%eax
80103c03:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c0a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c0d:	6a 10                	push   $0x10
80103c0f:	68 25 78 10 80       	push   $0x80107825
80103c14:	50                   	push   %eax
80103c15:	e8 c6 0d 00 00       	call   801049e0 <safestrcpy>
  p->cwd = namei("/");
80103c1a:	c7 04 24 2e 78 10 80 	movl   $0x8010782e,(%esp)
80103c21:	e8 5a e6 ff ff       	call   80102280 <namei>
80103c26:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103c29:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c30:	e8 ab 0a 00 00       	call   801046e0 <acquire>

  p->state = RUNNABLE;
80103c35:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103c3c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c43:	e8 48 0b 00 00       	call   80104790 <release>
}
80103c48:	83 c4 10             	add    $0x10,%esp
80103c4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c4e:	c9                   	leave  
80103c4f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103c50:	83 ec 0c             	sub    $0xc,%esp
80103c53:	68 0c 78 10 80       	push   $0x8010780c
80103c58:	e8 13 c7 ff ff       	call   80100370 <panic>
80103c5d:	8d 76 00             	lea    0x0(%esi),%esi

80103c60 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	56                   	push   %esi
80103c64:	53                   	push   %ebx
80103c65:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c68:	e8 93 09 00 00       	call   80104600 <pushcli>
  c = mycpu();
80103c6d:	e8 2e fe ff ff       	call   80103aa0 <mycpu>
  p = c->proc;
80103c72:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c78:	e8 c3 09 00 00       	call   80104640 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103c7d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103c80:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103c82:	7e 34                	jle    80103cb8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c84:	83 ec 04             	sub    $0x4,%esp
80103c87:	01 c6                	add    %eax,%esi
80103c89:	56                   	push   %esi
80103c8a:	50                   	push   %eax
80103c8b:	ff 73 04             	pushl  0x4(%ebx)
80103c8e:	e8 9d 31 00 00       	call   80106e30 <allocuvm>
80103c93:	83 c4 10             	add    $0x10,%esp
80103c96:	85 c0                	test   %eax,%eax
80103c98:	74 36                	je     80103cd0 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103c9a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103c9d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103c9f:	53                   	push   %ebx
80103ca0:	e8 3b 2f 00 00       	call   80106be0 <switchuvm>
  return 0;
80103ca5:	83 c4 10             	add    $0x10,%esp
80103ca8:	31 c0                	xor    %eax,%eax
}
80103caa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cad:	5b                   	pop    %ebx
80103cae:	5e                   	pop    %esi
80103caf:	5d                   	pop    %ebp
80103cb0:	c3                   	ret    
80103cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103cb8:	74 e0                	je     80103c9a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103cba:	83 ec 04             	sub    $0x4,%esp
80103cbd:	01 c6                	add    %eax,%esi
80103cbf:	56                   	push   %esi
80103cc0:	50                   	push   %eax
80103cc1:	ff 73 04             	pushl  0x4(%ebx)
80103cc4:	e8 67 32 00 00       	call   80106f30 <deallocuvm>
80103cc9:	83 c4 10             	add    $0x10,%esp
80103ccc:	85 c0                	test   %eax,%eax
80103cce:	75 ca                	jne    80103c9a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cd5:	eb d3                	jmp    80103caa <growproc+0x4a>
80103cd7:	89 f6                	mov    %esi,%esi
80103cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ce0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	57                   	push   %edi
80103ce4:	56                   	push   %esi
80103ce5:	53                   	push   %ebx
80103ce6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ce9:	e8 12 09 00 00       	call   80104600 <pushcli>
  c = mycpu();
80103cee:	e8 ad fd ff ff       	call   80103aa0 <mycpu>
  p = c->proc;
80103cf3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cf9:	e8 42 09 00 00       	call   80104640 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103cfe:	e8 6d fc ff ff       	call   80103970 <allocproc>
80103d03:	85 c0                	test   %eax,%eax
80103d05:	89 c7                	mov    %eax,%edi
80103d07:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d0a:	0f 84 b5 00 00 00    	je     80103dc5 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d10:	83 ec 08             	sub    $0x8,%esp
80103d13:	ff 33                	pushl  (%ebx)
80103d15:	ff 73 04             	pushl  0x4(%ebx)
80103d18:	e8 93 33 00 00       	call   801070b0 <copyuvm>
80103d1d:	83 c4 10             	add    $0x10,%esp
80103d20:	85 c0                	test   %eax,%eax
80103d22:	89 47 04             	mov    %eax,0x4(%edi)
80103d25:	0f 84 a1 00 00 00    	je     80103dcc <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103d2b:	8b 03                	mov    (%ebx),%eax
80103d2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103d30:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103d32:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103d35:	89 c8                	mov    %ecx,%eax
80103d37:	8b 79 18             	mov    0x18(%ecx),%edi
80103d3a:	8b 73 18             	mov    0x18(%ebx),%esi
80103d3d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103d42:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103d44:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103d46:	8b 40 18             	mov    0x18(%eax),%eax
80103d49:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103d50:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103d54:	85 c0                	test   %eax,%eax
80103d56:	74 13                	je     80103d6b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d58:	83 ec 0c             	sub    $0xc,%esp
80103d5b:	50                   	push   %eax
80103d5c:	e8 7f d0 ff ff       	call   80100de0 <filedup>
80103d61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103d64:	83 c4 10             	add    $0x10,%esp
80103d67:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103d6b:	83 c6 01             	add    $0x1,%esi
80103d6e:	83 fe 10             	cmp    $0x10,%esi
80103d71:	75 dd                	jne    80103d50 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103d73:	83 ec 0c             	sub    $0xc,%esp
80103d76:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d79:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103d7c:	e8 8f da ff ff       	call   80101810 <idup>
80103d81:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d84:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103d87:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d8a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d8d:	6a 10                	push   $0x10
80103d8f:	53                   	push   %ebx
80103d90:	50                   	push   %eax
80103d91:	e8 4a 0c 00 00       	call   801049e0 <safestrcpy>

  pid = np->pid;
80103d96:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103d99:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103da0:	e8 3b 09 00 00       	call   801046e0 <acquire>

  np->state = RUNNABLE;
80103da5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103dac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103db3:	e8 d8 09 00 00       	call   80104790 <release>

  return pid;
80103db8:	83 c4 10             	add    $0x10,%esp
80103dbb:	89 d8                	mov    %ebx,%eax
}
80103dbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103dc0:	5b                   	pop    %ebx
80103dc1:	5e                   	pop    %esi
80103dc2:	5f                   	pop    %edi
80103dc3:	5d                   	pop    %ebp
80103dc4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103dc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103dca:	eb f1                	jmp    80103dbd <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103dcc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103dcf:	83 ec 0c             	sub    $0xc,%esp
80103dd2:	ff 77 08             	pushl  0x8(%edi)
80103dd5:	e8 c6 e8 ff ff       	call   801026a0 <kfree>
    np->kstack = 0;
80103dda:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103de1:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103de8:	83 c4 10             	add    $0x10,%esp
80103deb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103df0:	eb cb                	jmp    80103dbd <fork+0xdd>
80103df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e00 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	57                   	push   %edi
80103e04:	56                   	push   %esi
80103e05:	53                   	push   %ebx
80103e06:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103e09:	e8 92 fc ff ff       	call   80103aa0 <mycpu>
80103e0e:	8d 78 04             	lea    0x4(%eax),%edi
80103e11:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103e13:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103e1a:	00 00 00 
80103e1d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103e20:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103e21:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e24:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103e29:	68 20 2d 11 80       	push   $0x80112d20
80103e2e:	e8 ad 08 00 00       	call   801046e0 <acquire>
80103e33:	83 c4 10             	add    $0x10,%esp
80103e36:	eb 13                	jmp    80103e4b <scheduler+0x4b>
80103e38:	90                   	nop
80103e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e40:	83 c3 7c             	add    $0x7c,%ebx
80103e43:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103e49:	74 45                	je     80103e90 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103e4b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103e4f:	75 ef                	jne    80103e40 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103e51:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103e54:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103e5a:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e5b:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103e5e:	e8 7d 2d 00 00       	call   80106be0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103e63:	58                   	pop    %eax
80103e64:	5a                   	pop    %edx
80103e65:	ff 73 a0             	pushl  -0x60(%ebx)
80103e68:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103e69:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103e70:	e8 c6 0b 00 00       	call   80104a3b <swtch>
      switchkvm();
80103e75:	e8 46 2d 00 00       	call   80106bc0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103e7a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e7d:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103e83:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103e8a:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e8d:	75 bc                	jne    80103e4b <scheduler+0x4b>
80103e8f:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103e90:	83 ec 0c             	sub    $0xc,%esp
80103e93:	68 20 2d 11 80       	push   $0x80112d20
80103e98:	e8 f3 08 00 00       	call   80104790 <release>

  }
80103e9d:	83 c4 10             	add    $0x10,%esp
80103ea0:	e9 7b ff ff ff       	jmp    80103e20 <scheduler+0x20>
80103ea5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103eb0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	56                   	push   %esi
80103eb4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103eb5:	e8 46 07 00 00       	call   80104600 <pushcli>
  c = mycpu();
80103eba:	e8 e1 fb ff ff       	call   80103aa0 <mycpu>
  p = c->proc;
80103ebf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ec5:	e8 76 07 00 00       	call   80104640 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103eca:	83 ec 0c             	sub    $0xc,%esp
80103ecd:	68 20 2d 11 80       	push   $0x80112d20
80103ed2:	e8 d9 07 00 00       	call   801046b0 <holding>
80103ed7:	83 c4 10             	add    $0x10,%esp
80103eda:	85 c0                	test   %eax,%eax
80103edc:	74 4f                	je     80103f2d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103ede:	e8 bd fb ff ff       	call   80103aa0 <mycpu>
80103ee3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103eea:	75 68                	jne    80103f54 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103eec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103ef0:	74 55                	je     80103f47 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ef2:	9c                   	pushf  
80103ef3:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103ef4:	f6 c4 02             	test   $0x2,%ah
80103ef7:	75 41                	jne    80103f3a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103ef9:	e8 a2 fb ff ff       	call   80103aa0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103efe:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103f01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103f07:	e8 94 fb ff ff       	call   80103aa0 <mycpu>
80103f0c:	83 ec 08             	sub    $0x8,%esp
80103f0f:	ff 70 04             	pushl  0x4(%eax)
80103f12:	53                   	push   %ebx
80103f13:	e8 23 0b 00 00       	call   80104a3b <swtch>
  mycpu()->intena = intena;
80103f18:	e8 83 fb ff ff       	call   80103aa0 <mycpu>
}
80103f1d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103f20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103f26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f29:	5b                   	pop    %ebx
80103f2a:	5e                   	pop    %esi
80103f2b:	5d                   	pop    %ebp
80103f2c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103f2d:	83 ec 0c             	sub    $0xc,%esp
80103f30:	68 30 78 10 80       	push   $0x80107830
80103f35:	e8 36 c4 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103f3a:	83 ec 0c             	sub    $0xc,%esp
80103f3d:	68 5c 78 10 80       	push   $0x8010785c
80103f42:	e8 29 c4 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103f47:	83 ec 0c             	sub    $0xc,%esp
80103f4a:	68 4e 78 10 80       	push   $0x8010784e
80103f4f:	e8 1c c4 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103f54:	83 ec 0c             	sub    $0xc,%esp
80103f57:	68 42 78 10 80       	push   $0x80107842
80103f5c:	e8 0f c4 ff ff       	call   80100370 <panic>
80103f61:	eb 0d                	jmp    80103f70 <exit>
80103f63:	90                   	nop
80103f64:	90                   	nop
80103f65:	90                   	nop
80103f66:	90                   	nop
80103f67:	90                   	nop
80103f68:	90                   	nop
80103f69:	90                   	nop
80103f6a:	90                   	nop
80103f6b:	90                   	nop
80103f6c:	90                   	nop
80103f6d:	90                   	nop
80103f6e:	90                   	nop
80103f6f:	90                   	nop

80103f70 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	57                   	push   %edi
80103f74:	56                   	push   %esi
80103f75:	53                   	push   %ebx
80103f76:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f79:	e8 82 06 00 00       	call   80104600 <pushcli>
  c = mycpu();
80103f7e:	e8 1d fb ff ff       	call   80103aa0 <mycpu>
  p = c->proc;
80103f83:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f89:	e8 b2 06 00 00       	call   80104640 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103f8e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103f94:	8d 5e 28             	lea    0x28(%esi),%ebx
80103f97:	8d 7e 68             	lea    0x68(%esi),%edi
80103f9a:	0f 84 e7 00 00 00    	je     80104087 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103fa0:	8b 03                	mov    (%ebx),%eax
80103fa2:	85 c0                	test   %eax,%eax
80103fa4:	74 12                	je     80103fb8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103fa6:	83 ec 0c             	sub    $0xc,%esp
80103fa9:	50                   	push   %eax
80103faa:	e8 81 ce ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103faf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103fb5:	83 c4 10             	add    $0x10,%esp
80103fb8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103fbb:	39 df                	cmp    %ebx,%edi
80103fbd:	75 e1                	jne    80103fa0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103fbf:	e8 4c ef ff ff       	call   80102f10 <begin_op>
  iput(curproc->cwd);
80103fc4:	83 ec 0c             	sub    $0xc,%esp
80103fc7:	ff 76 68             	pushl  0x68(%esi)
80103fca:	e8 a1 d9 ff ff       	call   80101970 <iput>
  end_op();
80103fcf:	e8 ac ef ff ff       	call   80102f80 <end_op>
  curproc->cwd = 0;
80103fd4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103fdb:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fe2:	e8 f9 06 00 00       	call   801046e0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103fe7:	8b 56 14             	mov    0x14(%esi),%edx
80103fea:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fed:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103ff2:	eb 0e                	jmp    80104002 <exit+0x92>
80103ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ff8:	83 c0 7c             	add    $0x7c,%eax
80103ffb:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104000:	74 1c                	je     8010401e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80104002:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104006:	75 f0                	jne    80103ff8 <exit+0x88>
80104008:	3b 50 20             	cmp    0x20(%eax),%edx
8010400b:	75 eb                	jne    80103ff8 <exit+0x88>
      p->state = RUNNABLE;
8010400d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104014:	83 c0 7c             	add    $0x7c,%eax
80104017:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
8010401c:	75 e4                	jne    80104002 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
8010401e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
80104024:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80104029:	eb 10                	jmp    8010403b <exit+0xcb>
8010402b:	90                   	nop
8010402c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104030:	83 c2 7c             	add    $0x7c,%edx
80104033:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80104039:	74 33                	je     8010406e <exit+0xfe>
    if(p->parent == curproc){
8010403b:	39 72 14             	cmp    %esi,0x14(%edx)
8010403e:	75 f0                	jne    80104030 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80104040:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80104044:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104047:	75 e7                	jne    80104030 <exit+0xc0>
80104049:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010404e:	eb 0a                	jmp    8010405a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104050:	83 c0 7c             	add    $0x7c,%eax
80104053:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104058:	74 d6                	je     80104030 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
8010405a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010405e:	75 f0                	jne    80104050 <exit+0xe0>
80104060:	3b 48 20             	cmp    0x20(%eax),%ecx
80104063:	75 eb                	jne    80104050 <exit+0xe0>
      p->state = RUNNABLE;
80104065:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010406c:	eb e2                	jmp    80104050 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
8010406e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104075:	e8 36 fe ff ff       	call   80103eb0 <sched>
  panic("zombie exit");
8010407a:	83 ec 0c             	sub    $0xc,%esp
8010407d:	68 7d 78 10 80       	push   $0x8010787d
80104082:	e8 e9 c2 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80104087:	83 ec 0c             	sub    $0xc,%esp
8010408a:	68 70 78 10 80       	push   $0x80107870
8010408f:	e8 dc c2 ff ff       	call   80100370 <panic>
80104094:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010409a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801040a0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	53                   	push   %ebx
801040a4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801040a7:	68 20 2d 11 80       	push   $0x80112d20
801040ac:	e8 2f 06 00 00       	call   801046e0 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801040b1:	e8 4a 05 00 00       	call   80104600 <pushcli>
  c = mycpu();
801040b6:	e8 e5 f9 ff ff       	call   80103aa0 <mycpu>
  p = c->proc;
801040bb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040c1:	e8 7a 05 00 00       	call   80104640 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
801040c6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801040cd:	e8 de fd ff ff       	call   80103eb0 <sched>
  release(&ptable.lock);
801040d2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040d9:	e8 b2 06 00 00       	call   80104790 <release>
}
801040de:	83 c4 10             	add    $0x10,%esp
801040e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040e4:	c9                   	leave  
801040e5:	c3                   	ret    
801040e6:	8d 76 00             	lea    0x0(%esi),%esi
801040e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040f0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	57                   	push   %edi
801040f4:	56                   	push   %esi
801040f5:	53                   	push   %ebx
801040f6:	83 ec 0c             	sub    $0xc,%esp
801040f9:	8b 7d 08             	mov    0x8(%ebp),%edi
801040fc:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801040ff:	e8 fc 04 00 00       	call   80104600 <pushcli>
  c = mycpu();
80104104:	e8 97 f9 ff ff       	call   80103aa0 <mycpu>
  p = c->proc;
80104109:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010410f:	e8 2c 05 00 00       	call   80104640 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80104114:	85 db                	test   %ebx,%ebx
80104116:	0f 84 87 00 00 00    	je     801041a3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
8010411c:	85 f6                	test   %esi,%esi
8010411e:	74 76                	je     80104196 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104120:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80104126:	74 50                	je     80104178 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104128:	83 ec 0c             	sub    $0xc,%esp
8010412b:	68 20 2d 11 80       	push   $0x80112d20
80104130:	e8 ab 05 00 00       	call   801046e0 <acquire>
    release(lk);
80104135:	89 34 24             	mov    %esi,(%esp)
80104138:	e8 53 06 00 00       	call   80104790 <release>
  }
  // Go to sleep.
  p->chan = chan;
8010413d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104140:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104147:	e8 64 fd ff ff       	call   80103eb0 <sched>

  // Tidy up.
  p->chan = 0;
8010414c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104153:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010415a:	e8 31 06 00 00       	call   80104790 <release>
    acquire(lk);
8010415f:	89 75 08             	mov    %esi,0x8(%ebp)
80104162:	83 c4 10             	add    $0x10,%esp
  }
}
80104165:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104168:	5b                   	pop    %ebx
80104169:	5e                   	pop    %esi
8010416a:	5f                   	pop    %edi
8010416b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
8010416c:	e9 6f 05 00 00       	jmp    801046e0 <acquire>
80104171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80104178:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010417b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104182:	e8 29 fd ff ff       	call   80103eb0 <sched>

  // Tidy up.
  p->chan = 0;
80104187:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
8010418e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104191:	5b                   	pop    %ebx
80104192:	5e                   	pop    %esi
80104193:	5f                   	pop    %edi
80104194:	5d                   	pop    %ebp
80104195:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80104196:	83 ec 0c             	sub    $0xc,%esp
80104199:	68 8f 78 10 80       	push   $0x8010788f
8010419e:	e8 cd c1 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
801041a3:	83 ec 0c             	sub    $0xc,%esp
801041a6:	68 89 78 10 80       	push   $0x80107889
801041ab:	e8 c0 c1 ff ff       	call   80100370 <panic>

801041b0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	56                   	push   %esi
801041b4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801041b5:	e8 46 04 00 00       	call   80104600 <pushcli>
  c = mycpu();
801041ba:	e8 e1 f8 ff ff       	call   80103aa0 <mycpu>
  p = c->proc;
801041bf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801041c5:	e8 76 04 00 00       	call   80104640 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
801041ca:	83 ec 0c             	sub    $0xc,%esp
801041cd:	68 20 2d 11 80       	push   $0x80112d20
801041d2:	e8 09 05 00 00       	call   801046e0 <acquire>
801041d7:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801041da:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041dc:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
801041e1:	eb 10                	jmp    801041f3 <wait+0x43>
801041e3:	90                   	nop
801041e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041e8:	83 c3 7c             	add    $0x7c,%ebx
801041eb:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801041f1:	74 1d                	je     80104210 <wait+0x60>
      if(p->parent != curproc)
801041f3:	39 73 14             	cmp    %esi,0x14(%ebx)
801041f6:	75 f0                	jne    801041e8 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
801041f8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801041fc:	74 30                	je     8010422e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041fe:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104201:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104206:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
8010420c:	75 e5                	jne    801041f3 <wait+0x43>
8010420e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104210:	85 c0                	test   %eax,%eax
80104212:	74 70                	je     80104284 <wait+0xd4>
80104214:	8b 46 24             	mov    0x24(%esi),%eax
80104217:	85 c0                	test   %eax,%eax
80104219:	75 69                	jne    80104284 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010421b:	83 ec 08             	sub    $0x8,%esp
8010421e:	68 20 2d 11 80       	push   $0x80112d20
80104223:	56                   	push   %esi
80104224:	e8 c7 fe ff ff       	call   801040f0 <sleep>
  }
80104229:	83 c4 10             	add    $0x10,%esp
8010422c:	eb ac                	jmp    801041da <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
8010422e:	83 ec 0c             	sub    $0xc,%esp
80104231:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104234:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104237:	e8 64 e4 ff ff       	call   801026a0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
8010423c:	5a                   	pop    %edx
8010423d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104240:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104247:	e8 14 2d 00 00       	call   80106f60 <freevm>
        p->pid = 0;
8010424c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104253:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010425a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010425e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104265:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010426c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104273:	e8 18 05 00 00       	call   80104790 <release>
        return pid;
80104278:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010427b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
8010427e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104280:	5b                   	pop    %ebx
80104281:	5e                   	pop    %esi
80104282:	5d                   	pop    %ebp
80104283:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104284:	83 ec 0c             	sub    $0xc,%esp
80104287:	68 20 2d 11 80       	push   $0x80112d20
8010428c:	e8 ff 04 00 00       	call   80104790 <release>
      return -1;
80104291:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104294:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104297:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010429c:	5b                   	pop    %ebx
8010429d:	5e                   	pop    %esi
8010429e:	5d                   	pop    %ebp
8010429f:	c3                   	ret    

801042a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 10             	sub    $0x10,%esp
801042a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801042aa:	68 20 2d 11 80       	push   $0x80112d20
801042af:	e8 2c 04 00 00       	call   801046e0 <acquire>
801042b4:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042b7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801042bc:	eb 0c                	jmp    801042ca <wakeup+0x2a>
801042be:	66 90                	xchg   %ax,%ax
801042c0:	83 c0 7c             	add    $0x7c,%eax
801042c3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
801042c8:	74 1c                	je     801042e6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801042ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801042ce:	75 f0                	jne    801042c0 <wakeup+0x20>
801042d0:	3b 58 20             	cmp    0x20(%eax),%ebx
801042d3:	75 eb                	jne    801042c0 <wakeup+0x20>
      p->state = RUNNABLE;
801042d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042dc:	83 c0 7c             	add    $0x7c,%eax
801042df:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
801042e4:	75 e4                	jne    801042ca <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801042e6:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801042ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042f0:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801042f1:	e9 9a 04 00 00       	jmp    80104790 <release>
801042f6:	8d 76 00             	lea    0x0(%esi),%esi
801042f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104300 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	53                   	push   %ebx
80104304:	83 ec 10             	sub    $0x10,%esp
80104307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010430a:	68 20 2d 11 80       	push   $0x80112d20
8010430f:	e8 cc 03 00 00       	call   801046e0 <acquire>
80104314:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104317:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010431c:	eb 0c                	jmp    8010432a <kill+0x2a>
8010431e:	66 90                	xchg   %ax,%ax
80104320:	83 c0 7c             	add    $0x7c,%eax
80104323:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104328:	74 3e                	je     80104368 <kill+0x68>
    if(p->pid == pid){
8010432a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010432d:	75 f1                	jne    80104320 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010432f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104333:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010433a:	74 1c                	je     80104358 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010433c:	83 ec 0c             	sub    $0xc,%esp
8010433f:	68 20 2d 11 80       	push   $0x80112d20
80104344:	e8 47 04 00 00       	call   80104790 <release>
      return 0;
80104349:	83 c4 10             	add    $0x10,%esp
8010434c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010434e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104351:	c9                   	leave  
80104352:	c3                   	ret    
80104353:	90                   	nop
80104354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104358:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010435f:	eb db                	jmp    8010433c <kill+0x3c>
80104361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104368:	83 ec 0c             	sub    $0xc,%esp
8010436b:	68 20 2d 11 80       	push   $0x80112d20
80104370:	e8 1b 04 00 00       	call   80104790 <release>
  return -1;
80104375:	83 c4 10             	add    $0x10,%esp
80104378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010437d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104380:	c9                   	leave  
80104381:	c3                   	ret    
80104382:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104390 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	57                   	push   %edi
80104394:	56                   	push   %esi
80104395:	53                   	push   %ebx
80104396:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104399:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010439e:	83 ec 3c             	sub    $0x3c,%esp
801043a1:	eb 24                	jmp    801043c7 <procdump+0x37>
801043a3:	90                   	nop
801043a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801043a8:	83 ec 0c             	sub    $0xc,%esp
801043ab:	68 17 7c 10 80       	push   $0x80107c17
801043b0:	e8 ab c2 ff ff       	call   80100660 <cprintf>
801043b5:	83 c4 10             	add    $0x10,%esp
801043b8:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043bb:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
801043c1:	0f 84 81 00 00 00    	je     80104448 <procdump+0xb8>
    if(p->state == UNUSED)
801043c7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801043ca:	85 c0                	test   %eax,%eax
801043cc:	74 ea                	je     801043b8 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043ce:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801043d1:	ba a0 78 10 80       	mov    $0x801078a0,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043d6:	77 11                	ja     801043e9 <procdump+0x59>
801043d8:	8b 14 85 00 79 10 80 	mov    -0x7fef8700(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801043df:	b8 a0 78 10 80       	mov    $0x801078a0,%eax
801043e4:	85 d2                	test   %edx,%edx
801043e6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801043e9:	53                   	push   %ebx
801043ea:	52                   	push   %edx
801043eb:	ff 73 a4             	pushl  -0x5c(%ebx)
801043ee:	68 a4 78 10 80       	push   $0x801078a4
801043f3:	e8 68 c2 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801043f8:	83 c4 10             	add    $0x10,%esp
801043fb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801043ff:	75 a7                	jne    801043a8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104401:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104404:	83 ec 08             	sub    $0x8,%esp
80104407:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010440a:	50                   	push   %eax
8010440b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010440e:	8b 40 0c             	mov    0xc(%eax),%eax
80104411:	83 c0 08             	add    $0x8,%eax
80104414:	50                   	push   %eax
80104415:	e8 86 01 00 00       	call   801045a0 <getcallerpcs>
8010441a:	83 c4 10             	add    $0x10,%esp
8010441d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104420:	8b 17                	mov    (%edi),%edx
80104422:	85 d2                	test   %edx,%edx
80104424:	74 82                	je     801043a8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104426:	83 ec 08             	sub    $0x8,%esp
80104429:	83 c7 04             	add    $0x4,%edi
8010442c:	52                   	push   %edx
8010442d:	68 e1 72 10 80       	push   $0x801072e1
80104432:	e8 29 c2 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104437:	83 c4 10             	add    $0x10,%esp
8010443a:	39 f7                	cmp    %esi,%edi
8010443c:	75 e2                	jne    80104420 <procdump+0x90>
8010443e:	e9 65 ff ff ff       	jmp    801043a8 <procdump+0x18>
80104443:	90                   	nop
80104444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104448:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010444b:	5b                   	pop    %ebx
8010444c:	5e                   	pop    %esi
8010444d:	5f                   	pop    %edi
8010444e:	5d                   	pop    %ebp
8010444f:	c3                   	ret    

80104450 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	53                   	push   %ebx
80104454:	83 ec 0c             	sub    $0xc,%esp
80104457:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010445a:	68 18 79 10 80       	push   $0x80107918
8010445f:	8d 43 04             	lea    0x4(%ebx),%eax
80104462:	50                   	push   %eax
80104463:	e8 18 01 00 00       	call   80104580 <initlock>
  lk->name = name;
80104468:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010446b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104471:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104474:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010447b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010447e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104481:	c9                   	leave  
80104482:	c3                   	ret    
80104483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104490 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	56                   	push   %esi
80104494:	53                   	push   %ebx
80104495:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104498:	83 ec 0c             	sub    $0xc,%esp
8010449b:	8d 73 04             	lea    0x4(%ebx),%esi
8010449e:	56                   	push   %esi
8010449f:	e8 3c 02 00 00       	call   801046e0 <acquire>
  while (lk->locked) {
801044a4:	8b 13                	mov    (%ebx),%edx
801044a6:	83 c4 10             	add    $0x10,%esp
801044a9:	85 d2                	test   %edx,%edx
801044ab:	74 16                	je     801044c3 <acquiresleep+0x33>
801044ad:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801044b0:	83 ec 08             	sub    $0x8,%esp
801044b3:	56                   	push   %esi
801044b4:	53                   	push   %ebx
801044b5:	e8 36 fc ff ff       	call   801040f0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
801044ba:	8b 03                	mov    (%ebx),%eax
801044bc:	83 c4 10             	add    $0x10,%esp
801044bf:	85 c0                	test   %eax,%eax
801044c1:	75 ed                	jne    801044b0 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
801044c3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801044c9:	e8 72 f6 ff ff       	call   80103b40 <myproc>
801044ce:	8b 40 10             	mov    0x10(%eax),%eax
801044d1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801044d4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801044d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044da:	5b                   	pop    %ebx
801044db:	5e                   	pop    %esi
801044dc:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
801044dd:	e9 ae 02 00 00       	jmp    80104790 <release>
801044e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044f0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	56                   	push   %esi
801044f4:	53                   	push   %ebx
801044f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801044f8:	83 ec 0c             	sub    $0xc,%esp
801044fb:	8d 73 04             	lea    0x4(%ebx),%esi
801044fe:	56                   	push   %esi
801044ff:	e8 dc 01 00 00       	call   801046e0 <acquire>
  lk->locked = 0;
80104504:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010450a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104511:	89 1c 24             	mov    %ebx,(%esp)
80104514:	e8 87 fd ff ff       	call   801042a0 <wakeup>
  release(&lk->lk);
80104519:	89 75 08             	mov    %esi,0x8(%ebp)
8010451c:	83 c4 10             	add    $0x10,%esp
}
8010451f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104522:	5b                   	pop    %ebx
80104523:	5e                   	pop    %esi
80104524:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104525:	e9 66 02 00 00       	jmp    80104790 <release>
8010452a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104530 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	56                   	push   %esi
80104535:	53                   	push   %ebx
80104536:	31 ff                	xor    %edi,%edi
80104538:	83 ec 18             	sub    $0x18,%esp
8010453b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010453e:	8d 73 04             	lea    0x4(%ebx),%esi
80104541:	56                   	push   %esi
80104542:	e8 99 01 00 00       	call   801046e0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104547:	8b 03                	mov    (%ebx),%eax
80104549:	83 c4 10             	add    $0x10,%esp
8010454c:	85 c0                	test   %eax,%eax
8010454e:	74 13                	je     80104563 <holdingsleep+0x33>
80104550:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104553:	e8 e8 f5 ff ff       	call   80103b40 <myproc>
80104558:	39 58 10             	cmp    %ebx,0x10(%eax)
8010455b:	0f 94 c0             	sete   %al
8010455e:	0f b6 c0             	movzbl %al,%eax
80104561:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104563:	83 ec 0c             	sub    $0xc,%esp
80104566:	56                   	push   %esi
80104567:	e8 24 02 00 00       	call   80104790 <release>
  return r;
}
8010456c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010456f:	89 f8                	mov    %edi,%eax
80104571:	5b                   	pop    %ebx
80104572:	5e                   	pop    %esi
80104573:	5f                   	pop    %edi
80104574:	5d                   	pop    %ebp
80104575:	c3                   	ret    
80104576:	66 90                	xchg   %ax,%ax
80104578:	66 90                	xchg   %ax,%ax
8010457a:	66 90                	xchg   %ax,%ax
8010457c:	66 90                	xchg   %ax,%ax
8010457e:	66 90                	xchg   %ax,%ax

80104580 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104586:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104589:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010458f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104592:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104599:	5d                   	pop    %ebp
8010459a:	c3                   	ret    
8010459b:	90                   	nop
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801045a4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801045a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801045aa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801045ad:	31 c0                	xor    %eax,%eax
801045af:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045b0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801045b6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801045bc:	77 1a                	ja     801045d8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801045be:	8b 5a 04             	mov    0x4(%edx),%ebx
801045c1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801045c4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801045c7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801045c9:	83 f8 0a             	cmp    $0xa,%eax
801045cc:	75 e2                	jne    801045b0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801045ce:	5b                   	pop    %ebx
801045cf:	5d                   	pop    %ebp
801045d0:	c3                   	ret    
801045d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801045d8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801045df:	83 c0 01             	add    $0x1,%eax
801045e2:	83 f8 0a             	cmp    $0xa,%eax
801045e5:	74 e7                	je     801045ce <getcallerpcs+0x2e>
    pcs[i] = 0;
801045e7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801045ee:	83 c0 01             	add    $0x1,%eax
801045f1:	83 f8 0a             	cmp    $0xa,%eax
801045f4:	75 e2                	jne    801045d8 <getcallerpcs+0x38>
801045f6:	eb d6                	jmp    801045ce <getcallerpcs+0x2e>
801045f8:	90                   	nop
801045f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104600 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	53                   	push   %ebx
80104604:	83 ec 04             	sub    $0x4,%esp
80104607:	9c                   	pushf  
80104608:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104609:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010460a:	e8 91 f4 ff ff       	call   80103aa0 <mycpu>
8010460f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104615:	85 c0                	test   %eax,%eax
80104617:	75 11                	jne    8010462a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104619:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010461f:	e8 7c f4 ff ff       	call   80103aa0 <mycpu>
80104624:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010462a:	e8 71 f4 ff ff       	call   80103aa0 <mycpu>
8010462f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104636:	83 c4 04             	add    $0x4,%esp
80104639:	5b                   	pop    %ebx
8010463a:	5d                   	pop    %ebp
8010463b:	c3                   	ret    
8010463c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104640 <popcli>:

void
popcli(void)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104646:	9c                   	pushf  
80104647:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104648:	f6 c4 02             	test   $0x2,%ah
8010464b:	75 52                	jne    8010469f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010464d:	e8 4e f4 ff ff       	call   80103aa0 <mycpu>
80104652:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104658:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010465b:	85 d2                	test   %edx,%edx
8010465d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104663:	78 2d                	js     80104692 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104665:	e8 36 f4 ff ff       	call   80103aa0 <mycpu>
8010466a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104670:	85 d2                	test   %edx,%edx
80104672:	74 0c                	je     80104680 <popcli+0x40>
    sti();
}
80104674:	c9                   	leave  
80104675:	c3                   	ret    
80104676:	8d 76 00             	lea    0x0(%esi),%esi
80104679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104680:	e8 1b f4 ff ff       	call   80103aa0 <mycpu>
80104685:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010468b:	85 c0                	test   %eax,%eax
8010468d:	74 e5                	je     80104674 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010468f:	fb                   	sti    
    sti();
}
80104690:	c9                   	leave  
80104691:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80104692:	83 ec 0c             	sub    $0xc,%esp
80104695:	68 3a 79 10 80       	push   $0x8010793a
8010469a:	e8 d1 bc ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010469f:	83 ec 0c             	sub    $0xc,%esp
801046a2:	68 23 79 10 80       	push   $0x80107923
801046a7:	e8 c4 bc ff ff       	call   80100370 <panic>
801046ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046b0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	53                   	push   %ebx
801046b5:	8b 75 08             	mov    0x8(%ebp),%esi
801046b8:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
801046ba:	e8 41 ff ff ff       	call   80104600 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801046bf:	8b 06                	mov    (%esi),%eax
801046c1:	85 c0                	test   %eax,%eax
801046c3:	74 10                	je     801046d5 <holding+0x25>
801046c5:	8b 5e 08             	mov    0x8(%esi),%ebx
801046c8:	e8 d3 f3 ff ff       	call   80103aa0 <mycpu>
801046cd:	39 c3                	cmp    %eax,%ebx
801046cf:	0f 94 c3             	sete   %bl
801046d2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801046d5:	e8 66 ff ff ff       	call   80104640 <popcli>
  return r;
}
801046da:	89 d8                	mov    %ebx,%eax
801046dc:	5b                   	pop    %ebx
801046dd:	5e                   	pop    %esi
801046de:	5d                   	pop    %ebp
801046df:	c3                   	ret    

801046e0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	53                   	push   %ebx
801046e4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801046e7:	e8 14 ff ff ff       	call   80104600 <pushcli>
  if(holding(lk))
801046ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046ef:	83 ec 0c             	sub    $0xc,%esp
801046f2:	53                   	push   %ebx
801046f3:	e8 b8 ff ff ff       	call   801046b0 <holding>
801046f8:	83 c4 10             	add    $0x10,%esp
801046fb:	85 c0                	test   %eax,%eax
801046fd:	0f 85 7d 00 00 00    	jne    80104780 <acquire+0xa0>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104703:	ba 01 00 00 00       	mov    $0x1,%edx
80104708:	eb 09                	jmp    80104713 <acquire+0x33>
8010470a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104710:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104713:	89 d0                	mov    %edx,%eax
80104715:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104718:	85 c0                	test   %eax,%eax
8010471a:	75 f4                	jne    80104710 <acquire+0x30>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010471c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104721:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104724:	e8 77 f3 ff ff       	call   80103aa0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104729:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010472b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010472e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104731:	31 c0                	xor    %eax,%eax
80104733:	90                   	nop
80104734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104738:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010473e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104744:	77 1a                	ja     80104760 <acquire+0x80>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104746:	8b 5a 04             	mov    0x4(%edx),%ebx
80104749:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010474c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010474f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104751:	83 f8 0a             	cmp    $0xa,%eax
80104754:	75 e2                	jne    80104738 <acquire+0x58>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104756:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104759:	c9                   	leave  
8010475a:	c3                   	ret    
8010475b:	90                   	nop
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104760:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104767:	83 c0 01             	add    $0x1,%eax
8010476a:	83 f8 0a             	cmp    $0xa,%eax
8010476d:	74 e7                	je     80104756 <acquire+0x76>
    pcs[i] = 0;
8010476f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104776:	83 c0 01             	add    $0x1,%eax
80104779:	83 f8 0a             	cmp    $0xa,%eax
8010477c:	75 e2                	jne    80104760 <acquire+0x80>
8010477e:	eb d6                	jmp    80104756 <acquire+0x76>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104780:	83 ec 0c             	sub    $0xc,%esp
80104783:	68 41 79 10 80       	push   $0x80107941
80104788:	e8 e3 bb ff ff       	call   80100370 <panic>
8010478d:	8d 76 00             	lea    0x0(%esi),%esi

80104790 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	53                   	push   %ebx
80104794:	83 ec 10             	sub    $0x10,%esp
80104797:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010479a:	53                   	push   %ebx
8010479b:	e8 10 ff ff ff       	call   801046b0 <holding>
801047a0:	83 c4 10             	add    $0x10,%esp
801047a3:	85 c0                	test   %eax,%eax
801047a5:	74 22                	je     801047c9 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
801047a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801047ae:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801047b5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801047ba:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
801047c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047c3:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
801047c4:	e9 77 fe ff ff       	jmp    80104640 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801047c9:	83 ec 0c             	sub    $0xc,%esp
801047cc:	68 49 79 10 80       	push   $0x80107949
801047d1:	e8 9a bb ff ff       	call   80100370 <panic>
801047d6:	66 90                	xchg   %ax,%ax
801047d8:	66 90                	xchg   %ax,%ax
801047da:	66 90                	xchg   %ax,%ax
801047dc:	66 90                	xchg   %ax,%ax
801047de:	66 90                	xchg   %ax,%ax

801047e0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	57                   	push   %edi
801047e4:	53                   	push   %ebx
801047e5:	8b 55 08             	mov    0x8(%ebp),%edx
801047e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801047eb:	f6 c2 03             	test   $0x3,%dl
801047ee:	75 05                	jne    801047f5 <memset+0x15>
801047f0:	f6 c1 03             	test   $0x3,%cl
801047f3:	74 13                	je     80104808 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801047f5:	89 d7                	mov    %edx,%edi
801047f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801047fa:	fc                   	cld    
801047fb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801047fd:	5b                   	pop    %ebx
801047fe:	89 d0                	mov    %edx,%eax
80104800:	5f                   	pop    %edi
80104801:	5d                   	pop    %ebp
80104802:	c3                   	ret    
80104803:	90                   	nop
80104804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104808:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010480c:	c1 e9 02             	shr    $0x2,%ecx
8010480f:	89 fb                	mov    %edi,%ebx
80104811:	89 f8                	mov    %edi,%eax
80104813:	c1 e3 18             	shl    $0x18,%ebx
80104816:	c1 e0 10             	shl    $0x10,%eax
80104819:	09 d8                	or     %ebx,%eax
8010481b:	09 f8                	or     %edi,%eax
8010481d:	c1 e7 08             	shl    $0x8,%edi
80104820:	09 f8                	or     %edi,%eax
80104822:	89 d7                	mov    %edx,%edi
80104824:	fc                   	cld    
80104825:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104827:	5b                   	pop    %ebx
80104828:	89 d0                	mov    %edx,%eax
8010482a:	5f                   	pop    %edi
8010482b:	5d                   	pop    %ebp
8010482c:	c3                   	ret    
8010482d:	8d 76 00             	lea    0x0(%esi),%esi

80104830 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	57                   	push   %edi
80104834:	56                   	push   %esi
80104835:	8b 45 10             	mov    0x10(%ebp),%eax
80104838:	53                   	push   %ebx
80104839:	8b 75 0c             	mov    0xc(%ebp),%esi
8010483c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010483f:	85 c0                	test   %eax,%eax
80104841:	74 29                	je     8010486c <memcmp+0x3c>
    if(*s1 != *s2)
80104843:	0f b6 13             	movzbl (%ebx),%edx
80104846:	0f b6 0e             	movzbl (%esi),%ecx
80104849:	38 d1                	cmp    %dl,%cl
8010484b:	75 2b                	jne    80104878 <memcmp+0x48>
8010484d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104850:	31 c0                	xor    %eax,%eax
80104852:	eb 14                	jmp    80104868 <memcmp+0x38>
80104854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104858:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010485d:	83 c0 01             	add    $0x1,%eax
80104860:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104864:	38 ca                	cmp    %cl,%dl
80104866:	75 10                	jne    80104878 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104868:	39 f8                	cmp    %edi,%eax
8010486a:	75 ec                	jne    80104858 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010486c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010486d:	31 c0                	xor    %eax,%eax
}
8010486f:	5e                   	pop    %esi
80104870:	5f                   	pop    %edi
80104871:	5d                   	pop    %ebp
80104872:	c3                   	ret    
80104873:	90                   	nop
80104874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104878:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010487b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010487c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010487e:	5e                   	pop    %esi
8010487f:	5f                   	pop    %edi
80104880:	5d                   	pop    %ebp
80104881:	c3                   	ret    
80104882:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104890 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	56                   	push   %esi
80104894:	53                   	push   %ebx
80104895:	8b 45 08             	mov    0x8(%ebp),%eax
80104898:	8b 75 0c             	mov    0xc(%ebp),%esi
8010489b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010489e:	39 c6                	cmp    %eax,%esi
801048a0:	73 2e                	jae    801048d0 <memmove+0x40>
801048a2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801048a5:	39 c8                	cmp    %ecx,%eax
801048a7:	73 27                	jae    801048d0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801048a9:	85 db                	test   %ebx,%ebx
801048ab:	8d 53 ff             	lea    -0x1(%ebx),%edx
801048ae:	74 17                	je     801048c7 <memmove+0x37>
      *--d = *--s;
801048b0:	29 d9                	sub    %ebx,%ecx
801048b2:	89 cb                	mov    %ecx,%ebx
801048b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048b8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801048bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801048bf:	83 ea 01             	sub    $0x1,%edx
801048c2:	83 fa ff             	cmp    $0xffffffff,%edx
801048c5:	75 f1                	jne    801048b8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801048c7:	5b                   	pop    %ebx
801048c8:	5e                   	pop    %esi
801048c9:	5d                   	pop    %ebp
801048ca:	c3                   	ret    
801048cb:	90                   	nop
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801048d0:	31 d2                	xor    %edx,%edx
801048d2:	85 db                	test   %ebx,%ebx
801048d4:	74 f1                	je     801048c7 <memmove+0x37>
801048d6:	8d 76 00             	lea    0x0(%esi),%esi
801048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801048e0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801048e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801048e7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801048ea:	39 d3                	cmp    %edx,%ebx
801048ec:	75 f2                	jne    801048e0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801048ee:	5b                   	pop    %ebx
801048ef:	5e                   	pop    %esi
801048f0:	5d                   	pop    %ebp
801048f1:	c3                   	ret    
801048f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104900 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104903:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104904:	eb 8a                	jmp    80104890 <memmove>
80104906:	8d 76 00             	lea    0x0(%esi),%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104910 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	57                   	push   %edi
80104914:	56                   	push   %esi
80104915:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104918:	53                   	push   %ebx
80104919:	8b 7d 08             	mov    0x8(%ebp),%edi
8010491c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010491f:	85 c9                	test   %ecx,%ecx
80104921:	74 37                	je     8010495a <strncmp+0x4a>
80104923:	0f b6 17             	movzbl (%edi),%edx
80104926:	0f b6 1e             	movzbl (%esi),%ebx
80104929:	84 d2                	test   %dl,%dl
8010492b:	74 3f                	je     8010496c <strncmp+0x5c>
8010492d:	38 d3                	cmp    %dl,%bl
8010492f:	75 3b                	jne    8010496c <strncmp+0x5c>
80104931:	8d 47 01             	lea    0x1(%edi),%eax
80104934:	01 cf                	add    %ecx,%edi
80104936:	eb 1b                	jmp    80104953 <strncmp+0x43>
80104938:	90                   	nop
80104939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104940:	0f b6 10             	movzbl (%eax),%edx
80104943:	84 d2                	test   %dl,%dl
80104945:	74 21                	je     80104968 <strncmp+0x58>
80104947:	0f b6 19             	movzbl (%ecx),%ebx
8010494a:	83 c0 01             	add    $0x1,%eax
8010494d:	89 ce                	mov    %ecx,%esi
8010494f:	38 da                	cmp    %bl,%dl
80104951:	75 19                	jne    8010496c <strncmp+0x5c>
80104953:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104955:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104958:	75 e6                	jne    80104940 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010495a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010495b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010495d:	5e                   	pop    %esi
8010495e:	5f                   	pop    %edi
8010495f:	5d                   	pop    %ebp
80104960:	c3                   	ret    
80104961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104968:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010496c:	0f b6 c2             	movzbl %dl,%eax
8010496f:	29 d8                	sub    %ebx,%eax
}
80104971:	5b                   	pop    %ebx
80104972:	5e                   	pop    %esi
80104973:	5f                   	pop    %edi
80104974:	5d                   	pop    %ebp
80104975:	c3                   	ret    
80104976:	8d 76 00             	lea    0x0(%esi),%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104980 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	56                   	push   %esi
80104984:	53                   	push   %ebx
80104985:	8b 45 08             	mov    0x8(%ebp),%eax
80104988:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010498b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010498e:	89 c2                	mov    %eax,%edx
80104990:	eb 19                	jmp    801049ab <strncpy+0x2b>
80104992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104998:	83 c3 01             	add    $0x1,%ebx
8010499b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010499f:	83 c2 01             	add    $0x1,%edx
801049a2:	84 c9                	test   %cl,%cl
801049a4:	88 4a ff             	mov    %cl,-0x1(%edx)
801049a7:	74 09                	je     801049b2 <strncpy+0x32>
801049a9:	89 f1                	mov    %esi,%ecx
801049ab:	85 c9                	test   %ecx,%ecx
801049ad:	8d 71 ff             	lea    -0x1(%ecx),%esi
801049b0:	7f e6                	jg     80104998 <strncpy+0x18>
    ;
  while(n-- > 0)
801049b2:	31 c9                	xor    %ecx,%ecx
801049b4:	85 f6                	test   %esi,%esi
801049b6:	7e 17                	jle    801049cf <strncpy+0x4f>
801049b8:	90                   	nop
801049b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801049c0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801049c4:	89 f3                	mov    %esi,%ebx
801049c6:	83 c1 01             	add    $0x1,%ecx
801049c9:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801049cb:	85 db                	test   %ebx,%ebx
801049cd:	7f f1                	jg     801049c0 <strncpy+0x40>
    *s++ = 0;
  return os;
}
801049cf:	5b                   	pop    %ebx
801049d0:	5e                   	pop    %esi
801049d1:	5d                   	pop    %ebp
801049d2:	c3                   	ret    
801049d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049e0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	56                   	push   %esi
801049e4:	53                   	push   %ebx
801049e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801049e8:	8b 45 08             	mov    0x8(%ebp),%eax
801049eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801049ee:	85 c9                	test   %ecx,%ecx
801049f0:	7e 26                	jle    80104a18 <safestrcpy+0x38>
801049f2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801049f6:	89 c1                	mov    %eax,%ecx
801049f8:	eb 17                	jmp    80104a11 <safestrcpy+0x31>
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104a00:	83 c2 01             	add    $0x1,%edx
80104a03:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104a07:	83 c1 01             	add    $0x1,%ecx
80104a0a:	84 db                	test   %bl,%bl
80104a0c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104a0f:	74 04                	je     80104a15 <safestrcpy+0x35>
80104a11:	39 f2                	cmp    %esi,%edx
80104a13:	75 eb                	jne    80104a00 <safestrcpy+0x20>
    ;
  *s = 0;
80104a15:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104a18:	5b                   	pop    %ebx
80104a19:	5e                   	pop    %esi
80104a1a:	5d                   	pop    %ebp
80104a1b:	c3                   	ret    
80104a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a20 <strlen>:

int
strlen(const char *s)
{
80104a20:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104a21:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104a23:	89 e5                	mov    %esp,%ebp
80104a25:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104a28:	80 3a 00             	cmpb   $0x0,(%edx)
80104a2b:	74 0c                	je     80104a39 <strlen+0x19>
80104a2d:	8d 76 00             	lea    0x0(%esi),%esi
80104a30:	83 c0 01             	add    $0x1,%eax
80104a33:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104a37:	75 f7                	jne    80104a30 <strlen+0x10>
    ;
  return n;
}
80104a39:	5d                   	pop    %ebp
80104a3a:	c3                   	ret    

80104a3b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104a3b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104a3f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104a43:	55                   	push   %ebp
  pushl %ebx
80104a44:	53                   	push   %ebx
  pushl %esi
80104a45:	56                   	push   %esi
  pushl %edi
80104a46:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104a47:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104a49:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104a4b:	5f                   	pop    %edi
  popl %esi
80104a4c:	5e                   	pop    %esi
  popl %ebx
80104a4d:	5b                   	pop    %ebx
  popl %ebp
80104a4e:	5d                   	pop    %ebp
  ret
80104a4f:	c3                   	ret    

80104a50 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	53                   	push   %ebx
80104a54:	83 ec 04             	sub    $0x4,%esp
80104a57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104a5a:	e8 e1 f0 ff ff       	call   80103b40 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a5f:	8b 00                	mov    (%eax),%eax
80104a61:	39 d8                	cmp    %ebx,%eax
80104a63:	76 1b                	jbe    80104a80 <fetchint+0x30>
80104a65:	8d 53 04             	lea    0x4(%ebx),%edx
80104a68:	39 d0                	cmp    %edx,%eax
80104a6a:	72 14                	jb     80104a80 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104a6c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a6f:	8b 13                	mov    (%ebx),%edx
80104a71:	89 10                	mov    %edx,(%eax)
  return 0;
80104a73:	31 c0                	xor    %eax,%eax
}
80104a75:	83 c4 04             	add    $0x4,%esp
80104a78:	5b                   	pop    %ebx
80104a79:	5d                   	pop    %ebp
80104a7a:	c3                   	ret    
80104a7b:	90                   	nop
80104a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a85:	eb ee                	jmp    80104a75 <fetchint+0x25>
80104a87:	89 f6                	mov    %esi,%esi
80104a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a90 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	53                   	push   %ebx
80104a94:	83 ec 04             	sub    $0x4,%esp
80104a97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104a9a:	e8 a1 f0 ff ff       	call   80103b40 <myproc>

  if(addr >= curproc->sz)
80104a9f:	39 18                	cmp    %ebx,(%eax)
80104aa1:	76 29                	jbe    80104acc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104aa3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104aa6:	89 da                	mov    %ebx,%edx
80104aa8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104aaa:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104aac:	39 c3                	cmp    %eax,%ebx
80104aae:	73 1c                	jae    80104acc <fetchstr+0x3c>
    if(*s == 0)
80104ab0:	80 3b 00             	cmpb   $0x0,(%ebx)
80104ab3:	75 10                	jne    80104ac5 <fetchstr+0x35>
80104ab5:	eb 29                	jmp    80104ae0 <fetchstr+0x50>
80104ab7:	89 f6                	mov    %esi,%esi
80104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ac0:	80 3a 00             	cmpb   $0x0,(%edx)
80104ac3:	74 1b                	je     80104ae0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104ac5:	83 c2 01             	add    $0x1,%edx
80104ac8:	39 d0                	cmp    %edx,%eax
80104aca:	77 f4                	ja     80104ac0 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104acc:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
80104acf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104ad4:	5b                   	pop    %ebx
80104ad5:	5d                   	pop    %ebp
80104ad6:	c3                   	ret    
80104ad7:	89 f6                	mov    %esi,%esi
80104ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ae0:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104ae3:	89 d0                	mov    %edx,%eax
80104ae5:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104ae7:	5b                   	pop    %ebx
80104ae8:	5d                   	pop    %ebp
80104ae9:	c3                   	ret    
80104aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104af0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	56                   	push   %esi
80104af4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104af5:	e8 46 f0 ff ff       	call   80103b40 <myproc>
80104afa:	8b 40 18             	mov    0x18(%eax),%eax
80104afd:	8b 55 08             	mov    0x8(%ebp),%edx
80104b00:	8b 40 44             	mov    0x44(%eax),%eax
80104b03:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104b06:	e8 35 f0 ff ff       	call   80103b40 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b0b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b0d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b10:	39 c6                	cmp    %eax,%esi
80104b12:	73 1c                	jae    80104b30 <argint+0x40>
80104b14:	8d 53 08             	lea    0x8(%ebx),%edx
80104b17:	39 d0                	cmp    %edx,%eax
80104b19:	72 15                	jb     80104b30 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
80104b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b1e:	8b 53 04             	mov    0x4(%ebx),%edx
80104b21:	89 10                	mov    %edx,(%eax)
  return 0;
80104b23:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104b25:	5b                   	pop    %ebx
80104b26:	5e                   	pop    %esi
80104b27:	5d                   	pop    %ebp
80104b28:	c3                   	ret    
80104b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b35:	eb ee                	jmp    80104b25 <argint+0x35>
80104b37:	89 f6                	mov    %esi,%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b40 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	56                   	push   %esi
80104b44:	53                   	push   %ebx
80104b45:	83 ec 10             	sub    $0x10,%esp
80104b48:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104b4b:	e8 f0 ef ff ff       	call   80103b40 <myproc>
80104b50:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104b52:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b55:	83 ec 08             	sub    $0x8,%esp
80104b58:	50                   	push   %eax
80104b59:	ff 75 08             	pushl  0x8(%ebp)
80104b5c:	e8 8f ff ff ff       	call   80104af0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104b61:	c1 e8 1f             	shr    $0x1f,%eax
80104b64:	83 c4 10             	add    $0x10,%esp
80104b67:	84 c0                	test   %al,%al
80104b69:	75 2d                	jne    80104b98 <argptr+0x58>
80104b6b:	89 d8                	mov    %ebx,%eax
80104b6d:	c1 e8 1f             	shr    $0x1f,%eax
80104b70:	84 c0                	test   %al,%al
80104b72:	75 24                	jne    80104b98 <argptr+0x58>
80104b74:	8b 16                	mov    (%esi),%edx
80104b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b79:	39 c2                	cmp    %eax,%edx
80104b7b:	76 1b                	jbe    80104b98 <argptr+0x58>
80104b7d:	01 c3                	add    %eax,%ebx
80104b7f:	39 da                	cmp    %ebx,%edx
80104b81:	72 15                	jb     80104b98 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104b83:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b86:	89 02                	mov    %eax,(%edx)
  return 0;
80104b88:	31 c0                	xor    %eax,%eax
}
80104b8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b8d:	5b                   	pop    %ebx
80104b8e:	5e                   	pop    %esi
80104b8f:	5d                   	pop    %ebp
80104b90:	c3                   	ret    
80104b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104b98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b9d:	eb eb                	jmp    80104b8a <argptr+0x4a>
80104b9f:	90                   	nop

80104ba0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104ba6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ba9:	50                   	push   %eax
80104baa:	ff 75 08             	pushl  0x8(%ebp)
80104bad:	e8 3e ff ff ff       	call   80104af0 <argint>
80104bb2:	83 c4 10             	add    $0x10,%esp
80104bb5:	85 c0                	test   %eax,%eax
80104bb7:	78 17                	js     80104bd0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104bb9:	83 ec 08             	sub    $0x8,%esp
80104bbc:	ff 75 0c             	pushl  0xc(%ebp)
80104bbf:	ff 75 f4             	pushl  -0xc(%ebp)
80104bc2:	e8 c9 fe ff ff       	call   80104a90 <fetchstr>
80104bc7:	83 c4 10             	add    $0x10,%esp
}
80104bca:	c9                   	leave  
80104bcb:	c3                   	ret    
80104bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104bd5:	c9                   	leave  
80104bd6:	c3                   	ret    
80104bd7:	89 f6                	mov    %esi,%esi
80104bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104be0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	56                   	push   %esi
80104be4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104be5:	e8 56 ef ff ff       	call   80103b40 <myproc>

  num = curproc->tf->eax;
80104bea:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104bed:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104bef:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104bf2:	8d 50 ff             	lea    -0x1(%eax),%edx
80104bf5:	83 fa 14             	cmp    $0x14,%edx
80104bf8:	77 1e                	ja     80104c18 <syscall+0x38>
80104bfa:	8b 14 85 80 79 10 80 	mov    -0x7fef8680(,%eax,4),%edx
80104c01:	85 d2                	test   %edx,%edx
80104c03:	74 13                	je     80104c18 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104c05:	ff d2                	call   *%edx
80104c07:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104c0a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c0d:	5b                   	pop    %ebx
80104c0e:	5e                   	pop    %esi
80104c0f:	5d                   	pop    %ebp
80104c10:	c3                   	ret    
80104c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104c18:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104c19:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104c1c:	50                   	push   %eax
80104c1d:	ff 73 10             	pushl  0x10(%ebx)
80104c20:	68 51 79 10 80       	push   $0x80107951
80104c25:	e8 36 ba ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104c2a:	8b 43 18             	mov    0x18(%ebx),%eax
80104c2d:	83 c4 10             	add    $0x10,%esp
80104c30:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104c37:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c3a:	5b                   	pop    %ebx
80104c3b:	5e                   	pop    %esi
80104c3c:	5d                   	pop    %ebp
80104c3d:	c3                   	ret    
80104c3e:	66 90                	xchg   %ax,%ax

80104c40 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	57                   	push   %edi
80104c44:	56                   	push   %esi
80104c45:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104c46:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104c49:	83 ec 44             	sub    $0x44,%esp
80104c4c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104c4f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104c52:	56                   	push   %esi
80104c53:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104c54:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104c57:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104c5a:	e8 41 d6 ff ff       	call   801022a0 <nameiparent>
80104c5f:	83 c4 10             	add    $0x10,%esp
80104c62:	85 c0                	test   %eax,%eax
80104c64:	0f 84 f6 00 00 00    	je     80104d60 <create+0x120>
    return 0;
  ilock(dp);
80104c6a:	83 ec 0c             	sub    $0xc,%esp
80104c6d:	89 c7                	mov    %eax,%edi
80104c6f:	50                   	push   %eax
80104c70:	e8 cb cb ff ff       	call   80101840 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104c75:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104c78:	83 c4 0c             	add    $0xc,%esp
80104c7b:	50                   	push   %eax
80104c7c:	56                   	push   %esi
80104c7d:	57                   	push   %edi
80104c7e:	e8 dd d2 ff ff       	call   80101f60 <dirlookup>
80104c83:	83 c4 10             	add    $0x10,%esp
80104c86:	85 c0                	test   %eax,%eax
80104c88:	89 c3                	mov    %eax,%ebx
80104c8a:	74 54                	je     80104ce0 <create+0xa0>
    iunlockput(dp);
80104c8c:	83 ec 0c             	sub    $0xc,%esp
80104c8f:	57                   	push   %edi
80104c90:	e8 2b d0 ff ff       	call   80101cc0 <iunlockput>
    ilock(ip);
80104c95:	89 1c 24             	mov    %ebx,(%esp)
80104c98:	e8 a3 cb ff ff       	call   80101840 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104c9d:	83 c4 10             	add    $0x10,%esp
80104ca0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ca5:	75 19                	jne    80104cc0 <create+0x80>
80104ca7:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104cac:	89 d8                	mov    %ebx,%eax
80104cae:	75 10                	jne    80104cc0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104cb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cb3:	5b                   	pop    %ebx
80104cb4:	5e                   	pop    %esi
80104cb5:	5f                   	pop    %edi
80104cb6:	5d                   	pop    %ebp
80104cb7:	c3                   	ret    
80104cb8:	90                   	nop
80104cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104cc0:	83 ec 0c             	sub    $0xc,%esp
80104cc3:	53                   	push   %ebx
80104cc4:	e8 f7 cf ff ff       	call   80101cc0 <iunlockput>
    return 0;
80104cc9:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ccc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104ccf:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104cd1:	5b                   	pop    %ebx
80104cd2:	5e                   	pop    %esi
80104cd3:	5f                   	pop    %edi
80104cd4:	5d                   	pop    %ebp
80104cd5:	c3                   	ret    
80104cd6:	8d 76 00             	lea    0x0(%esi),%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104ce0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104ce4:	83 ec 08             	sub    $0x8,%esp
80104ce7:	50                   	push   %eax
80104ce8:	ff 37                	pushl  (%edi)
80104cea:	e8 e1 c9 ff ff       	call   801016d0 <ialloc>
80104cef:	83 c4 10             	add    $0x10,%esp
80104cf2:	85 c0                	test   %eax,%eax
80104cf4:	89 c3                	mov    %eax,%ebx
80104cf6:	0f 84 cc 00 00 00    	je     80104dc8 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104cfc:	83 ec 0c             	sub    $0xc,%esp
80104cff:	50                   	push   %eax
80104d00:	e8 3b cb ff ff       	call   80101840 <ilock>
  ip->major = major;
80104d05:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104d09:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104d0d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104d11:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104d15:	b8 01 00 00 00       	mov    $0x1,%eax
80104d1a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104d1e:	89 1c 24             	mov    %ebx,(%esp)
80104d21:	e8 6a ca ff ff       	call   80101790 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104d26:	83 c4 10             	add    $0x10,%esp
80104d29:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104d2e:	74 40                	je     80104d70 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104d30:	83 ec 04             	sub    $0x4,%esp
80104d33:	ff 73 04             	pushl  0x4(%ebx)
80104d36:	56                   	push   %esi
80104d37:	57                   	push   %edi
80104d38:	e8 83 d4 ff ff       	call   801021c0 <dirlink>
80104d3d:	83 c4 10             	add    $0x10,%esp
80104d40:	85 c0                	test   %eax,%eax
80104d42:	78 77                	js     80104dbb <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104d44:	83 ec 0c             	sub    $0xc,%esp
80104d47:	57                   	push   %edi
80104d48:	e8 73 cf ff ff       	call   80101cc0 <iunlockput>

  return ip;
80104d4d:	83 c4 10             	add    $0x10,%esp
}
80104d50:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104d53:	89 d8                	mov    %ebx,%eax
}
80104d55:	5b                   	pop    %ebx
80104d56:	5e                   	pop    %esi
80104d57:	5f                   	pop    %edi
80104d58:	5d                   	pop    %ebp
80104d59:	c3                   	ret    
80104d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104d60:	31 c0                	xor    %eax,%eax
80104d62:	e9 49 ff ff ff       	jmp    80104cb0 <create+0x70>
80104d67:	89 f6                	mov    %esi,%esi
80104d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104d70:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104d75:	83 ec 0c             	sub    $0xc,%esp
80104d78:	57                   	push   %edi
80104d79:	e8 12 ca ff ff       	call   80101790 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104d7e:	83 c4 0c             	add    $0xc,%esp
80104d81:	ff 73 04             	pushl  0x4(%ebx)
80104d84:	68 f4 79 10 80       	push   $0x801079f4
80104d89:	53                   	push   %ebx
80104d8a:	e8 31 d4 ff ff       	call   801021c0 <dirlink>
80104d8f:	83 c4 10             	add    $0x10,%esp
80104d92:	85 c0                	test   %eax,%eax
80104d94:	78 18                	js     80104dae <create+0x16e>
80104d96:	83 ec 04             	sub    $0x4,%esp
80104d99:	ff 77 04             	pushl  0x4(%edi)
80104d9c:	68 f3 79 10 80       	push   $0x801079f3
80104da1:	53                   	push   %ebx
80104da2:	e8 19 d4 ff ff       	call   801021c0 <dirlink>
80104da7:	83 c4 10             	add    $0x10,%esp
80104daa:	85 c0                	test   %eax,%eax
80104dac:	79 82                	jns    80104d30 <create+0xf0>
      panic("create dots");
80104dae:	83 ec 0c             	sub    $0xc,%esp
80104db1:	68 e7 79 10 80       	push   $0x801079e7
80104db6:	e8 b5 b5 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104dbb:	83 ec 0c             	sub    $0xc,%esp
80104dbe:	68 f6 79 10 80       	push   $0x801079f6
80104dc3:	e8 a8 b5 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104dc8:	83 ec 0c             	sub    $0xc,%esp
80104dcb:	68 d8 79 10 80       	push   $0x801079d8
80104dd0:	e8 9b b5 ff ff       	call   80100370 <panic>
80104dd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104de0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	56                   	push   %esi
80104de4:	53                   	push   %ebx
80104de5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104de7:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104dea:	89 d3                	mov    %edx,%ebx
80104dec:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104def:	50                   	push   %eax
80104df0:	6a 00                	push   $0x0
80104df2:	e8 f9 fc ff ff       	call   80104af0 <argint>
80104df7:	83 c4 10             	add    $0x10,%esp
80104dfa:	85 c0                	test   %eax,%eax
80104dfc:	78 32                	js     80104e30 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104dfe:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e02:	77 2c                	ja     80104e30 <argfd.constprop.0+0x50>
80104e04:	e8 37 ed ff ff       	call   80103b40 <myproc>
80104e09:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e0c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104e10:	85 c0                	test   %eax,%eax
80104e12:	74 1c                	je     80104e30 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104e14:	85 f6                	test   %esi,%esi
80104e16:	74 02                	je     80104e1a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104e18:	89 16                	mov    %edx,(%esi)
  if(pf)
80104e1a:	85 db                	test   %ebx,%ebx
80104e1c:	74 22                	je     80104e40 <argfd.constprop.0+0x60>
    *pf = f;
80104e1e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104e20:	31 c0                	xor    %eax,%eax
}
80104e22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e25:	5b                   	pop    %ebx
80104e26:	5e                   	pop    %esi
80104e27:	5d                   	pop    %ebp
80104e28:	c3                   	ret    
80104e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e30:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104e33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104e38:	5b                   	pop    %ebx
80104e39:	5e                   	pop    %esi
80104e3a:	5d                   	pop    %ebp
80104e3b:	c3                   	ret    
80104e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104e40:	31 c0                	xor    %eax,%eax
80104e42:	eb de                	jmp    80104e22 <argfd.constprop.0+0x42>
80104e44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e50 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104e50:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104e51:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104e53:	89 e5                	mov    %esp,%ebp
80104e55:	56                   	push   %esi
80104e56:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104e57:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104e5a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104e5d:	e8 7e ff ff ff       	call   80104de0 <argfd.constprop.0>
80104e62:	85 c0                	test   %eax,%eax
80104e64:	78 1a                	js     80104e80 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104e66:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104e68:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104e6b:	e8 d0 ec ff ff       	call   80103b40 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104e70:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104e74:	85 d2                	test   %edx,%edx
80104e76:	74 18                	je     80104e90 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104e78:	83 c3 01             	add    $0x1,%ebx
80104e7b:	83 fb 10             	cmp    $0x10,%ebx
80104e7e:	75 f0                	jne    80104e70 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104e80:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104e83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104e88:	5b                   	pop    %ebx
80104e89:	5e                   	pop    %esi
80104e8a:	5d                   	pop    %ebp
80104e8b:	c3                   	ret    
80104e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104e90:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104e94:	83 ec 0c             	sub    $0xc,%esp
80104e97:	ff 75 f4             	pushl  -0xc(%ebp)
80104e9a:	e8 41 bf ff ff       	call   80100de0 <filedup>
  return fd;
80104e9f:	83 c4 10             	add    $0x10,%esp
}
80104ea2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104ea5:	89 d8                	mov    %ebx,%eax
}
80104ea7:	5b                   	pop    %ebx
80104ea8:	5e                   	pop    %esi
80104ea9:	5d                   	pop    %ebp
80104eaa:	c3                   	ret    
80104eab:	90                   	nop
80104eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104eb0 <sys_read>:

int
sys_read(void)
{
80104eb0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104eb1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104eb3:	89 e5                	mov    %esp,%ebp
80104eb5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104eb8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ebb:	e8 20 ff ff ff       	call   80104de0 <argfd.constprop.0>
80104ec0:	85 c0                	test   %eax,%eax
80104ec2:	78 4c                	js     80104f10 <sys_read+0x60>
80104ec4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ec7:	83 ec 08             	sub    $0x8,%esp
80104eca:	50                   	push   %eax
80104ecb:	6a 02                	push   $0x2
80104ecd:	e8 1e fc ff ff       	call   80104af0 <argint>
80104ed2:	83 c4 10             	add    $0x10,%esp
80104ed5:	85 c0                	test   %eax,%eax
80104ed7:	78 37                	js     80104f10 <sys_read+0x60>
80104ed9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104edc:	83 ec 04             	sub    $0x4,%esp
80104edf:	ff 75 f0             	pushl  -0x10(%ebp)
80104ee2:	50                   	push   %eax
80104ee3:	6a 01                	push   $0x1
80104ee5:	e8 56 fc ff ff       	call   80104b40 <argptr>
80104eea:	83 c4 10             	add    $0x10,%esp
80104eed:	85 c0                	test   %eax,%eax
80104eef:	78 1f                	js     80104f10 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104ef1:	83 ec 04             	sub    $0x4,%esp
80104ef4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ef7:	ff 75 f4             	pushl  -0xc(%ebp)
80104efa:	ff 75 ec             	pushl  -0x14(%ebp)
80104efd:	e8 4e c0 ff ff       	call   80100f50 <fileread>
80104f02:	83 c4 10             	add    $0x10,%esp
}
80104f05:	c9                   	leave  
80104f06:	c3                   	ret    
80104f07:	89 f6                	mov    %esi,%esi
80104f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104f10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104f15:	c9                   	leave  
80104f16:	c3                   	ret    
80104f17:	89 f6                	mov    %esi,%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f20 <sys_write>:

int
sys_write(void)
{
80104f20:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f21:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104f23:	89 e5                	mov    %esp,%ebp
80104f25:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f2b:	e8 b0 fe ff ff       	call   80104de0 <argfd.constprop.0>
80104f30:	85 c0                	test   %eax,%eax
80104f32:	78 4c                	js     80104f80 <sys_write+0x60>
80104f34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f37:	83 ec 08             	sub    $0x8,%esp
80104f3a:	50                   	push   %eax
80104f3b:	6a 02                	push   $0x2
80104f3d:	e8 ae fb ff ff       	call   80104af0 <argint>
80104f42:	83 c4 10             	add    $0x10,%esp
80104f45:	85 c0                	test   %eax,%eax
80104f47:	78 37                	js     80104f80 <sys_write+0x60>
80104f49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f4c:	83 ec 04             	sub    $0x4,%esp
80104f4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104f52:	50                   	push   %eax
80104f53:	6a 01                	push   $0x1
80104f55:	e8 e6 fb ff ff       	call   80104b40 <argptr>
80104f5a:	83 c4 10             	add    $0x10,%esp
80104f5d:	85 c0                	test   %eax,%eax
80104f5f:	78 1f                	js     80104f80 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104f61:	83 ec 04             	sub    $0x4,%esp
80104f64:	ff 75 f0             	pushl  -0x10(%ebp)
80104f67:	ff 75 f4             	pushl  -0xc(%ebp)
80104f6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f6d:	e8 6e c0 ff ff       	call   80100fe0 <filewrite>
80104f72:	83 c4 10             	add    $0x10,%esp
}
80104f75:	c9                   	leave  
80104f76:	c3                   	ret    
80104f77:	89 f6                	mov    %esi,%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104f80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104f85:	c9                   	leave  
80104f86:	c3                   	ret    
80104f87:	89 f6                	mov    %esi,%esi
80104f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f90 <sys_close>:

int
sys_close(void)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104f96:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104f99:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f9c:	e8 3f fe ff ff       	call   80104de0 <argfd.constprop.0>
80104fa1:	85 c0                	test   %eax,%eax
80104fa3:	78 2b                	js     80104fd0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104fa5:	e8 96 eb ff ff       	call   80103b40 <myproc>
80104faa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104fad:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104fb0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104fb7:	00 
  fileclose(f);
80104fb8:	ff 75 f4             	pushl  -0xc(%ebp)
80104fbb:	e8 70 be ff ff       	call   80100e30 <fileclose>
  return 0;
80104fc0:	83 c4 10             	add    $0x10,%esp
80104fc3:	31 c0                	xor    %eax,%eax
}
80104fc5:	c9                   	leave  
80104fc6:	c3                   	ret    
80104fc7:	89 f6                	mov    %esi,%esi
80104fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104fd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104fd5:	c9                   	leave  
80104fd6:	c3                   	ret    
80104fd7:	89 f6                	mov    %esi,%esi
80104fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fe0 <sys_fstat>:

int
sys_fstat(void)
{
80104fe0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104fe1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104fe3:	89 e5                	mov    %esp,%ebp
80104fe5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104fe8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104feb:	e8 f0 fd ff ff       	call   80104de0 <argfd.constprop.0>
80104ff0:	85 c0                	test   %eax,%eax
80104ff2:	78 2c                	js     80105020 <sys_fstat+0x40>
80104ff4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ff7:	83 ec 04             	sub    $0x4,%esp
80104ffa:	6a 14                	push   $0x14
80104ffc:	50                   	push   %eax
80104ffd:	6a 01                	push   $0x1
80104fff:	e8 3c fb ff ff       	call   80104b40 <argptr>
80105004:	83 c4 10             	add    $0x10,%esp
80105007:	85 c0                	test   %eax,%eax
80105009:	78 15                	js     80105020 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
8010500b:	83 ec 08             	sub    $0x8,%esp
8010500e:	ff 75 f4             	pushl  -0xc(%ebp)
80105011:	ff 75 f0             	pushl  -0x10(%ebp)
80105014:	e8 e7 be ff ff       	call   80100f00 <filestat>
80105019:	83 c4 10             	add    $0x10,%esp
}
8010501c:	c9                   	leave  
8010501d:	c3                   	ret    
8010501e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80105020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80105025:	c9                   	leave  
80105026:	c3                   	ret    
80105027:	89 f6                	mov    %esi,%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105030 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	57                   	push   %edi
80105034:	56                   	push   %esi
80105035:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105036:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105039:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010503c:	50                   	push   %eax
8010503d:	6a 00                	push   $0x0
8010503f:	e8 5c fb ff ff       	call   80104ba0 <argstr>
80105044:	83 c4 10             	add    $0x10,%esp
80105047:	85 c0                	test   %eax,%eax
80105049:	0f 88 fb 00 00 00    	js     8010514a <sys_link+0x11a>
8010504f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105052:	83 ec 08             	sub    $0x8,%esp
80105055:	50                   	push   %eax
80105056:	6a 01                	push   $0x1
80105058:	e8 43 fb ff ff       	call   80104ba0 <argstr>
8010505d:	83 c4 10             	add    $0x10,%esp
80105060:	85 c0                	test   %eax,%eax
80105062:	0f 88 e2 00 00 00    	js     8010514a <sys_link+0x11a>
    return -1;

  begin_op();
80105068:	e8 a3 de ff ff       	call   80102f10 <begin_op>
  if((ip = namei(old)) == 0){
8010506d:	83 ec 0c             	sub    $0xc,%esp
80105070:	ff 75 d4             	pushl  -0x2c(%ebp)
80105073:	e8 08 d2 ff ff       	call   80102280 <namei>
80105078:	83 c4 10             	add    $0x10,%esp
8010507b:	85 c0                	test   %eax,%eax
8010507d:	89 c3                	mov    %eax,%ebx
8010507f:	0f 84 f3 00 00 00    	je     80105178 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80105085:	83 ec 0c             	sub    $0xc,%esp
80105088:	50                   	push   %eax
80105089:	e8 b2 c7 ff ff       	call   80101840 <ilock>
  if(ip->type == T_DIR){
8010508e:	83 c4 10             	add    $0x10,%esp
80105091:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105096:	0f 84 c4 00 00 00    	je     80105160 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010509c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
801050a1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
801050a4:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
801050a7:	53                   	push   %ebx
801050a8:	e8 e3 c6 ff ff       	call   80101790 <iupdate>
  iunlock(ip);
801050ad:	89 1c 24             	mov    %ebx,(%esp)
801050b0:	e8 6b c8 ff ff       	call   80101920 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
801050b5:	58                   	pop    %eax
801050b6:	5a                   	pop    %edx
801050b7:	57                   	push   %edi
801050b8:	ff 75 d0             	pushl  -0x30(%ebp)
801050bb:	e8 e0 d1 ff ff       	call   801022a0 <nameiparent>
801050c0:	83 c4 10             	add    $0x10,%esp
801050c3:	85 c0                	test   %eax,%eax
801050c5:	89 c6                	mov    %eax,%esi
801050c7:	74 5b                	je     80105124 <sys_link+0xf4>
    goto bad;
  ilock(dp);
801050c9:	83 ec 0c             	sub    $0xc,%esp
801050cc:	50                   	push   %eax
801050cd:	e8 6e c7 ff ff       	call   80101840 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801050d2:	83 c4 10             	add    $0x10,%esp
801050d5:	8b 03                	mov    (%ebx),%eax
801050d7:	39 06                	cmp    %eax,(%esi)
801050d9:	75 3d                	jne    80105118 <sys_link+0xe8>
801050db:	83 ec 04             	sub    $0x4,%esp
801050de:	ff 73 04             	pushl  0x4(%ebx)
801050e1:	57                   	push   %edi
801050e2:	56                   	push   %esi
801050e3:	e8 d8 d0 ff ff       	call   801021c0 <dirlink>
801050e8:	83 c4 10             	add    $0x10,%esp
801050eb:	85 c0                	test   %eax,%eax
801050ed:	78 29                	js     80105118 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801050ef:	83 ec 0c             	sub    $0xc,%esp
801050f2:	56                   	push   %esi
801050f3:	e8 c8 cb ff ff       	call   80101cc0 <iunlockput>
  iput(ip);
801050f8:	89 1c 24             	mov    %ebx,(%esp)
801050fb:	e8 70 c8 ff ff       	call   80101970 <iput>

  end_op();
80105100:	e8 7b de ff ff       	call   80102f80 <end_op>

  return 0;
80105105:	83 c4 10             	add    $0x10,%esp
80105108:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010510a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010510d:	5b                   	pop    %ebx
8010510e:	5e                   	pop    %esi
8010510f:	5f                   	pop    %edi
80105110:	5d                   	pop    %ebp
80105111:	c3                   	ret    
80105112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80105118:	83 ec 0c             	sub    $0xc,%esp
8010511b:	56                   	push   %esi
8010511c:	e8 9f cb ff ff       	call   80101cc0 <iunlockput>
    goto bad;
80105121:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105124:	83 ec 0c             	sub    $0xc,%esp
80105127:	53                   	push   %ebx
80105128:	e8 13 c7 ff ff       	call   80101840 <ilock>
  ip->nlink--;
8010512d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105132:	89 1c 24             	mov    %ebx,(%esp)
80105135:	e8 56 c6 ff ff       	call   80101790 <iupdate>
  iunlockput(ip);
8010513a:	89 1c 24             	mov    %ebx,(%esp)
8010513d:	e8 7e cb ff ff       	call   80101cc0 <iunlockput>
  end_op();
80105142:	e8 39 de ff ff       	call   80102f80 <end_op>
  return -1;
80105147:	83 c4 10             	add    $0x10,%esp
}
8010514a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
8010514d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105152:	5b                   	pop    %ebx
80105153:	5e                   	pop    %esi
80105154:	5f                   	pop    %edi
80105155:	5d                   	pop    %ebp
80105156:	c3                   	ret    
80105157:	89 f6                	mov    %esi,%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105160:	83 ec 0c             	sub    $0xc,%esp
80105163:	53                   	push   %ebx
80105164:	e8 57 cb ff ff       	call   80101cc0 <iunlockput>
    end_op();
80105169:	e8 12 de ff ff       	call   80102f80 <end_op>
    return -1;
8010516e:	83 c4 10             	add    $0x10,%esp
80105171:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105176:	eb 92                	jmp    8010510a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105178:	e8 03 de ff ff       	call   80102f80 <end_op>
    return -1;
8010517d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105182:	eb 86                	jmp    8010510a <sys_link+0xda>
80105184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010518a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105190 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	57                   	push   %edi
80105194:	56                   	push   %esi
80105195:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105196:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105199:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
8010519c:	50                   	push   %eax
8010519d:	6a 00                	push   $0x0
8010519f:	e8 fc f9 ff ff       	call   80104ba0 <argstr>
801051a4:	83 c4 10             	add    $0x10,%esp
801051a7:	85 c0                	test   %eax,%eax
801051a9:	0f 88 82 01 00 00    	js     80105331 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
801051af:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
801051b2:	e8 59 dd ff ff       	call   80102f10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801051b7:	83 ec 08             	sub    $0x8,%esp
801051ba:	53                   	push   %ebx
801051bb:	ff 75 c0             	pushl  -0x40(%ebp)
801051be:	e8 dd d0 ff ff       	call   801022a0 <nameiparent>
801051c3:	83 c4 10             	add    $0x10,%esp
801051c6:	85 c0                	test   %eax,%eax
801051c8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801051cb:	0f 84 6a 01 00 00    	je     8010533b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
801051d1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
801051d4:	83 ec 0c             	sub    $0xc,%esp
801051d7:	56                   	push   %esi
801051d8:	e8 63 c6 ff ff       	call   80101840 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801051dd:	58                   	pop    %eax
801051de:	5a                   	pop    %edx
801051df:	68 f4 79 10 80       	push   $0x801079f4
801051e4:	53                   	push   %ebx
801051e5:	e8 56 cd ff ff       	call   80101f40 <namecmp>
801051ea:	83 c4 10             	add    $0x10,%esp
801051ed:	85 c0                	test   %eax,%eax
801051ef:	0f 84 fc 00 00 00    	je     801052f1 <sys_unlink+0x161>
801051f5:	83 ec 08             	sub    $0x8,%esp
801051f8:	68 f3 79 10 80       	push   $0x801079f3
801051fd:	53                   	push   %ebx
801051fe:	e8 3d cd ff ff       	call   80101f40 <namecmp>
80105203:	83 c4 10             	add    $0x10,%esp
80105206:	85 c0                	test   %eax,%eax
80105208:	0f 84 e3 00 00 00    	je     801052f1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010520e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105211:	83 ec 04             	sub    $0x4,%esp
80105214:	50                   	push   %eax
80105215:	53                   	push   %ebx
80105216:	56                   	push   %esi
80105217:	e8 44 cd ff ff       	call   80101f60 <dirlookup>
8010521c:	83 c4 10             	add    $0x10,%esp
8010521f:	85 c0                	test   %eax,%eax
80105221:	89 c3                	mov    %eax,%ebx
80105223:	0f 84 c8 00 00 00    	je     801052f1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105229:	83 ec 0c             	sub    $0xc,%esp
8010522c:	50                   	push   %eax
8010522d:	e8 0e c6 ff ff       	call   80101840 <ilock>

  if(ip->nlink < 1)
80105232:	83 c4 10             	add    $0x10,%esp
80105235:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010523a:	0f 8e 24 01 00 00    	jle    80105364 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105240:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105245:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105248:	74 66                	je     801052b0 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010524a:	83 ec 04             	sub    $0x4,%esp
8010524d:	6a 10                	push   $0x10
8010524f:	6a 00                	push   $0x0
80105251:	56                   	push   %esi
80105252:	e8 89 f5 ff ff       	call   801047e0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105257:	6a 10                	push   $0x10
80105259:	ff 75 c4             	pushl  -0x3c(%ebp)
8010525c:	56                   	push   %esi
8010525d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105260:	e8 ab cb ff ff       	call   80101e10 <writei>
80105265:	83 c4 20             	add    $0x20,%esp
80105268:	83 f8 10             	cmp    $0x10,%eax
8010526b:	0f 85 e6 00 00 00    	jne    80105357 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105271:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105276:	0f 84 9c 00 00 00    	je     80105318 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010527c:	83 ec 0c             	sub    $0xc,%esp
8010527f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105282:	e8 39 ca ff ff       	call   80101cc0 <iunlockput>

  ip->nlink--;
80105287:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010528c:	89 1c 24             	mov    %ebx,(%esp)
8010528f:	e8 fc c4 ff ff       	call   80101790 <iupdate>
  iunlockput(ip);
80105294:	89 1c 24             	mov    %ebx,(%esp)
80105297:	e8 24 ca ff ff       	call   80101cc0 <iunlockput>

  end_op();
8010529c:	e8 df dc ff ff       	call   80102f80 <end_op>

  return 0;
801052a1:	83 c4 10             	add    $0x10,%esp
801052a4:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801052a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052a9:	5b                   	pop    %ebx
801052aa:	5e                   	pop    %esi
801052ab:	5f                   	pop    %edi
801052ac:	5d                   	pop    %ebp
801052ad:	c3                   	ret    
801052ae:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801052b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801052b4:	76 94                	jbe    8010524a <sys_unlink+0xba>
801052b6:	bf 20 00 00 00       	mov    $0x20,%edi
801052bb:	eb 0f                	jmp    801052cc <sys_unlink+0x13c>
801052bd:	8d 76 00             	lea    0x0(%esi),%esi
801052c0:	83 c7 10             	add    $0x10,%edi
801052c3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801052c6:	0f 83 7e ff ff ff    	jae    8010524a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052cc:	6a 10                	push   $0x10
801052ce:	57                   	push   %edi
801052cf:	56                   	push   %esi
801052d0:	53                   	push   %ebx
801052d1:	e8 3a ca ff ff       	call   80101d10 <readi>
801052d6:	83 c4 10             	add    $0x10,%esp
801052d9:	83 f8 10             	cmp    $0x10,%eax
801052dc:	75 6c                	jne    8010534a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
801052de:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801052e3:	74 db                	je     801052c0 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801052e5:	83 ec 0c             	sub    $0xc,%esp
801052e8:	53                   	push   %ebx
801052e9:	e8 d2 c9 ff ff       	call   80101cc0 <iunlockput>
    goto bad;
801052ee:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801052f1:	83 ec 0c             	sub    $0xc,%esp
801052f4:	ff 75 b4             	pushl  -0x4c(%ebp)
801052f7:	e8 c4 c9 ff ff       	call   80101cc0 <iunlockput>
  end_op();
801052fc:	e8 7f dc ff ff       	call   80102f80 <end_op>
  return -1;
80105301:	83 c4 10             	add    $0x10,%esp
}
80105304:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105307:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010530c:	5b                   	pop    %ebx
8010530d:	5e                   	pop    %esi
8010530e:	5f                   	pop    %edi
8010530f:	5d                   	pop    %ebp
80105310:	c3                   	ret    
80105311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105318:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010531b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010531e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105323:	50                   	push   %eax
80105324:	e8 67 c4 ff ff       	call   80101790 <iupdate>
80105329:	83 c4 10             	add    $0x10,%esp
8010532c:	e9 4b ff ff ff       	jmp    8010527c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105331:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105336:	e9 6b ff ff ff       	jmp    801052a6 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010533b:	e8 40 dc ff ff       	call   80102f80 <end_op>
    return -1;
80105340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105345:	e9 5c ff ff ff       	jmp    801052a6 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010534a:	83 ec 0c             	sub    $0xc,%esp
8010534d:	68 18 7a 10 80       	push   $0x80107a18
80105352:	e8 19 b0 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105357:	83 ec 0c             	sub    $0xc,%esp
8010535a:	68 2a 7a 10 80       	push   $0x80107a2a
8010535f:	e8 0c b0 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105364:	83 ec 0c             	sub    $0xc,%esp
80105367:	68 06 7a 10 80       	push   $0x80107a06
8010536c:	e8 ff af ff ff       	call   80100370 <panic>
80105371:	eb 0d                	jmp    80105380 <sys_open>
80105373:	90                   	nop
80105374:	90                   	nop
80105375:	90                   	nop
80105376:	90                   	nop
80105377:	90                   	nop
80105378:	90                   	nop
80105379:	90                   	nop
8010537a:	90                   	nop
8010537b:	90                   	nop
8010537c:	90                   	nop
8010537d:	90                   	nop
8010537e:	90                   	nop
8010537f:	90                   	nop

80105380 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	57                   	push   %edi
80105384:	56                   	push   %esi
80105385:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105386:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105389:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010538c:	50                   	push   %eax
8010538d:	6a 00                	push   $0x0
8010538f:	e8 0c f8 ff ff       	call   80104ba0 <argstr>
80105394:	83 c4 10             	add    $0x10,%esp
80105397:	85 c0                	test   %eax,%eax
80105399:	0f 88 9e 00 00 00    	js     8010543d <sys_open+0xbd>
8010539f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801053a2:	83 ec 08             	sub    $0x8,%esp
801053a5:	50                   	push   %eax
801053a6:	6a 01                	push   $0x1
801053a8:	e8 43 f7 ff ff       	call   80104af0 <argint>
801053ad:	83 c4 10             	add    $0x10,%esp
801053b0:	85 c0                	test   %eax,%eax
801053b2:	0f 88 85 00 00 00    	js     8010543d <sys_open+0xbd>
    return -1;

  begin_op();
801053b8:	e8 53 db ff ff       	call   80102f10 <begin_op>

  if(omode & O_CREATE){
801053bd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801053c1:	0f 85 89 00 00 00    	jne    80105450 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801053c7:	83 ec 0c             	sub    $0xc,%esp
801053ca:	ff 75 e0             	pushl  -0x20(%ebp)
801053cd:	e8 ae ce ff ff       	call   80102280 <namei>
801053d2:	83 c4 10             	add    $0x10,%esp
801053d5:	85 c0                	test   %eax,%eax
801053d7:	89 c6                	mov    %eax,%esi
801053d9:	0f 84 8e 00 00 00    	je     8010546d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
801053df:	83 ec 0c             	sub    $0xc,%esp
801053e2:	50                   	push   %eax
801053e3:	e8 58 c4 ff ff       	call   80101840 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801053e8:	83 c4 10             	add    $0x10,%esp
801053eb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801053f0:	0f 84 d2 00 00 00    	je     801054c8 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801053f6:	e8 75 b9 ff ff       	call   80100d70 <filealloc>
801053fb:	85 c0                	test   %eax,%eax
801053fd:	89 c7                	mov    %eax,%edi
801053ff:	74 2b                	je     8010542c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105401:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105403:	e8 38 e7 ff ff       	call   80103b40 <myproc>
80105408:	90                   	nop
80105409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105410:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105414:	85 d2                	test   %edx,%edx
80105416:	74 68                	je     80105480 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105418:	83 c3 01             	add    $0x1,%ebx
8010541b:	83 fb 10             	cmp    $0x10,%ebx
8010541e:	75 f0                	jne    80105410 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105420:	83 ec 0c             	sub    $0xc,%esp
80105423:	57                   	push   %edi
80105424:	e8 07 ba ff ff       	call   80100e30 <fileclose>
80105429:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010542c:	83 ec 0c             	sub    $0xc,%esp
8010542f:	56                   	push   %esi
80105430:	e8 8b c8 ff ff       	call   80101cc0 <iunlockput>
    end_op();
80105435:	e8 46 db ff ff       	call   80102f80 <end_op>
    return -1;
8010543a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010543d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105445:	5b                   	pop    %ebx
80105446:	5e                   	pop    %esi
80105447:	5f                   	pop    %edi
80105448:	5d                   	pop    %ebp
80105449:	c3                   	ret    
8010544a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105450:	83 ec 0c             	sub    $0xc,%esp
80105453:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105456:	31 c9                	xor    %ecx,%ecx
80105458:	6a 00                	push   $0x0
8010545a:	ba 02 00 00 00       	mov    $0x2,%edx
8010545f:	e8 dc f7 ff ff       	call   80104c40 <create>
    if(ip == 0){
80105464:	83 c4 10             	add    $0x10,%esp
80105467:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105469:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010546b:	75 89                	jne    801053f6 <sys_open+0x76>
      end_op();
8010546d:	e8 0e db ff ff       	call   80102f80 <end_op>
      return -1;
80105472:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105477:	eb 43                	jmp    801054bc <sys_open+0x13c>
80105479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105480:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105483:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105487:	56                   	push   %esi
80105488:	e8 93 c4 ff ff       	call   80101920 <iunlock>
  end_op();
8010548d:	e8 ee da ff ff       	call   80102f80 <end_op>

  f->type = FD_INODE;
80105492:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105498:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010549b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010549e:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801054a1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801054a8:	89 d0                	mov    %edx,%eax
801054aa:	83 e0 01             	and    $0x1,%eax
801054ad:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054b0:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801054b3:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054b6:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
801054ba:	89 d8                	mov    %ebx,%eax
}
801054bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054bf:	5b                   	pop    %ebx
801054c0:	5e                   	pop    %esi
801054c1:	5f                   	pop    %edi
801054c2:	5d                   	pop    %ebp
801054c3:	c3                   	ret    
801054c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801054c8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801054cb:	85 c9                	test   %ecx,%ecx
801054cd:	0f 84 23 ff ff ff    	je     801053f6 <sys_open+0x76>
801054d3:	e9 54 ff ff ff       	jmp    8010542c <sys_open+0xac>
801054d8:	90                   	nop
801054d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054e0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801054e6:	e8 25 da ff ff       	call   80102f10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801054eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ee:	83 ec 08             	sub    $0x8,%esp
801054f1:	50                   	push   %eax
801054f2:	6a 00                	push   $0x0
801054f4:	e8 a7 f6 ff ff       	call   80104ba0 <argstr>
801054f9:	83 c4 10             	add    $0x10,%esp
801054fc:	85 c0                	test   %eax,%eax
801054fe:	78 30                	js     80105530 <sys_mkdir+0x50>
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105506:	31 c9                	xor    %ecx,%ecx
80105508:	6a 00                	push   $0x0
8010550a:	ba 01 00 00 00       	mov    $0x1,%edx
8010550f:	e8 2c f7 ff ff       	call   80104c40 <create>
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	85 c0                	test   %eax,%eax
80105519:	74 15                	je     80105530 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010551b:	83 ec 0c             	sub    $0xc,%esp
8010551e:	50                   	push   %eax
8010551f:	e8 9c c7 ff ff       	call   80101cc0 <iunlockput>
  end_op();
80105524:	e8 57 da ff ff       	call   80102f80 <end_op>
  return 0;
80105529:	83 c4 10             	add    $0x10,%esp
8010552c:	31 c0                	xor    %eax,%eax
}
8010552e:	c9                   	leave  
8010552f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105530:	e8 4b da ff ff       	call   80102f80 <end_op>
    return -1;
80105535:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010553a:	c9                   	leave  
8010553b:	c3                   	ret    
8010553c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105540 <sys_mknod>:

int
sys_mknod(void)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105546:	e8 c5 d9 ff ff       	call   80102f10 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010554b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010554e:	83 ec 08             	sub    $0x8,%esp
80105551:	50                   	push   %eax
80105552:	6a 00                	push   $0x0
80105554:	e8 47 f6 ff ff       	call   80104ba0 <argstr>
80105559:	83 c4 10             	add    $0x10,%esp
8010555c:	85 c0                	test   %eax,%eax
8010555e:	78 60                	js     801055c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105560:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105563:	83 ec 08             	sub    $0x8,%esp
80105566:	50                   	push   %eax
80105567:	6a 01                	push   $0x1
80105569:	e8 82 f5 ff ff       	call   80104af0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010556e:	83 c4 10             	add    $0x10,%esp
80105571:	85 c0                	test   %eax,%eax
80105573:	78 4b                	js     801055c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105575:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105578:	83 ec 08             	sub    $0x8,%esp
8010557b:	50                   	push   %eax
8010557c:	6a 02                	push   $0x2
8010557e:	e8 6d f5 ff ff       	call   80104af0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105583:	83 c4 10             	add    $0x10,%esp
80105586:	85 c0                	test   %eax,%eax
80105588:	78 36                	js     801055c0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010558a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010558e:	83 ec 0c             	sub    $0xc,%esp
80105591:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105595:	ba 03 00 00 00       	mov    $0x3,%edx
8010559a:	50                   	push   %eax
8010559b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010559e:	e8 9d f6 ff ff       	call   80104c40 <create>
801055a3:	83 c4 10             	add    $0x10,%esp
801055a6:	85 c0                	test   %eax,%eax
801055a8:	74 16                	je     801055c0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801055aa:	83 ec 0c             	sub    $0xc,%esp
801055ad:	50                   	push   %eax
801055ae:	e8 0d c7 ff ff       	call   80101cc0 <iunlockput>
  end_op();
801055b3:	e8 c8 d9 ff ff       	call   80102f80 <end_op>
  return 0;
801055b8:	83 c4 10             	add    $0x10,%esp
801055bb:	31 c0                	xor    %eax,%eax
}
801055bd:	c9                   	leave  
801055be:	c3                   	ret    
801055bf:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801055c0:	e8 bb d9 ff ff       	call   80102f80 <end_op>
    return -1;
801055c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801055ca:	c9                   	leave  
801055cb:	c3                   	ret    
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055d0 <sys_chdir>:

int
sys_chdir(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	56                   	push   %esi
801055d4:	53                   	push   %ebx
801055d5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801055d8:	e8 63 e5 ff ff       	call   80103b40 <myproc>
801055dd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801055df:	e8 2c d9 ff ff       	call   80102f10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801055e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055e7:	83 ec 08             	sub    $0x8,%esp
801055ea:	50                   	push   %eax
801055eb:	6a 00                	push   $0x0
801055ed:	e8 ae f5 ff ff       	call   80104ba0 <argstr>
801055f2:	83 c4 10             	add    $0x10,%esp
801055f5:	85 c0                	test   %eax,%eax
801055f7:	78 77                	js     80105670 <sys_chdir+0xa0>
801055f9:	83 ec 0c             	sub    $0xc,%esp
801055fc:	ff 75 f4             	pushl  -0xc(%ebp)
801055ff:	e8 7c cc ff ff       	call   80102280 <namei>
80105604:	83 c4 10             	add    $0x10,%esp
80105607:	85 c0                	test   %eax,%eax
80105609:	89 c3                	mov    %eax,%ebx
8010560b:	74 63                	je     80105670 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010560d:	83 ec 0c             	sub    $0xc,%esp
80105610:	50                   	push   %eax
80105611:	e8 2a c2 ff ff       	call   80101840 <ilock>
  if(ip->type != T_DIR){
80105616:	83 c4 10             	add    $0x10,%esp
80105619:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010561e:	75 30                	jne    80105650 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105620:	83 ec 0c             	sub    $0xc,%esp
80105623:	53                   	push   %ebx
80105624:	e8 f7 c2 ff ff       	call   80101920 <iunlock>
  iput(curproc->cwd);
80105629:	58                   	pop    %eax
8010562a:	ff 76 68             	pushl  0x68(%esi)
8010562d:	e8 3e c3 ff ff       	call   80101970 <iput>
  end_op();
80105632:	e8 49 d9 ff ff       	call   80102f80 <end_op>
  curproc->cwd = ip;
80105637:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010563a:	83 c4 10             	add    $0x10,%esp
8010563d:	31 c0                	xor    %eax,%eax
}
8010563f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105642:	5b                   	pop    %ebx
80105643:	5e                   	pop    %esi
80105644:	5d                   	pop    %ebp
80105645:	c3                   	ret    
80105646:	8d 76 00             	lea    0x0(%esi),%esi
80105649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105650:	83 ec 0c             	sub    $0xc,%esp
80105653:	53                   	push   %ebx
80105654:	e8 67 c6 ff ff       	call   80101cc0 <iunlockput>
    end_op();
80105659:	e8 22 d9 ff ff       	call   80102f80 <end_op>
    return -1;
8010565e:	83 c4 10             	add    $0x10,%esp
80105661:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105666:	eb d7                	jmp    8010563f <sys_chdir+0x6f>
80105668:	90                   	nop
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105670:	e8 0b d9 ff ff       	call   80102f80 <end_op>
    return -1;
80105675:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010567a:	eb c3                	jmp    8010563f <sys_chdir+0x6f>
8010567c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105680 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	57                   	push   %edi
80105684:	56                   	push   %esi
80105685:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105686:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010568c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105692:	50                   	push   %eax
80105693:	6a 00                	push   $0x0
80105695:	e8 06 f5 ff ff       	call   80104ba0 <argstr>
8010569a:	83 c4 10             	add    $0x10,%esp
8010569d:	85 c0                	test   %eax,%eax
8010569f:	78 7f                	js     80105720 <sys_exec+0xa0>
801056a1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801056a7:	83 ec 08             	sub    $0x8,%esp
801056aa:	50                   	push   %eax
801056ab:	6a 01                	push   $0x1
801056ad:	e8 3e f4 ff ff       	call   80104af0 <argint>
801056b2:	83 c4 10             	add    $0x10,%esp
801056b5:	85 c0                	test   %eax,%eax
801056b7:	78 67                	js     80105720 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801056b9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801056bf:	83 ec 04             	sub    $0x4,%esp
801056c2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801056c8:	68 80 00 00 00       	push   $0x80
801056cd:	6a 00                	push   $0x0
801056cf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801056d5:	50                   	push   %eax
801056d6:	31 db                	xor    %ebx,%ebx
801056d8:	e8 03 f1 ff ff       	call   801047e0 <memset>
801056dd:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801056e0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801056e6:	83 ec 08             	sub    $0x8,%esp
801056e9:	57                   	push   %edi
801056ea:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801056ed:	50                   	push   %eax
801056ee:	e8 5d f3 ff ff       	call   80104a50 <fetchint>
801056f3:	83 c4 10             	add    $0x10,%esp
801056f6:	85 c0                	test   %eax,%eax
801056f8:	78 26                	js     80105720 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801056fa:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105700:	85 c0                	test   %eax,%eax
80105702:	74 2c                	je     80105730 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105704:	83 ec 08             	sub    $0x8,%esp
80105707:	56                   	push   %esi
80105708:	50                   	push   %eax
80105709:	e8 82 f3 ff ff       	call   80104a90 <fetchstr>
8010570e:	83 c4 10             	add    $0x10,%esp
80105711:	85 c0                	test   %eax,%eax
80105713:	78 0b                	js     80105720 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105715:	83 c3 01             	add    $0x1,%ebx
80105718:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010571b:	83 fb 20             	cmp    $0x20,%ebx
8010571e:	75 c0                	jne    801056e0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105720:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105723:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105728:	5b                   	pop    %ebx
80105729:	5e                   	pop    %esi
8010572a:	5f                   	pop    %edi
8010572b:	5d                   	pop    %ebp
8010572c:	c3                   	ret    
8010572d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105730:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105736:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105739:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105740:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105744:	50                   	push   %eax
80105745:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010574b:	e8 a0 b2 ff ff       	call   801009f0 <exec>
80105750:	83 c4 10             	add    $0x10,%esp
}
80105753:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105756:	5b                   	pop    %ebx
80105757:	5e                   	pop    %esi
80105758:	5f                   	pop    %edi
80105759:	5d                   	pop    %ebp
8010575a:	c3                   	ret    
8010575b:	90                   	nop
8010575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105760 <sys_pipe>:

int
sys_pipe(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	57                   	push   %edi
80105764:	56                   	push   %esi
80105765:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105766:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105769:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010576c:	6a 08                	push   $0x8
8010576e:	50                   	push   %eax
8010576f:	6a 00                	push   $0x0
80105771:	e8 ca f3 ff ff       	call   80104b40 <argptr>
80105776:	83 c4 10             	add    $0x10,%esp
80105779:	85 c0                	test   %eax,%eax
8010577b:	78 4a                	js     801057c7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010577d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105780:	83 ec 08             	sub    $0x8,%esp
80105783:	50                   	push   %eax
80105784:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105787:	50                   	push   %eax
80105788:	e8 23 de ff ff       	call   801035b0 <pipealloc>
8010578d:	83 c4 10             	add    $0x10,%esp
80105790:	85 c0                	test   %eax,%eax
80105792:	78 33                	js     801057c7 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105794:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105796:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105799:	e8 a2 e3 ff ff       	call   80103b40 <myproc>
8010579e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801057a0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801057a4:	85 f6                	test   %esi,%esi
801057a6:	74 30                	je     801057d8 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801057a8:	83 c3 01             	add    $0x1,%ebx
801057ab:	83 fb 10             	cmp    $0x10,%ebx
801057ae:	75 f0                	jne    801057a0 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801057b0:	83 ec 0c             	sub    $0xc,%esp
801057b3:	ff 75 e0             	pushl  -0x20(%ebp)
801057b6:	e8 75 b6 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
801057bb:	58                   	pop    %eax
801057bc:	ff 75 e4             	pushl  -0x1c(%ebp)
801057bf:	e8 6c b6 ff ff       	call   80100e30 <fileclose>
    return -1;
801057c4:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801057c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801057ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801057cf:	5b                   	pop    %ebx
801057d0:	5e                   	pop    %esi
801057d1:	5f                   	pop    %edi
801057d2:	5d                   	pop    %ebp
801057d3:	c3                   	ret    
801057d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801057d8:	8d 73 08             	lea    0x8(%ebx),%esi
801057db:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057df:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801057e2:	e8 59 e3 ff ff       	call   80103b40 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801057e7:	31 d2                	xor    %edx,%edx
801057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801057f0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801057f4:	85 c9                	test   %ecx,%ecx
801057f6:	74 18                	je     80105810 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801057f8:	83 c2 01             	add    $0x1,%edx
801057fb:	83 fa 10             	cmp    $0x10,%edx
801057fe:	75 f0                	jne    801057f0 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105800:	e8 3b e3 ff ff       	call   80103b40 <myproc>
80105805:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010580c:	00 
8010580d:	eb a1                	jmp    801057b0 <sys_pipe+0x50>
8010580f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105810:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105814:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105817:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105819:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010581c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010581f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105822:	31 c0                	xor    %eax,%eax
}
80105824:	5b                   	pop    %ebx
80105825:	5e                   	pop    %esi
80105826:	5f                   	pop    %edi
80105827:	5d                   	pop    %ebp
80105828:	c3                   	ret    
80105829:	66 90                	xchg   %ax,%ax
8010582b:	66 90                	xchg   %ax,%ax
8010582d:	66 90                	xchg   %ax,%ax
8010582f:	90                   	nop

80105830 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105833:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105834:	e9 a7 e4 ff ff       	jmp    80103ce0 <fork>
80105839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105840 <sys_exit>:
}

int
sys_exit(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	83 ec 08             	sub    $0x8,%esp
  exit();
80105846:	e8 25 e7 ff ff       	call   80103f70 <exit>
  return 0;  // not reached
}
8010584b:	31 c0                	xor    %eax,%eax
8010584d:	c9                   	leave  
8010584e:	c3                   	ret    
8010584f:	90                   	nop

80105850 <sys_wait>:

int
sys_wait(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105853:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105854:	e9 57 e9 ff ff       	jmp    801041b0 <wait>
80105859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105860 <sys_kill>:
}

int
sys_kill(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105866:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105869:	50                   	push   %eax
8010586a:	6a 00                	push   $0x0
8010586c:	e8 7f f2 ff ff       	call   80104af0 <argint>
80105871:	83 c4 10             	add    $0x10,%esp
80105874:	85 c0                	test   %eax,%eax
80105876:	78 18                	js     80105890 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105878:	83 ec 0c             	sub    $0xc,%esp
8010587b:	ff 75 f4             	pushl  -0xc(%ebp)
8010587e:	e8 7d ea ff ff       	call   80104300 <kill>
80105883:	83 c4 10             	add    $0x10,%esp
}
80105886:	c9                   	leave  
80105887:	c3                   	ret    
80105888:	90                   	nop
80105889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105895:	c9                   	leave  
80105896:	c3                   	ret    
80105897:	89 f6                	mov    %esi,%esi
80105899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058a0 <sys_getpid>:

int
sys_getpid(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801058a6:	e8 95 e2 ff ff       	call   80103b40 <myproc>
801058ab:	8b 40 10             	mov    0x10(%eax),%eax
}
801058ae:	c9                   	leave  
801058af:	c3                   	ret    

801058b0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801058b7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058ba:	50                   	push   %eax
801058bb:	6a 00                	push   $0x0
801058bd:	e8 2e f2 ff ff       	call   80104af0 <argint>
801058c2:	83 c4 10             	add    $0x10,%esp
801058c5:	85 c0                	test   %eax,%eax
801058c7:	78 27                	js     801058f0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801058c9:	e8 72 e2 ff ff       	call   80103b40 <myproc>
  if(growproc(n) < 0)
801058ce:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
801058d1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801058d3:	ff 75 f4             	pushl  -0xc(%ebp)
801058d6:	e8 85 e3 ff ff       	call   80103c60 <growproc>
801058db:	83 c4 10             	add    $0x10,%esp
801058de:	85 c0                	test   %eax,%eax
801058e0:	78 0e                	js     801058f0 <sys_sbrk+0x40>
    return -1;
  return addr;
801058e2:	89 d8                	mov    %ebx,%eax
}
801058e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058e7:	c9                   	leave  
801058e8:	c3                   	ret    
801058e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
801058f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058f5:	eb ed                	jmp    801058e4 <sys_sbrk+0x34>
801058f7:	89 f6                	mov    %esi,%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105900 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105904:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105907:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010590a:	50                   	push   %eax
8010590b:	6a 00                	push   $0x0
8010590d:	e8 de f1 ff ff       	call   80104af0 <argint>
80105912:	83 c4 10             	add    $0x10,%esp
80105915:	85 c0                	test   %eax,%eax
80105917:	0f 88 8a 00 00 00    	js     801059a7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010591d:	83 ec 0c             	sub    $0xc,%esp
80105920:	68 60 4c 11 80       	push   $0x80114c60
80105925:	e8 b6 ed ff ff       	call   801046e0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010592a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010592d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105930:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
80105936:	85 d2                	test   %edx,%edx
80105938:	75 27                	jne    80105961 <sys_sleep+0x61>
8010593a:	eb 54                	jmp    80105990 <sys_sleep+0x90>
8010593c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105940:	83 ec 08             	sub    $0x8,%esp
80105943:	68 60 4c 11 80       	push   $0x80114c60
80105948:	68 a0 54 11 80       	push   $0x801154a0
8010594d:	e8 9e e7 ff ff       	call   801040f0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105952:	a1 a0 54 11 80       	mov    0x801154a0,%eax
80105957:	83 c4 10             	add    $0x10,%esp
8010595a:	29 d8                	sub    %ebx,%eax
8010595c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010595f:	73 2f                	jae    80105990 <sys_sleep+0x90>
    if(myproc()->killed){
80105961:	e8 da e1 ff ff       	call   80103b40 <myproc>
80105966:	8b 40 24             	mov    0x24(%eax),%eax
80105969:	85 c0                	test   %eax,%eax
8010596b:	74 d3                	je     80105940 <sys_sleep+0x40>
      release(&tickslock);
8010596d:	83 ec 0c             	sub    $0xc,%esp
80105970:	68 60 4c 11 80       	push   $0x80114c60
80105975:	e8 16 ee ff ff       	call   80104790 <release>
      return -1;
8010597a:	83 c4 10             	add    $0x10,%esp
8010597d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105982:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105985:	c9                   	leave  
80105986:	c3                   	ret    
80105987:	89 f6                	mov    %esi,%esi
80105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105990:	83 ec 0c             	sub    $0xc,%esp
80105993:	68 60 4c 11 80       	push   $0x80114c60
80105998:	e8 f3 ed ff ff       	call   80104790 <release>
  return 0;
8010599d:	83 c4 10             	add    $0x10,%esp
801059a0:	31 c0                	xor    %eax,%eax
}
801059a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059a5:	c9                   	leave  
801059a6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801059a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059ac:	eb d4                	jmp    80105982 <sys_sleep+0x82>
801059ae:	66 90                	xchg   %ax,%ax

801059b0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	53                   	push   %ebx
801059b4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059b7:	68 60 4c 11 80       	push   $0x80114c60
801059bc:	e8 1f ed ff ff       	call   801046e0 <acquire>
  xticks = ticks;
801059c1:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
801059c7:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801059ce:	e8 bd ed ff ff       	call   80104790 <release>
  return xticks;
}
801059d3:	89 d8                	mov    %ebx,%eax
801059d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059d8:	c9                   	leave  
801059d9:	c3                   	ret    

801059da <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801059da:	1e                   	push   %ds
  pushl %es
801059db:	06                   	push   %es
  pushl %fs
801059dc:	0f a0                	push   %fs
  pushl %gs
801059de:	0f a8                	push   %gs
  pushal
801059e0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801059e1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801059e5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801059e7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801059e9:	54                   	push   %esp
  call trap
801059ea:	e8 e1 00 00 00       	call   80105ad0 <trap>
  addl $4, %esp
801059ef:	83 c4 04             	add    $0x4,%esp

801059f2 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801059f2:	61                   	popa   
  popl %gs
801059f3:	0f a9                	pop    %gs
  popl %fs
801059f5:	0f a1                	pop    %fs
  popl %es
801059f7:	07                   	pop    %es
  popl %ds
801059f8:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801059f9:	83 c4 08             	add    $0x8,%esp
  iret
801059fc:	cf                   	iret   
801059fd:	66 90                	xchg   %ax,%ax
801059ff:	90                   	nop

80105a00 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105a00:	31 c0                	xor    %eax,%eax
80105a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a08:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105a0f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105a14:	c6 04 c5 a4 4c 11 80 	movb   $0x0,-0x7feeb35c(,%eax,8)
80105a1b:	00 
80105a1c:	66 89 0c c5 a2 4c 11 	mov    %cx,-0x7feeb35e(,%eax,8)
80105a23:	80 
80105a24:	c6 04 c5 a5 4c 11 80 	movb   $0x8e,-0x7feeb35b(,%eax,8)
80105a2b:	8e 
80105a2c:	66 89 14 c5 a0 4c 11 	mov    %dx,-0x7feeb360(,%eax,8)
80105a33:	80 
80105a34:	c1 ea 10             	shr    $0x10,%edx
80105a37:	66 89 14 c5 a6 4c 11 	mov    %dx,-0x7feeb35a(,%eax,8)
80105a3e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105a3f:	83 c0 01             	add    $0x1,%eax
80105a42:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a47:	75 bf                	jne    80105a08 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a49:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a4a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a4f:	89 e5                	mov    %esp,%ebp
80105a51:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a54:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105a59:	68 39 7a 10 80       	push   $0x80107a39
80105a5e:	68 60 4c 11 80       	push   $0x80114c60
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a63:	66 89 15 a2 4e 11 80 	mov    %dx,0x80114ea2
80105a6a:	c6 05 a4 4e 11 80 00 	movb   $0x0,0x80114ea4
80105a71:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
80105a77:	c1 e8 10             	shr    $0x10,%eax
80105a7a:	c6 05 a5 4e 11 80 ef 	movb   $0xef,0x80114ea5
80105a81:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6

  initlock(&tickslock, "time");
80105a87:	e8 f4 ea ff ff       	call   80104580 <initlock>
}
80105a8c:	83 c4 10             	add    $0x10,%esp
80105a8f:	c9                   	leave  
80105a90:	c3                   	ret    
80105a91:	eb 0d                	jmp    80105aa0 <idtinit>
80105a93:	90                   	nop
80105a94:	90                   	nop
80105a95:	90                   	nop
80105a96:	90                   	nop
80105a97:	90                   	nop
80105a98:	90                   	nop
80105a99:	90                   	nop
80105a9a:	90                   	nop
80105a9b:	90                   	nop
80105a9c:	90                   	nop
80105a9d:	90                   	nop
80105a9e:	90                   	nop
80105a9f:	90                   	nop

80105aa0 <idtinit>:

void
idtinit(void)
{
80105aa0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105aa1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105aa6:	89 e5                	mov    %esp,%ebp
80105aa8:	83 ec 10             	sub    $0x10,%esp
80105aab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105aaf:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
80105ab4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105ab8:	c1 e8 10             	shr    $0x10,%eax
80105abb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105abf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ac2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ac5:	c9                   	leave  
80105ac6:	c3                   	ret    
80105ac7:	89 f6                	mov    %esi,%esi
80105ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ad0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	57                   	push   %edi
80105ad4:	56                   	push   %esi
80105ad5:	53                   	push   %ebx
80105ad6:	83 ec 1c             	sub    $0x1c,%esp
80105ad9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105adc:	8b 47 30             	mov    0x30(%edi),%eax
80105adf:	83 f8 40             	cmp    $0x40,%eax
80105ae2:	0f 84 88 01 00 00    	je     80105c70 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105ae8:	83 e8 20             	sub    $0x20,%eax
80105aeb:	83 f8 1f             	cmp    $0x1f,%eax
80105aee:	77 10                	ja     80105b00 <trap+0x30>
80105af0:	ff 24 85 e0 7a 10 80 	jmp    *-0x7fef8520(,%eax,4)
80105af7:	89 f6                	mov    %esi,%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105b00:	e8 3b e0 ff ff       	call   80103b40 <myproc>
80105b05:	85 c0                	test   %eax,%eax
80105b07:	0f 84 d7 01 00 00    	je     80105ce4 <trap+0x214>
80105b0d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105b11:	0f 84 cd 01 00 00    	je     80105ce4 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105b17:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b1a:	8b 57 38             	mov    0x38(%edi),%edx
80105b1d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105b20:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105b23:	e8 f8 df ff ff       	call   80103b20 <cpuid>
80105b28:	8b 77 34             	mov    0x34(%edi),%esi
80105b2b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105b2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b31:	e8 0a e0 ff ff       	call   80103b40 <myproc>
80105b36:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105b39:	e8 02 e0 ff ff       	call   80103b40 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b3e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105b41:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105b44:	51                   	push   %ecx
80105b45:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b46:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b49:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b4c:	56                   	push   %esi
80105b4d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b4e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b51:	52                   	push   %edx
80105b52:	ff 70 10             	pushl  0x10(%eax)
80105b55:	68 9c 7a 10 80       	push   $0x80107a9c
80105b5a:	e8 01 ab ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105b5f:	83 c4 20             	add    $0x20,%esp
80105b62:	e8 d9 df ff ff       	call   80103b40 <myproc>
80105b67:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105b6e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b70:	e8 cb df ff ff       	call   80103b40 <myproc>
80105b75:	85 c0                	test   %eax,%eax
80105b77:	74 0c                	je     80105b85 <trap+0xb5>
80105b79:	e8 c2 df ff ff       	call   80103b40 <myproc>
80105b7e:	8b 50 24             	mov    0x24(%eax),%edx
80105b81:	85 d2                	test   %edx,%edx
80105b83:	75 4b                	jne    80105bd0 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b85:	e8 b6 df ff ff       	call   80103b40 <myproc>
80105b8a:	85 c0                	test   %eax,%eax
80105b8c:	74 0b                	je     80105b99 <trap+0xc9>
80105b8e:	e8 ad df ff ff       	call   80103b40 <myproc>
80105b93:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b97:	74 4f                	je     80105be8 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b99:	e8 a2 df ff ff       	call   80103b40 <myproc>
80105b9e:	85 c0                	test   %eax,%eax
80105ba0:	74 1d                	je     80105bbf <trap+0xef>
80105ba2:	e8 99 df ff ff       	call   80103b40 <myproc>
80105ba7:	8b 40 24             	mov    0x24(%eax),%eax
80105baa:	85 c0                	test   %eax,%eax
80105bac:	74 11                	je     80105bbf <trap+0xef>
80105bae:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105bb2:	83 e0 03             	and    $0x3,%eax
80105bb5:	66 83 f8 03          	cmp    $0x3,%ax
80105bb9:	0f 84 da 00 00 00    	je     80105c99 <trap+0x1c9>
    exit();
}
80105bbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bc2:	5b                   	pop    %ebx
80105bc3:	5e                   	pop    %esi
80105bc4:	5f                   	pop    %edi
80105bc5:	5d                   	pop    %ebp
80105bc6:	c3                   	ret    
80105bc7:	89 f6                	mov    %esi,%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bd0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105bd4:	83 e0 03             	and    $0x3,%eax
80105bd7:	66 83 f8 03          	cmp    $0x3,%ax
80105bdb:	75 a8                	jne    80105b85 <trap+0xb5>
    exit();
80105bdd:	e8 8e e3 ff ff       	call   80103f70 <exit>
80105be2:	eb a1                	jmp    80105b85 <trap+0xb5>
80105be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105be8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105bec:	75 ab                	jne    80105b99 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105bee:	e8 ad e4 ff ff       	call   801040a0 <yield>
80105bf3:	eb a4                	jmp    80105b99 <trap+0xc9>
80105bf5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105bf8:	e8 23 df ff ff       	call   80103b20 <cpuid>
80105bfd:	85 c0                	test   %eax,%eax
80105bff:	0f 84 ab 00 00 00    	je     80105cb0 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105c05:	e8 c6 ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105c0a:	e9 61 ff ff ff       	jmp    80105b70 <trap+0xa0>
80105c0f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105c10:	e8 7b cd ff ff       	call   80102990 <kbdintr>
    lapiceoi();
80105c15:	e8 b6 ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105c1a:	e9 51 ff ff ff       	jmp    80105b70 <trap+0xa0>
80105c1f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105c20:	e8 5b 02 00 00       	call   80105e80 <uartintr>
    lapiceoi();
80105c25:	e8 a6 ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105c2a:	e9 41 ff ff ff       	jmp    80105b70 <trap+0xa0>
80105c2f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105c30:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105c34:	8b 77 38             	mov    0x38(%edi),%esi
80105c37:	e8 e4 de ff ff       	call   80103b20 <cpuid>
80105c3c:	56                   	push   %esi
80105c3d:	53                   	push   %ebx
80105c3e:	50                   	push   %eax
80105c3f:	68 44 7a 10 80       	push   $0x80107a44
80105c44:	e8 17 aa ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105c49:	e8 82 ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105c4e:	83 c4 10             	add    $0x10,%esp
80105c51:	e9 1a ff ff ff       	jmp    80105b70 <trap+0xa0>
80105c56:	8d 76 00             	lea    0x0(%esi),%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105c60:	e8 ab c7 ff ff       	call   80102410 <ideintr>
80105c65:	eb 9e                	jmp    80105c05 <trap+0x135>
80105c67:	89 f6                	mov    %esi,%esi
80105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105c70:	e8 cb de ff ff       	call   80103b40 <myproc>
80105c75:	8b 58 24             	mov    0x24(%eax),%ebx
80105c78:	85 db                	test   %ebx,%ebx
80105c7a:	75 2c                	jne    80105ca8 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105c7c:	e8 bf de ff ff       	call   80103b40 <myproc>
80105c81:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105c84:	e8 57 ef ff ff       	call   80104be0 <syscall>
    if(myproc()->killed)
80105c89:	e8 b2 de ff ff       	call   80103b40 <myproc>
80105c8e:	8b 48 24             	mov    0x24(%eax),%ecx
80105c91:	85 c9                	test   %ecx,%ecx
80105c93:	0f 84 26 ff ff ff    	je     80105bbf <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105c99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c9c:	5b                   	pop    %ebx
80105c9d:	5e                   	pop    %esi
80105c9e:	5f                   	pop    %edi
80105c9f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105ca0:	e9 cb e2 ff ff       	jmp    80103f70 <exit>
80105ca5:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105ca8:	e8 c3 e2 ff ff       	call   80103f70 <exit>
80105cad:	eb cd                	jmp    80105c7c <trap+0x1ac>
80105caf:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105cb0:	83 ec 0c             	sub    $0xc,%esp
80105cb3:	68 60 4c 11 80       	push   $0x80114c60
80105cb8:	e8 23 ea ff ff       	call   801046e0 <acquire>
      ticks++;
      wakeup(&ticks);
80105cbd:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105cc4:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
80105ccb:	e8 d0 e5 ff ff       	call   801042a0 <wakeup>
      release(&tickslock);
80105cd0:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105cd7:	e8 b4 ea ff ff       	call   80104790 <release>
80105cdc:	83 c4 10             	add    $0x10,%esp
80105cdf:	e9 21 ff ff ff       	jmp    80105c05 <trap+0x135>
80105ce4:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105ce7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105cea:	e8 31 de ff ff       	call   80103b20 <cpuid>
80105cef:	83 ec 0c             	sub    $0xc,%esp
80105cf2:	56                   	push   %esi
80105cf3:	53                   	push   %ebx
80105cf4:	50                   	push   %eax
80105cf5:	ff 77 30             	pushl  0x30(%edi)
80105cf8:	68 68 7a 10 80       	push   $0x80107a68
80105cfd:	e8 5e a9 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105d02:	83 c4 14             	add    $0x14,%esp
80105d05:	68 3e 7a 10 80       	push   $0x80107a3e
80105d0a:	e8 61 a6 ff ff       	call   80100370 <panic>
80105d0f:	90                   	nop

80105d10 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d10:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105d15:	55                   	push   %ebp
80105d16:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105d18:	85 c0                	test   %eax,%eax
80105d1a:	74 1c                	je     80105d38 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d1c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d21:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d22:	a8 01                	test   $0x1,%al
80105d24:	74 12                	je     80105d38 <uartgetc+0x28>
80105d26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d2b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d2c:	0f b6 c0             	movzbl %al,%eax
}
80105d2f:	5d                   	pop    %ebp
80105d30:	c3                   	ret    
80105d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105d38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105d3d:	5d                   	pop    %ebp
80105d3e:	c3                   	ret    
80105d3f:	90                   	nop

80105d40 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105d40:	55                   	push   %ebp
80105d41:	89 e5                	mov    %esp,%ebp
80105d43:	57                   	push   %edi
80105d44:	56                   	push   %esi
80105d45:	53                   	push   %ebx
80105d46:	89 c7                	mov    %eax,%edi
80105d48:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d4d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d52:	83 ec 0c             	sub    $0xc,%esp
80105d55:	eb 1b                	jmp    80105d72 <uartputc.part.0+0x32>
80105d57:	89 f6                	mov    %esi,%esi
80105d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105d60:	83 ec 0c             	sub    $0xc,%esp
80105d63:	6a 0a                	push   $0xa
80105d65:	e8 86 cd ff ff       	call   80102af0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d6a:	83 c4 10             	add    $0x10,%esp
80105d6d:	83 eb 01             	sub    $0x1,%ebx
80105d70:	74 07                	je     80105d79 <uartputc.part.0+0x39>
80105d72:	89 f2                	mov    %esi,%edx
80105d74:	ec                   	in     (%dx),%al
80105d75:	a8 20                	test   $0x20,%al
80105d77:	74 e7                	je     80105d60 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d79:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d7e:	89 f8                	mov    %edi,%eax
80105d80:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105d81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d84:	5b                   	pop    %ebx
80105d85:	5e                   	pop    %esi
80105d86:	5f                   	pop    %edi
80105d87:	5d                   	pop    %ebp
80105d88:	c3                   	ret    
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d90 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105d90:	55                   	push   %ebp
80105d91:	31 c9                	xor    %ecx,%ecx
80105d93:	89 c8                	mov    %ecx,%eax
80105d95:	89 e5                	mov    %esp,%ebp
80105d97:	57                   	push   %edi
80105d98:	56                   	push   %esi
80105d99:	53                   	push   %ebx
80105d9a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d9f:	89 da                	mov    %ebx,%edx
80105da1:	83 ec 0c             	sub    $0xc,%esp
80105da4:	ee                   	out    %al,(%dx)
80105da5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105daa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105daf:	89 fa                	mov    %edi,%edx
80105db1:	ee                   	out    %al,(%dx)
80105db2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105db7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dbc:	ee                   	out    %al,(%dx)
80105dbd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105dc2:	89 c8                	mov    %ecx,%eax
80105dc4:	89 f2                	mov    %esi,%edx
80105dc6:	ee                   	out    %al,(%dx)
80105dc7:	b8 03 00 00 00       	mov    $0x3,%eax
80105dcc:	89 fa                	mov    %edi,%edx
80105dce:	ee                   	out    %al,(%dx)
80105dcf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105dd4:	89 c8                	mov    %ecx,%eax
80105dd6:	ee                   	out    %al,(%dx)
80105dd7:	b8 01 00 00 00       	mov    $0x1,%eax
80105ddc:	89 f2                	mov    %esi,%edx
80105dde:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105ddf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105de4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105de5:	3c ff                	cmp    $0xff,%al
80105de7:	74 5a                	je     80105e43 <uartinit+0xb3>
    return;
  uart = 1;
80105de9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105df0:	00 00 00 
80105df3:	89 da                	mov    %ebx,%edx
80105df5:	ec                   	in     (%dx),%al
80105df6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dfb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105dfc:	83 ec 08             	sub    $0x8,%esp
80105dff:	bb 60 7b 10 80       	mov    $0x80107b60,%ebx
80105e04:	6a 00                	push   $0x0
80105e06:	6a 04                	push   $0x4
80105e08:	e8 53 c8 ff ff       	call   80102660 <ioapicenable>
80105e0d:	83 c4 10             	add    $0x10,%esp
80105e10:	b8 78 00 00 00       	mov    $0x78,%eax
80105e15:	eb 13                	jmp    80105e2a <uartinit+0x9a>
80105e17:	89 f6                	mov    %esi,%esi
80105e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105e20:	83 c3 01             	add    $0x1,%ebx
80105e23:	0f be 03             	movsbl (%ebx),%eax
80105e26:	84 c0                	test   %al,%al
80105e28:	74 19                	je     80105e43 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105e2a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105e30:	85 d2                	test   %edx,%edx
80105e32:	74 ec                	je     80105e20 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105e34:	83 c3 01             	add    $0x1,%ebx
80105e37:	e8 04 ff ff ff       	call   80105d40 <uartputc.part.0>
80105e3c:	0f be 03             	movsbl (%ebx),%eax
80105e3f:	84 c0                	test   %al,%al
80105e41:	75 e7                	jne    80105e2a <uartinit+0x9a>
    uartputc(*p);
}
80105e43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e46:	5b                   	pop    %ebx
80105e47:	5e                   	pop    %esi
80105e48:	5f                   	pop    %edi
80105e49:	5d                   	pop    %ebp
80105e4a:	c3                   	ret    
80105e4b:	90                   	nop
80105e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e50 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105e50:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105e56:	55                   	push   %ebp
80105e57:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105e59:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105e5e:	74 10                	je     80105e70 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105e60:	5d                   	pop    %ebp
80105e61:	e9 da fe ff ff       	jmp    80105d40 <uartputc.part.0>
80105e66:	8d 76 00             	lea    0x0(%esi),%esi
80105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e70:	5d                   	pop    %ebp
80105e71:	c3                   	ret    
80105e72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e80 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105e80:	55                   	push   %ebp
80105e81:	89 e5                	mov    %esp,%ebp
80105e83:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e86:	68 10 5d 10 80       	push   $0x80105d10
80105e8b:	e8 60 a9 ff ff       	call   801007f0 <consoleintr>
}
80105e90:	83 c4 10             	add    $0x10,%esp
80105e93:	c9                   	leave  
80105e94:	c3                   	ret    

80105e95 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e95:	6a 00                	push   $0x0
  pushl $0
80105e97:	6a 00                	push   $0x0
  jmp alltraps
80105e99:	e9 3c fb ff ff       	jmp    801059da <alltraps>

80105e9e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e9e:	6a 00                	push   $0x0
  pushl $1
80105ea0:	6a 01                	push   $0x1
  jmp alltraps
80105ea2:	e9 33 fb ff ff       	jmp    801059da <alltraps>

80105ea7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105ea7:	6a 00                	push   $0x0
  pushl $2
80105ea9:	6a 02                	push   $0x2
  jmp alltraps
80105eab:	e9 2a fb ff ff       	jmp    801059da <alltraps>

80105eb0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105eb0:	6a 00                	push   $0x0
  pushl $3
80105eb2:	6a 03                	push   $0x3
  jmp alltraps
80105eb4:	e9 21 fb ff ff       	jmp    801059da <alltraps>

80105eb9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105eb9:	6a 00                	push   $0x0
  pushl $4
80105ebb:	6a 04                	push   $0x4
  jmp alltraps
80105ebd:	e9 18 fb ff ff       	jmp    801059da <alltraps>

80105ec2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105ec2:	6a 00                	push   $0x0
  pushl $5
80105ec4:	6a 05                	push   $0x5
  jmp alltraps
80105ec6:	e9 0f fb ff ff       	jmp    801059da <alltraps>

80105ecb <vector6>:
.globl vector6
vector6:
  pushl $0
80105ecb:	6a 00                	push   $0x0
  pushl $6
80105ecd:	6a 06                	push   $0x6
  jmp alltraps
80105ecf:	e9 06 fb ff ff       	jmp    801059da <alltraps>

80105ed4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105ed4:	6a 00                	push   $0x0
  pushl $7
80105ed6:	6a 07                	push   $0x7
  jmp alltraps
80105ed8:	e9 fd fa ff ff       	jmp    801059da <alltraps>

80105edd <vector8>:
.globl vector8
vector8:
  pushl $8
80105edd:	6a 08                	push   $0x8
  jmp alltraps
80105edf:	e9 f6 fa ff ff       	jmp    801059da <alltraps>

80105ee4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105ee4:	6a 00                	push   $0x0
  pushl $9
80105ee6:	6a 09                	push   $0x9
  jmp alltraps
80105ee8:	e9 ed fa ff ff       	jmp    801059da <alltraps>

80105eed <vector10>:
.globl vector10
vector10:
  pushl $10
80105eed:	6a 0a                	push   $0xa
  jmp alltraps
80105eef:	e9 e6 fa ff ff       	jmp    801059da <alltraps>

80105ef4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105ef4:	6a 0b                	push   $0xb
  jmp alltraps
80105ef6:	e9 df fa ff ff       	jmp    801059da <alltraps>

80105efb <vector12>:
.globl vector12
vector12:
  pushl $12
80105efb:	6a 0c                	push   $0xc
  jmp alltraps
80105efd:	e9 d8 fa ff ff       	jmp    801059da <alltraps>

80105f02 <vector13>:
.globl vector13
vector13:
  pushl $13
80105f02:	6a 0d                	push   $0xd
  jmp alltraps
80105f04:	e9 d1 fa ff ff       	jmp    801059da <alltraps>

80105f09 <vector14>:
.globl vector14
vector14:
  pushl $14
80105f09:	6a 0e                	push   $0xe
  jmp alltraps
80105f0b:	e9 ca fa ff ff       	jmp    801059da <alltraps>

80105f10 <vector15>:
.globl vector15
vector15:
  pushl $0
80105f10:	6a 00                	push   $0x0
  pushl $15
80105f12:	6a 0f                	push   $0xf
  jmp alltraps
80105f14:	e9 c1 fa ff ff       	jmp    801059da <alltraps>

80105f19 <vector16>:
.globl vector16
vector16:
  pushl $0
80105f19:	6a 00                	push   $0x0
  pushl $16
80105f1b:	6a 10                	push   $0x10
  jmp alltraps
80105f1d:	e9 b8 fa ff ff       	jmp    801059da <alltraps>

80105f22 <vector17>:
.globl vector17
vector17:
  pushl $17
80105f22:	6a 11                	push   $0x11
  jmp alltraps
80105f24:	e9 b1 fa ff ff       	jmp    801059da <alltraps>

80105f29 <vector18>:
.globl vector18
vector18:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $18
80105f2b:	6a 12                	push   $0x12
  jmp alltraps
80105f2d:	e9 a8 fa ff ff       	jmp    801059da <alltraps>

80105f32 <vector19>:
.globl vector19
vector19:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $19
80105f34:	6a 13                	push   $0x13
  jmp alltraps
80105f36:	e9 9f fa ff ff       	jmp    801059da <alltraps>

80105f3b <vector20>:
.globl vector20
vector20:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $20
80105f3d:	6a 14                	push   $0x14
  jmp alltraps
80105f3f:	e9 96 fa ff ff       	jmp    801059da <alltraps>

80105f44 <vector21>:
.globl vector21
vector21:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $21
80105f46:	6a 15                	push   $0x15
  jmp alltraps
80105f48:	e9 8d fa ff ff       	jmp    801059da <alltraps>

80105f4d <vector22>:
.globl vector22
vector22:
  pushl $0
80105f4d:	6a 00                	push   $0x0
  pushl $22
80105f4f:	6a 16                	push   $0x16
  jmp alltraps
80105f51:	e9 84 fa ff ff       	jmp    801059da <alltraps>

80105f56 <vector23>:
.globl vector23
vector23:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $23
80105f58:	6a 17                	push   $0x17
  jmp alltraps
80105f5a:	e9 7b fa ff ff       	jmp    801059da <alltraps>

80105f5f <vector24>:
.globl vector24
vector24:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $24
80105f61:	6a 18                	push   $0x18
  jmp alltraps
80105f63:	e9 72 fa ff ff       	jmp    801059da <alltraps>

80105f68 <vector25>:
.globl vector25
vector25:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $25
80105f6a:	6a 19                	push   $0x19
  jmp alltraps
80105f6c:	e9 69 fa ff ff       	jmp    801059da <alltraps>

80105f71 <vector26>:
.globl vector26
vector26:
  pushl $0
80105f71:	6a 00                	push   $0x0
  pushl $26
80105f73:	6a 1a                	push   $0x1a
  jmp alltraps
80105f75:	e9 60 fa ff ff       	jmp    801059da <alltraps>

80105f7a <vector27>:
.globl vector27
vector27:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $27
80105f7c:	6a 1b                	push   $0x1b
  jmp alltraps
80105f7e:	e9 57 fa ff ff       	jmp    801059da <alltraps>

80105f83 <vector28>:
.globl vector28
vector28:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $28
80105f85:	6a 1c                	push   $0x1c
  jmp alltraps
80105f87:	e9 4e fa ff ff       	jmp    801059da <alltraps>

80105f8c <vector29>:
.globl vector29
vector29:
  pushl $0
80105f8c:	6a 00                	push   $0x0
  pushl $29
80105f8e:	6a 1d                	push   $0x1d
  jmp alltraps
80105f90:	e9 45 fa ff ff       	jmp    801059da <alltraps>

80105f95 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f95:	6a 00                	push   $0x0
  pushl $30
80105f97:	6a 1e                	push   $0x1e
  jmp alltraps
80105f99:	e9 3c fa ff ff       	jmp    801059da <alltraps>

80105f9e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $31
80105fa0:	6a 1f                	push   $0x1f
  jmp alltraps
80105fa2:	e9 33 fa ff ff       	jmp    801059da <alltraps>

80105fa7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105fa7:	6a 00                	push   $0x0
  pushl $32
80105fa9:	6a 20                	push   $0x20
  jmp alltraps
80105fab:	e9 2a fa ff ff       	jmp    801059da <alltraps>

80105fb0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105fb0:	6a 00                	push   $0x0
  pushl $33
80105fb2:	6a 21                	push   $0x21
  jmp alltraps
80105fb4:	e9 21 fa ff ff       	jmp    801059da <alltraps>

80105fb9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $34
80105fbb:	6a 22                	push   $0x22
  jmp alltraps
80105fbd:	e9 18 fa ff ff       	jmp    801059da <alltraps>

80105fc2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $35
80105fc4:	6a 23                	push   $0x23
  jmp alltraps
80105fc6:	e9 0f fa ff ff       	jmp    801059da <alltraps>

80105fcb <vector36>:
.globl vector36
vector36:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $36
80105fcd:	6a 24                	push   $0x24
  jmp alltraps
80105fcf:	e9 06 fa ff ff       	jmp    801059da <alltraps>

80105fd4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $37
80105fd6:	6a 25                	push   $0x25
  jmp alltraps
80105fd8:	e9 fd f9 ff ff       	jmp    801059da <alltraps>

80105fdd <vector38>:
.globl vector38
vector38:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $38
80105fdf:	6a 26                	push   $0x26
  jmp alltraps
80105fe1:	e9 f4 f9 ff ff       	jmp    801059da <alltraps>

80105fe6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $39
80105fe8:	6a 27                	push   $0x27
  jmp alltraps
80105fea:	e9 eb f9 ff ff       	jmp    801059da <alltraps>

80105fef <vector40>:
.globl vector40
vector40:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $40
80105ff1:	6a 28                	push   $0x28
  jmp alltraps
80105ff3:	e9 e2 f9 ff ff       	jmp    801059da <alltraps>

80105ff8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $41
80105ffa:	6a 29                	push   $0x29
  jmp alltraps
80105ffc:	e9 d9 f9 ff ff       	jmp    801059da <alltraps>

80106001 <vector42>:
.globl vector42
vector42:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $42
80106003:	6a 2a                	push   $0x2a
  jmp alltraps
80106005:	e9 d0 f9 ff ff       	jmp    801059da <alltraps>

8010600a <vector43>:
.globl vector43
vector43:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $43
8010600c:	6a 2b                	push   $0x2b
  jmp alltraps
8010600e:	e9 c7 f9 ff ff       	jmp    801059da <alltraps>

80106013 <vector44>:
.globl vector44
vector44:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $44
80106015:	6a 2c                	push   $0x2c
  jmp alltraps
80106017:	e9 be f9 ff ff       	jmp    801059da <alltraps>

8010601c <vector45>:
.globl vector45
vector45:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $45
8010601e:	6a 2d                	push   $0x2d
  jmp alltraps
80106020:	e9 b5 f9 ff ff       	jmp    801059da <alltraps>

80106025 <vector46>:
.globl vector46
vector46:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $46
80106027:	6a 2e                	push   $0x2e
  jmp alltraps
80106029:	e9 ac f9 ff ff       	jmp    801059da <alltraps>

8010602e <vector47>:
.globl vector47
vector47:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $47
80106030:	6a 2f                	push   $0x2f
  jmp alltraps
80106032:	e9 a3 f9 ff ff       	jmp    801059da <alltraps>

80106037 <vector48>:
.globl vector48
vector48:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $48
80106039:	6a 30                	push   $0x30
  jmp alltraps
8010603b:	e9 9a f9 ff ff       	jmp    801059da <alltraps>

80106040 <vector49>:
.globl vector49
vector49:
  pushl $0
80106040:	6a 00                	push   $0x0
  pushl $49
80106042:	6a 31                	push   $0x31
  jmp alltraps
80106044:	e9 91 f9 ff ff       	jmp    801059da <alltraps>

80106049 <vector50>:
.globl vector50
vector50:
  pushl $0
80106049:	6a 00                	push   $0x0
  pushl $50
8010604b:	6a 32                	push   $0x32
  jmp alltraps
8010604d:	e9 88 f9 ff ff       	jmp    801059da <alltraps>

80106052 <vector51>:
.globl vector51
vector51:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $51
80106054:	6a 33                	push   $0x33
  jmp alltraps
80106056:	e9 7f f9 ff ff       	jmp    801059da <alltraps>

8010605b <vector52>:
.globl vector52
vector52:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $52
8010605d:	6a 34                	push   $0x34
  jmp alltraps
8010605f:	e9 76 f9 ff ff       	jmp    801059da <alltraps>

80106064 <vector53>:
.globl vector53
vector53:
  pushl $0
80106064:	6a 00                	push   $0x0
  pushl $53
80106066:	6a 35                	push   $0x35
  jmp alltraps
80106068:	e9 6d f9 ff ff       	jmp    801059da <alltraps>

8010606d <vector54>:
.globl vector54
vector54:
  pushl $0
8010606d:	6a 00                	push   $0x0
  pushl $54
8010606f:	6a 36                	push   $0x36
  jmp alltraps
80106071:	e9 64 f9 ff ff       	jmp    801059da <alltraps>

80106076 <vector55>:
.globl vector55
vector55:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $55
80106078:	6a 37                	push   $0x37
  jmp alltraps
8010607a:	e9 5b f9 ff ff       	jmp    801059da <alltraps>

8010607f <vector56>:
.globl vector56
vector56:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $56
80106081:	6a 38                	push   $0x38
  jmp alltraps
80106083:	e9 52 f9 ff ff       	jmp    801059da <alltraps>

80106088 <vector57>:
.globl vector57
vector57:
  pushl $0
80106088:	6a 00                	push   $0x0
  pushl $57
8010608a:	6a 39                	push   $0x39
  jmp alltraps
8010608c:	e9 49 f9 ff ff       	jmp    801059da <alltraps>

80106091 <vector58>:
.globl vector58
vector58:
  pushl $0
80106091:	6a 00                	push   $0x0
  pushl $58
80106093:	6a 3a                	push   $0x3a
  jmp alltraps
80106095:	e9 40 f9 ff ff       	jmp    801059da <alltraps>

8010609a <vector59>:
.globl vector59
vector59:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $59
8010609c:	6a 3b                	push   $0x3b
  jmp alltraps
8010609e:	e9 37 f9 ff ff       	jmp    801059da <alltraps>

801060a3 <vector60>:
.globl vector60
vector60:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $60
801060a5:	6a 3c                	push   $0x3c
  jmp alltraps
801060a7:	e9 2e f9 ff ff       	jmp    801059da <alltraps>

801060ac <vector61>:
.globl vector61
vector61:
  pushl $0
801060ac:	6a 00                	push   $0x0
  pushl $61
801060ae:	6a 3d                	push   $0x3d
  jmp alltraps
801060b0:	e9 25 f9 ff ff       	jmp    801059da <alltraps>

801060b5 <vector62>:
.globl vector62
vector62:
  pushl $0
801060b5:	6a 00                	push   $0x0
  pushl $62
801060b7:	6a 3e                	push   $0x3e
  jmp alltraps
801060b9:	e9 1c f9 ff ff       	jmp    801059da <alltraps>

801060be <vector63>:
.globl vector63
vector63:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $63
801060c0:	6a 3f                	push   $0x3f
  jmp alltraps
801060c2:	e9 13 f9 ff ff       	jmp    801059da <alltraps>

801060c7 <vector64>:
.globl vector64
vector64:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $64
801060c9:	6a 40                	push   $0x40
  jmp alltraps
801060cb:	e9 0a f9 ff ff       	jmp    801059da <alltraps>

801060d0 <vector65>:
.globl vector65
vector65:
  pushl $0
801060d0:	6a 00                	push   $0x0
  pushl $65
801060d2:	6a 41                	push   $0x41
  jmp alltraps
801060d4:	e9 01 f9 ff ff       	jmp    801059da <alltraps>

801060d9 <vector66>:
.globl vector66
vector66:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $66
801060db:	6a 42                	push   $0x42
  jmp alltraps
801060dd:	e9 f8 f8 ff ff       	jmp    801059da <alltraps>

801060e2 <vector67>:
.globl vector67
vector67:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $67
801060e4:	6a 43                	push   $0x43
  jmp alltraps
801060e6:	e9 ef f8 ff ff       	jmp    801059da <alltraps>

801060eb <vector68>:
.globl vector68
vector68:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $68
801060ed:	6a 44                	push   $0x44
  jmp alltraps
801060ef:	e9 e6 f8 ff ff       	jmp    801059da <alltraps>

801060f4 <vector69>:
.globl vector69
vector69:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $69
801060f6:	6a 45                	push   $0x45
  jmp alltraps
801060f8:	e9 dd f8 ff ff       	jmp    801059da <alltraps>

801060fd <vector70>:
.globl vector70
vector70:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $70
801060ff:	6a 46                	push   $0x46
  jmp alltraps
80106101:	e9 d4 f8 ff ff       	jmp    801059da <alltraps>

80106106 <vector71>:
.globl vector71
vector71:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $71
80106108:	6a 47                	push   $0x47
  jmp alltraps
8010610a:	e9 cb f8 ff ff       	jmp    801059da <alltraps>

8010610f <vector72>:
.globl vector72
vector72:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $72
80106111:	6a 48                	push   $0x48
  jmp alltraps
80106113:	e9 c2 f8 ff ff       	jmp    801059da <alltraps>

80106118 <vector73>:
.globl vector73
vector73:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $73
8010611a:	6a 49                	push   $0x49
  jmp alltraps
8010611c:	e9 b9 f8 ff ff       	jmp    801059da <alltraps>

80106121 <vector74>:
.globl vector74
vector74:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $74
80106123:	6a 4a                	push   $0x4a
  jmp alltraps
80106125:	e9 b0 f8 ff ff       	jmp    801059da <alltraps>

8010612a <vector75>:
.globl vector75
vector75:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $75
8010612c:	6a 4b                	push   $0x4b
  jmp alltraps
8010612e:	e9 a7 f8 ff ff       	jmp    801059da <alltraps>

80106133 <vector76>:
.globl vector76
vector76:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $76
80106135:	6a 4c                	push   $0x4c
  jmp alltraps
80106137:	e9 9e f8 ff ff       	jmp    801059da <alltraps>

8010613c <vector77>:
.globl vector77
vector77:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $77
8010613e:	6a 4d                	push   $0x4d
  jmp alltraps
80106140:	e9 95 f8 ff ff       	jmp    801059da <alltraps>

80106145 <vector78>:
.globl vector78
vector78:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $78
80106147:	6a 4e                	push   $0x4e
  jmp alltraps
80106149:	e9 8c f8 ff ff       	jmp    801059da <alltraps>

8010614e <vector79>:
.globl vector79
vector79:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $79
80106150:	6a 4f                	push   $0x4f
  jmp alltraps
80106152:	e9 83 f8 ff ff       	jmp    801059da <alltraps>

80106157 <vector80>:
.globl vector80
vector80:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $80
80106159:	6a 50                	push   $0x50
  jmp alltraps
8010615b:	e9 7a f8 ff ff       	jmp    801059da <alltraps>

80106160 <vector81>:
.globl vector81
vector81:
  pushl $0
80106160:	6a 00                	push   $0x0
  pushl $81
80106162:	6a 51                	push   $0x51
  jmp alltraps
80106164:	e9 71 f8 ff ff       	jmp    801059da <alltraps>

80106169 <vector82>:
.globl vector82
vector82:
  pushl $0
80106169:	6a 00                	push   $0x0
  pushl $82
8010616b:	6a 52                	push   $0x52
  jmp alltraps
8010616d:	e9 68 f8 ff ff       	jmp    801059da <alltraps>

80106172 <vector83>:
.globl vector83
vector83:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $83
80106174:	6a 53                	push   $0x53
  jmp alltraps
80106176:	e9 5f f8 ff ff       	jmp    801059da <alltraps>

8010617b <vector84>:
.globl vector84
vector84:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $84
8010617d:	6a 54                	push   $0x54
  jmp alltraps
8010617f:	e9 56 f8 ff ff       	jmp    801059da <alltraps>

80106184 <vector85>:
.globl vector85
vector85:
  pushl $0
80106184:	6a 00                	push   $0x0
  pushl $85
80106186:	6a 55                	push   $0x55
  jmp alltraps
80106188:	e9 4d f8 ff ff       	jmp    801059da <alltraps>

8010618d <vector86>:
.globl vector86
vector86:
  pushl $0
8010618d:	6a 00                	push   $0x0
  pushl $86
8010618f:	6a 56                	push   $0x56
  jmp alltraps
80106191:	e9 44 f8 ff ff       	jmp    801059da <alltraps>

80106196 <vector87>:
.globl vector87
vector87:
  pushl $0
80106196:	6a 00                	push   $0x0
  pushl $87
80106198:	6a 57                	push   $0x57
  jmp alltraps
8010619a:	e9 3b f8 ff ff       	jmp    801059da <alltraps>

8010619f <vector88>:
.globl vector88
vector88:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $88
801061a1:	6a 58                	push   $0x58
  jmp alltraps
801061a3:	e9 32 f8 ff ff       	jmp    801059da <alltraps>

801061a8 <vector89>:
.globl vector89
vector89:
  pushl $0
801061a8:	6a 00                	push   $0x0
  pushl $89
801061aa:	6a 59                	push   $0x59
  jmp alltraps
801061ac:	e9 29 f8 ff ff       	jmp    801059da <alltraps>

801061b1 <vector90>:
.globl vector90
vector90:
  pushl $0
801061b1:	6a 00                	push   $0x0
  pushl $90
801061b3:	6a 5a                	push   $0x5a
  jmp alltraps
801061b5:	e9 20 f8 ff ff       	jmp    801059da <alltraps>

801061ba <vector91>:
.globl vector91
vector91:
  pushl $0
801061ba:	6a 00                	push   $0x0
  pushl $91
801061bc:	6a 5b                	push   $0x5b
  jmp alltraps
801061be:	e9 17 f8 ff ff       	jmp    801059da <alltraps>

801061c3 <vector92>:
.globl vector92
vector92:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $92
801061c5:	6a 5c                	push   $0x5c
  jmp alltraps
801061c7:	e9 0e f8 ff ff       	jmp    801059da <alltraps>

801061cc <vector93>:
.globl vector93
vector93:
  pushl $0
801061cc:	6a 00                	push   $0x0
  pushl $93
801061ce:	6a 5d                	push   $0x5d
  jmp alltraps
801061d0:	e9 05 f8 ff ff       	jmp    801059da <alltraps>

801061d5 <vector94>:
.globl vector94
vector94:
  pushl $0
801061d5:	6a 00                	push   $0x0
  pushl $94
801061d7:	6a 5e                	push   $0x5e
  jmp alltraps
801061d9:	e9 fc f7 ff ff       	jmp    801059da <alltraps>

801061de <vector95>:
.globl vector95
vector95:
  pushl $0
801061de:	6a 00                	push   $0x0
  pushl $95
801061e0:	6a 5f                	push   $0x5f
  jmp alltraps
801061e2:	e9 f3 f7 ff ff       	jmp    801059da <alltraps>

801061e7 <vector96>:
.globl vector96
vector96:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $96
801061e9:	6a 60                	push   $0x60
  jmp alltraps
801061eb:	e9 ea f7 ff ff       	jmp    801059da <alltraps>

801061f0 <vector97>:
.globl vector97
vector97:
  pushl $0
801061f0:	6a 00                	push   $0x0
  pushl $97
801061f2:	6a 61                	push   $0x61
  jmp alltraps
801061f4:	e9 e1 f7 ff ff       	jmp    801059da <alltraps>

801061f9 <vector98>:
.globl vector98
vector98:
  pushl $0
801061f9:	6a 00                	push   $0x0
  pushl $98
801061fb:	6a 62                	push   $0x62
  jmp alltraps
801061fd:	e9 d8 f7 ff ff       	jmp    801059da <alltraps>

80106202 <vector99>:
.globl vector99
vector99:
  pushl $0
80106202:	6a 00                	push   $0x0
  pushl $99
80106204:	6a 63                	push   $0x63
  jmp alltraps
80106206:	e9 cf f7 ff ff       	jmp    801059da <alltraps>

8010620b <vector100>:
.globl vector100
vector100:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $100
8010620d:	6a 64                	push   $0x64
  jmp alltraps
8010620f:	e9 c6 f7 ff ff       	jmp    801059da <alltraps>

80106214 <vector101>:
.globl vector101
vector101:
  pushl $0
80106214:	6a 00                	push   $0x0
  pushl $101
80106216:	6a 65                	push   $0x65
  jmp alltraps
80106218:	e9 bd f7 ff ff       	jmp    801059da <alltraps>

8010621d <vector102>:
.globl vector102
vector102:
  pushl $0
8010621d:	6a 00                	push   $0x0
  pushl $102
8010621f:	6a 66                	push   $0x66
  jmp alltraps
80106221:	e9 b4 f7 ff ff       	jmp    801059da <alltraps>

80106226 <vector103>:
.globl vector103
vector103:
  pushl $0
80106226:	6a 00                	push   $0x0
  pushl $103
80106228:	6a 67                	push   $0x67
  jmp alltraps
8010622a:	e9 ab f7 ff ff       	jmp    801059da <alltraps>

8010622f <vector104>:
.globl vector104
vector104:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $104
80106231:	6a 68                	push   $0x68
  jmp alltraps
80106233:	e9 a2 f7 ff ff       	jmp    801059da <alltraps>

80106238 <vector105>:
.globl vector105
vector105:
  pushl $0
80106238:	6a 00                	push   $0x0
  pushl $105
8010623a:	6a 69                	push   $0x69
  jmp alltraps
8010623c:	e9 99 f7 ff ff       	jmp    801059da <alltraps>

80106241 <vector106>:
.globl vector106
vector106:
  pushl $0
80106241:	6a 00                	push   $0x0
  pushl $106
80106243:	6a 6a                	push   $0x6a
  jmp alltraps
80106245:	e9 90 f7 ff ff       	jmp    801059da <alltraps>

8010624a <vector107>:
.globl vector107
vector107:
  pushl $0
8010624a:	6a 00                	push   $0x0
  pushl $107
8010624c:	6a 6b                	push   $0x6b
  jmp alltraps
8010624e:	e9 87 f7 ff ff       	jmp    801059da <alltraps>

80106253 <vector108>:
.globl vector108
vector108:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $108
80106255:	6a 6c                	push   $0x6c
  jmp alltraps
80106257:	e9 7e f7 ff ff       	jmp    801059da <alltraps>

8010625c <vector109>:
.globl vector109
vector109:
  pushl $0
8010625c:	6a 00                	push   $0x0
  pushl $109
8010625e:	6a 6d                	push   $0x6d
  jmp alltraps
80106260:	e9 75 f7 ff ff       	jmp    801059da <alltraps>

80106265 <vector110>:
.globl vector110
vector110:
  pushl $0
80106265:	6a 00                	push   $0x0
  pushl $110
80106267:	6a 6e                	push   $0x6e
  jmp alltraps
80106269:	e9 6c f7 ff ff       	jmp    801059da <alltraps>

8010626e <vector111>:
.globl vector111
vector111:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $111
80106270:	6a 6f                	push   $0x6f
  jmp alltraps
80106272:	e9 63 f7 ff ff       	jmp    801059da <alltraps>

80106277 <vector112>:
.globl vector112
vector112:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $112
80106279:	6a 70                	push   $0x70
  jmp alltraps
8010627b:	e9 5a f7 ff ff       	jmp    801059da <alltraps>

80106280 <vector113>:
.globl vector113
vector113:
  pushl $0
80106280:	6a 00                	push   $0x0
  pushl $113
80106282:	6a 71                	push   $0x71
  jmp alltraps
80106284:	e9 51 f7 ff ff       	jmp    801059da <alltraps>

80106289 <vector114>:
.globl vector114
vector114:
  pushl $0
80106289:	6a 00                	push   $0x0
  pushl $114
8010628b:	6a 72                	push   $0x72
  jmp alltraps
8010628d:	e9 48 f7 ff ff       	jmp    801059da <alltraps>

80106292 <vector115>:
.globl vector115
vector115:
  pushl $0
80106292:	6a 00                	push   $0x0
  pushl $115
80106294:	6a 73                	push   $0x73
  jmp alltraps
80106296:	e9 3f f7 ff ff       	jmp    801059da <alltraps>

8010629b <vector116>:
.globl vector116
vector116:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $116
8010629d:	6a 74                	push   $0x74
  jmp alltraps
8010629f:	e9 36 f7 ff ff       	jmp    801059da <alltraps>

801062a4 <vector117>:
.globl vector117
vector117:
  pushl $0
801062a4:	6a 00                	push   $0x0
  pushl $117
801062a6:	6a 75                	push   $0x75
  jmp alltraps
801062a8:	e9 2d f7 ff ff       	jmp    801059da <alltraps>

801062ad <vector118>:
.globl vector118
vector118:
  pushl $0
801062ad:	6a 00                	push   $0x0
  pushl $118
801062af:	6a 76                	push   $0x76
  jmp alltraps
801062b1:	e9 24 f7 ff ff       	jmp    801059da <alltraps>

801062b6 <vector119>:
.globl vector119
vector119:
  pushl $0
801062b6:	6a 00                	push   $0x0
  pushl $119
801062b8:	6a 77                	push   $0x77
  jmp alltraps
801062ba:	e9 1b f7 ff ff       	jmp    801059da <alltraps>

801062bf <vector120>:
.globl vector120
vector120:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $120
801062c1:	6a 78                	push   $0x78
  jmp alltraps
801062c3:	e9 12 f7 ff ff       	jmp    801059da <alltraps>

801062c8 <vector121>:
.globl vector121
vector121:
  pushl $0
801062c8:	6a 00                	push   $0x0
  pushl $121
801062ca:	6a 79                	push   $0x79
  jmp alltraps
801062cc:	e9 09 f7 ff ff       	jmp    801059da <alltraps>

801062d1 <vector122>:
.globl vector122
vector122:
  pushl $0
801062d1:	6a 00                	push   $0x0
  pushl $122
801062d3:	6a 7a                	push   $0x7a
  jmp alltraps
801062d5:	e9 00 f7 ff ff       	jmp    801059da <alltraps>

801062da <vector123>:
.globl vector123
vector123:
  pushl $0
801062da:	6a 00                	push   $0x0
  pushl $123
801062dc:	6a 7b                	push   $0x7b
  jmp alltraps
801062de:	e9 f7 f6 ff ff       	jmp    801059da <alltraps>

801062e3 <vector124>:
.globl vector124
vector124:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $124
801062e5:	6a 7c                	push   $0x7c
  jmp alltraps
801062e7:	e9 ee f6 ff ff       	jmp    801059da <alltraps>

801062ec <vector125>:
.globl vector125
vector125:
  pushl $0
801062ec:	6a 00                	push   $0x0
  pushl $125
801062ee:	6a 7d                	push   $0x7d
  jmp alltraps
801062f0:	e9 e5 f6 ff ff       	jmp    801059da <alltraps>

801062f5 <vector126>:
.globl vector126
vector126:
  pushl $0
801062f5:	6a 00                	push   $0x0
  pushl $126
801062f7:	6a 7e                	push   $0x7e
  jmp alltraps
801062f9:	e9 dc f6 ff ff       	jmp    801059da <alltraps>

801062fe <vector127>:
.globl vector127
vector127:
  pushl $0
801062fe:	6a 00                	push   $0x0
  pushl $127
80106300:	6a 7f                	push   $0x7f
  jmp alltraps
80106302:	e9 d3 f6 ff ff       	jmp    801059da <alltraps>

80106307 <vector128>:
.globl vector128
vector128:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $128
80106309:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010630e:	e9 c7 f6 ff ff       	jmp    801059da <alltraps>

80106313 <vector129>:
.globl vector129
vector129:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $129
80106315:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010631a:	e9 bb f6 ff ff       	jmp    801059da <alltraps>

8010631f <vector130>:
.globl vector130
vector130:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $130
80106321:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106326:	e9 af f6 ff ff       	jmp    801059da <alltraps>

8010632b <vector131>:
.globl vector131
vector131:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $131
8010632d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106332:	e9 a3 f6 ff ff       	jmp    801059da <alltraps>

80106337 <vector132>:
.globl vector132
vector132:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $132
80106339:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010633e:	e9 97 f6 ff ff       	jmp    801059da <alltraps>

80106343 <vector133>:
.globl vector133
vector133:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $133
80106345:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010634a:	e9 8b f6 ff ff       	jmp    801059da <alltraps>

8010634f <vector134>:
.globl vector134
vector134:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $134
80106351:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106356:	e9 7f f6 ff ff       	jmp    801059da <alltraps>

8010635b <vector135>:
.globl vector135
vector135:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $135
8010635d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106362:	e9 73 f6 ff ff       	jmp    801059da <alltraps>

80106367 <vector136>:
.globl vector136
vector136:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $136
80106369:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010636e:	e9 67 f6 ff ff       	jmp    801059da <alltraps>

80106373 <vector137>:
.globl vector137
vector137:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $137
80106375:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010637a:	e9 5b f6 ff ff       	jmp    801059da <alltraps>

8010637f <vector138>:
.globl vector138
vector138:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $138
80106381:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106386:	e9 4f f6 ff ff       	jmp    801059da <alltraps>

8010638b <vector139>:
.globl vector139
vector139:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $139
8010638d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106392:	e9 43 f6 ff ff       	jmp    801059da <alltraps>

80106397 <vector140>:
.globl vector140
vector140:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $140
80106399:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010639e:	e9 37 f6 ff ff       	jmp    801059da <alltraps>

801063a3 <vector141>:
.globl vector141
vector141:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $141
801063a5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801063aa:	e9 2b f6 ff ff       	jmp    801059da <alltraps>

801063af <vector142>:
.globl vector142
vector142:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $142
801063b1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801063b6:	e9 1f f6 ff ff       	jmp    801059da <alltraps>

801063bb <vector143>:
.globl vector143
vector143:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $143
801063bd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801063c2:	e9 13 f6 ff ff       	jmp    801059da <alltraps>

801063c7 <vector144>:
.globl vector144
vector144:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $144
801063c9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801063ce:	e9 07 f6 ff ff       	jmp    801059da <alltraps>

801063d3 <vector145>:
.globl vector145
vector145:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $145
801063d5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801063da:	e9 fb f5 ff ff       	jmp    801059da <alltraps>

801063df <vector146>:
.globl vector146
vector146:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $146
801063e1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801063e6:	e9 ef f5 ff ff       	jmp    801059da <alltraps>

801063eb <vector147>:
.globl vector147
vector147:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $147
801063ed:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801063f2:	e9 e3 f5 ff ff       	jmp    801059da <alltraps>

801063f7 <vector148>:
.globl vector148
vector148:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $148
801063f9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801063fe:	e9 d7 f5 ff ff       	jmp    801059da <alltraps>

80106403 <vector149>:
.globl vector149
vector149:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $149
80106405:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010640a:	e9 cb f5 ff ff       	jmp    801059da <alltraps>

8010640f <vector150>:
.globl vector150
vector150:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $150
80106411:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106416:	e9 bf f5 ff ff       	jmp    801059da <alltraps>

8010641b <vector151>:
.globl vector151
vector151:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $151
8010641d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106422:	e9 b3 f5 ff ff       	jmp    801059da <alltraps>

80106427 <vector152>:
.globl vector152
vector152:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $152
80106429:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010642e:	e9 a7 f5 ff ff       	jmp    801059da <alltraps>

80106433 <vector153>:
.globl vector153
vector153:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $153
80106435:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010643a:	e9 9b f5 ff ff       	jmp    801059da <alltraps>

8010643f <vector154>:
.globl vector154
vector154:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $154
80106441:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106446:	e9 8f f5 ff ff       	jmp    801059da <alltraps>

8010644b <vector155>:
.globl vector155
vector155:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $155
8010644d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106452:	e9 83 f5 ff ff       	jmp    801059da <alltraps>

80106457 <vector156>:
.globl vector156
vector156:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $156
80106459:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010645e:	e9 77 f5 ff ff       	jmp    801059da <alltraps>

80106463 <vector157>:
.globl vector157
vector157:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $157
80106465:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010646a:	e9 6b f5 ff ff       	jmp    801059da <alltraps>

8010646f <vector158>:
.globl vector158
vector158:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $158
80106471:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106476:	e9 5f f5 ff ff       	jmp    801059da <alltraps>

8010647b <vector159>:
.globl vector159
vector159:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $159
8010647d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106482:	e9 53 f5 ff ff       	jmp    801059da <alltraps>

80106487 <vector160>:
.globl vector160
vector160:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $160
80106489:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010648e:	e9 47 f5 ff ff       	jmp    801059da <alltraps>

80106493 <vector161>:
.globl vector161
vector161:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $161
80106495:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010649a:	e9 3b f5 ff ff       	jmp    801059da <alltraps>

8010649f <vector162>:
.globl vector162
vector162:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $162
801064a1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801064a6:	e9 2f f5 ff ff       	jmp    801059da <alltraps>

801064ab <vector163>:
.globl vector163
vector163:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $163
801064ad:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801064b2:	e9 23 f5 ff ff       	jmp    801059da <alltraps>

801064b7 <vector164>:
.globl vector164
vector164:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $164
801064b9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801064be:	e9 17 f5 ff ff       	jmp    801059da <alltraps>

801064c3 <vector165>:
.globl vector165
vector165:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $165
801064c5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801064ca:	e9 0b f5 ff ff       	jmp    801059da <alltraps>

801064cf <vector166>:
.globl vector166
vector166:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $166
801064d1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801064d6:	e9 ff f4 ff ff       	jmp    801059da <alltraps>

801064db <vector167>:
.globl vector167
vector167:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $167
801064dd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801064e2:	e9 f3 f4 ff ff       	jmp    801059da <alltraps>

801064e7 <vector168>:
.globl vector168
vector168:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $168
801064e9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801064ee:	e9 e7 f4 ff ff       	jmp    801059da <alltraps>

801064f3 <vector169>:
.globl vector169
vector169:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $169
801064f5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801064fa:	e9 db f4 ff ff       	jmp    801059da <alltraps>

801064ff <vector170>:
.globl vector170
vector170:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $170
80106501:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106506:	e9 cf f4 ff ff       	jmp    801059da <alltraps>

8010650b <vector171>:
.globl vector171
vector171:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $171
8010650d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106512:	e9 c3 f4 ff ff       	jmp    801059da <alltraps>

80106517 <vector172>:
.globl vector172
vector172:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $172
80106519:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010651e:	e9 b7 f4 ff ff       	jmp    801059da <alltraps>

80106523 <vector173>:
.globl vector173
vector173:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $173
80106525:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010652a:	e9 ab f4 ff ff       	jmp    801059da <alltraps>

8010652f <vector174>:
.globl vector174
vector174:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $174
80106531:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106536:	e9 9f f4 ff ff       	jmp    801059da <alltraps>

8010653b <vector175>:
.globl vector175
vector175:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $175
8010653d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106542:	e9 93 f4 ff ff       	jmp    801059da <alltraps>

80106547 <vector176>:
.globl vector176
vector176:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $176
80106549:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010654e:	e9 87 f4 ff ff       	jmp    801059da <alltraps>

80106553 <vector177>:
.globl vector177
vector177:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $177
80106555:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010655a:	e9 7b f4 ff ff       	jmp    801059da <alltraps>

8010655f <vector178>:
.globl vector178
vector178:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $178
80106561:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106566:	e9 6f f4 ff ff       	jmp    801059da <alltraps>

8010656b <vector179>:
.globl vector179
vector179:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $179
8010656d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106572:	e9 63 f4 ff ff       	jmp    801059da <alltraps>

80106577 <vector180>:
.globl vector180
vector180:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $180
80106579:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010657e:	e9 57 f4 ff ff       	jmp    801059da <alltraps>

80106583 <vector181>:
.globl vector181
vector181:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $181
80106585:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010658a:	e9 4b f4 ff ff       	jmp    801059da <alltraps>

8010658f <vector182>:
.globl vector182
vector182:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $182
80106591:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106596:	e9 3f f4 ff ff       	jmp    801059da <alltraps>

8010659b <vector183>:
.globl vector183
vector183:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $183
8010659d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801065a2:	e9 33 f4 ff ff       	jmp    801059da <alltraps>

801065a7 <vector184>:
.globl vector184
vector184:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $184
801065a9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801065ae:	e9 27 f4 ff ff       	jmp    801059da <alltraps>

801065b3 <vector185>:
.globl vector185
vector185:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $185
801065b5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801065ba:	e9 1b f4 ff ff       	jmp    801059da <alltraps>

801065bf <vector186>:
.globl vector186
vector186:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $186
801065c1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801065c6:	e9 0f f4 ff ff       	jmp    801059da <alltraps>

801065cb <vector187>:
.globl vector187
vector187:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $187
801065cd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801065d2:	e9 03 f4 ff ff       	jmp    801059da <alltraps>

801065d7 <vector188>:
.globl vector188
vector188:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $188
801065d9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801065de:	e9 f7 f3 ff ff       	jmp    801059da <alltraps>

801065e3 <vector189>:
.globl vector189
vector189:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $189
801065e5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801065ea:	e9 eb f3 ff ff       	jmp    801059da <alltraps>

801065ef <vector190>:
.globl vector190
vector190:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $190
801065f1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801065f6:	e9 df f3 ff ff       	jmp    801059da <alltraps>

801065fb <vector191>:
.globl vector191
vector191:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $191
801065fd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106602:	e9 d3 f3 ff ff       	jmp    801059da <alltraps>

80106607 <vector192>:
.globl vector192
vector192:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $192
80106609:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010660e:	e9 c7 f3 ff ff       	jmp    801059da <alltraps>

80106613 <vector193>:
.globl vector193
vector193:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $193
80106615:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010661a:	e9 bb f3 ff ff       	jmp    801059da <alltraps>

8010661f <vector194>:
.globl vector194
vector194:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $194
80106621:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106626:	e9 af f3 ff ff       	jmp    801059da <alltraps>

8010662b <vector195>:
.globl vector195
vector195:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $195
8010662d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106632:	e9 a3 f3 ff ff       	jmp    801059da <alltraps>

80106637 <vector196>:
.globl vector196
vector196:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $196
80106639:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010663e:	e9 97 f3 ff ff       	jmp    801059da <alltraps>

80106643 <vector197>:
.globl vector197
vector197:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $197
80106645:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010664a:	e9 8b f3 ff ff       	jmp    801059da <alltraps>

8010664f <vector198>:
.globl vector198
vector198:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $198
80106651:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106656:	e9 7f f3 ff ff       	jmp    801059da <alltraps>

8010665b <vector199>:
.globl vector199
vector199:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $199
8010665d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106662:	e9 73 f3 ff ff       	jmp    801059da <alltraps>

80106667 <vector200>:
.globl vector200
vector200:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $200
80106669:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010666e:	e9 67 f3 ff ff       	jmp    801059da <alltraps>

80106673 <vector201>:
.globl vector201
vector201:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $201
80106675:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010667a:	e9 5b f3 ff ff       	jmp    801059da <alltraps>

8010667f <vector202>:
.globl vector202
vector202:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $202
80106681:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106686:	e9 4f f3 ff ff       	jmp    801059da <alltraps>

8010668b <vector203>:
.globl vector203
vector203:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $203
8010668d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106692:	e9 43 f3 ff ff       	jmp    801059da <alltraps>

80106697 <vector204>:
.globl vector204
vector204:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $204
80106699:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010669e:	e9 37 f3 ff ff       	jmp    801059da <alltraps>

801066a3 <vector205>:
.globl vector205
vector205:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $205
801066a5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801066aa:	e9 2b f3 ff ff       	jmp    801059da <alltraps>

801066af <vector206>:
.globl vector206
vector206:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $206
801066b1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801066b6:	e9 1f f3 ff ff       	jmp    801059da <alltraps>

801066bb <vector207>:
.globl vector207
vector207:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $207
801066bd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801066c2:	e9 13 f3 ff ff       	jmp    801059da <alltraps>

801066c7 <vector208>:
.globl vector208
vector208:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $208
801066c9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801066ce:	e9 07 f3 ff ff       	jmp    801059da <alltraps>

801066d3 <vector209>:
.globl vector209
vector209:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $209
801066d5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801066da:	e9 fb f2 ff ff       	jmp    801059da <alltraps>

801066df <vector210>:
.globl vector210
vector210:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $210
801066e1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801066e6:	e9 ef f2 ff ff       	jmp    801059da <alltraps>

801066eb <vector211>:
.globl vector211
vector211:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $211
801066ed:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801066f2:	e9 e3 f2 ff ff       	jmp    801059da <alltraps>

801066f7 <vector212>:
.globl vector212
vector212:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $212
801066f9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801066fe:	e9 d7 f2 ff ff       	jmp    801059da <alltraps>

80106703 <vector213>:
.globl vector213
vector213:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $213
80106705:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010670a:	e9 cb f2 ff ff       	jmp    801059da <alltraps>

8010670f <vector214>:
.globl vector214
vector214:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $214
80106711:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106716:	e9 bf f2 ff ff       	jmp    801059da <alltraps>

8010671b <vector215>:
.globl vector215
vector215:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $215
8010671d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106722:	e9 b3 f2 ff ff       	jmp    801059da <alltraps>

80106727 <vector216>:
.globl vector216
vector216:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $216
80106729:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010672e:	e9 a7 f2 ff ff       	jmp    801059da <alltraps>

80106733 <vector217>:
.globl vector217
vector217:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $217
80106735:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010673a:	e9 9b f2 ff ff       	jmp    801059da <alltraps>

8010673f <vector218>:
.globl vector218
vector218:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $218
80106741:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106746:	e9 8f f2 ff ff       	jmp    801059da <alltraps>

8010674b <vector219>:
.globl vector219
vector219:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $219
8010674d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106752:	e9 83 f2 ff ff       	jmp    801059da <alltraps>

80106757 <vector220>:
.globl vector220
vector220:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $220
80106759:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010675e:	e9 77 f2 ff ff       	jmp    801059da <alltraps>

80106763 <vector221>:
.globl vector221
vector221:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $221
80106765:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010676a:	e9 6b f2 ff ff       	jmp    801059da <alltraps>

8010676f <vector222>:
.globl vector222
vector222:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $222
80106771:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106776:	e9 5f f2 ff ff       	jmp    801059da <alltraps>

8010677b <vector223>:
.globl vector223
vector223:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $223
8010677d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106782:	e9 53 f2 ff ff       	jmp    801059da <alltraps>

80106787 <vector224>:
.globl vector224
vector224:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $224
80106789:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010678e:	e9 47 f2 ff ff       	jmp    801059da <alltraps>

80106793 <vector225>:
.globl vector225
vector225:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $225
80106795:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010679a:	e9 3b f2 ff ff       	jmp    801059da <alltraps>

8010679f <vector226>:
.globl vector226
vector226:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $226
801067a1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801067a6:	e9 2f f2 ff ff       	jmp    801059da <alltraps>

801067ab <vector227>:
.globl vector227
vector227:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $227
801067ad:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801067b2:	e9 23 f2 ff ff       	jmp    801059da <alltraps>

801067b7 <vector228>:
.globl vector228
vector228:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $228
801067b9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801067be:	e9 17 f2 ff ff       	jmp    801059da <alltraps>

801067c3 <vector229>:
.globl vector229
vector229:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $229
801067c5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801067ca:	e9 0b f2 ff ff       	jmp    801059da <alltraps>

801067cf <vector230>:
.globl vector230
vector230:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $230
801067d1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801067d6:	e9 ff f1 ff ff       	jmp    801059da <alltraps>

801067db <vector231>:
.globl vector231
vector231:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $231
801067dd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801067e2:	e9 f3 f1 ff ff       	jmp    801059da <alltraps>

801067e7 <vector232>:
.globl vector232
vector232:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $232
801067e9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801067ee:	e9 e7 f1 ff ff       	jmp    801059da <alltraps>

801067f3 <vector233>:
.globl vector233
vector233:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $233
801067f5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801067fa:	e9 db f1 ff ff       	jmp    801059da <alltraps>

801067ff <vector234>:
.globl vector234
vector234:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $234
80106801:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106806:	e9 cf f1 ff ff       	jmp    801059da <alltraps>

8010680b <vector235>:
.globl vector235
vector235:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $235
8010680d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106812:	e9 c3 f1 ff ff       	jmp    801059da <alltraps>

80106817 <vector236>:
.globl vector236
vector236:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $236
80106819:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010681e:	e9 b7 f1 ff ff       	jmp    801059da <alltraps>

80106823 <vector237>:
.globl vector237
vector237:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $237
80106825:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010682a:	e9 ab f1 ff ff       	jmp    801059da <alltraps>

8010682f <vector238>:
.globl vector238
vector238:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $238
80106831:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106836:	e9 9f f1 ff ff       	jmp    801059da <alltraps>

8010683b <vector239>:
.globl vector239
vector239:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $239
8010683d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106842:	e9 93 f1 ff ff       	jmp    801059da <alltraps>

80106847 <vector240>:
.globl vector240
vector240:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $240
80106849:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010684e:	e9 87 f1 ff ff       	jmp    801059da <alltraps>

80106853 <vector241>:
.globl vector241
vector241:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $241
80106855:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010685a:	e9 7b f1 ff ff       	jmp    801059da <alltraps>

8010685f <vector242>:
.globl vector242
vector242:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $242
80106861:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106866:	e9 6f f1 ff ff       	jmp    801059da <alltraps>

8010686b <vector243>:
.globl vector243
vector243:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $243
8010686d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106872:	e9 63 f1 ff ff       	jmp    801059da <alltraps>

80106877 <vector244>:
.globl vector244
vector244:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $244
80106879:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010687e:	e9 57 f1 ff ff       	jmp    801059da <alltraps>

80106883 <vector245>:
.globl vector245
vector245:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $245
80106885:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010688a:	e9 4b f1 ff ff       	jmp    801059da <alltraps>

8010688f <vector246>:
.globl vector246
vector246:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $246
80106891:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106896:	e9 3f f1 ff ff       	jmp    801059da <alltraps>

8010689b <vector247>:
.globl vector247
vector247:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $247
8010689d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801068a2:	e9 33 f1 ff ff       	jmp    801059da <alltraps>

801068a7 <vector248>:
.globl vector248
vector248:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $248
801068a9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801068ae:	e9 27 f1 ff ff       	jmp    801059da <alltraps>

801068b3 <vector249>:
.globl vector249
vector249:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $249
801068b5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801068ba:	e9 1b f1 ff ff       	jmp    801059da <alltraps>

801068bf <vector250>:
.globl vector250
vector250:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $250
801068c1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801068c6:	e9 0f f1 ff ff       	jmp    801059da <alltraps>

801068cb <vector251>:
.globl vector251
vector251:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $251
801068cd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801068d2:	e9 03 f1 ff ff       	jmp    801059da <alltraps>

801068d7 <vector252>:
.globl vector252
vector252:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $252
801068d9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801068de:	e9 f7 f0 ff ff       	jmp    801059da <alltraps>

801068e3 <vector253>:
.globl vector253
vector253:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $253
801068e5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801068ea:	e9 eb f0 ff ff       	jmp    801059da <alltraps>

801068ef <vector254>:
.globl vector254
vector254:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $254
801068f1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801068f6:	e9 df f0 ff ff       	jmp    801059da <alltraps>

801068fb <vector255>:
.globl vector255
vector255:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $255
801068fd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106902:	e9 d3 f0 ff ff       	jmp    801059da <alltraps>
80106907:	66 90                	xchg   %ax,%ax
80106909:	66 90                	xchg   %ax,%ax
8010690b:	66 90                	xchg   %ax,%ax
8010690d:	66 90                	xchg   %ax,%ax
8010690f:	90                   	nop

80106910 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	57                   	push   %edi
80106914:	56                   	push   %esi
80106915:	53                   	push   %ebx
80106916:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106918:	c1 ea 16             	shr    $0x16,%edx
8010691b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010691e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106921:	8b 07                	mov    (%edi),%eax
80106923:	a8 01                	test   $0x1,%al
80106925:	74 29                	je     80106950 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106927:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010692c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106932:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106935:	c1 eb 0a             	shr    $0xa,%ebx
80106938:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010693e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106941:	5b                   	pop    %ebx
80106942:	5e                   	pop    %esi
80106943:	5f                   	pop    %edi
80106944:	5d                   	pop    %ebp
80106945:	c3                   	ret    
80106946:	8d 76 00             	lea    0x0(%esi),%esi
80106949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106950:	85 c9                	test   %ecx,%ecx
80106952:	74 2c                	je     80106980 <walkpgdir+0x70>
80106954:	e8 f7 be ff ff       	call   80102850 <kalloc>
80106959:	85 c0                	test   %eax,%eax
8010695b:	89 c6                	mov    %eax,%esi
8010695d:	74 21                	je     80106980 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010695f:	83 ec 04             	sub    $0x4,%esp
80106962:	68 00 10 00 00       	push   $0x1000
80106967:	6a 00                	push   $0x0
80106969:	50                   	push   %eax
8010696a:	e8 71 de ff ff       	call   801047e0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010696f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106975:	83 c4 10             	add    $0x10,%esp
80106978:	83 c8 07             	or     $0x7,%eax
8010697b:	89 07                	mov    %eax,(%edi)
8010697d:	eb b3                	jmp    80106932 <walkpgdir+0x22>
8010697f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106980:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106983:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106985:	5b                   	pop    %ebx
80106986:	5e                   	pop    %esi
80106987:	5f                   	pop    %edi
80106988:	5d                   	pop    %ebp
80106989:	c3                   	ret    
8010698a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106990 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	57                   	push   %edi
80106994:	56                   	push   %esi
80106995:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106996:	89 d3                	mov    %edx,%ebx
80106998:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010699e:	83 ec 1c             	sub    $0x1c,%esp
801069a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801069a4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801069a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801069ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801069b6:	29 df                	sub    %ebx,%edi
801069b8:	83 c8 01             	or     $0x1,%eax
801069bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801069be:	eb 15                	jmp    801069d5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801069c0:	f6 00 01             	testb  $0x1,(%eax)
801069c3:	75 45                	jne    80106a0a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801069c5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801069c8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069cb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801069cd:	74 31                	je     80106a00 <mappages+0x70>
      break;
    a += PGSIZE;
801069cf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801069d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069d8:	b9 01 00 00 00       	mov    $0x1,%ecx
801069dd:	89 da                	mov    %ebx,%edx
801069df:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801069e2:	e8 29 ff ff ff       	call   80106910 <walkpgdir>
801069e7:	85 c0                	test   %eax,%eax
801069e9:	75 d5                	jne    801069c0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801069eb:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801069ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801069f3:	5b                   	pop    %ebx
801069f4:	5e                   	pop    %esi
801069f5:	5f                   	pop    %edi
801069f6:	5d                   	pop    %ebp
801069f7:	c3                   	ret    
801069f8:	90                   	nop
801069f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a00:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106a03:	31 c0                	xor    %eax,%eax
}
80106a05:	5b                   	pop    %ebx
80106a06:	5e                   	pop    %esi
80106a07:	5f                   	pop    %edi
80106a08:	5d                   	pop    %ebp
80106a09:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106a0a:	83 ec 0c             	sub    $0xc,%esp
80106a0d:	68 68 7b 10 80       	push   $0x80107b68
80106a12:	e8 59 99 ff ff       	call   80100370 <panic>
80106a17:	89 f6                	mov    %esi,%esi
80106a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a20 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	57                   	push   %edi
80106a24:	56                   	push   %esi
80106a25:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a26:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a2c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a2e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a34:	83 ec 1c             	sub    $0x1c,%esp
80106a37:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a3a:	39 d3                	cmp    %edx,%ebx
80106a3c:	73 66                	jae    80106aa4 <deallocuvm.part.0+0x84>
80106a3e:	89 d6                	mov    %edx,%esi
80106a40:	eb 3d                	jmp    80106a7f <deallocuvm.part.0+0x5f>
80106a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a48:	8b 10                	mov    (%eax),%edx
80106a4a:	f6 c2 01             	test   $0x1,%dl
80106a4d:	74 26                	je     80106a75 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a4f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a55:	74 58                	je     80106aaf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106a57:	83 ec 0c             	sub    $0xc,%esp
80106a5a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106a60:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a63:	52                   	push   %edx
80106a64:	e8 37 bc ff ff       	call   801026a0 <kfree>
      *pte = 0;
80106a69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a6c:	83 c4 10             	add    $0x10,%esp
80106a6f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a75:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a7b:	39 f3                	cmp    %esi,%ebx
80106a7d:	73 25                	jae    80106aa4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a7f:	31 c9                	xor    %ecx,%ecx
80106a81:	89 da                	mov    %ebx,%edx
80106a83:	89 f8                	mov    %edi,%eax
80106a85:	e8 86 fe ff ff       	call   80106910 <walkpgdir>
    if(!pte)
80106a8a:	85 c0                	test   %eax,%eax
80106a8c:	75 ba                	jne    80106a48 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a8e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a94:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a9a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106aa0:	39 f3                	cmp    %esi,%ebx
80106aa2:	72 db                	jb     80106a7f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106aa4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106aa7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106aaa:	5b                   	pop    %ebx
80106aab:	5e                   	pop    %esi
80106aac:	5f                   	pop    %edi
80106aad:	5d                   	pop    %ebp
80106aae:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106aaf:	83 ec 0c             	sub    $0xc,%esp
80106ab2:	68 06 75 10 80       	push   $0x80107506
80106ab7:	e8 b4 98 ff ff       	call   80100370 <panic>
80106abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ac0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106ac0:	55                   	push   %ebp
80106ac1:	89 e5                	mov    %esp,%ebp
80106ac3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106ac6:	e8 55 d0 ff ff       	call   80103b20 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106acb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106ad1:	31 c9                	xor    %ecx,%ecx
80106ad3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106ad8:	66 89 90 f8 27 11 80 	mov    %dx,-0x7feed808(%eax)
80106adf:	66 89 88 fa 27 11 80 	mov    %cx,-0x7feed806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ae6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106aeb:	31 c9                	xor    %ecx,%ecx
80106aed:	66 89 90 00 28 11 80 	mov    %dx,-0x7feed800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106af4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106af9:	66 89 88 02 28 11 80 	mov    %cx,-0x7feed7fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b00:	31 c9                	xor    %ecx,%ecx
80106b02:	66 89 90 08 28 11 80 	mov    %dx,-0x7feed7f8(%eax)
80106b09:	66 89 88 0a 28 11 80 	mov    %cx,-0x7feed7f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b10:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106b15:	31 c9                	xor    %ecx,%ecx
80106b17:	66 89 90 10 28 11 80 	mov    %dx,-0x7feed7f0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b1e:	c6 80 fc 27 11 80 00 	movb   $0x0,-0x7feed804(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106b25:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106b2a:	c6 80 fd 27 11 80 9a 	movb   $0x9a,-0x7feed803(%eax)
80106b31:	c6 80 fe 27 11 80 cf 	movb   $0xcf,-0x7feed802(%eax)
80106b38:	c6 80 ff 27 11 80 00 	movb   $0x0,-0x7feed801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b3f:	c6 80 04 28 11 80 00 	movb   $0x0,-0x7feed7fc(%eax)
80106b46:	c6 80 05 28 11 80 92 	movb   $0x92,-0x7feed7fb(%eax)
80106b4d:	c6 80 06 28 11 80 cf 	movb   $0xcf,-0x7feed7fa(%eax)
80106b54:	c6 80 07 28 11 80 00 	movb   $0x0,-0x7feed7f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b5b:	c6 80 0c 28 11 80 00 	movb   $0x0,-0x7feed7f4(%eax)
80106b62:	c6 80 0d 28 11 80 fa 	movb   $0xfa,-0x7feed7f3(%eax)
80106b69:	c6 80 0e 28 11 80 cf 	movb   $0xcf,-0x7feed7f2(%eax)
80106b70:	c6 80 0f 28 11 80 00 	movb   $0x0,-0x7feed7f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b77:	66 89 88 12 28 11 80 	mov    %cx,-0x7feed7ee(%eax)
80106b7e:	c6 80 14 28 11 80 00 	movb   $0x0,-0x7feed7ec(%eax)
80106b85:	c6 80 15 28 11 80 f2 	movb   $0xf2,-0x7feed7eb(%eax)
80106b8c:	c6 80 16 28 11 80 cf 	movb   $0xcf,-0x7feed7ea(%eax)
80106b93:	c6 80 17 28 11 80 00 	movb   $0x0,-0x7feed7e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106b9a:	05 f0 27 11 80       	add    $0x801127f0,%eax
80106b9f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106ba3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ba7:	c1 e8 10             	shr    $0x10,%eax
80106baa:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106bae:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106bb1:	0f 01 10             	lgdtl  (%eax)
}
80106bb4:	c9                   	leave  
80106bb5:	c3                   	ret    
80106bb6:	8d 76 00             	lea    0x0(%esi),%esi
80106bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bc0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106bc0:	a1 a4 54 11 80       	mov    0x801154a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106bc5:	55                   	push   %ebp
80106bc6:	89 e5                	mov    %esp,%ebp
80106bc8:	05 00 00 00 80       	add    $0x80000000,%eax
80106bcd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106bd0:	5d                   	pop    %ebp
80106bd1:	c3                   	ret    
80106bd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106be0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106be0:	55                   	push   %ebp
80106be1:	89 e5                	mov    %esp,%ebp
80106be3:	57                   	push   %edi
80106be4:	56                   	push   %esi
80106be5:	53                   	push   %ebx
80106be6:	83 ec 1c             	sub    $0x1c,%esp
80106be9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106bec:	85 f6                	test   %esi,%esi
80106bee:	0f 84 cd 00 00 00    	je     80106cc1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106bf4:	8b 46 08             	mov    0x8(%esi),%eax
80106bf7:	85 c0                	test   %eax,%eax
80106bf9:	0f 84 dc 00 00 00    	je     80106cdb <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106bff:	8b 7e 04             	mov    0x4(%esi),%edi
80106c02:	85 ff                	test   %edi,%edi
80106c04:	0f 84 c4 00 00 00    	je     80106cce <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106c0a:	e8 f1 d9 ff ff       	call   80104600 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106c0f:	e8 8c ce ff ff       	call   80103aa0 <mycpu>
80106c14:	89 c3                	mov    %eax,%ebx
80106c16:	e8 85 ce ff ff       	call   80103aa0 <mycpu>
80106c1b:	89 c7                	mov    %eax,%edi
80106c1d:	e8 7e ce ff ff       	call   80103aa0 <mycpu>
80106c22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c25:	83 c7 08             	add    $0x8,%edi
80106c28:	e8 73 ce ff ff       	call   80103aa0 <mycpu>
80106c2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c30:	83 c0 08             	add    $0x8,%eax
80106c33:	ba 67 00 00 00       	mov    $0x67,%edx
80106c38:	c1 e8 18             	shr    $0x18,%eax
80106c3b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106c42:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106c49:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106c50:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106c57:	83 c1 08             	add    $0x8,%ecx
80106c5a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106c60:	c1 e9 10             	shr    $0x10,%ecx
80106c63:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c69:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106c6e:	e8 2d ce ff ff       	call   80103aa0 <mycpu>
80106c73:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c7a:	e8 21 ce ff ff       	call   80103aa0 <mycpu>
80106c7f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106c84:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c88:	e8 13 ce ff ff       	call   80103aa0 <mycpu>
80106c8d:	8b 56 08             	mov    0x8(%esi),%edx
80106c90:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106c96:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c99:	e8 02 ce ff ff       	call   80103aa0 <mycpu>
80106c9e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106ca2:	b8 28 00 00 00       	mov    $0x28,%eax
80106ca7:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106caa:	8b 46 04             	mov    0x4(%esi),%eax
80106cad:	05 00 00 00 80       	add    $0x80000000,%eax
80106cb2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106cb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cb8:	5b                   	pop    %ebx
80106cb9:	5e                   	pop    %esi
80106cba:	5f                   	pop    %edi
80106cbb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106cbc:	e9 7f d9 ff ff       	jmp    80104640 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106cc1:	83 ec 0c             	sub    $0xc,%esp
80106cc4:	68 6e 7b 10 80       	push   $0x80107b6e
80106cc9:	e8 a2 96 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106cce:	83 ec 0c             	sub    $0xc,%esp
80106cd1:	68 99 7b 10 80       	push   $0x80107b99
80106cd6:	e8 95 96 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106cdb:	83 ec 0c             	sub    $0xc,%esp
80106cde:	68 84 7b 10 80       	push   $0x80107b84
80106ce3:	e8 88 96 ff ff       	call   80100370 <panic>
80106ce8:	90                   	nop
80106ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106cf0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	57                   	push   %edi
80106cf4:	56                   	push   %esi
80106cf5:	53                   	push   %ebx
80106cf6:	83 ec 1c             	sub    $0x1c,%esp
80106cf9:	8b 75 10             	mov    0x10(%ebp),%esi
80106cfc:	8b 45 08             	mov    0x8(%ebp),%eax
80106cff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106d02:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106d08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106d0b:	77 49                	ja     80106d56 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106d0d:	e8 3e bb ff ff       	call   80102850 <kalloc>
  memset(mem, 0, PGSIZE);
80106d12:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106d15:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106d17:	68 00 10 00 00       	push   $0x1000
80106d1c:	6a 00                	push   $0x0
80106d1e:	50                   	push   %eax
80106d1f:	e8 bc da ff ff       	call   801047e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106d24:	58                   	pop    %eax
80106d25:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d2b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d30:	5a                   	pop    %edx
80106d31:	6a 06                	push   $0x6
80106d33:	50                   	push   %eax
80106d34:	31 d2                	xor    %edx,%edx
80106d36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d39:	e8 52 fc ff ff       	call   80106990 <mappages>
  memmove(mem, init, sz);
80106d3e:	89 75 10             	mov    %esi,0x10(%ebp)
80106d41:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106d44:	83 c4 10             	add    $0x10,%esp
80106d47:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106d4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d4d:	5b                   	pop    %ebx
80106d4e:	5e                   	pop    %esi
80106d4f:	5f                   	pop    %edi
80106d50:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106d51:	e9 3a db ff ff       	jmp    80104890 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106d56:	83 ec 0c             	sub    $0xc,%esp
80106d59:	68 ad 7b 10 80       	push   $0x80107bad
80106d5e:	e8 0d 96 ff ff       	call   80100370 <panic>
80106d63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d70 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106d79:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106d80:	0f 85 91 00 00 00    	jne    80106e17 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106d86:	8b 75 18             	mov    0x18(%ebp),%esi
80106d89:	31 db                	xor    %ebx,%ebx
80106d8b:	85 f6                	test   %esi,%esi
80106d8d:	75 1a                	jne    80106da9 <loaduvm+0x39>
80106d8f:	eb 6f                	jmp    80106e00 <loaduvm+0x90>
80106d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d98:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d9e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106da4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106da7:	76 57                	jbe    80106e00 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106da9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106dac:	8b 45 08             	mov    0x8(%ebp),%eax
80106daf:	31 c9                	xor    %ecx,%ecx
80106db1:	01 da                	add    %ebx,%edx
80106db3:	e8 58 fb ff ff       	call   80106910 <walkpgdir>
80106db8:	85 c0                	test   %eax,%eax
80106dba:	74 4e                	je     80106e0a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106dbc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106dbe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106dc1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106dc6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106dcb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106dd1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106dd4:	01 d9                	add    %ebx,%ecx
80106dd6:	05 00 00 00 80       	add    $0x80000000,%eax
80106ddb:	57                   	push   %edi
80106ddc:	51                   	push   %ecx
80106ddd:	50                   	push   %eax
80106dde:	ff 75 10             	pushl  0x10(%ebp)
80106de1:	e8 2a af ff ff       	call   80101d10 <readi>
80106de6:	83 c4 10             	add    $0x10,%esp
80106de9:	39 c7                	cmp    %eax,%edi
80106deb:	74 ab                	je     80106d98 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106ded:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106df5:	5b                   	pop    %ebx
80106df6:	5e                   	pop    %esi
80106df7:	5f                   	pop    %edi
80106df8:	5d                   	pop    %ebp
80106df9:	c3                   	ret    
80106dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e00:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106e03:	31 c0                	xor    %eax,%eax
}
80106e05:	5b                   	pop    %ebx
80106e06:	5e                   	pop    %esi
80106e07:	5f                   	pop    %edi
80106e08:	5d                   	pop    %ebp
80106e09:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106e0a:	83 ec 0c             	sub    $0xc,%esp
80106e0d:	68 c7 7b 10 80       	push   $0x80107bc7
80106e12:	e8 59 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106e17:	83 ec 0c             	sub    $0xc,%esp
80106e1a:	68 68 7c 10 80       	push   $0x80107c68
80106e1f:	e8 4c 95 ff ff       	call   80100370 <panic>
80106e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e30 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
80106e33:	57                   	push   %edi
80106e34:	56                   	push   %esi
80106e35:	53                   	push   %ebx
80106e36:	83 ec 0c             	sub    $0xc,%esp
80106e39:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106e3c:	85 ff                	test   %edi,%edi
80106e3e:	0f 88 ca 00 00 00    	js     80106f0e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106e44:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106e47:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106e4a:	0f 82 82 00 00 00    	jb     80106ed2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106e50:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106e56:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106e5c:	39 df                	cmp    %ebx,%edi
80106e5e:	77 43                	ja     80106ea3 <allocuvm+0x73>
80106e60:	e9 bb 00 00 00       	jmp    80106f20 <allocuvm+0xf0>
80106e65:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106e68:	83 ec 04             	sub    $0x4,%esp
80106e6b:	68 00 10 00 00       	push   $0x1000
80106e70:	6a 00                	push   $0x0
80106e72:	50                   	push   %eax
80106e73:	e8 68 d9 ff ff       	call   801047e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e78:	58                   	pop    %eax
80106e79:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e7f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e84:	5a                   	pop    %edx
80106e85:	6a 06                	push   $0x6
80106e87:	50                   	push   %eax
80106e88:	89 da                	mov    %ebx,%edx
80106e8a:	8b 45 08             	mov    0x8(%ebp),%eax
80106e8d:	e8 fe fa ff ff       	call   80106990 <mappages>
80106e92:	83 c4 10             	add    $0x10,%esp
80106e95:	85 c0                	test   %eax,%eax
80106e97:	78 47                	js     80106ee0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e99:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e9f:	39 df                	cmp    %ebx,%edi
80106ea1:	76 7d                	jbe    80106f20 <allocuvm+0xf0>
    mem = kalloc();
80106ea3:	e8 a8 b9 ff ff       	call   80102850 <kalloc>
    if(mem == 0){
80106ea8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106eaa:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106eac:	75 ba                	jne    80106e68 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106eae:	83 ec 0c             	sub    $0xc,%esp
80106eb1:	68 e5 7b 10 80       	push   $0x80107be5
80106eb6:	e8 a5 97 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106ebb:	83 c4 10             	add    $0x10,%esp
80106ebe:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ec1:	76 4b                	jbe    80106f0e <allocuvm+0xde>
80106ec3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ec6:	8b 45 08             	mov    0x8(%ebp),%eax
80106ec9:	89 fa                	mov    %edi,%edx
80106ecb:	e8 50 fb ff ff       	call   80106a20 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106ed0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106ed2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ed5:	5b                   	pop    %ebx
80106ed6:	5e                   	pop    %esi
80106ed7:	5f                   	pop    %edi
80106ed8:	5d                   	pop    %ebp
80106ed9:	c3                   	ret    
80106eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106ee0:	83 ec 0c             	sub    $0xc,%esp
80106ee3:	68 fd 7b 10 80       	push   $0x80107bfd
80106ee8:	e8 73 97 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106eed:	83 c4 10             	add    $0x10,%esp
80106ef0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ef3:	76 0d                	jbe    80106f02 <allocuvm+0xd2>
80106ef5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80106efb:	89 fa                	mov    %edi,%edx
80106efd:	e8 1e fb ff ff       	call   80106a20 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106f02:	83 ec 0c             	sub    $0xc,%esp
80106f05:	56                   	push   %esi
80106f06:	e8 95 b7 ff ff       	call   801026a0 <kfree>
      return 0;
80106f0b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106f0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106f11:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106f13:	5b                   	pop    %ebx
80106f14:	5e                   	pop    %esi
80106f15:	5f                   	pop    %edi
80106f16:	5d                   	pop    %ebp
80106f17:	c3                   	ret    
80106f18:	90                   	nop
80106f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f20:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106f23:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106f25:	5b                   	pop    %ebx
80106f26:	5e                   	pop    %esi
80106f27:	5f                   	pop    %edi
80106f28:	5d                   	pop    %ebp
80106f29:	c3                   	ret    
80106f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f30 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f36:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106f39:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106f3c:	39 d1                	cmp    %edx,%ecx
80106f3e:	73 10                	jae    80106f50 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106f40:	5d                   	pop    %ebp
80106f41:	e9 da fa ff ff       	jmp    80106a20 <deallocuvm.part.0>
80106f46:	8d 76 00             	lea    0x0(%esi),%esi
80106f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106f50:	89 d0                	mov    %edx,%eax
80106f52:	5d                   	pop    %ebp
80106f53:	c3                   	ret    
80106f54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f60 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	57                   	push   %edi
80106f64:	56                   	push   %esi
80106f65:	53                   	push   %ebx
80106f66:	83 ec 0c             	sub    $0xc,%esp
80106f69:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106f6c:	85 f6                	test   %esi,%esi
80106f6e:	74 59                	je     80106fc9 <freevm+0x69>
80106f70:	31 c9                	xor    %ecx,%ecx
80106f72:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f77:	89 f0                	mov    %esi,%eax
80106f79:	e8 a2 fa ff ff       	call   80106a20 <deallocuvm.part.0>
80106f7e:	89 f3                	mov    %esi,%ebx
80106f80:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f86:	eb 0f                	jmp    80106f97 <freevm+0x37>
80106f88:	90                   	nop
80106f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f90:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f93:	39 fb                	cmp    %edi,%ebx
80106f95:	74 23                	je     80106fba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f97:	8b 03                	mov    (%ebx),%eax
80106f99:	a8 01                	test   $0x1,%al
80106f9b:	74 f3                	je     80106f90 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106f9d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106fa2:	83 ec 0c             	sub    $0xc,%esp
80106fa5:	83 c3 04             	add    $0x4,%ebx
80106fa8:	05 00 00 00 80       	add    $0x80000000,%eax
80106fad:	50                   	push   %eax
80106fae:	e8 ed b6 ff ff       	call   801026a0 <kfree>
80106fb3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106fb6:	39 fb                	cmp    %edi,%ebx
80106fb8:	75 dd                	jne    80106f97 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106fba:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106fbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fc0:	5b                   	pop    %ebx
80106fc1:	5e                   	pop    %esi
80106fc2:	5f                   	pop    %edi
80106fc3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106fc4:	e9 d7 b6 ff ff       	jmp    801026a0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106fc9:	83 ec 0c             	sub    $0xc,%esp
80106fcc:	68 19 7c 10 80       	push   $0x80107c19
80106fd1:	e8 9a 93 ff ff       	call   80100370 <panic>
80106fd6:	8d 76 00             	lea    0x0(%esi),%esi
80106fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fe0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	56                   	push   %esi
80106fe4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106fe5:	e8 66 b8 ff ff       	call   80102850 <kalloc>
80106fea:	85 c0                	test   %eax,%eax
80106fec:	74 6a                	je     80107058 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106fee:	83 ec 04             	sub    $0x4,%esp
80106ff1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ff3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106ff8:	68 00 10 00 00       	push   $0x1000
80106ffd:	6a 00                	push   $0x0
80106fff:	50                   	push   %eax
80107000:	e8 db d7 ff ff       	call   801047e0 <memset>
80107005:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107008:	8b 43 04             	mov    0x4(%ebx),%eax
8010700b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010700e:	83 ec 08             	sub    $0x8,%esp
80107011:	8b 13                	mov    (%ebx),%edx
80107013:	ff 73 0c             	pushl  0xc(%ebx)
80107016:	50                   	push   %eax
80107017:	29 c1                	sub    %eax,%ecx
80107019:	89 f0                	mov    %esi,%eax
8010701b:	e8 70 f9 ff ff       	call   80106990 <mappages>
80107020:	83 c4 10             	add    $0x10,%esp
80107023:	85 c0                	test   %eax,%eax
80107025:	78 19                	js     80107040 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107027:	83 c3 10             	add    $0x10,%ebx
8010702a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107030:	75 d6                	jne    80107008 <setupkvm+0x28>
80107032:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107034:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107037:	5b                   	pop    %ebx
80107038:	5e                   	pop    %esi
80107039:	5d                   	pop    %ebp
8010703a:	c3                   	ret    
8010703b:	90                   	nop
8010703c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107040:	83 ec 0c             	sub    $0xc,%esp
80107043:	56                   	push   %esi
80107044:	e8 17 ff ff ff       	call   80106f60 <freevm>
      return 0;
80107049:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
8010704c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
8010704f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107051:	5b                   	pop    %ebx
80107052:	5e                   	pop    %esi
80107053:	5d                   	pop    %ebp
80107054:	c3                   	ret    
80107055:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107058:	31 c0                	xor    %eax,%eax
8010705a:	eb d8                	jmp    80107034 <setupkvm+0x54>
8010705c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107060 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107060:	55                   	push   %ebp
80107061:	89 e5                	mov    %esp,%ebp
80107063:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107066:	e8 75 ff ff ff       	call   80106fe0 <setupkvm>
8010706b:	a3 a4 54 11 80       	mov    %eax,0x801154a4
80107070:	05 00 00 00 80       	add    $0x80000000,%eax
80107075:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107078:	c9                   	leave  
80107079:	c3                   	ret    
8010707a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107080 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107080:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107081:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107083:	89 e5                	mov    %esp,%ebp
80107085:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107088:	8b 55 0c             	mov    0xc(%ebp),%edx
8010708b:	8b 45 08             	mov    0x8(%ebp),%eax
8010708e:	e8 7d f8 ff ff       	call   80106910 <walkpgdir>
  if(pte == 0)
80107093:	85 c0                	test   %eax,%eax
80107095:	74 05                	je     8010709c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107097:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010709a:	c9                   	leave  
8010709b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010709c:	83 ec 0c             	sub    $0xc,%esp
8010709f:	68 2a 7c 10 80       	push   $0x80107c2a
801070a4:	e8 c7 92 ff ff       	call   80100370 <panic>
801070a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801070b0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	57                   	push   %edi
801070b4:	56                   	push   %esi
801070b5:	53                   	push   %ebx
801070b6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801070b9:	e8 22 ff ff ff       	call   80106fe0 <setupkvm>
801070be:	85 c0                	test   %eax,%eax
801070c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801070c3:	0f 84 c5 00 00 00    	je     8010718e <copyuvm+0xde>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801070cc:	85 c9                	test   %ecx,%ecx
801070ce:	0f 84 9c 00 00 00    	je     80107170 <copyuvm+0xc0>
801070d4:	31 ff                	xor    %edi,%edi
801070d6:	eb 4a                	jmp    80107122 <copyuvm+0x72>
801070d8:	90                   	nop
801070d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801070e0:	83 ec 04             	sub    $0x4,%esp
801070e3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801070e9:	68 00 10 00 00       	push   $0x1000
801070ee:	53                   	push   %ebx
801070ef:	50                   	push   %eax
801070f0:	e8 9b d7 ff ff       	call   80104890 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801070f5:	58                   	pop    %eax
801070f6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801070fc:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107101:	5a                   	pop    %edx
80107102:	ff 75 e4             	pushl  -0x1c(%ebp)
80107105:	50                   	push   %eax
80107106:	89 fa                	mov    %edi,%edx
80107108:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010710b:	e8 80 f8 ff ff       	call   80106990 <mappages>
80107110:	83 c4 10             	add    $0x10,%esp
80107113:	85 c0                	test   %eax,%eax
80107115:	78 69                	js     80107180 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107117:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010711d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107120:	76 4e                	jbe    80107170 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107122:	8b 45 08             	mov    0x8(%ebp),%eax
80107125:	31 c9                	xor    %ecx,%ecx
80107127:	89 fa                	mov    %edi,%edx
80107129:	e8 e2 f7 ff ff       	call   80106910 <walkpgdir>
8010712e:	85 c0                	test   %eax,%eax
80107130:	74 6d                	je     8010719f <copyuvm+0xef>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107132:	8b 00                	mov    (%eax),%eax
80107134:	a8 01                	test   $0x1,%al
80107136:	74 5a                	je     80107192 <copyuvm+0xe2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107138:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010713a:	25 ff 0f 00 00       	and    $0xfff,%eax
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010713f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107145:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107148:	e8 03 b7 ff ff       	call   80102850 <kalloc>
8010714d:	85 c0                	test   %eax,%eax
8010714f:	89 c6                	mov    %eax,%esi
80107151:	75 8d                	jne    801070e0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107153:	83 ec 0c             	sub    $0xc,%esp
80107156:	ff 75 e0             	pushl  -0x20(%ebp)
80107159:	e8 02 fe ff ff       	call   80106f60 <freevm>
  return 0;
8010715e:	83 c4 10             	add    $0x10,%esp
80107161:	31 c0                	xor    %eax,%eax
}
80107163:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107166:	5b                   	pop    %ebx
80107167:	5e                   	pop    %esi
80107168:	5f                   	pop    %edi
80107169:	5d                   	pop    %ebp
8010716a:	c3                   	ret    
8010716b:	90                   	nop
8010716c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107170:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107173:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107176:	5b                   	pop    %ebx
80107177:	5e                   	pop    %esi
80107178:	5f                   	pop    %edi
80107179:	5d                   	pop    %ebp
8010717a:	c3                   	ret    
8010717b:	90                   	nop
8010717c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80107180:	83 ec 0c             	sub    $0xc,%esp
80107183:	56                   	push   %esi
80107184:	e8 17 b5 ff ff       	call   801026a0 <kfree>
      goto bad;
80107189:	83 c4 10             	add    $0x10,%esp
8010718c:	eb c5                	jmp    80107153 <copyuvm+0xa3>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010718e:	31 c0                	xor    %eax,%eax
80107190:	eb d1                	jmp    80107163 <copyuvm+0xb3>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107192:	83 ec 0c             	sub    $0xc,%esp
80107195:	68 4e 7c 10 80       	push   $0x80107c4e
8010719a:	e8 d1 91 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010719f:	83 ec 0c             	sub    $0xc,%esp
801071a2:	68 34 7c 10 80       	push   $0x80107c34
801071a7:	e8 c4 91 ff ff       	call   80100370 <panic>
801071ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801071b0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801071b0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801071b1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801071b3:	89 e5                	mov    %esp,%ebp
801071b5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801071b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801071bb:	8b 45 08             	mov    0x8(%ebp),%eax
801071be:	e8 4d f7 ff ff       	call   80106910 <walkpgdir>
  if((*pte & PTE_P) == 0)
801071c3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801071c5:	89 c2                	mov    %eax,%edx
801071c7:	83 e2 05             	and    $0x5,%edx
801071ca:	83 fa 05             	cmp    $0x5,%edx
801071cd:	75 11                	jne    801071e0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801071cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
801071d4:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801071d5:	05 00 00 00 80       	add    $0x80000000,%eax
}
801071da:	c3                   	ret    
801071db:	90                   	nop
801071dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801071e0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801071e2:	c9                   	leave  
801071e3:	c3                   	ret    
801071e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801071f0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	57                   	push   %edi
801071f4:	56                   	push   %esi
801071f5:	53                   	push   %ebx
801071f6:	83 ec 1c             	sub    $0x1c,%esp
801071f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801071fc:	8b 55 0c             	mov    0xc(%ebp),%edx
801071ff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107202:	85 db                	test   %ebx,%ebx
80107204:	75 40                	jne    80107246 <copyout+0x56>
80107206:	eb 70                	jmp    80107278 <copyout+0x88>
80107208:	90                   	nop
80107209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107210:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107213:	89 f1                	mov    %esi,%ecx
80107215:	29 d1                	sub    %edx,%ecx
80107217:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010721d:	39 d9                	cmp    %ebx,%ecx
8010721f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107222:	29 f2                	sub    %esi,%edx
80107224:	83 ec 04             	sub    $0x4,%esp
80107227:	01 d0                	add    %edx,%eax
80107229:	51                   	push   %ecx
8010722a:	57                   	push   %edi
8010722b:	50                   	push   %eax
8010722c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010722f:	e8 5c d6 ff ff       	call   80104890 <memmove>
    len -= n;
    buf += n;
80107234:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107237:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010723a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107240:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107242:	29 cb                	sub    %ecx,%ebx
80107244:	74 32                	je     80107278 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107246:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107248:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010724b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010724e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107254:	56                   	push   %esi
80107255:	ff 75 08             	pushl  0x8(%ebp)
80107258:	e8 53 ff ff ff       	call   801071b0 <uva2ka>
    if(pa0 == 0)
8010725d:	83 c4 10             	add    $0x10,%esp
80107260:	85 c0                	test   %eax,%eax
80107262:	75 ac                	jne    80107210 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107264:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107267:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010726c:	5b                   	pop    %ebx
8010726d:	5e                   	pop    %esi
8010726e:	5f                   	pop    %edi
8010726f:	5d                   	pop    %ebp
80107270:	c3                   	ret    
80107271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107278:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010727b:	31 c0                	xor    %eax,%eax
}
8010727d:	5b                   	pop    %ebx
8010727e:	5e                   	pop    %esi
8010727f:	5f                   	pop    %edi
80107280:	5d                   	pop    %ebp
80107281:	c3                   	ret    
