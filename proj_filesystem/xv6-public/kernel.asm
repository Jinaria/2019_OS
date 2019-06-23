
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 80 32 10 80       	mov    $0x80103280,%eax
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
8010004c:	68 20 73 10 80       	push   $0x80107320
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 85 45 00 00       	call   801045e0 <initlock>

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
80100092:	68 27 73 10 80       	push   $0x80107327
80100097:	50                   	push   %eax
80100098:	e8 13 44 00 00       	call   801044b0 <initsleeplock>
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
801000e4:	e8 57 46 00 00       	call   80104740 <acquire>

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
80100162:	e8 89 46 00 00       	call   801047f0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 7e 43 00 00       	call   801044f0 <acquiresleep>
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
80100193:	68 2e 73 10 80       	push   $0x8010732e
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
801001ae:	e8 dd 43 00 00       	call   80104590 <holdingsleep>
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
801001cc:	68 3f 73 10 80       	push   $0x8010733f
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
801001ef:	e8 9c 43 00 00       	call   80104590 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 4c 43 00 00       	call   80104550 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 30 45 00 00       	call   80104740 <acquire>
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
8010025c:	e9 8f 45 00 00       	jmp    801047f0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 46 73 10 80       	push   $0x80107346
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
8010028c:	e8 af 44 00 00       	call   80104740 <acquire>
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
801002bd:	e8 8e 3e 00 00       	call   80104150 <sleep>

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
801002d2:	e8 c9 38 00 00       	call   80103ba0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 a5 10 80       	push   $0x8010a520
801002e6:	e8 05 45 00 00       	call   801047f0 <release>
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
80100346:	e8 a5 44 00 00       	call   801047f0 <release>
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
80100392:	68 4d 73 10 80       	push   $0x8010734d
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 9f 7c 10 80 	movl   $0x80107c9f,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 43 42 00 00       	call   80104600 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 61 73 10 80       	push   $0x80107361
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
8010041a:	e8 b1 5a 00 00       	call   80105ed0 <uartputc>
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
801004d3:	e8 f8 59 00 00       	call   80105ed0 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 ec 59 00 00       	call   80105ed0 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 e0 59 00 00       	call   80105ed0 <uartputc>
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
80100514:	e8 d7 43 00 00       	call   801048f0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 12 43 00 00       	call   80104840 <memset>
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
80100540:	68 65 73 10 80       	push   $0x80107365
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
801005b1:	0f b6 92 90 73 10 80 	movzbl -0x7fef8c70(%edx),%edx
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
8010061b:	e8 20 41 00 00       	call   80104740 <acquire>
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
80100647:	e8 a4 41 00 00       	call   801047f0 <release>
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
8010070d:	e8 de 40 00 00       	call   801047f0 <release>
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
80100788:	b8 78 73 10 80       	mov    $0x80107378,%eax
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
801007c8:	e8 73 3f 00 00       	call   80104740 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 7f 73 10 80       	push   $0x8010737f
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
80100803:	e8 38 3f 00 00       	call   80104740 <acquire>
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
80100868:	e8 83 3f 00 00       	call   801047f0 <release>
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
801008f6:	e8 05 3a 00 00       	call   80104300 <wakeup>
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
80100977:	e9 74 3a 00 00       	jmp    801043f0 <procdump>
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
801009a6:	68 88 73 10 80       	push   $0x80107388
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 2b 3c 00 00       	call   801045e0 <initlock>

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
801009fc:	e8 9f 31 00 00       	call   80103ba0 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a07:	e8 a4 25 00 00       	call   80102fb0 <begin_op>

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
80100a4f:	e8 cc 25 00 00       	call   80103020 <end_op>
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
80100a74:	e8 e7 65 00 00       	call   80107060 <setupkvm>
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
80100b04:	e8 a7 63 00 00       	call   80106eb0 <allocuvm>
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
80100b3a:	e8 b1 62 00 00       	call   80106df0 <loaduvm>
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
80100b59:	e8 82 64 00 00       	call   80106fe0 <freevm>
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
80100b6f:	e8 ac 24 00 00       	call   80103020 <end_op>
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
80100b95:	e8 16 63 00 00       	call   80106eb0 <allocuvm>
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
80100bac:	e8 2f 64 00 00       	call   80106fe0 <freevm>
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
80100bbe:	e8 5d 24 00 00       	call   80103020 <end_op>
    cprintf("exec: fail\n");
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 a1 73 10 80       	push   $0x801073a1
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
80100bf1:	e8 0a 65 00 00       	call   80107100 <clearpteu>
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
80100c2d:	e8 4e 3e 00 00       	call   80104a80 <strlen>
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
80100c40:	e8 3b 3e 00 00       	call   80104a80 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 1a 66 00 00       	call   80107270 <copyout>
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
80100cbb:	e8 b0 65 00 00       	call   80107270 <copyout>
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
80100d00:	e8 3b 3d 00 00       	call   80104a40 <safestrcpy>

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
80100d2c:	e8 2f 5f 00 00       	call   80106c60 <switchuvm>
  freevm(oldpgdir);
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 a7 62 00 00       	call   80106fe0 <freevm>
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
80100d56:	68 ad 73 10 80       	push   $0x801073ad
80100d5b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d60:	e8 7b 38 00 00       	call   801045e0 <initlock>
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
80100d81:	e8 ba 39 00 00       	call   80104740 <acquire>
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
80100db1:	e8 3a 3a 00 00       	call   801047f0 <release>
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
80100dc8:	e8 23 3a 00 00       	call   801047f0 <release>
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
80100def:	e8 4c 39 00 00       	call   80104740 <acquire>
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
80100e0c:	e8 df 39 00 00       	call   801047f0 <release>
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
80100e1b:	68 b4 73 10 80       	push   $0x801073b4
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
80100e41:	e8 fa 38 00 00       	call   80104740 <acquire>
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
80100e6c:	e9 7f 39 00 00       	jmp    801047f0 <release>
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
80100e98:	e8 53 39 00 00       	call   801047f0 <release>

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
80100ec1:	e8 4a 28 00 00       	call   80103710 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ed0:	e8 db 20 00 00       	call   80102fb0 <begin_op>
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
80100eea:	e9 31 21 00 00       	jmp    80103020 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 bc 73 10 80       	push   $0x801073bc
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
80100fbd:	e9 ee 28 00 00       	jmp    801038b0 <piperead>
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
80100fd2:	68 c6 73 10 80       	push   $0x801073c6
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
80101039:	e8 e2 1f 00 00       	call   80103020 <end_op>
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
80101066:	e8 45 1f 00 00       	call   80102fb0 <begin_op>
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
8010109d:	e8 7e 1f 00 00       	call   80103020 <end_op>

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
801010dc:	e9 cf 26 00 00       	jmp    801037b0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010e1:	83 ec 0c             	sub    $0xc,%esp
801010e4:	68 cf 73 10 80       	push   $0x801073cf
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 d5 73 10 80       	push   $0x801073d5
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
801011a2:	68 df 73 10 80       	push   $0x801073df
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
801011bd:	e8 7e 1f 00 00       	call   80103140 <log_write>
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
801011e5:	e8 56 36 00 00       	call   80104840 <memset>
  log_write(bp);
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 4e 1f 00 00       	call   80103140 <log_write>
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
8010122a:	e8 11 35 00 00       	call   80104740 <acquire>
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
80101272:	e8 79 35 00 00       	call   801047f0 <release>
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
801012bf:	e8 2c 35 00 00       	call   801047f0 <release>

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
801012d4:	68 f5 73 10 80       	push   $0x801073f5
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
80101429:	e8 12 1d 00 00       	call   80103140 <log_write>
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
801014eb:	e8 50 1c 00 00       	call   80103140 <log_write>
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
80101516:	e8 25 1c 00 00       	call   80103140 <log_write>
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
8010154b:	e8 f0 1b 00 00       	call   80103140 <log_write>
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
80101575:	68 05 74 10 80       	push   $0x80107405
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
801015a1:	e8 4a 33 00 00       	call   801048f0 <memmove>
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
8010161c:	e8 1f 1b 00 00       	call   80103140 <log_write>
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
80101636:	68 18 74 10 80       	push   $0x80107418
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
8010164c:	68 2b 74 10 80       	push   $0x8010742b
80101651:	68 e0 09 11 80       	push   $0x801109e0
80101656:	e8 85 2f 00 00       	call   801045e0 <initlock>
8010165b:	83 c4 10             	add    $0x10,%esp
8010165e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101660:	83 ec 08             	sub    $0x8,%esp
80101663:	68 32 74 10 80       	push   $0x80107432
80101668:	53                   	push   %ebx
80101669:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010166f:	e8 3c 2e 00 00       	call   801044b0 <initsleeplock>
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
801016b9:	68 98 74 10 80       	push   $0x80107498
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
8010174e:	e8 ed 30 00 00       	call   80104840 <memset>
      dip->type = type;
80101753:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101757:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010175a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010175d:	89 3c 24             	mov    %edi,(%esp)
80101760:	e8 db 19 00 00       	call   80103140 <log_write>
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
80101783:	68 38 74 10 80       	push   $0x80107438
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
801017f1:	e8 fa 30 00 00       	call   801048f0 <memmove>
  log_write(bp);
801017f6:	89 34 24             	mov    %esi,(%esp)
801017f9:	e8 42 19 00 00       	call   80103140 <log_write>
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
8010181f:	e8 1c 2f 00 00       	call   80104740 <acquire>
  ip->ref++;
80101824:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101828:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010182f:	e8 bc 2f 00 00       	call   801047f0 <release>
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
80101862:	e8 89 2c 00 00       	call   801044f0 <acquiresleep>

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
801018d8:	e8 13 30 00 00       	call   801048f0 <memmove>
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
801018fd:	68 50 74 10 80       	push   $0x80107450
80101902:	e8 69 ea ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101907:	83 ec 0c             	sub    $0xc,%esp
8010190a:	68 4a 74 10 80       	push   $0x8010744a
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
80101933:	e8 58 2c 00 00       	call   80104590 <holdingsleep>
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
8010194f:	e9 fc 2b 00 00       	jmp    80104550 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101954:	83 ec 0c             	sub    $0xc,%esp
80101957:	68 5f 74 10 80       	push   $0x8010745f
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
80101983:	e8 68 2b 00 00       	call   801044f0 <acquiresleep>
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
8010199f:	e8 ac 2b 00 00       	call   80104550 <releasesleep>

  acquire(&icache.lock);
801019a4:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801019ab:	e8 90 2d 00 00       	call   80104740 <acquire>
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
801019c5:	e9 26 2e 00 00       	jmp    801047f0 <release>
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801019ca:	83 ec 0c             	sub    $0xc,%esp
801019cd:	68 e0 09 11 80       	push   $0x801109e0
801019d2:	e8 69 2d 00 00       	call   80104740 <acquire>
    int r = ip->ref;
801019d7:	8b 5f 08             	mov    0x8(%edi),%ebx
    release(&icache.lock);
801019da:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801019e1:	e8 0a 2e 00 00       	call   801047f0 <release>
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
80101db8:	e8 33 2b 00 00       	call   801048f0 <memmove>
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
80101eb4:	e8 37 2a 00 00       	call   801048f0 <memmove>
    log_write(bp);
80101eb9:	89 3c 24             	mov    %edi,(%esp)
80101ebc:	e8 7f 12 00 00       	call   80103140 <log_write>
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
80101f4e:	e8 1d 2a 00 00       	call   80104970 <strncmp>
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
80101fb5:	e8 b6 29 00 00       	call   80104970 <strncmp>
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
80101fed:	68 79 74 10 80       	push   $0x80107479
80101ff2:	e8 79 e3 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101ff7:	83 ec 0c             	sub    $0xc,%esp
80101ffa:	68 67 74 10 80       	push   $0x80107467
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
80102029:	e8 72 1b 00 00       	call   80103ba0 <myproc>
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
80102039:	e8 02 27 00 00       	call   80104740 <acquire>
  ip->ref++;
8010203e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102042:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80102049:	e8 a2 27 00 00       	call   801047f0 <release>
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
801020a5:	e8 46 28 00 00       	call   801048f0 <memmove>
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
80102134:	e8 b7 27 00 00       	call   801048f0 <memmove>
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
8010221d:	e8 be 27 00 00       	call   801049e0 <strncpy>
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
8010225b:	68 88 74 10 80       	push   $0x80107488
80102260:	e8 0b e1 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80102265:	83 ec 0c             	sub    $0xc,%esp
80102268:	68 86 7a 10 80       	push   $0x80107a86
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
80102370:	68 f4 74 10 80       	push   $0x801074f4
80102375:	e8 f6 df ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010237a:	83 ec 0c             	sub    $0xc,%esp
8010237d:	68 eb 74 10 80       	push   $0x801074eb
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
80102396:	68 06 75 10 80       	push   $0x80107506
8010239b:	68 80 a5 10 80       	push   $0x8010a580
801023a0:	e8 3b 22 00 00       	call   801045e0 <initlock>
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
8010241e:	e8 1d 23 00 00       	call   80104740 <acquire>

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
8010244e:	e8 ad 1e 00 00       	call   80104300 <wakeup>

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
8010246c:	e8 7f 23 00 00       	call   801047f0 <release>
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
801024be:	e8 cd 20 00 00       	call   80104590 <holdingsleep>
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
801024f8:	e8 43 22 00 00       	call   80104740 <acquire>

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
80102549:	e8 02 1c 00 00       	call   80104150 <sleep>
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
80102566:	e9 85 22 00 00       	jmp    801047f0 <release>

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
8010257e:	68 0a 75 10 80       	push   $0x8010750a
80102583:	e8 e8 dd ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102588:	83 ec 0c             	sub    $0xc,%esp
8010258b:	68 35 75 10 80       	push   $0x80107535
80102590:	e8 db dd ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102595:	83 ec 0c             	sub    $0xc,%esp
80102598:	68 20 75 10 80       	push   $0x80107520
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
801025fa:	68 54 75 10 80       	push   $0x80107554
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
801026d2:	e8 69 21 00 00       	call   80104840 <memset>

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
8010270b:	e9 e0 20 00 00       	jmp    801047f0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102710:	83 ec 0c             	sub    $0xc,%esp
80102713:	68 40 26 11 80       	push   $0x80112640
80102718:	e8 23 20 00 00       	call   80104740 <acquire>
8010271d:	83 c4 10             	add    $0x10,%esp
80102720:	eb c2                	jmp    801026e4 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102722:	83 ec 0c             	sub    $0xc,%esp
80102725:	68 86 75 10 80       	push   $0x80107586
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
8010278b:	68 8c 75 10 80       	push   $0x8010758c
80102790:	68 40 26 11 80       	push   $0x80112640
80102795:	e8 46 1e 00 00       	call   801045e0 <initlock>

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
8010287e:	e8 6d 1f 00 00       	call   801047f0 <release>
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
80102898:	e8 a3 1e 00 00       	call   80104740 <acquire>
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
801028f6:	0f b6 82 c0 76 10 80 	movzbl -0x7fef8940(%edx),%eax
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
8010291e:	0f b6 82 c0 76 10 80 	movzbl -0x7fef8940(%edx),%eax
80102925:	09 c1                	or     %eax,%ecx
80102927:	0f b6 82 c0 75 10 80 	movzbl -0x7fef8a40(%edx),%eax
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
8010293e:	8b 04 85 a0 75 10 80 	mov    -0x7fef8a60(,%eax,4),%eax
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
80102ca4:	e8 e7 1b 00 00       	call   80104890 <memcmp>
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
80102dd4:	e8 17 1b 00 00       	call   801048f0 <memmove>
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

80102e70 <write_log>:
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e70:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102e76:	85 c9                	test   %ecx,%ecx
80102e78:	0f 8e 85 00 00 00    	jle    80102f03 <write_log+0x93>
}

// Copy modified blocks from cache to log.
static void
write_log(void)
{
80102e7e:	55                   	push   %ebp
80102e7f:	89 e5                	mov    %esp,%ebp
80102e81:	57                   	push   %edi
80102e82:	56                   	push   %esi
80102e83:	53                   	push   %ebx
80102e84:	31 db                	xor    %ebx,%ebx
80102e86:	83 ec 0c             	sub    $0xc,%esp
80102e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e90:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102e95:	83 ec 08             	sub    $0x8,%esp
80102e98:	01 d8                	add    %ebx,%eax
80102e9a:	83 c0 01             	add    $0x1,%eax
80102e9d:	50                   	push   %eax
80102e9e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ea4:	e8 27 d2 ff ff       	call   801000d0 <bread>
80102ea9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102eab:	58                   	pop    %eax
80102eac:	5a                   	pop    %edx
80102ead:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102eb4:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102eba:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ebd:	e8 0e d2 ff ff       	call   801000d0 <bread>
80102ec2:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ec4:	8d 40 5c             	lea    0x5c(%eax),%eax
80102ec7:	83 c4 0c             	add    $0xc,%esp
80102eca:	68 00 02 00 00       	push   $0x200
80102ecf:	50                   	push   %eax
80102ed0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ed3:	50                   	push   %eax
80102ed4:	e8 17 1a 00 00       	call   801048f0 <memmove>
    bwrite(to);  // write the log
80102ed9:	89 34 24             	mov    %esi,(%esp)
80102edc:	e8 bf d2 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102ee1:	89 3c 24             	mov    %edi,(%esp)
80102ee4:	e8 f7 d2 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ee9:	89 34 24             	mov    %esi,(%esp)
80102eec:	e8 ef d2 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ef1:	83 c4 10             	add    $0x10,%esp
80102ef4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102efa:	7f 94                	jg     80102e90 <write_log+0x20>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from);
    brelse(to);
  }
}
80102efc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eff:	5b                   	pop    %ebx
80102f00:	5e                   	pop    %esi
80102f01:	5f                   	pop    %edi
80102f02:	5d                   	pop    %ebp
80102f03:	f3 c3                	repz ret 
80102f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f10 <initlog>:
static void recover_from_log(void);
void commit();

void
initlog(int dev)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 ec 2c             	sub    $0x2c,%esp
80102f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102f1a:	68 c0 77 10 80       	push   $0x801077c0
80102f1f:	68 80 26 11 80       	push   $0x80112680
80102f24:	e8 b7 16 00 00       	call   801045e0 <initlock>
  readsb(dev, &sb);
80102f29:	58                   	pop    %eax
80102f2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102f2d:	5a                   	pop    %edx
80102f2e:	50                   	push   %eax
80102f2f:	53                   	push   %ebx
80102f30:	e8 4b e6 ff ff       	call   80101580 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102f35:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102f38:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102f3b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102f3c:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102f42:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102f48:	a3 b4 26 11 80       	mov    %eax,0x801126b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102f4d:	5a                   	pop    %edx
80102f4e:	50                   	push   %eax
80102f4f:	53                   	push   %ebx
80102f50:	e8 7b d1 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102f55:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f58:	83 c4 10             	add    $0x10,%esp
80102f5b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102f5d:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102f63:	7e 1c                	jle    80102f81 <initlog+0x71>
80102f65:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102f6c:	31 d2                	xor    %edx,%edx
80102f6e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102f70:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102f74:	83 c2 04             	add    $0x4,%edx
80102f77:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102f7d:	39 da                	cmp    %ebx,%edx
80102f7f:	75 ef                	jne    80102f70 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102f81:	83 ec 0c             	sub    $0xc,%esp
80102f84:	50                   	push   %eax
80102f85:	e8 56 d2 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102f8a:	e8 e1 fd ff ff       	call   80102d70 <install_trans>
  log.lh.n = 0;
80102f8f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102f96:	00 00 00 
  write_head(); // clear the log
80102f99:	e8 72 fe ff ff       	call   80102e10 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102f9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fa1:	c9                   	leave  
80102fa2:	c3                   	ret    
80102fa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102fb0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102fb6:	68 80 26 11 80       	push   $0x80112680
80102fbb:	e8 80 17 00 00       	call   80104740 <acquire>
80102fc0:	83 c4 10             	add    $0x10,%esp
80102fc3:	eb 18                	jmp    80102fdd <begin_op+0x2d>
80102fc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102fc8:	83 ec 08             	sub    $0x8,%esp
80102fcb:	68 80 26 11 80       	push   $0x80112680
80102fd0:	68 80 26 11 80       	push   $0x80112680
80102fd5:	e8 76 11 00 00       	call   80104150 <sleep>
80102fda:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102fdd:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102fe2:	85 c0                	test   %eax,%eax
80102fe4:	75 e2                	jne    80102fc8 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102fe6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102feb:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102ff1:	83 c0 01             	add    $0x1,%eax
80102ff4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ff7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102ffa:	83 fa 1e             	cmp    $0x1e,%edx
80102ffd:	7f c9                	jg     80102fc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102fff:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80103002:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80103007:	68 80 26 11 80       	push   $0x80112680
8010300c:	e8 df 17 00 00       	call   801047f0 <release>
      break;
    }
  }
}
80103011:	83 c4 10             	add    $0x10,%esp
80103014:	c9                   	leave  
80103015:	c3                   	ret    
80103016:	8d 76 00             	lea    0x0(%esi),%esi
80103019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103020 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103020:	55                   	push   %ebp
80103021:	89 e5                	mov    %esp,%ebp
80103023:	83 ec 14             	sub    $0x14,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103026:	68 80 26 11 80       	push   $0x80112680
8010302b:	e8 10 17 00 00       	call   80104740 <acquire>
  log.outstanding -= 1;
80103030:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80103035:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
8010303b:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
8010303e:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80103041:	85 d2                	test   %edx,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80103043:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80103048:	0f 85 a0 00 00 00    	jne    801030ee <end_op+0xce>
    panic("log.committing");
  if(log.outstanding == 0){
8010304e:	85 c0                	test   %eax,%eax
80103050:	75 7e                	jne    801030d0 <end_op+0xb0>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103052:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80103055:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
8010305c:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010305f:	68 80 26 11 80       	push   $0x80112680
80103064:	e8 87 17 00 00       	call   801047f0 <release>
}

void
commit()
{
  if (log.lh.n > 0) {
80103069:	a1 c8 26 11 80       	mov    0x801126c8,%eax
8010306e:	83 c4 10             	add    $0x10,%esp
80103071:	85 c0                	test   %eax,%eax
80103073:	7e 1e                	jle    80103093 <end_op+0x73>
    write_log();     // Write modified blocks from cache to log
80103075:	e8 f6 fd ff ff       	call   80102e70 <write_log>
    write_head();    // Write header to disk -- the real commit
8010307a:	e8 91 fd ff ff       	call   80102e10 <write_head>
    install_trans(); // Now install writes to home locations
8010307f:	e8 ec fc ff ff       	call   80102d70 <install_trans>
    log.lh.n = 0;
80103084:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
8010308b:	00 00 00 
    write_head();    // Erase the transaction from the log
8010308e:	e8 7d fd ff ff       	call   80102e10 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80103093:	83 ec 0c             	sub    $0xc,%esp
80103096:	68 80 26 11 80       	push   $0x80112680
8010309b:	e8 a0 16 00 00       	call   80104740 <acquire>
    log.committing = 0;
    wakeup(&log);
801030a0:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
801030a7:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
801030ae:	00 00 00 
    wakeup(&log);
801030b1:	e8 4a 12 00 00       	call   80104300 <wakeup>
    release(&log.lock);
801030b6:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
801030bd:	e8 2e 17 00 00       	call   801047f0 <release>
801030c2:	83 c4 10             	add    $0x10,%esp
  }
}
801030c5:	c9                   	leave  
801030c6:	c3                   	ret    
801030c7:	89 f6                	mov    %esi,%esi
801030c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
801030d0:	83 ec 0c             	sub    $0xc,%esp
801030d3:	68 80 26 11 80       	push   $0x80112680
801030d8:	e8 23 12 00 00       	call   80104300 <wakeup>
  }
  release(&log.lock);
801030dd:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
801030e4:	e8 07 17 00 00       	call   801047f0 <release>
801030e9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
801030ec:	c9                   	leave  
801030ed:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
801030ee:	83 ec 0c             	sub    $0xc,%esp
801030f1:	68 c4 77 10 80       	push   $0x801077c4
801030f6:	e8 75 d2 ff ff       	call   80100370 <panic>
801030fb:	90                   	nop
801030fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103100 <commit>:
}

void
commit()
{
  if (log.lh.n > 0) {
80103100:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80103105:	85 c0                	test   %eax,%eax
80103107:	7e 27                	jle    80103130 <commit+0x30>
  }
}

void
commit()
{
80103109:	55                   	push   %ebp
8010310a:	89 e5                	mov    %esp,%ebp
8010310c:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
8010310f:	e8 5c fd ff ff       	call   80102e70 <write_log>
    write_head();    // Write header to disk -- the real commit
80103114:	e8 f7 fc ff ff       	call   80102e10 <write_head>
    install_trans(); // Now install writes to home locations
80103119:	e8 52 fc ff ff       	call   80102d70 <install_trans>
    log.lh.n = 0;
8010311e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80103125:	00 00 00 
    write_head();    // Erase the transaction from the log
  }
}
80103128:	c9                   	leave  
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    install_trans(); // Now install writes to home locations
    log.lh.n = 0;
    write_head();    // Erase the transaction from the log
80103129:	e9 e2 fc ff ff       	jmp    80102e10 <write_head>
8010312e:	66 90                	xchg   %ax,%ax
80103130:	f3 c3                	repz ret 
80103132:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103140 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103140:	55                   	push   %ebp
80103141:	89 e5                	mov    %esp,%ebp
80103143:	53                   	push   %ebx
80103144:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103147:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010314d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103150:	83 fa 1d             	cmp    $0x1d,%edx
80103153:	0f 8f 97 00 00 00    	jg     801031f0 <log_write+0xb0>
80103159:	a1 b8 26 11 80       	mov    0x801126b8,%eax
8010315e:	83 e8 01             	sub    $0x1,%eax
80103161:	39 c2                	cmp    %eax,%edx
80103163:	0f 8d 87 00 00 00    	jge    801031f0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103169:	a1 bc 26 11 80       	mov    0x801126bc,%eax
8010316e:	85 c0                	test   %eax,%eax
80103170:	0f 8e 87 00 00 00    	jle    801031fd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103176:	83 ec 0c             	sub    $0xc,%esp
80103179:	68 80 26 11 80       	push   $0x80112680
8010317e:	e8 bd 15 00 00       	call   80104740 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103183:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80103189:	83 c4 10             	add    $0x10,%esp
8010318c:	83 fa 00             	cmp    $0x0,%edx
8010318f:	7e 50                	jle    801031e1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103191:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103194:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103196:	3b 0d cc 26 11 80    	cmp    0x801126cc,%ecx
8010319c:	75 0b                	jne    801031a9 <log_write+0x69>
8010319e:	eb 38                	jmp    801031d8 <log_write+0x98>
801031a0:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
801031a7:	74 2f                	je     801031d8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
801031a9:	83 c0 01             	add    $0x1,%eax
801031ac:	39 d0                	cmp    %edx,%eax
801031ae:	75 f0                	jne    801031a0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801031b0:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
801031b7:	83 c2 01             	add    $0x1,%edx
801031ba:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
801031c0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
801031c3:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
801031ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031cd:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
801031ce:	e9 1d 16 00 00       	jmp    801047f0 <release>
801031d3:	90                   	nop
801031d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801031d8:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
801031df:	eb df                	jmp    801031c0 <log_write+0x80>
801031e1:	8b 43 08             	mov    0x8(%ebx),%eax
801031e4:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
801031e9:	75 d5                	jne    801031c0 <log_write+0x80>
801031eb:	eb ca                	jmp    801031b7 <log_write+0x77>
801031ed:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
801031f0:	83 ec 0c             	sub    $0xc,%esp
801031f3:	68 d3 77 10 80       	push   $0x801077d3
801031f8:	e8 73 d1 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
801031fd:	83 ec 0c             	sub    $0xc,%esp
80103200:	68 e9 77 10 80       	push   $0x801077e9
80103205:	e8 66 d1 ff ff       	call   80100370 <panic>
8010320a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103210 <log_num>:
  release(&log.lock);
}

int
log_num(void)
{
80103210:	55                   	push   %ebp
  return log.lh.n;
}
80103211:	a1 c8 26 11 80       	mov    0x801126c8,%eax
  release(&log.lock);
}

int
log_num(void)
{
80103216:	89 e5                	mov    %esp,%ebp
  return log.lh.n;
}
80103218:	5d                   	pop    %ebp
80103219:	c3                   	ret    
8010321a:	66 90                	xchg   %ax,%ax
8010321c:	66 90                	xchg   %ax,%ax
8010321e:	66 90                	xchg   %ax,%ax

80103220 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103220:	55                   	push   %ebp
80103221:	89 e5                	mov    %esp,%ebp
80103223:	53                   	push   %ebx
80103224:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103227:	e8 54 09 00 00       	call   80103b80 <cpuid>
8010322c:	89 c3                	mov    %eax,%ebx
8010322e:	e8 4d 09 00 00       	call   80103b80 <cpuid>
80103233:	83 ec 04             	sub    $0x4,%esp
80103236:	53                   	push   %ebx
80103237:	50                   	push   %eax
80103238:	68 04 78 10 80       	push   $0x80107804
8010323d:	e8 1e d4 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103242:	e8 d9 28 00 00       	call   80105b20 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103247:	e8 b4 08 00 00       	call   80103b00 <mycpu>
8010324c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010324e:	b8 01 00 00 00       	mov    $0x1,%eax
80103253:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010325a:	e8 01 0c 00 00       	call   80103e60 <scheduler>
8010325f:	90                   	nop

80103260 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103266:	e8 d5 39 00 00       	call   80106c40 <switchkvm>
  seginit();
8010326b:	e8 d0 38 00 00       	call   80106b40 <seginit>
  lapicinit();
80103270:	e8 3b f7 ff ff       	call   801029b0 <lapicinit>
  mpmain();
80103275:	e8 a6 ff ff ff       	call   80103220 <mpmain>
8010327a:	66 90                	xchg   %ax,%ax
8010327c:	66 90                	xchg   %ax,%ax
8010327e:	66 90                	xchg   %ax,%ax

80103280 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103280:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103284:	83 e4 f0             	and    $0xfffffff0,%esp
80103287:	ff 71 fc             	pushl  -0x4(%ecx)
8010328a:	55                   	push   %ebp
8010328b:	89 e5                	mov    %esp,%ebp
8010328d:	53                   	push   %ebx
8010328e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010328f:	bb 80 27 11 80       	mov    $0x80112780,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103294:	83 ec 08             	sub    $0x8,%esp
80103297:	68 00 00 40 80       	push   $0x80400000
8010329c:	68 a8 54 11 80       	push   $0x801154a8
801032a1:	e8 da f4 ff ff       	call   80102780 <kinit1>
  kvmalloc();      // kernel page table
801032a6:	e8 35 3e 00 00       	call   801070e0 <kvmalloc>
  mpinit();        // detect other processors
801032ab:	e8 70 01 00 00       	call   80103420 <mpinit>
  lapicinit();     // interrupt controller
801032b0:	e8 fb f6 ff ff       	call   801029b0 <lapicinit>
  seginit();       // segment descriptors
801032b5:	e8 86 38 00 00       	call   80106b40 <seginit>
  picinit();       // disable pic
801032ba:	e8 31 03 00 00       	call   801035f0 <picinit>
  ioapicinit();    // another interrupt controller
801032bf:	e8 ec f2 ff ff       	call   801025b0 <ioapicinit>
  consoleinit();   // console hardware
801032c4:	e8 d7 d6 ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
801032c9:	e8 42 2b 00 00       	call   80105e10 <uartinit>
  pinit();         // process table
801032ce:	e8 0d 08 00 00       	call   80103ae0 <pinit>
  tvinit();        // trap vectors
801032d3:	e8 a8 27 00 00       	call   80105a80 <tvinit>
  binit();         // buffer cache
801032d8:	e8 63 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
801032dd:	e8 6e da ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
801032e2:	e8 a9 f0 ff ff       	call   80102390 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801032e7:	83 c4 0c             	add    $0xc,%esp
801032ea:	68 8a 00 00 00       	push   $0x8a
801032ef:	68 8c a4 10 80       	push   $0x8010a48c
801032f4:	68 00 70 00 80       	push   $0x80007000
801032f9:	e8 f2 15 00 00       	call   801048f0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801032fe:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103305:	00 00 00 
80103308:	83 c4 10             	add    $0x10,%esp
8010330b:	05 80 27 11 80       	add    $0x80112780,%eax
80103310:	39 d8                	cmp    %ebx,%eax
80103312:	76 6f                	jbe    80103383 <main+0x103>
80103314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80103318:	e8 e3 07 00 00       	call   80103b00 <mycpu>
8010331d:	39 d8                	cmp    %ebx,%eax
8010331f:	74 49                	je     8010336a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103321:	e8 2a f5 ff ff       	call   80102850 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103326:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
8010332b:	c7 05 f8 6f 00 80 60 	movl   $0x80103260,0x80006ff8
80103332:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103335:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010333c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010333f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103344:	0f b6 03             	movzbl (%ebx),%eax
80103347:	83 ec 08             	sub    $0x8,%esp
8010334a:	68 00 70 00 00       	push   $0x7000
8010334f:	50                   	push   %eax
80103350:	e8 ab f7 ff ff       	call   80102b00 <lapicstartap>
80103355:	83 c4 10             	add    $0x10,%esp
80103358:	90                   	nop
80103359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103360:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103366:	85 c0                	test   %eax,%eax
80103368:	74 f6                	je     80103360 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010336a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103371:	00 00 00 
80103374:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010337a:	05 80 27 11 80       	add    $0x80112780,%eax
8010337f:	39 c3                	cmp    %eax,%ebx
80103381:	72 95                	jb     80103318 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103383:	83 ec 08             	sub    $0x8,%esp
80103386:	68 00 00 00 8e       	push   $0x8e000000
8010338b:	68 00 00 40 80       	push   $0x80400000
80103390:	e8 5b f4 ff ff       	call   801027f0 <kinit2>
  userinit();      // first user process
80103395:	e8 36 08 00 00       	call   80103bd0 <userinit>
  mpmain();        // finish this processor's setup
8010339a:	e8 81 fe ff ff       	call   80103220 <mpmain>
8010339f:	90                   	nop

801033a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801033a0:	55                   	push   %ebp
801033a1:	89 e5                	mov    %esp,%ebp
801033a3:	57                   	push   %edi
801033a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801033a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801033ab:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
801033ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801033af:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801033b2:	39 de                	cmp    %ebx,%esi
801033b4:	73 48                	jae    801033fe <mpsearch1+0x5e>
801033b6:	8d 76 00             	lea    0x0(%esi),%esi
801033b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033c0:	83 ec 04             	sub    $0x4,%esp
801033c3:	8d 7e 10             	lea    0x10(%esi),%edi
801033c6:	6a 04                	push   $0x4
801033c8:	68 18 78 10 80       	push   $0x80107818
801033cd:	56                   	push   %esi
801033ce:	e8 bd 14 00 00       	call   80104890 <memcmp>
801033d3:	83 c4 10             	add    $0x10,%esp
801033d6:	85 c0                	test   %eax,%eax
801033d8:	75 1e                	jne    801033f8 <mpsearch1+0x58>
801033da:	8d 7e 10             	lea    0x10(%esi),%edi
801033dd:	89 f2                	mov    %esi,%edx
801033df:	31 c9                	xor    %ecx,%ecx
801033e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801033e8:	0f b6 02             	movzbl (%edx),%eax
801033eb:	83 c2 01             	add    $0x1,%edx
801033ee:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801033f0:	39 fa                	cmp    %edi,%edx
801033f2:	75 f4                	jne    801033e8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033f4:	84 c9                	test   %cl,%cl
801033f6:	74 10                	je     80103408 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801033f8:	39 fb                	cmp    %edi,%ebx
801033fa:	89 fe                	mov    %edi,%esi
801033fc:	77 c2                	ja     801033c0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801033fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103401:	31 c0                	xor    %eax,%eax
}
80103403:	5b                   	pop    %ebx
80103404:	5e                   	pop    %esi
80103405:	5f                   	pop    %edi
80103406:	5d                   	pop    %ebp
80103407:	c3                   	ret    
80103408:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010340b:	89 f0                	mov    %esi,%eax
8010340d:	5b                   	pop    %ebx
8010340e:	5e                   	pop    %esi
8010340f:	5f                   	pop    %edi
80103410:	5d                   	pop    %ebp
80103411:	c3                   	ret    
80103412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103420 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	57                   	push   %edi
80103424:	56                   	push   %esi
80103425:	53                   	push   %ebx
80103426:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103429:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103430:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103437:	c1 e0 08             	shl    $0x8,%eax
8010343a:	09 d0                	or     %edx,%eax
8010343c:	c1 e0 04             	shl    $0x4,%eax
8010343f:	85 c0                	test   %eax,%eax
80103441:	75 1b                	jne    8010345e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103443:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010344a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103451:	c1 e0 08             	shl    $0x8,%eax
80103454:	09 d0                	or     %edx,%eax
80103456:	c1 e0 0a             	shl    $0xa,%eax
80103459:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010345e:	ba 00 04 00 00       	mov    $0x400,%edx
80103463:	e8 38 ff ff ff       	call   801033a0 <mpsearch1>
80103468:	85 c0                	test   %eax,%eax
8010346a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010346d:	0f 84 37 01 00 00    	je     801035aa <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103473:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103476:	8b 58 04             	mov    0x4(%eax),%ebx
80103479:	85 db                	test   %ebx,%ebx
8010347b:	0f 84 43 01 00 00    	je     801035c4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103481:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103487:	83 ec 04             	sub    $0x4,%esp
8010348a:	6a 04                	push   $0x4
8010348c:	68 1d 78 10 80       	push   $0x8010781d
80103491:	56                   	push   %esi
80103492:	e8 f9 13 00 00       	call   80104890 <memcmp>
80103497:	83 c4 10             	add    $0x10,%esp
8010349a:	85 c0                	test   %eax,%eax
8010349c:	0f 85 22 01 00 00    	jne    801035c4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801034a2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801034a9:	3c 01                	cmp    $0x1,%al
801034ab:	74 08                	je     801034b5 <mpinit+0x95>
801034ad:	3c 04                	cmp    $0x4,%al
801034af:	0f 85 0f 01 00 00    	jne    801035c4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801034b5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801034bc:	85 ff                	test   %edi,%edi
801034be:	74 21                	je     801034e1 <mpinit+0xc1>
801034c0:	31 d2                	xor    %edx,%edx
801034c2:	31 c0                	xor    %eax,%eax
801034c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801034c8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801034cf:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801034d0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801034d3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801034d5:	39 c7                	cmp    %eax,%edi
801034d7:	75 ef                	jne    801034c8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801034d9:	84 d2                	test   %dl,%dl
801034db:	0f 85 e3 00 00 00    	jne    801035c4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801034e1:	85 f6                	test   %esi,%esi
801034e3:	0f 84 db 00 00 00    	je     801035c4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801034e9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801034ef:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034f4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801034fb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103501:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103506:	01 d6                	add    %edx,%esi
80103508:	90                   	nop
80103509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103510:	39 c6                	cmp    %eax,%esi
80103512:	76 23                	jbe    80103537 <mpinit+0x117>
80103514:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103517:	80 fa 04             	cmp    $0x4,%dl
8010351a:	0f 87 c0 00 00 00    	ja     801035e0 <mpinit+0x1c0>
80103520:	ff 24 95 5c 78 10 80 	jmp    *-0x7fef87a4(,%edx,4)
80103527:	89 f6                	mov    %esi,%esi
80103529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103530:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103533:	39 c6                	cmp    %eax,%esi
80103535:	77 dd                	ja     80103514 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103537:	85 db                	test   %ebx,%ebx
80103539:	0f 84 92 00 00 00    	je     801035d1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010353f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103542:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103546:	74 15                	je     8010355d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103548:	ba 22 00 00 00       	mov    $0x22,%edx
8010354d:	b8 70 00 00 00       	mov    $0x70,%eax
80103552:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103553:	ba 23 00 00 00       	mov    $0x23,%edx
80103558:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103559:	83 c8 01             	or     $0x1,%eax
8010355c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010355d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103560:	5b                   	pop    %ebx
80103561:	5e                   	pop    %esi
80103562:	5f                   	pop    %edi
80103563:	5d                   	pop    %ebp
80103564:	c3                   	ret    
80103565:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103568:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010356e:	83 f9 07             	cmp    $0x7,%ecx
80103571:	7f 19                	jg     8010358c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103573:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103577:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010357d:	83 c1 01             	add    $0x1,%ecx
80103580:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103586:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010358c:	83 c0 14             	add    $0x14,%eax
      continue;
8010358f:	e9 7c ff ff ff       	jmp    80103510 <mpinit+0xf0>
80103594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103598:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010359c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010359f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      p += sizeof(struct mpioapic);
      continue;
801035a5:	e9 66 ff ff ff       	jmp    80103510 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801035aa:	ba 00 00 01 00       	mov    $0x10000,%edx
801035af:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801035b4:	e8 e7 fd ff ff       	call   801033a0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035b9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801035bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035be:	0f 85 af fe ff ff    	jne    80103473 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801035c4:	83 ec 0c             	sub    $0xc,%esp
801035c7:	68 22 78 10 80       	push   $0x80107822
801035cc:	e8 9f cd ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801035d1:	83 ec 0c             	sub    $0xc,%esp
801035d4:	68 3c 78 10 80       	push   $0x8010783c
801035d9:	e8 92 cd ff ff       	call   80100370 <panic>
801035de:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801035e0:	31 db                	xor    %ebx,%ebx
801035e2:	e9 30 ff ff ff       	jmp    80103517 <mpinit+0xf7>
801035e7:	66 90                	xchg   %ax,%ax
801035e9:	66 90                	xchg   %ax,%ax
801035eb:	66 90                	xchg   %ax,%ax
801035ed:	66 90                	xchg   %ax,%ax
801035ef:	90                   	nop

801035f0 <picinit>:
801035f0:	55                   	push   %ebp
801035f1:	ba 21 00 00 00       	mov    $0x21,%edx
801035f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035fb:	89 e5                	mov    %esp,%ebp
801035fd:	ee                   	out    %al,(%dx)
801035fe:	ba a1 00 00 00       	mov    $0xa1,%edx
80103603:	ee                   	out    %al,(%dx)
80103604:	5d                   	pop    %ebp
80103605:	c3                   	ret    
80103606:	66 90                	xchg   %ax,%ax
80103608:	66 90                	xchg   %ax,%ax
8010360a:	66 90                	xchg   %ax,%ax
8010360c:	66 90                	xchg   %ax,%ax
8010360e:	66 90                	xchg   %ax,%ax

80103610 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	57                   	push   %edi
80103614:	56                   	push   %esi
80103615:	53                   	push   %ebx
80103616:	83 ec 0c             	sub    $0xc,%esp
80103619:	8b 75 08             	mov    0x8(%ebp),%esi
8010361c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010361f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103625:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010362b:	e8 40 d7 ff ff       	call   80100d70 <filealloc>
80103630:	85 c0                	test   %eax,%eax
80103632:	89 06                	mov    %eax,(%esi)
80103634:	0f 84 a8 00 00 00    	je     801036e2 <pipealloc+0xd2>
8010363a:	e8 31 d7 ff ff       	call   80100d70 <filealloc>
8010363f:	85 c0                	test   %eax,%eax
80103641:	89 03                	mov    %eax,(%ebx)
80103643:	0f 84 87 00 00 00    	je     801036d0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103649:	e8 02 f2 ff ff       	call   80102850 <kalloc>
8010364e:	85 c0                	test   %eax,%eax
80103650:	89 c7                	mov    %eax,%edi
80103652:	0f 84 b0 00 00 00    	je     80103708 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103658:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010365b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103662:	00 00 00 
  p->writeopen = 1;
80103665:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010366c:	00 00 00 
  p->nwrite = 0;
8010366f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103676:	00 00 00 
  p->nread = 0;
80103679:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103680:	00 00 00 
  initlock(&p->lock, "pipe");
80103683:	68 70 78 10 80       	push   $0x80107870
80103688:	50                   	push   %eax
80103689:	e8 52 0f 00 00       	call   801045e0 <initlock>
  (*f0)->type = FD_PIPE;
8010368e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103690:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103693:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103699:	8b 06                	mov    (%esi),%eax
8010369b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010369f:	8b 06                	mov    (%esi),%eax
801036a1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801036a5:	8b 06                	mov    (%esi),%eax
801036a7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801036aa:	8b 03                	mov    (%ebx),%eax
801036ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801036b2:	8b 03                	mov    (%ebx),%eax
801036b4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801036b8:	8b 03                	mov    (%ebx),%eax
801036ba:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801036be:	8b 03                	mov    (%ebx),%eax
801036c0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801036c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801036c6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801036c8:	5b                   	pop    %ebx
801036c9:	5e                   	pop    %esi
801036ca:	5f                   	pop    %edi
801036cb:	5d                   	pop    %ebp
801036cc:	c3                   	ret    
801036cd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801036d0:	8b 06                	mov    (%esi),%eax
801036d2:	85 c0                	test   %eax,%eax
801036d4:	74 1e                	je     801036f4 <pipealloc+0xe4>
    fileclose(*f0);
801036d6:	83 ec 0c             	sub    $0xc,%esp
801036d9:	50                   	push   %eax
801036da:	e8 51 d7 ff ff       	call   80100e30 <fileclose>
801036df:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801036e2:	8b 03                	mov    (%ebx),%eax
801036e4:	85 c0                	test   %eax,%eax
801036e6:	74 0c                	je     801036f4 <pipealloc+0xe4>
    fileclose(*f1);
801036e8:	83 ec 0c             	sub    $0xc,%esp
801036eb:	50                   	push   %eax
801036ec:	e8 3f d7 ff ff       	call   80100e30 <fileclose>
801036f1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801036f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801036f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801036fc:	5b                   	pop    %ebx
801036fd:	5e                   	pop    %esi
801036fe:	5f                   	pop    %edi
801036ff:	5d                   	pop    %ebp
80103700:	c3                   	ret    
80103701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103708:	8b 06                	mov    (%esi),%eax
8010370a:	85 c0                	test   %eax,%eax
8010370c:	75 c8                	jne    801036d6 <pipealloc+0xc6>
8010370e:	eb d2                	jmp    801036e2 <pipealloc+0xd2>

80103710 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103710:	55                   	push   %ebp
80103711:	89 e5                	mov    %esp,%ebp
80103713:	56                   	push   %esi
80103714:	53                   	push   %ebx
80103715:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103718:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010371b:	83 ec 0c             	sub    $0xc,%esp
8010371e:	53                   	push   %ebx
8010371f:	e8 1c 10 00 00       	call   80104740 <acquire>
  if(writable){
80103724:	83 c4 10             	add    $0x10,%esp
80103727:	85 f6                	test   %esi,%esi
80103729:	74 45                	je     80103770 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010372b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103731:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103734:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010373b:	00 00 00 
    wakeup(&p->nread);
8010373e:	50                   	push   %eax
8010373f:	e8 bc 0b 00 00       	call   80104300 <wakeup>
80103744:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103747:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010374d:	85 d2                	test   %edx,%edx
8010374f:	75 0a                	jne    8010375b <pipeclose+0x4b>
80103751:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103757:	85 c0                	test   %eax,%eax
80103759:	74 35                	je     80103790 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010375b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010375e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103761:	5b                   	pop    %ebx
80103762:	5e                   	pop    %esi
80103763:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103764:	e9 87 10 00 00       	jmp    801047f0 <release>
80103769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103770:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103776:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103779:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103780:	00 00 00 
    wakeup(&p->nwrite);
80103783:	50                   	push   %eax
80103784:	e8 77 0b 00 00       	call   80104300 <wakeup>
80103789:	83 c4 10             	add    $0x10,%esp
8010378c:	eb b9                	jmp    80103747 <pipeclose+0x37>
8010378e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103790:	83 ec 0c             	sub    $0xc,%esp
80103793:	53                   	push   %ebx
80103794:	e8 57 10 00 00       	call   801047f0 <release>
    kfree((char*)p);
80103799:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010379c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010379f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037a2:	5b                   	pop    %ebx
801037a3:	5e                   	pop    %esi
801037a4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801037a5:	e9 f6 ee ff ff       	jmp    801026a0 <kfree>
801037aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037b0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	57                   	push   %edi
801037b4:	56                   	push   %esi
801037b5:	53                   	push   %ebx
801037b6:	83 ec 28             	sub    $0x28,%esp
801037b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801037bc:	53                   	push   %ebx
801037bd:	e8 7e 0f 00 00       	call   80104740 <acquire>
  for(i = 0; i < n; i++){
801037c2:	8b 45 10             	mov    0x10(%ebp),%eax
801037c5:	83 c4 10             	add    $0x10,%esp
801037c8:	85 c0                	test   %eax,%eax
801037ca:	0f 8e b9 00 00 00    	jle    80103889 <pipewrite+0xd9>
801037d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801037d3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801037d9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037df:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801037e5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801037e8:	03 4d 10             	add    0x10(%ebp),%ecx
801037eb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037ee:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801037f4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801037fa:	39 d0                	cmp    %edx,%eax
801037fc:	74 38                	je     80103836 <pipewrite+0x86>
801037fe:	eb 59                	jmp    80103859 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
80103800:	e8 9b 03 00 00       	call   80103ba0 <myproc>
80103805:	8b 48 24             	mov    0x24(%eax),%ecx
80103808:	85 c9                	test   %ecx,%ecx
8010380a:	75 34                	jne    80103840 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010380c:	83 ec 0c             	sub    $0xc,%esp
8010380f:	57                   	push   %edi
80103810:	e8 eb 0a 00 00       	call   80104300 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103815:	58                   	pop    %eax
80103816:	5a                   	pop    %edx
80103817:	53                   	push   %ebx
80103818:	56                   	push   %esi
80103819:	e8 32 09 00 00       	call   80104150 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010381e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103824:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010382a:	83 c4 10             	add    $0x10,%esp
8010382d:	05 00 02 00 00       	add    $0x200,%eax
80103832:	39 c2                	cmp    %eax,%edx
80103834:	75 2a                	jne    80103860 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103836:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010383c:	85 c0                	test   %eax,%eax
8010383e:	75 c0                	jne    80103800 <pipewrite+0x50>
        release(&p->lock);
80103840:	83 ec 0c             	sub    $0xc,%esp
80103843:	53                   	push   %ebx
80103844:	e8 a7 0f 00 00       	call   801047f0 <release>
        return -1;
80103849:	83 c4 10             	add    $0x10,%esp
8010384c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103851:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103854:	5b                   	pop    %ebx
80103855:	5e                   	pop    %esi
80103856:	5f                   	pop    %edi
80103857:	5d                   	pop    %ebp
80103858:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103859:	89 c2                	mov    %eax,%edx
8010385b:	90                   	nop
8010385c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103860:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103863:	8d 42 01             	lea    0x1(%edx),%eax
80103866:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010386a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103870:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103876:	0f b6 09             	movzbl (%ecx),%ecx
80103879:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010387d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103880:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103883:	0f 85 65 ff ff ff    	jne    801037ee <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103889:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010388f:	83 ec 0c             	sub    $0xc,%esp
80103892:	50                   	push   %eax
80103893:	e8 68 0a 00 00       	call   80104300 <wakeup>
  release(&p->lock);
80103898:	89 1c 24             	mov    %ebx,(%esp)
8010389b:	e8 50 0f 00 00       	call   801047f0 <release>
  return n;
801038a0:	83 c4 10             	add    $0x10,%esp
801038a3:	8b 45 10             	mov    0x10(%ebp),%eax
801038a6:	eb a9                	jmp    80103851 <pipewrite+0xa1>
801038a8:	90                   	nop
801038a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038b0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	57                   	push   %edi
801038b4:	56                   	push   %esi
801038b5:	53                   	push   %ebx
801038b6:	83 ec 18             	sub    $0x18,%esp
801038b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801038bf:	53                   	push   %ebx
801038c0:	e8 7b 0e 00 00       	call   80104740 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038c5:	83 c4 10             	add    $0x10,%esp
801038c8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801038ce:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801038d4:	75 6a                	jne    80103940 <piperead+0x90>
801038d6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801038dc:	85 f6                	test   %esi,%esi
801038de:	0f 84 cc 00 00 00    	je     801039b0 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801038e4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801038ea:	eb 2d                	jmp    80103919 <piperead+0x69>
801038ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038f0:	83 ec 08             	sub    $0x8,%esp
801038f3:	53                   	push   %ebx
801038f4:	56                   	push   %esi
801038f5:	e8 56 08 00 00       	call   80104150 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038fa:	83 c4 10             	add    $0x10,%esp
801038fd:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103903:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103909:	75 35                	jne    80103940 <piperead+0x90>
8010390b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103911:	85 d2                	test   %edx,%edx
80103913:	0f 84 97 00 00 00    	je     801039b0 <piperead+0x100>
    if(myproc()->killed){
80103919:	e8 82 02 00 00       	call   80103ba0 <myproc>
8010391e:	8b 48 24             	mov    0x24(%eax),%ecx
80103921:	85 c9                	test   %ecx,%ecx
80103923:	74 cb                	je     801038f0 <piperead+0x40>
      release(&p->lock);
80103925:	83 ec 0c             	sub    $0xc,%esp
80103928:	53                   	push   %ebx
80103929:	e8 c2 0e 00 00       	call   801047f0 <release>
      return -1;
8010392e:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103931:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103934:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103939:	5b                   	pop    %ebx
8010393a:	5e                   	pop    %esi
8010393b:	5f                   	pop    %edi
8010393c:	5d                   	pop    %ebp
8010393d:	c3                   	ret    
8010393e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103940:	8b 45 10             	mov    0x10(%ebp),%eax
80103943:	85 c0                	test   %eax,%eax
80103945:	7e 69                	jle    801039b0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103947:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010394d:	31 c9                	xor    %ecx,%ecx
8010394f:	eb 15                	jmp    80103966 <piperead+0xb6>
80103951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103958:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010395e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103964:	74 5a                	je     801039c0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103966:	8d 70 01             	lea    0x1(%eax),%esi
80103969:	25 ff 01 00 00       	and    $0x1ff,%eax
8010396e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103974:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103979:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010397c:	83 c1 01             	add    $0x1,%ecx
8010397f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103982:	75 d4                	jne    80103958 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103984:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010398a:	83 ec 0c             	sub    $0xc,%esp
8010398d:	50                   	push   %eax
8010398e:	e8 6d 09 00 00       	call   80104300 <wakeup>
  release(&p->lock);
80103993:	89 1c 24             	mov    %ebx,(%esp)
80103996:	e8 55 0e 00 00       	call   801047f0 <release>
  return i;
8010399b:	8b 45 10             	mov    0x10(%ebp),%eax
8010399e:	83 c4 10             	add    $0x10,%esp
}
801039a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039a4:	5b                   	pop    %ebx
801039a5:	5e                   	pop    %esi
801039a6:	5f                   	pop    %edi
801039a7:	5d                   	pop    %ebp
801039a8:	c3                   	ret    
801039a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039b0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801039b7:	eb cb                	jmp    80103984 <piperead+0xd4>
801039b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039c0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801039c3:	eb bf                	jmp    80103984 <piperead+0xd4>
801039c5:	66 90                	xchg   %ax,%ax
801039c7:	66 90                	xchg   %ax,%ax
801039c9:	66 90                	xchg   %ax,%ax
801039cb:	66 90                	xchg   %ax,%ax
801039cd:	66 90                	xchg   %ax,%ax
801039cf:	90                   	nop

801039d0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039d4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801039d9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801039dc:	68 20 2d 11 80       	push   $0x80112d20
801039e1:	e8 5a 0d 00 00       	call   80104740 <acquire>
801039e6:	83 c4 10             	add    $0x10,%esp
801039e9:	eb 10                	jmp    801039fb <allocproc+0x2b>
801039eb:	90                   	nop
801039ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039f0:	83 c3 7c             	add    $0x7c,%ebx
801039f3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801039f9:	74 75                	je     80103a70 <allocproc+0xa0>
    if(p->state == UNUSED)
801039fb:	8b 43 0c             	mov    0xc(%ebx),%eax
801039fe:	85 c0                	test   %eax,%eax
80103a00:	75 ee                	jne    801039f0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a02:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103a07:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103a0a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103a11:	68 20 2d 11 80       	push   $0x80112d20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a16:	8d 50 01             	lea    0x1(%eax),%edx
80103a19:	89 43 10             	mov    %eax,0x10(%ebx)
80103a1c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
80103a22:	e8 c9 0d 00 00       	call   801047f0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103a27:	e8 24 ee ff ff       	call   80102850 <kalloc>
80103a2c:	83 c4 10             	add    $0x10,%esp
80103a2f:	85 c0                	test   %eax,%eax
80103a31:	89 43 08             	mov    %eax,0x8(%ebx)
80103a34:	74 51                	je     80103a87 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103a36:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103a3c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103a3f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103a44:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103a47:	c7 40 14 72 5a 10 80 	movl   $0x80105a72,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103a4e:	6a 14                	push   $0x14
80103a50:	6a 00                	push   $0x0
80103a52:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103a53:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a56:	e8 e5 0d 00 00       	call   80104840 <memset>
  p->context->eip = (uint)forkret;
80103a5b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103a5e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103a61:	c7 40 10 90 3a 10 80 	movl   $0x80103a90,0x10(%eax)

  return p;
80103a68:	89 d8                	mov    %ebx,%eax
}
80103a6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a6d:	c9                   	leave  
80103a6e:	c3                   	ret    
80103a6f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103a70:	83 ec 0c             	sub    $0xc,%esp
80103a73:	68 20 2d 11 80       	push   $0x80112d20
80103a78:	e8 73 0d 00 00       	call   801047f0 <release>
  return 0;
80103a7d:	83 c4 10             	add    $0x10,%esp
80103a80:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103a82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a85:	c9                   	leave  
80103a86:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103a87:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103a8e:	eb da                	jmp    80103a6a <allocproc+0x9a>

80103a90 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103a96:	68 20 2d 11 80       	push   $0x80112d20
80103a9b:	e8 50 0d 00 00       	call   801047f0 <release>

  if (first) {
80103aa0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103aa5:	83 c4 10             	add    $0x10,%esp
80103aa8:	85 c0                	test   %eax,%eax
80103aaa:	75 04                	jne    80103ab0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103aac:	c9                   	leave  
80103aad:	c3                   	ret    
80103aae:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103ab0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103ab3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103aba:	00 00 00 
    iinit(ROOTDEV);
80103abd:	6a 01                	push   $0x1
80103abf:	e8 7c db ff ff       	call   80101640 <iinit>
    initlog(ROOTDEV);
80103ac4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103acb:	e8 40 f4 ff ff       	call   80102f10 <initlog>
80103ad0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103ad3:	c9                   	leave  
80103ad4:	c3                   	ret    
80103ad5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ae0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103ae6:	68 75 78 10 80       	push   $0x80107875
80103aeb:	68 20 2d 11 80       	push   $0x80112d20
80103af0:	e8 eb 0a 00 00       	call   801045e0 <initlock>
}
80103af5:	83 c4 10             	add    $0x10,%esp
80103af8:	c9                   	leave  
80103af9:	c3                   	ret    
80103afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b00 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	56                   	push   %esi
80103b04:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b05:	9c                   	pushf  
80103b06:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103b07:	f6 c4 02             	test   $0x2,%ah
80103b0a:	75 5b                	jne    80103b67 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
80103b0c:	e8 9f ef ff ff       	call   80102ab0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103b11:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103b17:	85 f6                	test   %esi,%esi
80103b19:	7e 3f                	jle    80103b5a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103b1b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103b22:	39 d0                	cmp    %edx,%eax
80103b24:	74 30                	je     80103b56 <mycpu+0x56>
80103b26:	b9 30 28 11 80       	mov    $0x80112830,%ecx
80103b2b:	31 d2                	xor    %edx,%edx
80103b2d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103b30:	83 c2 01             	add    $0x1,%edx
80103b33:	39 f2                	cmp    %esi,%edx
80103b35:	74 23                	je     80103b5a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103b37:	0f b6 19             	movzbl (%ecx),%ebx
80103b3a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103b40:	39 d8                	cmp    %ebx,%eax
80103b42:	75 ec                	jne    80103b30 <mycpu+0x30>
      return &cpus[i];
80103b44:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
80103b4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b4d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
80103b4e:	05 80 27 11 80       	add    $0x80112780,%eax
  }
  panic("unknown apicid\n");
}
80103b53:	5e                   	pop    %esi
80103b54:	5d                   	pop    %ebp
80103b55:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103b56:	31 d2                	xor    %edx,%edx
80103b58:	eb ea                	jmp    80103b44 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
80103b5a:	83 ec 0c             	sub    $0xc,%esp
80103b5d:	68 7c 78 10 80       	push   $0x8010787c
80103b62:	e8 09 c8 ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103b67:	83 ec 0c             	sub    $0xc,%esp
80103b6a:	68 58 79 10 80       	push   $0x80107958
80103b6f:	e8 fc c7 ff ff       	call   80100370 <panic>
80103b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103b80 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103b86:	e8 75 ff ff ff       	call   80103b00 <mycpu>
80103b8b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103b90:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103b91:	c1 f8 04             	sar    $0x4,%eax
80103b94:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103b9a:	c3                   	ret    
80103b9b:	90                   	nop
80103b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ba0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	53                   	push   %ebx
80103ba4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ba7:	e8 b4 0a 00 00       	call   80104660 <pushcli>
  c = mycpu();
80103bac:	e8 4f ff ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103bb1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bb7:	e8 e4 0a 00 00       	call   801046a0 <popcli>
  return p;
}
80103bbc:	83 c4 04             	add    $0x4,%esp
80103bbf:	89 d8                	mov    %ebx,%eax
80103bc1:	5b                   	pop    %ebx
80103bc2:	5d                   	pop    %ebp
80103bc3:	c3                   	ret    
80103bc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103bca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103bd0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	53                   	push   %ebx
80103bd4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103bd7:	e8 f4 fd ff ff       	call   801039d0 <allocproc>
80103bdc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
80103bde:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103be3:	e8 78 34 00 00       	call   80107060 <setupkvm>
80103be8:	85 c0                	test   %eax,%eax
80103bea:	89 43 04             	mov    %eax,0x4(%ebx)
80103bed:	0f 84 bd 00 00 00    	je     80103cb0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103bf3:	83 ec 04             	sub    $0x4,%esp
80103bf6:	68 2c 00 00 00       	push   $0x2c
80103bfb:	68 60 a4 10 80       	push   $0x8010a460
80103c00:	50                   	push   %eax
80103c01:	e8 6a 31 00 00       	call   80106d70 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103c06:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103c09:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103c0f:	6a 4c                	push   $0x4c
80103c11:	6a 00                	push   $0x0
80103c13:	ff 73 18             	pushl  0x18(%ebx)
80103c16:	e8 25 0c 00 00       	call   80104840 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c1b:	8b 43 18             	mov    0x18(%ebx),%eax
80103c1e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c23:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c28:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c2b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c2f:	8b 43 18             	mov    0x18(%ebx),%eax
80103c32:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103c36:	8b 43 18             	mov    0x18(%ebx),%eax
80103c39:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c3d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103c41:	8b 43 18             	mov    0x18(%ebx),%eax
80103c44:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c48:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103c4c:	8b 43 18             	mov    0x18(%ebx),%eax
80103c4f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103c56:	8b 43 18             	mov    0x18(%ebx),%eax
80103c59:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c60:	8b 43 18             	mov    0x18(%ebx),%eax
80103c63:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c6a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c6d:	6a 10                	push   $0x10
80103c6f:	68 a5 78 10 80       	push   $0x801078a5
80103c74:	50                   	push   %eax
80103c75:	e8 c6 0d 00 00       	call   80104a40 <safestrcpy>
  p->cwd = namei("/");
80103c7a:	c7 04 24 ae 78 10 80 	movl   $0x801078ae,(%esp)
80103c81:	e8 fa e5 ff ff       	call   80102280 <namei>
80103c86:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103c89:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c90:	e8 ab 0a 00 00       	call   80104740 <acquire>

  p->state = RUNNABLE;
80103c95:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103c9c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ca3:	e8 48 0b 00 00       	call   801047f0 <release>
}
80103ca8:	83 c4 10             	add    $0x10,%esp
80103cab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103cae:	c9                   	leave  
80103caf:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103cb0:	83 ec 0c             	sub    $0xc,%esp
80103cb3:	68 8c 78 10 80       	push   $0x8010788c
80103cb8:	e8 b3 c6 ff ff       	call   80100370 <panic>
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi

80103cc0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	56                   	push   %esi
80103cc4:	53                   	push   %ebx
80103cc5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103cc8:	e8 93 09 00 00       	call   80104660 <pushcli>
  c = mycpu();
80103ccd:	e8 2e fe ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103cd2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cd8:	e8 c3 09 00 00       	call   801046a0 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103cdd:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103ce0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ce2:	7e 34                	jle    80103d18 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ce4:	83 ec 04             	sub    $0x4,%esp
80103ce7:	01 c6                	add    %eax,%esi
80103ce9:	56                   	push   %esi
80103cea:	50                   	push   %eax
80103ceb:	ff 73 04             	pushl  0x4(%ebx)
80103cee:	e8 bd 31 00 00       	call   80106eb0 <allocuvm>
80103cf3:	83 c4 10             	add    $0x10,%esp
80103cf6:	85 c0                	test   %eax,%eax
80103cf8:	74 36                	je     80103d30 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103cfa:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103cfd:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103cff:	53                   	push   %ebx
80103d00:	e8 5b 2f 00 00       	call   80106c60 <switchuvm>
  return 0;
80103d05:	83 c4 10             	add    $0x10,%esp
80103d08:	31 c0                	xor    %eax,%eax
}
80103d0a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d0d:	5b                   	pop    %ebx
80103d0e:	5e                   	pop    %esi
80103d0f:	5d                   	pop    %ebp
80103d10:	c3                   	ret    
80103d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103d18:	74 e0                	je     80103cfa <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d1a:	83 ec 04             	sub    $0x4,%esp
80103d1d:	01 c6                	add    %eax,%esi
80103d1f:	56                   	push   %esi
80103d20:	50                   	push   %eax
80103d21:	ff 73 04             	pushl  0x4(%ebx)
80103d24:	e8 87 32 00 00       	call   80106fb0 <deallocuvm>
80103d29:	83 c4 10             	add    $0x10,%esp
80103d2c:	85 c0                	test   %eax,%eax
80103d2e:	75 ca                	jne    80103cfa <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d35:	eb d3                	jmp    80103d0a <growproc+0x4a>
80103d37:	89 f6                	mov    %esi,%esi
80103d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d40 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	57                   	push   %edi
80103d44:	56                   	push   %esi
80103d45:	53                   	push   %ebx
80103d46:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d49:	e8 12 09 00 00       	call   80104660 <pushcli>
  c = mycpu();
80103d4e:	e8 ad fd ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103d53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d59:	e8 42 09 00 00       	call   801046a0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103d5e:	e8 6d fc ff ff       	call   801039d0 <allocproc>
80103d63:	85 c0                	test   %eax,%eax
80103d65:	89 c7                	mov    %eax,%edi
80103d67:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d6a:	0f 84 b5 00 00 00    	je     80103e25 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d70:	83 ec 08             	sub    $0x8,%esp
80103d73:	ff 33                	pushl  (%ebx)
80103d75:	ff 73 04             	pushl  0x4(%ebx)
80103d78:	e8 b3 33 00 00       	call   80107130 <copyuvm>
80103d7d:	83 c4 10             	add    $0x10,%esp
80103d80:	85 c0                	test   %eax,%eax
80103d82:	89 47 04             	mov    %eax,0x4(%edi)
80103d85:	0f 84 a1 00 00 00    	je     80103e2c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103d8b:	8b 03                	mov    (%ebx),%eax
80103d8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103d90:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103d92:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103d95:	89 c8                	mov    %ecx,%eax
80103d97:	8b 79 18             	mov    0x18(%ecx),%edi
80103d9a:	8b 73 18             	mov    0x18(%ebx),%esi
80103d9d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103da2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103da4:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103da6:	8b 40 18             	mov    0x18(%eax),%eax
80103da9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103db0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103db4:	85 c0                	test   %eax,%eax
80103db6:	74 13                	je     80103dcb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103db8:	83 ec 0c             	sub    $0xc,%esp
80103dbb:	50                   	push   %eax
80103dbc:	e8 1f d0 ff ff       	call   80100de0 <filedup>
80103dc1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103dc4:	83 c4 10             	add    $0x10,%esp
80103dc7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103dcb:	83 c6 01             	add    $0x1,%esi
80103dce:	83 fe 10             	cmp    $0x10,%esi
80103dd1:	75 dd                	jne    80103db0 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103dd3:	83 ec 0c             	sub    $0xc,%esp
80103dd6:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dd9:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103ddc:	e8 2f da ff ff       	call   80101810 <idup>
80103de1:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103de4:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103de7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dea:	8d 47 6c             	lea    0x6c(%edi),%eax
80103ded:	6a 10                	push   $0x10
80103def:	53                   	push   %ebx
80103df0:	50                   	push   %eax
80103df1:	e8 4a 0c 00 00       	call   80104a40 <safestrcpy>

  pid = np->pid;
80103df6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103df9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e00:	e8 3b 09 00 00       	call   80104740 <acquire>

  np->state = RUNNABLE;
80103e05:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103e0c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e13:	e8 d8 09 00 00       	call   801047f0 <release>

  return pid;
80103e18:	83 c4 10             	add    $0x10,%esp
80103e1b:	89 d8                	mov    %ebx,%eax
}
80103e1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e20:	5b                   	pop    %ebx
80103e21:	5e                   	pop    %esi
80103e22:	5f                   	pop    %edi
80103e23:	5d                   	pop    %ebp
80103e24:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103e25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e2a:	eb f1                	jmp    80103e1d <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103e2c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103e2f:	83 ec 0c             	sub    $0xc,%esp
80103e32:	ff 77 08             	pushl  0x8(%edi)
80103e35:	e8 66 e8 ff ff       	call   801026a0 <kfree>
    np->kstack = 0;
80103e3a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103e41:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103e48:	83 c4 10             	add    $0x10,%esp
80103e4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e50:	eb cb                	jmp    80103e1d <fork+0xdd>
80103e52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e60 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	53                   	push   %ebx
80103e66:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103e69:	e8 92 fc ff ff       	call   80103b00 <mycpu>
80103e6e:	8d 78 04             	lea    0x4(%eax),%edi
80103e71:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103e73:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103e7a:	00 00 00 
80103e7d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103e80:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103e81:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e84:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103e89:	68 20 2d 11 80       	push   $0x80112d20
80103e8e:	e8 ad 08 00 00       	call   80104740 <acquire>
80103e93:	83 c4 10             	add    $0x10,%esp
80103e96:	eb 13                	jmp    80103eab <scheduler+0x4b>
80103e98:	90                   	nop
80103e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ea0:	83 c3 7c             	add    $0x7c,%ebx
80103ea3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103ea9:	74 45                	je     80103ef0 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103eab:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103eaf:	75 ef                	jne    80103ea0 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103eb1:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103eb4:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103eba:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ebb:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103ebe:	e8 9d 2d 00 00       	call   80106c60 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103ec3:	58                   	pop    %eax
80103ec4:	5a                   	pop    %edx
80103ec5:	ff 73 a0             	pushl  -0x60(%ebx)
80103ec8:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103ec9:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103ed0:	e8 c6 0b 00 00       	call   80104a9b <swtch>
      switchkvm();
80103ed5:	e8 66 2d 00 00       	call   80106c40 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103eda:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103edd:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103ee3:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103eea:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eed:	75 bc                	jne    80103eab <scheduler+0x4b>
80103eef:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103ef0:	83 ec 0c             	sub    $0xc,%esp
80103ef3:	68 20 2d 11 80       	push   $0x80112d20
80103ef8:	e8 f3 08 00 00       	call   801047f0 <release>

  }
80103efd:	83 c4 10             	add    $0x10,%esp
80103f00:	e9 7b ff ff ff       	jmp    80103e80 <scheduler+0x20>
80103f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f10 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	56                   	push   %esi
80103f14:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f15:	e8 46 07 00 00       	call   80104660 <pushcli>
  c = mycpu();
80103f1a:	e8 e1 fb ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103f1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f25:	e8 76 07 00 00       	call   801046a0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103f2a:	83 ec 0c             	sub    $0xc,%esp
80103f2d:	68 20 2d 11 80       	push   $0x80112d20
80103f32:	e8 d9 07 00 00       	call   80104710 <holding>
80103f37:	83 c4 10             	add    $0x10,%esp
80103f3a:	85 c0                	test   %eax,%eax
80103f3c:	74 4f                	je     80103f8d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103f3e:	e8 bd fb ff ff       	call   80103b00 <mycpu>
80103f43:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103f4a:	75 68                	jne    80103fb4 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103f4c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103f50:	74 55                	je     80103fa7 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103f52:	9c                   	pushf  
80103f53:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103f54:	f6 c4 02             	test   $0x2,%ah
80103f57:	75 41                	jne    80103f9a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103f59:	e8 a2 fb ff ff       	call   80103b00 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103f5e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103f61:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103f67:	e8 94 fb ff ff       	call   80103b00 <mycpu>
80103f6c:	83 ec 08             	sub    $0x8,%esp
80103f6f:	ff 70 04             	pushl  0x4(%eax)
80103f72:	53                   	push   %ebx
80103f73:	e8 23 0b 00 00       	call   80104a9b <swtch>
  mycpu()->intena = intena;
80103f78:	e8 83 fb ff ff       	call   80103b00 <mycpu>
}
80103f7d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103f80:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103f86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f89:	5b                   	pop    %ebx
80103f8a:	5e                   	pop    %esi
80103f8b:	5d                   	pop    %ebp
80103f8c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103f8d:	83 ec 0c             	sub    $0xc,%esp
80103f90:	68 b0 78 10 80       	push   $0x801078b0
80103f95:	e8 d6 c3 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103f9a:	83 ec 0c             	sub    $0xc,%esp
80103f9d:	68 dc 78 10 80       	push   $0x801078dc
80103fa2:	e8 c9 c3 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103fa7:	83 ec 0c             	sub    $0xc,%esp
80103faa:	68 ce 78 10 80       	push   $0x801078ce
80103faf:	e8 bc c3 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103fb4:	83 ec 0c             	sub    $0xc,%esp
80103fb7:	68 c2 78 10 80       	push   $0x801078c2
80103fbc:	e8 af c3 ff ff       	call   80100370 <panic>
80103fc1:	eb 0d                	jmp    80103fd0 <exit>
80103fc3:	90                   	nop
80103fc4:	90                   	nop
80103fc5:	90                   	nop
80103fc6:	90                   	nop
80103fc7:	90                   	nop
80103fc8:	90                   	nop
80103fc9:	90                   	nop
80103fca:	90                   	nop
80103fcb:	90                   	nop
80103fcc:	90                   	nop
80103fcd:	90                   	nop
80103fce:	90                   	nop
80103fcf:	90                   	nop

80103fd0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	57                   	push   %edi
80103fd4:	56                   	push   %esi
80103fd5:	53                   	push   %ebx
80103fd6:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103fd9:	e8 82 06 00 00       	call   80104660 <pushcli>
  c = mycpu();
80103fde:	e8 1d fb ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103fe3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fe9:	e8 b2 06 00 00       	call   801046a0 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103fee:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103ff4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103ff7:	8d 7e 68             	lea    0x68(%esi),%edi
80103ffa:	0f 84 e7 00 00 00    	je     801040e7 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80104000:	8b 03                	mov    (%ebx),%eax
80104002:	85 c0                	test   %eax,%eax
80104004:	74 12                	je     80104018 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104006:	83 ec 0c             	sub    $0xc,%esp
80104009:	50                   	push   %eax
8010400a:	e8 21 ce ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
8010400f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104015:	83 c4 10             	add    $0x10,%esp
80104018:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010401b:	39 df                	cmp    %ebx,%edi
8010401d:	75 e1                	jne    80104000 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
8010401f:	e8 8c ef ff ff       	call   80102fb0 <begin_op>
  iput(curproc->cwd);
80104024:	83 ec 0c             	sub    $0xc,%esp
80104027:	ff 76 68             	pushl  0x68(%esi)
8010402a:	e8 41 d9 ff ff       	call   80101970 <iput>
  end_op();
8010402f:	e8 ec ef ff ff       	call   80103020 <end_op>
  curproc->cwd = 0;
80104034:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
8010403b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104042:	e8 f9 06 00 00       	call   80104740 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80104047:	8b 56 14             	mov    0x14(%esi),%edx
8010404a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010404d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104052:	eb 0e                	jmp    80104062 <exit+0x92>
80104054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104058:	83 c0 7c             	add    $0x7c,%eax
8010405b:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104060:	74 1c                	je     8010407e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80104062:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104066:	75 f0                	jne    80104058 <exit+0x88>
80104068:	3b 50 20             	cmp    0x20(%eax),%edx
8010406b:	75 eb                	jne    80104058 <exit+0x88>
      p->state = RUNNABLE;
8010406d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104074:	83 c0 7c             	add    $0x7c,%eax
80104077:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
8010407c:	75 e4                	jne    80104062 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
8010407e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
80104084:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80104089:	eb 10                	jmp    8010409b <exit+0xcb>
8010408b:	90                   	nop
8010408c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104090:	83 c2 7c             	add    $0x7c,%edx
80104093:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80104099:	74 33                	je     801040ce <exit+0xfe>
    if(p->parent == curproc){
8010409b:	39 72 14             	cmp    %esi,0x14(%edx)
8010409e:	75 f0                	jne    80104090 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
801040a0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
801040a4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801040a7:	75 e7                	jne    80104090 <exit+0xc0>
801040a9:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040ae:	eb 0a                	jmp    801040ba <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040b0:	83 c0 7c             	add    $0x7c,%eax
801040b3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
801040b8:	74 d6                	je     80104090 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
801040ba:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040be:	75 f0                	jne    801040b0 <exit+0xe0>
801040c0:	3b 48 20             	cmp    0x20(%eax),%ecx
801040c3:	75 eb                	jne    801040b0 <exit+0xe0>
      p->state = RUNNABLE;
801040c5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040cc:	eb e2                	jmp    801040b0 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
801040ce:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801040d5:	e8 36 fe ff ff       	call   80103f10 <sched>
  panic("zombie exit");
801040da:	83 ec 0c             	sub    $0xc,%esp
801040dd:	68 fd 78 10 80       	push   $0x801078fd
801040e2:	e8 89 c2 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
801040e7:	83 ec 0c             	sub    $0xc,%esp
801040ea:	68 f0 78 10 80       	push   $0x801078f0
801040ef:	e8 7c c2 ff ff       	call   80100370 <panic>
801040f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801040fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104100 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	53                   	push   %ebx
80104104:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104107:	68 20 2d 11 80       	push   $0x80112d20
8010410c:	e8 2f 06 00 00       	call   80104740 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104111:	e8 4a 05 00 00       	call   80104660 <pushcli>
  c = mycpu();
80104116:	e8 e5 f9 ff ff       	call   80103b00 <mycpu>
  p = c->proc;
8010411b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104121:	e8 7a 05 00 00       	call   801046a0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80104126:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010412d:	e8 de fd ff ff       	call   80103f10 <sched>
  release(&ptable.lock);
80104132:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104139:	e8 b2 06 00 00       	call   801047f0 <release>
}
8010413e:	83 c4 10             	add    $0x10,%esp
80104141:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104144:	c9                   	leave  
80104145:	c3                   	ret    
80104146:	8d 76 00             	lea    0x0(%esi),%esi
80104149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104150 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	57                   	push   %edi
80104154:	56                   	push   %esi
80104155:	53                   	push   %ebx
80104156:	83 ec 0c             	sub    $0xc,%esp
80104159:	8b 7d 08             	mov    0x8(%ebp),%edi
8010415c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010415f:	e8 fc 04 00 00       	call   80104660 <pushcli>
  c = mycpu();
80104164:	e8 97 f9 ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80104169:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010416f:	e8 2c 05 00 00       	call   801046a0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80104174:	85 db                	test   %ebx,%ebx
80104176:	0f 84 87 00 00 00    	je     80104203 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
8010417c:	85 f6                	test   %esi,%esi
8010417e:	74 76                	je     801041f6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104180:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80104186:	74 50                	je     801041d8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104188:	83 ec 0c             	sub    $0xc,%esp
8010418b:	68 20 2d 11 80       	push   $0x80112d20
80104190:	e8 ab 05 00 00       	call   80104740 <acquire>
    release(lk);
80104195:	89 34 24             	mov    %esi,(%esp)
80104198:	e8 53 06 00 00       	call   801047f0 <release>
  }
  // Go to sleep.
  p->chan = chan;
8010419d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801041a0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
801041a7:	e8 64 fd ff ff       	call   80103f10 <sched>

  // Tidy up.
  p->chan = 0;
801041ac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
801041b3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801041ba:	e8 31 06 00 00       	call   801047f0 <release>
    acquire(lk);
801041bf:	89 75 08             	mov    %esi,0x8(%ebp)
801041c2:	83 c4 10             	add    $0x10,%esp
  }
}
801041c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041c8:	5b                   	pop    %ebx
801041c9:	5e                   	pop    %esi
801041ca:	5f                   	pop    %edi
801041cb:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
801041cc:	e9 6f 05 00 00       	jmp    80104740 <acquire>
801041d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
801041d8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801041db:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
801041e2:	e8 29 fd ff ff       	call   80103f10 <sched>

  // Tidy up.
  p->chan = 0;
801041e7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
801041ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041f1:	5b                   	pop    %ebx
801041f2:	5e                   	pop    %esi
801041f3:	5f                   	pop    %edi
801041f4:	5d                   	pop    %ebp
801041f5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
801041f6:	83 ec 0c             	sub    $0xc,%esp
801041f9:	68 0f 79 10 80       	push   $0x8010790f
801041fe:	e8 6d c1 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80104203:	83 ec 0c             	sub    $0xc,%esp
80104206:	68 09 79 10 80       	push   $0x80107909
8010420b:	e8 60 c1 ff ff       	call   80100370 <panic>

80104210 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	56                   	push   %esi
80104214:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104215:	e8 46 04 00 00       	call   80104660 <pushcli>
  c = mycpu();
8010421a:	e8 e1 f8 ff ff       	call   80103b00 <mycpu>
  p = c->proc;
8010421f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104225:	e8 76 04 00 00       	call   801046a0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
8010422a:	83 ec 0c             	sub    $0xc,%esp
8010422d:	68 20 2d 11 80       	push   $0x80112d20
80104232:	e8 09 05 00 00       	call   80104740 <acquire>
80104237:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010423a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010423c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80104241:	eb 10                	jmp    80104253 <wait+0x43>
80104243:	90                   	nop
80104244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104248:	83 c3 7c             	add    $0x7c,%ebx
8010424b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104251:	74 1d                	je     80104270 <wait+0x60>
      if(p->parent != curproc)
80104253:	39 73 14             	cmp    %esi,0x14(%ebx)
80104256:	75 f0                	jne    80104248 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104258:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010425c:	74 30                	je     8010428e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010425e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104261:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104266:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
8010426c:	75 e5                	jne    80104253 <wait+0x43>
8010426e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104270:	85 c0                	test   %eax,%eax
80104272:	74 70                	je     801042e4 <wait+0xd4>
80104274:	8b 46 24             	mov    0x24(%esi),%eax
80104277:	85 c0                	test   %eax,%eax
80104279:	75 69                	jne    801042e4 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010427b:	83 ec 08             	sub    $0x8,%esp
8010427e:	68 20 2d 11 80       	push   $0x80112d20
80104283:	56                   	push   %esi
80104284:	e8 c7 fe ff ff       	call   80104150 <sleep>
  }
80104289:	83 c4 10             	add    $0x10,%esp
8010428c:	eb ac                	jmp    8010423a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
8010428e:	83 ec 0c             	sub    $0xc,%esp
80104291:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104294:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104297:	e8 04 e4 ff ff       	call   801026a0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
8010429c:	5a                   	pop    %edx
8010429d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
801042a0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801042a7:	e8 34 2d 00 00       	call   80106fe0 <freevm>
        p->pid = 0;
801042ac:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801042b3:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801042ba:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801042be:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801042c5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801042cc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801042d3:	e8 18 05 00 00       	call   801047f0 <release>
        return pid;
801042d8:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801042db:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
801042de:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801042e0:	5b                   	pop    %ebx
801042e1:	5e                   	pop    %esi
801042e2:	5d                   	pop    %ebp
801042e3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
801042e4:	83 ec 0c             	sub    $0xc,%esp
801042e7:	68 20 2d 11 80       	push   $0x80112d20
801042ec:	e8 ff 04 00 00       	call   801047f0 <release>
      return -1;
801042f1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801042f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
801042f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801042fc:	5b                   	pop    %ebx
801042fd:	5e                   	pop    %esi
801042fe:	5d                   	pop    %ebp
801042ff:	c3                   	ret    

80104300 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	53                   	push   %ebx
80104304:	83 ec 10             	sub    $0x10,%esp
80104307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010430a:	68 20 2d 11 80       	push   $0x80112d20
8010430f:	e8 2c 04 00 00       	call   80104740 <acquire>
80104314:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104317:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010431c:	eb 0c                	jmp    8010432a <wakeup+0x2a>
8010431e:	66 90                	xchg   %ax,%ax
80104320:	83 c0 7c             	add    $0x7c,%eax
80104323:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104328:	74 1c                	je     80104346 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010432a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010432e:	75 f0                	jne    80104320 <wakeup+0x20>
80104330:	3b 58 20             	cmp    0x20(%eax),%ebx
80104333:	75 eb                	jne    80104320 <wakeup+0x20>
      p->state = RUNNABLE;
80104335:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010433c:	83 c0 7c             	add    $0x7c,%eax
8010433f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104344:	75 e4                	jne    8010432a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104346:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010434d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104350:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104351:	e9 9a 04 00 00       	jmp    801047f0 <release>
80104356:	8d 76 00             	lea    0x0(%esi),%esi
80104359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104360 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
80104364:	83 ec 10             	sub    $0x10,%esp
80104367:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010436a:	68 20 2d 11 80       	push   $0x80112d20
8010436f:	e8 cc 03 00 00       	call   80104740 <acquire>
80104374:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104377:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010437c:	eb 0c                	jmp    8010438a <kill+0x2a>
8010437e:	66 90                	xchg   %ax,%ax
80104380:	83 c0 7c             	add    $0x7c,%eax
80104383:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104388:	74 3e                	je     801043c8 <kill+0x68>
    if(p->pid == pid){
8010438a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010438d:	75 f1                	jne    80104380 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010438f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104393:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010439a:	74 1c                	je     801043b8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010439c:	83 ec 0c             	sub    $0xc,%esp
8010439f:	68 20 2d 11 80       	push   $0x80112d20
801043a4:	e8 47 04 00 00       	call   801047f0 <release>
      return 0;
801043a9:	83 c4 10             	add    $0x10,%esp
801043ac:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801043ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043b1:	c9                   	leave  
801043b2:	c3                   	ret    
801043b3:	90                   	nop
801043b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
801043b8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801043bf:	eb db                	jmp    8010439c <kill+0x3c>
801043c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801043c8:	83 ec 0c             	sub    $0xc,%esp
801043cb:	68 20 2d 11 80       	push   $0x80112d20
801043d0:	e8 1b 04 00 00       	call   801047f0 <release>
  return -1;
801043d5:	83 c4 10             	add    $0x10,%esp
801043d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801043dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043e0:	c9                   	leave  
801043e1:	c3                   	ret    
801043e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043f0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	57                   	push   %edi
801043f4:	56                   	push   %esi
801043f5:	53                   	push   %ebx
801043f6:	8d 75 e8             	lea    -0x18(%ebp),%esi
801043f9:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
801043fe:	83 ec 3c             	sub    $0x3c,%esp
80104401:	eb 24                	jmp    80104427 <procdump+0x37>
80104403:	90                   	nop
80104404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104408:	83 ec 0c             	sub    $0xc,%esp
8010440b:	68 9f 7c 10 80       	push   $0x80107c9f
80104410:	e8 4b c2 ff ff       	call   80100660 <cprintf>
80104415:	83 c4 10             	add    $0x10,%esp
80104418:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010441b:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80104421:	0f 84 81 00 00 00    	je     801044a8 <procdump+0xb8>
    if(p->state == UNUSED)
80104427:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010442a:	85 c0                	test   %eax,%eax
8010442c:	74 ea                	je     80104418 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010442e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104431:	ba 20 79 10 80       	mov    $0x80107920,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104436:	77 11                	ja     80104449 <procdump+0x59>
80104438:	8b 14 85 80 79 10 80 	mov    -0x7fef8680(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010443f:	b8 20 79 10 80       	mov    $0x80107920,%eax
80104444:	85 d2                	test   %edx,%edx
80104446:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104449:	53                   	push   %ebx
8010444a:	52                   	push   %edx
8010444b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010444e:	68 24 79 10 80       	push   $0x80107924
80104453:	e8 08 c2 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104458:	83 c4 10             	add    $0x10,%esp
8010445b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010445f:	75 a7                	jne    80104408 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104461:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104464:	83 ec 08             	sub    $0x8,%esp
80104467:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010446a:	50                   	push   %eax
8010446b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010446e:	8b 40 0c             	mov    0xc(%eax),%eax
80104471:	83 c0 08             	add    $0x8,%eax
80104474:	50                   	push   %eax
80104475:	e8 86 01 00 00       	call   80104600 <getcallerpcs>
8010447a:	83 c4 10             	add    $0x10,%esp
8010447d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104480:	8b 17                	mov    (%edi),%edx
80104482:	85 d2                	test   %edx,%edx
80104484:	74 82                	je     80104408 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104486:	83 ec 08             	sub    $0x8,%esp
80104489:	83 c7 04             	add    $0x4,%edi
8010448c:	52                   	push   %edx
8010448d:	68 61 73 10 80       	push   $0x80107361
80104492:	e8 c9 c1 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104497:	83 c4 10             	add    $0x10,%esp
8010449a:	39 f7                	cmp    %esi,%edi
8010449c:	75 e2                	jne    80104480 <procdump+0x90>
8010449e:	e9 65 ff ff ff       	jmp    80104408 <procdump+0x18>
801044a3:	90                   	nop
801044a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801044a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044ab:	5b                   	pop    %ebx
801044ac:	5e                   	pop    %esi
801044ad:	5f                   	pop    %edi
801044ae:	5d                   	pop    %ebp
801044af:	c3                   	ret    

801044b0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	53                   	push   %ebx
801044b4:	83 ec 0c             	sub    $0xc,%esp
801044b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801044ba:	68 98 79 10 80       	push   $0x80107998
801044bf:	8d 43 04             	lea    0x4(%ebx),%eax
801044c2:	50                   	push   %eax
801044c3:	e8 18 01 00 00       	call   801045e0 <initlock>
  lk->name = name;
801044c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801044cb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801044d1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801044d4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801044db:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801044de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044e1:	c9                   	leave  
801044e2:	c3                   	ret    
801044e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044f0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
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
801044ff:	e8 3c 02 00 00       	call   80104740 <acquire>
  while (lk->locked) {
80104504:	8b 13                	mov    (%ebx),%edx
80104506:	83 c4 10             	add    $0x10,%esp
80104509:	85 d2                	test   %edx,%edx
8010450b:	74 16                	je     80104523 <acquiresleep+0x33>
8010450d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104510:	83 ec 08             	sub    $0x8,%esp
80104513:	56                   	push   %esi
80104514:	53                   	push   %ebx
80104515:	e8 36 fc ff ff       	call   80104150 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010451a:	8b 03                	mov    (%ebx),%eax
8010451c:	83 c4 10             	add    $0x10,%esp
8010451f:	85 c0                	test   %eax,%eax
80104521:	75 ed                	jne    80104510 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104523:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104529:	e8 72 f6 ff ff       	call   80103ba0 <myproc>
8010452e:	8b 40 10             	mov    0x10(%eax),%eax
80104531:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104534:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104537:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010453a:	5b                   	pop    %ebx
8010453b:	5e                   	pop    %esi
8010453c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010453d:	e9 ae 02 00 00       	jmp    801047f0 <release>
80104542:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104550 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	56                   	push   %esi
80104554:	53                   	push   %ebx
80104555:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104558:	83 ec 0c             	sub    $0xc,%esp
8010455b:	8d 73 04             	lea    0x4(%ebx),%esi
8010455e:	56                   	push   %esi
8010455f:	e8 dc 01 00 00       	call   80104740 <acquire>
  lk->locked = 0;
80104564:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010456a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104571:	89 1c 24             	mov    %ebx,(%esp)
80104574:	e8 87 fd ff ff       	call   80104300 <wakeup>
  release(&lk->lk);
80104579:	89 75 08             	mov    %esi,0x8(%ebp)
8010457c:	83 c4 10             	add    $0x10,%esp
}
8010457f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104582:	5b                   	pop    %ebx
80104583:	5e                   	pop    %esi
80104584:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104585:	e9 66 02 00 00       	jmp    801047f0 <release>
8010458a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104590 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	57                   	push   %edi
80104594:	56                   	push   %esi
80104595:	53                   	push   %ebx
80104596:	31 ff                	xor    %edi,%edi
80104598:	83 ec 18             	sub    $0x18,%esp
8010459b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010459e:	8d 73 04             	lea    0x4(%ebx),%esi
801045a1:	56                   	push   %esi
801045a2:	e8 99 01 00 00       	call   80104740 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801045a7:	8b 03                	mov    (%ebx),%eax
801045a9:	83 c4 10             	add    $0x10,%esp
801045ac:	85 c0                	test   %eax,%eax
801045ae:	74 13                	je     801045c3 <holdingsleep+0x33>
801045b0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801045b3:	e8 e8 f5 ff ff       	call   80103ba0 <myproc>
801045b8:	39 58 10             	cmp    %ebx,0x10(%eax)
801045bb:	0f 94 c0             	sete   %al
801045be:	0f b6 c0             	movzbl %al,%eax
801045c1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801045c3:	83 ec 0c             	sub    $0xc,%esp
801045c6:	56                   	push   %esi
801045c7:	e8 24 02 00 00       	call   801047f0 <release>
  return r;
}
801045cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045cf:	89 f8                	mov    %edi,%eax
801045d1:	5b                   	pop    %ebx
801045d2:	5e                   	pop    %esi
801045d3:	5f                   	pop    %edi
801045d4:	5d                   	pop    %ebp
801045d5:	c3                   	ret    
801045d6:	66 90                	xchg   %ax,%ax
801045d8:	66 90                	xchg   %ax,%ax
801045da:	66 90                	xchg   %ax,%ax
801045dc:	66 90                	xchg   %ax,%ax
801045de:	66 90                	xchg   %ax,%ax

801045e0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801045e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801045e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801045ef:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801045f2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801045f9:	5d                   	pop    %ebp
801045fa:	c3                   	ret    
801045fb:	90                   	nop
801045fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104600 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104604:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104607:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010460a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010460d:	31 c0                	xor    %eax,%eax
8010460f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104610:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104616:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010461c:	77 1a                	ja     80104638 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010461e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104621:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104624:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104627:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104629:	83 f8 0a             	cmp    $0xa,%eax
8010462c:	75 e2                	jne    80104610 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010462e:	5b                   	pop    %ebx
8010462f:	5d                   	pop    %ebp
80104630:	c3                   	ret    
80104631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104638:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010463f:	83 c0 01             	add    $0x1,%eax
80104642:	83 f8 0a             	cmp    $0xa,%eax
80104645:	74 e7                	je     8010462e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104647:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010464e:	83 c0 01             	add    $0x1,%eax
80104651:	83 f8 0a             	cmp    $0xa,%eax
80104654:	75 e2                	jne    80104638 <getcallerpcs+0x38>
80104656:	eb d6                	jmp    8010462e <getcallerpcs+0x2e>
80104658:	90                   	nop
80104659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104660 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	53                   	push   %ebx
80104664:	83 ec 04             	sub    $0x4,%esp
80104667:	9c                   	pushf  
80104668:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104669:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010466a:	e8 91 f4 ff ff       	call   80103b00 <mycpu>
8010466f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104675:	85 c0                	test   %eax,%eax
80104677:	75 11                	jne    8010468a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104679:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010467f:	e8 7c f4 ff ff       	call   80103b00 <mycpu>
80104684:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010468a:	e8 71 f4 ff ff       	call   80103b00 <mycpu>
8010468f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104696:	83 c4 04             	add    $0x4,%esp
80104699:	5b                   	pop    %ebx
8010469a:	5d                   	pop    %ebp
8010469b:	c3                   	ret    
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046a0 <popcli>:

void
popcli(void)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046a6:	9c                   	pushf  
801046a7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801046a8:	f6 c4 02             	test   $0x2,%ah
801046ab:	75 52                	jne    801046ff <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801046ad:	e8 4e f4 ff ff       	call   80103b00 <mycpu>
801046b2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801046b8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801046bb:	85 d2                	test   %edx,%edx
801046bd:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801046c3:	78 2d                	js     801046f2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046c5:	e8 36 f4 ff ff       	call   80103b00 <mycpu>
801046ca:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801046d0:	85 d2                	test   %edx,%edx
801046d2:	74 0c                	je     801046e0 <popcli+0x40>
    sti();
}
801046d4:	c9                   	leave  
801046d5:	c3                   	ret    
801046d6:	8d 76 00             	lea    0x0(%esi),%esi
801046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046e0:	e8 1b f4 ff ff       	call   80103b00 <mycpu>
801046e5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801046eb:	85 c0                	test   %eax,%eax
801046ed:	74 e5                	je     801046d4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801046ef:	fb                   	sti    
    sti();
}
801046f0:	c9                   	leave  
801046f1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801046f2:	83 ec 0c             	sub    $0xc,%esp
801046f5:	68 ba 79 10 80       	push   $0x801079ba
801046fa:	e8 71 bc ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801046ff:	83 ec 0c             	sub    $0xc,%esp
80104702:	68 a3 79 10 80       	push   $0x801079a3
80104707:	e8 64 bc ff ff       	call   80100370 <panic>
8010470c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104710 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
80104715:	8b 75 08             	mov    0x8(%ebp),%esi
80104718:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
8010471a:	e8 41 ff ff ff       	call   80104660 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010471f:	8b 06                	mov    (%esi),%eax
80104721:	85 c0                	test   %eax,%eax
80104723:	74 10                	je     80104735 <holding+0x25>
80104725:	8b 5e 08             	mov    0x8(%esi),%ebx
80104728:	e8 d3 f3 ff ff       	call   80103b00 <mycpu>
8010472d:	39 c3                	cmp    %eax,%ebx
8010472f:	0f 94 c3             	sete   %bl
80104732:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104735:	e8 66 ff ff ff       	call   801046a0 <popcli>
  return r;
}
8010473a:	89 d8                	mov    %ebx,%eax
8010473c:	5b                   	pop    %ebx
8010473d:	5e                   	pop    %esi
8010473e:	5d                   	pop    %ebp
8010473f:	c3                   	ret    

80104740 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	53                   	push   %ebx
80104744:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104747:	e8 14 ff ff ff       	call   80104660 <pushcli>
  if(holding(lk))
8010474c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010474f:	83 ec 0c             	sub    $0xc,%esp
80104752:	53                   	push   %ebx
80104753:	e8 b8 ff ff ff       	call   80104710 <holding>
80104758:	83 c4 10             	add    $0x10,%esp
8010475b:	85 c0                	test   %eax,%eax
8010475d:	0f 85 7d 00 00 00    	jne    801047e0 <acquire+0xa0>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104763:	ba 01 00 00 00       	mov    $0x1,%edx
80104768:	eb 09                	jmp    80104773 <acquire+0x33>
8010476a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104770:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104773:	89 d0                	mov    %edx,%eax
80104775:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104778:	85 c0                	test   %eax,%eax
8010477a:	75 f4                	jne    80104770 <acquire+0x30>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010477c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104781:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104784:	e8 77 f3 ff ff       	call   80103b00 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104789:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010478b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010478e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104791:	31 c0                	xor    %eax,%eax
80104793:	90                   	nop
80104794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104798:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010479e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801047a4:	77 1a                	ja     801047c0 <acquire+0x80>
      break;
    pcs[i] = ebp[1];     // saved %eip
801047a6:	8b 5a 04             	mov    0x4(%edx),%ebx
801047a9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801047ac:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801047af:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801047b1:	83 f8 0a             	cmp    $0xa,%eax
801047b4:	75 e2                	jne    80104798 <acquire+0x58>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801047b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047b9:	c9                   	leave  
801047ba:	c3                   	ret    
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801047c0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801047c7:	83 c0 01             	add    $0x1,%eax
801047ca:	83 f8 0a             	cmp    $0xa,%eax
801047cd:	74 e7                	je     801047b6 <acquire+0x76>
    pcs[i] = 0;
801047cf:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801047d6:	83 c0 01             	add    $0x1,%eax
801047d9:	83 f8 0a             	cmp    $0xa,%eax
801047dc:	75 e2                	jne    801047c0 <acquire+0x80>
801047de:	eb d6                	jmp    801047b6 <acquire+0x76>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801047e0:	83 ec 0c             	sub    $0xc,%esp
801047e3:	68 c1 79 10 80       	push   $0x801079c1
801047e8:	e8 83 bb ff ff       	call   80100370 <panic>
801047ed:	8d 76 00             	lea    0x0(%esi),%esi

801047f0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	53                   	push   %ebx
801047f4:	83 ec 10             	sub    $0x10,%esp
801047f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801047fa:	53                   	push   %ebx
801047fb:	e8 10 ff ff ff       	call   80104710 <holding>
80104800:	83 c4 10             	add    $0x10,%esp
80104803:	85 c0                	test   %eax,%eax
80104805:	74 22                	je     80104829 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80104807:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010480e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104815:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010481a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104820:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104823:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104824:	e9 77 fe ff ff       	jmp    801046a0 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104829:	83 ec 0c             	sub    $0xc,%esp
8010482c:	68 c9 79 10 80       	push   $0x801079c9
80104831:	e8 3a bb ff ff       	call   80100370 <panic>
80104836:	66 90                	xchg   %ax,%ax
80104838:	66 90                	xchg   %ax,%ax
8010483a:	66 90                	xchg   %ax,%ax
8010483c:	66 90                	xchg   %ax,%ax
8010483e:	66 90                	xchg   %ax,%ax

80104840 <memset>:
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	57                   	push   %edi
80104844:	53                   	push   %ebx
80104845:	8b 55 08             	mov    0x8(%ebp),%edx
80104848:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010484b:	f6 c2 03             	test   $0x3,%dl
8010484e:	75 05                	jne    80104855 <memset+0x15>
80104850:	f6 c1 03             	test   $0x3,%cl
80104853:	74 13                	je     80104868 <memset+0x28>
80104855:	89 d7                	mov    %edx,%edi
80104857:	8b 45 0c             	mov    0xc(%ebp),%eax
8010485a:	fc                   	cld    
8010485b:	f3 aa                	rep stos %al,%es:(%edi)
8010485d:	5b                   	pop    %ebx
8010485e:	89 d0                	mov    %edx,%eax
80104860:	5f                   	pop    %edi
80104861:	5d                   	pop    %ebp
80104862:	c3                   	ret    
80104863:	90                   	nop
80104864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104868:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
8010486c:	c1 e9 02             	shr    $0x2,%ecx
8010486f:	89 fb                	mov    %edi,%ebx
80104871:	89 f8                	mov    %edi,%eax
80104873:	c1 e3 18             	shl    $0x18,%ebx
80104876:	c1 e0 10             	shl    $0x10,%eax
80104879:	09 d8                	or     %ebx,%eax
8010487b:	09 f8                	or     %edi,%eax
8010487d:	c1 e7 08             	shl    $0x8,%edi
80104880:	09 f8                	or     %edi,%eax
80104882:	89 d7                	mov    %edx,%edi
80104884:	fc                   	cld    
80104885:	f3 ab                	rep stos %eax,%es:(%edi)
80104887:	5b                   	pop    %ebx
80104888:	89 d0                	mov    %edx,%eax
8010488a:	5f                   	pop    %edi
8010488b:	5d                   	pop    %ebp
8010488c:	c3                   	ret    
8010488d:	8d 76 00             	lea    0x0(%esi),%esi

80104890 <memcmp>:
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	57                   	push   %edi
80104894:	56                   	push   %esi
80104895:	8b 45 10             	mov    0x10(%ebp),%eax
80104898:	53                   	push   %ebx
80104899:	8b 75 0c             	mov    0xc(%ebp),%esi
8010489c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010489f:	85 c0                	test   %eax,%eax
801048a1:	74 29                	je     801048cc <memcmp+0x3c>
801048a3:	0f b6 13             	movzbl (%ebx),%edx
801048a6:	0f b6 0e             	movzbl (%esi),%ecx
801048a9:	38 d1                	cmp    %dl,%cl
801048ab:	75 2b                	jne    801048d8 <memcmp+0x48>
801048ad:	8d 78 ff             	lea    -0x1(%eax),%edi
801048b0:	31 c0                	xor    %eax,%eax
801048b2:	eb 14                	jmp    801048c8 <memcmp+0x38>
801048b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048b8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
801048bd:	83 c0 01             	add    $0x1,%eax
801048c0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801048c4:	38 ca                	cmp    %cl,%dl
801048c6:	75 10                	jne    801048d8 <memcmp+0x48>
801048c8:	39 f8                	cmp    %edi,%eax
801048ca:	75 ec                	jne    801048b8 <memcmp+0x28>
801048cc:	5b                   	pop    %ebx
801048cd:	31 c0                	xor    %eax,%eax
801048cf:	5e                   	pop    %esi
801048d0:	5f                   	pop    %edi
801048d1:	5d                   	pop    %ebp
801048d2:	c3                   	ret    
801048d3:	90                   	nop
801048d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048d8:	0f b6 c2             	movzbl %dl,%eax
801048db:	5b                   	pop    %ebx
801048dc:	29 c8                	sub    %ecx,%eax
801048de:	5e                   	pop    %esi
801048df:	5f                   	pop    %edi
801048e0:	5d                   	pop    %ebp
801048e1:	c3                   	ret    
801048e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048f0 <memmove>:
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	56                   	push   %esi
801048f4:	53                   	push   %ebx
801048f5:	8b 45 08             	mov    0x8(%ebp),%eax
801048f8:	8b 75 0c             	mov    0xc(%ebp),%esi
801048fb:	8b 5d 10             	mov    0x10(%ebp),%ebx
801048fe:	39 c6                	cmp    %eax,%esi
80104900:	73 2e                	jae    80104930 <memmove+0x40>
80104902:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104905:	39 c8                	cmp    %ecx,%eax
80104907:	73 27                	jae    80104930 <memmove+0x40>
80104909:	85 db                	test   %ebx,%ebx
8010490b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010490e:	74 17                	je     80104927 <memmove+0x37>
80104910:	29 d9                	sub    %ebx,%ecx
80104912:	89 cb                	mov    %ecx,%ebx
80104914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104918:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010491c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
8010491f:	83 ea 01             	sub    $0x1,%edx
80104922:	83 fa ff             	cmp    $0xffffffff,%edx
80104925:	75 f1                	jne    80104918 <memmove+0x28>
80104927:	5b                   	pop    %ebx
80104928:	5e                   	pop    %esi
80104929:	5d                   	pop    %ebp
8010492a:	c3                   	ret    
8010492b:	90                   	nop
8010492c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104930:	31 d2                	xor    %edx,%edx
80104932:	85 db                	test   %ebx,%ebx
80104934:	74 f1                	je     80104927 <memmove+0x37>
80104936:	8d 76 00             	lea    0x0(%esi),%esi
80104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104940:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104944:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104947:	83 c2 01             	add    $0x1,%edx
8010494a:	39 d3                	cmp    %edx,%ebx
8010494c:	75 f2                	jne    80104940 <memmove+0x50>
8010494e:	5b                   	pop    %ebx
8010494f:	5e                   	pop    %esi
80104950:	5d                   	pop    %ebp
80104951:	c3                   	ret    
80104952:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104960 <memcpy>:
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	5d                   	pop    %ebp
80104964:	eb 8a                	jmp    801048f0 <memmove>
80104966:	8d 76 00             	lea    0x0(%esi),%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104970 <strncmp>:
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	57                   	push   %edi
80104974:	56                   	push   %esi
80104975:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104978:	53                   	push   %ebx
80104979:	8b 7d 08             	mov    0x8(%ebp),%edi
8010497c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010497f:	85 c9                	test   %ecx,%ecx
80104981:	74 37                	je     801049ba <strncmp+0x4a>
80104983:	0f b6 17             	movzbl (%edi),%edx
80104986:	0f b6 1e             	movzbl (%esi),%ebx
80104989:	84 d2                	test   %dl,%dl
8010498b:	74 3f                	je     801049cc <strncmp+0x5c>
8010498d:	38 d3                	cmp    %dl,%bl
8010498f:	75 3b                	jne    801049cc <strncmp+0x5c>
80104991:	8d 47 01             	lea    0x1(%edi),%eax
80104994:	01 cf                	add    %ecx,%edi
80104996:	eb 1b                	jmp    801049b3 <strncmp+0x43>
80104998:	90                   	nop
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049a0:	0f b6 10             	movzbl (%eax),%edx
801049a3:	84 d2                	test   %dl,%dl
801049a5:	74 21                	je     801049c8 <strncmp+0x58>
801049a7:	0f b6 19             	movzbl (%ecx),%ebx
801049aa:	83 c0 01             	add    $0x1,%eax
801049ad:	89 ce                	mov    %ecx,%esi
801049af:	38 da                	cmp    %bl,%dl
801049b1:	75 19                	jne    801049cc <strncmp+0x5c>
801049b3:	39 c7                	cmp    %eax,%edi
801049b5:	8d 4e 01             	lea    0x1(%esi),%ecx
801049b8:	75 e6                	jne    801049a0 <strncmp+0x30>
801049ba:	5b                   	pop    %ebx
801049bb:	31 c0                	xor    %eax,%eax
801049bd:	5e                   	pop    %esi
801049be:	5f                   	pop    %edi
801049bf:	5d                   	pop    %ebp
801049c0:	c3                   	ret    
801049c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049c8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
801049cc:	0f b6 c2             	movzbl %dl,%eax
801049cf:	29 d8                	sub    %ebx,%eax
801049d1:	5b                   	pop    %ebx
801049d2:	5e                   	pop    %esi
801049d3:	5f                   	pop    %edi
801049d4:	5d                   	pop    %ebp
801049d5:	c3                   	ret    
801049d6:	8d 76 00             	lea    0x0(%esi),%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049e0 <strncpy>:
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	56                   	push   %esi
801049e4:	53                   	push   %ebx
801049e5:	8b 45 08             	mov    0x8(%ebp),%eax
801049e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801049eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801049ee:	89 c2                	mov    %eax,%edx
801049f0:	eb 19                	jmp    80104a0b <strncpy+0x2b>
801049f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049f8:	83 c3 01             	add    $0x1,%ebx
801049fb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801049ff:	83 c2 01             	add    $0x1,%edx
80104a02:	84 c9                	test   %cl,%cl
80104a04:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a07:	74 09                	je     80104a12 <strncpy+0x32>
80104a09:	89 f1                	mov    %esi,%ecx
80104a0b:	85 c9                	test   %ecx,%ecx
80104a0d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104a10:	7f e6                	jg     801049f8 <strncpy+0x18>
80104a12:	31 c9                	xor    %ecx,%ecx
80104a14:	85 f6                	test   %esi,%esi
80104a16:	7e 17                	jle    80104a2f <strncpy+0x4f>
80104a18:	90                   	nop
80104a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a20:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104a24:	89 f3                	mov    %esi,%ebx
80104a26:	83 c1 01             	add    $0x1,%ecx
80104a29:	29 cb                	sub    %ecx,%ebx
80104a2b:	85 db                	test   %ebx,%ebx
80104a2d:	7f f1                	jg     80104a20 <strncpy+0x40>
80104a2f:	5b                   	pop    %ebx
80104a30:	5e                   	pop    %esi
80104a31:	5d                   	pop    %ebp
80104a32:	c3                   	ret    
80104a33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a40 <safestrcpy>:
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	56                   	push   %esi
80104a44:	53                   	push   %ebx
80104a45:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a48:	8b 45 08             	mov    0x8(%ebp),%eax
80104a4b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a4e:	85 c9                	test   %ecx,%ecx
80104a50:	7e 26                	jle    80104a78 <safestrcpy+0x38>
80104a52:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104a56:	89 c1                	mov    %eax,%ecx
80104a58:	eb 17                	jmp    80104a71 <safestrcpy+0x31>
80104a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a60:	83 c2 01             	add    $0x1,%edx
80104a63:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104a67:	83 c1 01             	add    $0x1,%ecx
80104a6a:	84 db                	test   %bl,%bl
80104a6c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104a6f:	74 04                	je     80104a75 <safestrcpy+0x35>
80104a71:	39 f2                	cmp    %esi,%edx
80104a73:	75 eb                	jne    80104a60 <safestrcpy+0x20>
80104a75:	c6 01 00             	movb   $0x0,(%ecx)
80104a78:	5b                   	pop    %ebx
80104a79:	5e                   	pop    %esi
80104a7a:	5d                   	pop    %ebp
80104a7b:	c3                   	ret    
80104a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a80 <strlen>:
80104a80:	55                   	push   %ebp
80104a81:	31 c0                	xor    %eax,%eax
80104a83:	89 e5                	mov    %esp,%ebp
80104a85:	8b 55 08             	mov    0x8(%ebp),%edx
80104a88:	80 3a 00             	cmpb   $0x0,(%edx)
80104a8b:	74 0c                	je     80104a99 <strlen+0x19>
80104a8d:	8d 76 00             	lea    0x0(%esi),%esi
80104a90:	83 c0 01             	add    $0x1,%eax
80104a93:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104a97:	75 f7                	jne    80104a90 <strlen+0x10>
80104a99:	5d                   	pop    %ebp
80104a9a:	c3                   	ret    

80104a9b <swtch>:
80104a9b:	8b 44 24 04          	mov    0x4(%esp),%eax
80104a9f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104aa3:	55                   	push   %ebp
80104aa4:	53                   	push   %ebx
80104aa5:	56                   	push   %esi
80104aa6:	57                   	push   %edi
80104aa7:	89 20                	mov    %esp,(%eax)
80104aa9:	89 d4                	mov    %edx,%esp
80104aab:	5f                   	pop    %edi
80104aac:	5e                   	pop    %esi
80104aad:	5b                   	pop    %ebx
80104aae:	5d                   	pop    %ebp
80104aaf:	c3                   	ret    

80104ab0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	53                   	push   %ebx
80104ab4:	83 ec 04             	sub    $0x4,%esp
80104ab7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104aba:	e8 e1 f0 ff ff       	call   80103ba0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104abf:	8b 00                	mov    (%eax),%eax
80104ac1:	39 d8                	cmp    %ebx,%eax
80104ac3:	76 1b                	jbe    80104ae0 <fetchint+0x30>
80104ac5:	8d 53 04             	lea    0x4(%ebx),%edx
80104ac8:	39 d0                	cmp    %edx,%eax
80104aca:	72 14                	jb     80104ae0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104acc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104acf:	8b 13                	mov    (%ebx),%edx
80104ad1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ad3:	31 c0                	xor    %eax,%eax
}
80104ad5:	83 c4 04             	add    $0x4,%esp
80104ad8:	5b                   	pop    %ebx
80104ad9:	5d                   	pop    %ebp
80104ada:	c3                   	ret    
80104adb:	90                   	nop
80104adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104ae0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ae5:	eb ee                	jmp    80104ad5 <fetchint+0x25>
80104ae7:	89 f6                	mov    %esi,%esi
80104ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104af0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	53                   	push   %ebx
80104af4:	83 ec 04             	sub    $0x4,%esp
80104af7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104afa:	e8 a1 f0 ff ff       	call   80103ba0 <myproc>

  if(addr >= curproc->sz)
80104aff:	39 18                	cmp    %ebx,(%eax)
80104b01:	76 29                	jbe    80104b2c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104b03:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104b06:	89 da                	mov    %ebx,%edx
80104b08:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104b0a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104b0c:	39 c3                	cmp    %eax,%ebx
80104b0e:	73 1c                	jae    80104b2c <fetchstr+0x3c>
    if(*s == 0)
80104b10:	80 3b 00             	cmpb   $0x0,(%ebx)
80104b13:	75 10                	jne    80104b25 <fetchstr+0x35>
80104b15:	eb 29                	jmp    80104b40 <fetchstr+0x50>
80104b17:	89 f6                	mov    %esi,%esi
80104b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b20:	80 3a 00             	cmpb   $0x0,(%edx)
80104b23:	74 1b                	je     80104b40 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104b25:	83 c2 01             	add    $0x1,%edx
80104b28:	39 d0                	cmp    %edx,%eax
80104b2a:	77 f4                	ja     80104b20 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104b2c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
80104b2f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104b34:	5b                   	pop    %ebx
80104b35:	5d                   	pop    %ebp
80104b36:	c3                   	ret    
80104b37:	89 f6                	mov    %esi,%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b40:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104b43:	89 d0                	mov    %edx,%eax
80104b45:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104b47:	5b                   	pop    %ebx
80104b48:	5d                   	pop    %ebp
80104b49:	c3                   	ret    
80104b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b50 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	56                   	push   %esi
80104b54:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b55:	e8 46 f0 ff ff       	call   80103ba0 <myproc>
80104b5a:	8b 40 18             	mov    0x18(%eax),%eax
80104b5d:	8b 55 08             	mov    0x8(%ebp),%edx
80104b60:	8b 40 44             	mov    0x44(%eax),%eax
80104b63:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104b66:	e8 35 f0 ff ff       	call   80103ba0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b6b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b6d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b70:	39 c6                	cmp    %eax,%esi
80104b72:	73 1c                	jae    80104b90 <argint+0x40>
80104b74:	8d 53 08             	lea    0x8(%ebx),%edx
80104b77:	39 d0                	cmp    %edx,%eax
80104b79:	72 15                	jb     80104b90 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
80104b7b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b7e:	8b 53 04             	mov    0x4(%ebx),%edx
80104b81:	89 10                	mov    %edx,(%eax)
  return 0;
80104b83:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104b85:	5b                   	pop    %ebx
80104b86:	5e                   	pop    %esi
80104b87:	5d                   	pop    %ebp
80104b88:	c3                   	ret    
80104b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b95:	eb ee                	jmp    80104b85 <argint+0x35>
80104b97:	89 f6                	mov    %esi,%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ba0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	56                   	push   %esi
80104ba4:	53                   	push   %ebx
80104ba5:	83 ec 10             	sub    $0x10,%esp
80104ba8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104bab:	e8 f0 ef ff ff       	call   80103ba0 <myproc>
80104bb0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104bb2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bb5:	83 ec 08             	sub    $0x8,%esp
80104bb8:	50                   	push   %eax
80104bb9:	ff 75 08             	pushl  0x8(%ebp)
80104bbc:	e8 8f ff ff ff       	call   80104b50 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104bc1:	c1 e8 1f             	shr    $0x1f,%eax
80104bc4:	83 c4 10             	add    $0x10,%esp
80104bc7:	84 c0                	test   %al,%al
80104bc9:	75 2d                	jne    80104bf8 <argptr+0x58>
80104bcb:	89 d8                	mov    %ebx,%eax
80104bcd:	c1 e8 1f             	shr    $0x1f,%eax
80104bd0:	84 c0                	test   %al,%al
80104bd2:	75 24                	jne    80104bf8 <argptr+0x58>
80104bd4:	8b 16                	mov    (%esi),%edx
80104bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd9:	39 c2                	cmp    %eax,%edx
80104bdb:	76 1b                	jbe    80104bf8 <argptr+0x58>
80104bdd:	01 c3                	add    %eax,%ebx
80104bdf:	39 da                	cmp    %ebx,%edx
80104be1:	72 15                	jb     80104bf8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104be3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104be6:	89 02                	mov    %eax,(%edx)
  return 0;
80104be8:	31 c0                	xor    %eax,%eax
}
80104bea:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bed:	5b                   	pop    %ebx
80104bee:	5e                   	pop    %esi
80104bef:	5d                   	pop    %ebp
80104bf0:	c3                   	ret    
80104bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104bf8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bfd:	eb eb                	jmp    80104bea <argptr+0x4a>
80104bff:	90                   	nop

80104c00 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104c00:	55                   	push   %ebp
80104c01:	89 e5                	mov    %esp,%ebp
80104c03:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104c06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c09:	50                   	push   %eax
80104c0a:	ff 75 08             	pushl  0x8(%ebp)
80104c0d:	e8 3e ff ff ff       	call   80104b50 <argint>
80104c12:	83 c4 10             	add    $0x10,%esp
80104c15:	85 c0                	test   %eax,%eax
80104c17:	78 17                	js     80104c30 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104c19:	83 ec 08             	sub    $0x8,%esp
80104c1c:	ff 75 0c             	pushl  0xc(%ebp)
80104c1f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c22:	e8 c9 fe ff ff       	call   80104af0 <fetchstr>
80104c27:	83 c4 10             	add    $0x10,%esp
}
80104c2a:	c9                   	leave  
80104c2b:	c3                   	ret    
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104c35:	c9                   	leave  
80104c36:	c3                   	ret    
80104c37:	89 f6                	mov    %esi,%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <syscall>:
[SYS_get_log_num] sys_get_log_num,
};

void
syscall(void)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	56                   	push   %esi
80104c44:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104c45:	e8 56 ef ff ff       	call   80103ba0 <myproc>

  num = curproc->tf->eax;
80104c4a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104c4d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104c4f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c52:	8d 50 ff             	lea    -0x1(%eax),%edx
80104c55:	83 fa 16             	cmp    $0x16,%edx
80104c58:	77 1e                	ja     80104c78 <syscall+0x38>
80104c5a:	8b 14 85 00 7a 10 80 	mov    -0x7fef8600(,%eax,4),%edx
80104c61:	85 d2                	test   %edx,%edx
80104c63:	74 13                	je     80104c78 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104c65:	ff d2                	call   *%edx
80104c67:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104c6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c6d:	5b                   	pop    %ebx
80104c6e:	5e                   	pop    %esi
80104c6f:	5d                   	pop    %ebp
80104c70:	c3                   	ret    
80104c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104c78:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104c79:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104c7c:	50                   	push   %eax
80104c7d:	ff 73 10             	pushl  0x10(%ebx)
80104c80:	68 d1 79 10 80       	push   $0x801079d1
80104c85:	e8 d6 b9 ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104c8a:	8b 43 18             	mov    0x18(%ebx),%eax
80104c8d:	83 c4 10             	add    $0x10,%esp
80104c90:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104c97:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c9a:	5b                   	pop    %ebx
80104c9b:	5e                   	pop    %esi
80104c9c:	5d                   	pop    %ebp
80104c9d:	c3                   	ret    
80104c9e:	66 90                	xchg   %ax,%ax

80104ca0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	57                   	push   %edi
80104ca4:	56                   	push   %esi
80104ca5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ca6:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ca9:	83 ec 44             	sub    $0x44,%esp
80104cac:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104caf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104cb2:	56                   	push   %esi
80104cb3:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104cb4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104cb7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104cba:	e8 e1 d5 ff ff       	call   801022a0 <nameiparent>
80104cbf:	83 c4 10             	add    $0x10,%esp
80104cc2:	85 c0                	test   %eax,%eax
80104cc4:	0f 84 f6 00 00 00    	je     80104dc0 <create+0x120>
    return 0;
  ilock(dp);
80104cca:	83 ec 0c             	sub    $0xc,%esp
80104ccd:	89 c7                	mov    %eax,%edi
80104ccf:	50                   	push   %eax
80104cd0:	e8 6b cb ff ff       	call   80101840 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104cd5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104cd8:	83 c4 0c             	add    $0xc,%esp
80104cdb:	50                   	push   %eax
80104cdc:	56                   	push   %esi
80104cdd:	57                   	push   %edi
80104cde:	e8 7d d2 ff ff       	call   80101f60 <dirlookup>
80104ce3:	83 c4 10             	add    $0x10,%esp
80104ce6:	85 c0                	test   %eax,%eax
80104ce8:	89 c3                	mov    %eax,%ebx
80104cea:	74 54                	je     80104d40 <create+0xa0>
    iunlockput(dp);
80104cec:	83 ec 0c             	sub    $0xc,%esp
80104cef:	57                   	push   %edi
80104cf0:	e8 cb cf ff ff       	call   80101cc0 <iunlockput>
    ilock(ip);
80104cf5:	89 1c 24             	mov    %ebx,(%esp)
80104cf8:	e8 43 cb ff ff       	call   80101840 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104cfd:	83 c4 10             	add    $0x10,%esp
80104d00:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104d05:	75 19                	jne    80104d20 <create+0x80>
80104d07:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104d0c:	89 d8                	mov    %ebx,%eax
80104d0e:	75 10                	jne    80104d20 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d13:	5b                   	pop    %ebx
80104d14:	5e                   	pop    %esi
80104d15:	5f                   	pop    %edi
80104d16:	5d                   	pop    %ebp
80104d17:	c3                   	ret    
80104d18:	90                   	nop
80104d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104d20:	83 ec 0c             	sub    $0xc,%esp
80104d23:	53                   	push   %ebx
80104d24:	e8 97 cf ff ff       	call   80101cc0 <iunlockput>
    return 0;
80104d29:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104d2f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d31:	5b                   	pop    %ebx
80104d32:	5e                   	pop    %esi
80104d33:	5f                   	pop    %edi
80104d34:	5d                   	pop    %ebp
80104d35:	c3                   	ret    
80104d36:	8d 76 00             	lea    0x0(%esi),%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104d40:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104d44:	83 ec 08             	sub    $0x8,%esp
80104d47:	50                   	push   %eax
80104d48:	ff 37                	pushl  (%edi)
80104d4a:	e8 81 c9 ff ff       	call   801016d0 <ialloc>
80104d4f:	83 c4 10             	add    $0x10,%esp
80104d52:	85 c0                	test   %eax,%eax
80104d54:	89 c3                	mov    %eax,%ebx
80104d56:	0f 84 cc 00 00 00    	je     80104e28 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104d5c:	83 ec 0c             	sub    $0xc,%esp
80104d5f:	50                   	push   %eax
80104d60:	e8 db ca ff ff       	call   80101840 <ilock>
  ip->major = major;
80104d65:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104d69:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104d6d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104d71:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104d75:	b8 01 00 00 00       	mov    $0x1,%eax
80104d7a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104d7e:	89 1c 24             	mov    %ebx,(%esp)
80104d81:	e8 0a ca ff ff       	call   80101790 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104d86:	83 c4 10             	add    $0x10,%esp
80104d89:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104d8e:	74 40                	je     80104dd0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104d90:	83 ec 04             	sub    $0x4,%esp
80104d93:	ff 73 04             	pushl  0x4(%ebx)
80104d96:	56                   	push   %esi
80104d97:	57                   	push   %edi
80104d98:	e8 23 d4 ff ff       	call   801021c0 <dirlink>
80104d9d:	83 c4 10             	add    $0x10,%esp
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 77                	js     80104e1b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104da4:	83 ec 0c             	sub    $0xc,%esp
80104da7:	57                   	push   %edi
80104da8:	e8 13 cf ff ff       	call   80101cc0 <iunlockput>

  return ip;
80104dad:	83 c4 10             	add    $0x10,%esp
}
80104db0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104db3:	89 d8                	mov    %ebx,%eax
}
80104db5:	5b                   	pop    %ebx
80104db6:	5e                   	pop    %esi
80104db7:	5f                   	pop    %edi
80104db8:	5d                   	pop    %ebp
80104db9:	c3                   	ret    
80104dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104dc0:	31 c0                	xor    %eax,%eax
80104dc2:	e9 49 ff ff ff       	jmp    80104d10 <create+0x70>
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104dd0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104dd5:	83 ec 0c             	sub    $0xc,%esp
80104dd8:	57                   	push   %edi
80104dd9:	e8 b2 c9 ff ff       	call   80101790 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104dde:	83 c4 0c             	add    $0xc,%esp
80104de1:	ff 73 04             	pushl  0x4(%ebx)
80104de4:	68 7c 7a 10 80       	push   $0x80107a7c
80104de9:	53                   	push   %ebx
80104dea:	e8 d1 d3 ff ff       	call   801021c0 <dirlink>
80104def:	83 c4 10             	add    $0x10,%esp
80104df2:	85 c0                	test   %eax,%eax
80104df4:	78 18                	js     80104e0e <create+0x16e>
80104df6:	83 ec 04             	sub    $0x4,%esp
80104df9:	ff 77 04             	pushl  0x4(%edi)
80104dfc:	68 7b 7a 10 80       	push   $0x80107a7b
80104e01:	53                   	push   %ebx
80104e02:	e8 b9 d3 ff ff       	call   801021c0 <dirlink>
80104e07:	83 c4 10             	add    $0x10,%esp
80104e0a:	85 c0                	test   %eax,%eax
80104e0c:	79 82                	jns    80104d90 <create+0xf0>
      panic("create dots");
80104e0e:	83 ec 0c             	sub    $0xc,%esp
80104e11:	68 6f 7a 10 80       	push   $0x80107a6f
80104e16:	e8 55 b5 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104e1b:	83 ec 0c             	sub    $0xc,%esp
80104e1e:	68 7e 7a 10 80       	push   $0x80107a7e
80104e23:	e8 48 b5 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104e28:	83 ec 0c             	sub    $0xc,%esp
80104e2b:	68 60 7a 10 80       	push   $0x80107a60
80104e30:	e8 3b b5 ff ff       	call   80100370 <panic>
80104e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e40 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	56                   	push   %esi
80104e44:	53                   	push   %ebx
80104e45:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104e47:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104e4a:	89 d3                	mov    %edx,%ebx
80104e4c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104e4f:	50                   	push   %eax
80104e50:	6a 00                	push   $0x0
80104e52:	e8 f9 fc ff ff       	call   80104b50 <argint>
80104e57:	83 c4 10             	add    $0x10,%esp
80104e5a:	85 c0                	test   %eax,%eax
80104e5c:	78 32                	js     80104e90 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e5e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e62:	77 2c                	ja     80104e90 <argfd.constprop.0+0x50>
80104e64:	e8 37 ed ff ff       	call   80103ba0 <myproc>
80104e69:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e6c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104e70:	85 c0                	test   %eax,%eax
80104e72:	74 1c                	je     80104e90 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104e74:	85 f6                	test   %esi,%esi
80104e76:	74 02                	je     80104e7a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104e78:	89 16                	mov    %edx,(%esi)
  if(pf)
80104e7a:	85 db                	test   %ebx,%ebx
80104e7c:	74 22                	je     80104ea0 <argfd.constprop.0+0x60>
    *pf = f;
80104e7e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104e80:	31 c0                	xor    %eax,%eax
}
80104e82:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e85:	5b                   	pop    %ebx
80104e86:	5e                   	pop    %esi
80104e87:	5d                   	pop    %ebp
80104e88:	c3                   	ret    
80104e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e90:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104e93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104e98:	5b                   	pop    %ebx
80104e99:	5e                   	pop    %esi
80104e9a:	5d                   	pop    %ebp
80104e9b:	c3                   	ret    
80104e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104ea0:	31 c0                	xor    %eax,%eax
80104ea2:	eb de                	jmp    80104e82 <argfd.constprop.0+0x42>
80104ea4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104eaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104eb0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104eb0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104eb1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104eb3:	89 e5                	mov    %esp,%ebp
80104eb5:	56                   	push   %esi
80104eb6:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104eb7:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104eba:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104ebd:	e8 7e ff ff ff       	call   80104e40 <argfd.constprop.0>
80104ec2:	85 c0                	test   %eax,%eax
80104ec4:	78 1a                	js     80104ee0 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104ec6:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104ec8:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104ecb:	e8 d0 ec ff ff       	call   80103ba0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104ed0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ed4:	85 d2                	test   %edx,%edx
80104ed6:	74 18                	je     80104ef0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104ed8:	83 c3 01             	add    $0x1,%ebx
80104edb:	83 fb 10             	cmp    $0x10,%ebx
80104ede:	75 f0                	jne    80104ed0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104ee0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104ee3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104ee8:	5b                   	pop    %ebx
80104ee9:	5e                   	pop    %esi
80104eea:	5d                   	pop    %ebp
80104eeb:	c3                   	ret    
80104eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104ef0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104ef4:	83 ec 0c             	sub    $0xc,%esp
80104ef7:	ff 75 f4             	pushl  -0xc(%ebp)
80104efa:	e8 e1 be ff ff       	call   80100de0 <filedup>
  return fd;
80104eff:	83 c4 10             	add    $0x10,%esp
}
80104f02:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104f05:	89 d8                	mov    %ebx,%eax
}
80104f07:	5b                   	pop    %ebx
80104f08:	5e                   	pop    %esi
80104f09:	5d                   	pop    %ebp
80104f0a:	c3                   	ret    
80104f0b:	90                   	nop
80104f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f10 <sys_read>:

int
sys_read(void)
{
80104f10:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f11:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104f13:	89 e5                	mov    %esp,%ebp
80104f15:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f18:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f1b:	e8 20 ff ff ff       	call   80104e40 <argfd.constprop.0>
80104f20:	85 c0                	test   %eax,%eax
80104f22:	78 4c                	js     80104f70 <sys_read+0x60>
80104f24:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f27:	83 ec 08             	sub    $0x8,%esp
80104f2a:	50                   	push   %eax
80104f2b:	6a 02                	push   $0x2
80104f2d:	e8 1e fc ff ff       	call   80104b50 <argint>
80104f32:	83 c4 10             	add    $0x10,%esp
80104f35:	85 c0                	test   %eax,%eax
80104f37:	78 37                	js     80104f70 <sys_read+0x60>
80104f39:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f3c:	83 ec 04             	sub    $0x4,%esp
80104f3f:	ff 75 f0             	pushl  -0x10(%ebp)
80104f42:	50                   	push   %eax
80104f43:	6a 01                	push   $0x1
80104f45:	e8 56 fc ff ff       	call   80104ba0 <argptr>
80104f4a:	83 c4 10             	add    $0x10,%esp
80104f4d:	85 c0                	test   %eax,%eax
80104f4f:	78 1f                	js     80104f70 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104f51:	83 ec 04             	sub    $0x4,%esp
80104f54:	ff 75 f0             	pushl  -0x10(%ebp)
80104f57:	ff 75 f4             	pushl  -0xc(%ebp)
80104f5a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f5d:	e8 ee bf ff ff       	call   80100f50 <fileread>
80104f62:	83 c4 10             	add    $0x10,%esp
}
80104f65:	c9                   	leave  
80104f66:	c3                   	ret    
80104f67:	89 f6                	mov    %esi,%esi
80104f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104f75:	c9                   	leave  
80104f76:	c3                   	ret    
80104f77:	89 f6                	mov    %esi,%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f80 <sys_write>:

int
sys_write(void)
{
80104f80:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f81:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104f83:	89 e5                	mov    %esp,%ebp
80104f85:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f88:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f8b:	e8 b0 fe ff ff       	call   80104e40 <argfd.constprop.0>
80104f90:	85 c0                	test   %eax,%eax
80104f92:	78 4c                	js     80104fe0 <sys_write+0x60>
80104f94:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f97:	83 ec 08             	sub    $0x8,%esp
80104f9a:	50                   	push   %eax
80104f9b:	6a 02                	push   $0x2
80104f9d:	e8 ae fb ff ff       	call   80104b50 <argint>
80104fa2:	83 c4 10             	add    $0x10,%esp
80104fa5:	85 c0                	test   %eax,%eax
80104fa7:	78 37                	js     80104fe0 <sys_write+0x60>
80104fa9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fac:	83 ec 04             	sub    $0x4,%esp
80104faf:	ff 75 f0             	pushl  -0x10(%ebp)
80104fb2:	50                   	push   %eax
80104fb3:	6a 01                	push   $0x1
80104fb5:	e8 e6 fb ff ff       	call   80104ba0 <argptr>
80104fba:	83 c4 10             	add    $0x10,%esp
80104fbd:	85 c0                	test   %eax,%eax
80104fbf:	78 1f                	js     80104fe0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104fc1:	83 ec 04             	sub    $0x4,%esp
80104fc4:	ff 75 f0             	pushl  -0x10(%ebp)
80104fc7:	ff 75 f4             	pushl  -0xc(%ebp)
80104fca:	ff 75 ec             	pushl  -0x14(%ebp)
80104fcd:	e8 0e c0 ff ff       	call   80100fe0 <filewrite>
80104fd2:	83 c4 10             	add    $0x10,%esp
}
80104fd5:	c9                   	leave  
80104fd6:	c3                   	ret    
80104fd7:	89 f6                	mov    %esi,%esi
80104fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104fe5:	c9                   	leave  
80104fe6:	c3                   	ret    
80104fe7:	89 f6                	mov    %esi,%esi
80104fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ff0 <sys_close>:

int
sys_close(void)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104ff6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ff9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ffc:	e8 3f fe ff ff       	call   80104e40 <argfd.constprop.0>
80105001:	85 c0                	test   %eax,%eax
80105003:	78 2b                	js     80105030 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105005:	e8 96 eb ff ff       	call   80103ba0 <myproc>
8010500a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010500d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80105010:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105017:	00 
  fileclose(f);
80105018:	ff 75 f4             	pushl  -0xc(%ebp)
8010501b:	e8 10 be ff ff       	call   80100e30 <fileclose>
  return 0;
80105020:	83 c4 10             	add    $0x10,%esp
80105023:	31 c0                	xor    %eax,%eax
}
80105025:	c9                   	leave  
80105026:	c3                   	ret    
80105027:	89 f6                	mov    %esi,%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80105030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80105035:	c9                   	leave  
80105036:	c3                   	ret    
80105037:	89 f6                	mov    %esi,%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105040 <sys_fstat>:

int
sys_fstat(void)
{
80105040:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105041:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80105043:	89 e5                	mov    %esp,%ebp
80105045:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105048:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010504b:	e8 f0 fd ff ff       	call   80104e40 <argfd.constprop.0>
80105050:	85 c0                	test   %eax,%eax
80105052:	78 2c                	js     80105080 <sys_fstat+0x40>
80105054:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105057:	83 ec 04             	sub    $0x4,%esp
8010505a:	6a 14                	push   $0x14
8010505c:	50                   	push   %eax
8010505d:	6a 01                	push   $0x1
8010505f:	e8 3c fb ff ff       	call   80104ba0 <argptr>
80105064:	83 c4 10             	add    $0x10,%esp
80105067:	85 c0                	test   %eax,%eax
80105069:	78 15                	js     80105080 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
8010506b:	83 ec 08             	sub    $0x8,%esp
8010506e:	ff 75 f4             	pushl  -0xc(%ebp)
80105071:	ff 75 f0             	pushl  -0x10(%ebp)
80105074:	e8 87 be ff ff       	call   80100f00 <filestat>
80105079:	83 c4 10             	add    $0x10,%esp
}
8010507c:	c9                   	leave  
8010507d:	c3                   	ret    
8010507e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80105080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80105085:	c9                   	leave  
80105086:	c3                   	ret    
80105087:	89 f6                	mov    %esi,%esi
80105089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105090 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	57                   	push   %edi
80105094:	56                   	push   %esi
80105095:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105096:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105099:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010509c:	50                   	push   %eax
8010509d:	6a 00                	push   $0x0
8010509f:	e8 5c fb ff ff       	call   80104c00 <argstr>
801050a4:	83 c4 10             	add    $0x10,%esp
801050a7:	85 c0                	test   %eax,%eax
801050a9:	0f 88 fb 00 00 00    	js     801051aa <sys_link+0x11a>
801050af:	8d 45 d0             	lea    -0x30(%ebp),%eax
801050b2:	83 ec 08             	sub    $0x8,%esp
801050b5:	50                   	push   %eax
801050b6:	6a 01                	push   $0x1
801050b8:	e8 43 fb ff ff       	call   80104c00 <argstr>
801050bd:	83 c4 10             	add    $0x10,%esp
801050c0:	85 c0                	test   %eax,%eax
801050c2:	0f 88 e2 00 00 00    	js     801051aa <sys_link+0x11a>
    return -1;

  begin_op();
801050c8:	e8 e3 de ff ff       	call   80102fb0 <begin_op>
  if((ip = namei(old)) == 0){
801050cd:	83 ec 0c             	sub    $0xc,%esp
801050d0:	ff 75 d4             	pushl  -0x2c(%ebp)
801050d3:	e8 a8 d1 ff ff       	call   80102280 <namei>
801050d8:	83 c4 10             	add    $0x10,%esp
801050db:	85 c0                	test   %eax,%eax
801050dd:	89 c3                	mov    %eax,%ebx
801050df:	0f 84 f3 00 00 00    	je     801051d8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
801050e5:	83 ec 0c             	sub    $0xc,%esp
801050e8:	50                   	push   %eax
801050e9:	e8 52 c7 ff ff       	call   80101840 <ilock>
  if(ip->type == T_DIR){
801050ee:	83 c4 10             	add    $0x10,%esp
801050f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050f6:	0f 84 c4 00 00 00    	je     801051c0 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
801050fc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105101:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105104:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80105107:	53                   	push   %ebx
80105108:	e8 83 c6 ff ff       	call   80101790 <iupdate>
  iunlock(ip);
8010510d:	89 1c 24             	mov    %ebx,(%esp)
80105110:	e8 0b c8 ff ff       	call   80101920 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105115:	58                   	pop    %eax
80105116:	5a                   	pop    %edx
80105117:	57                   	push   %edi
80105118:	ff 75 d0             	pushl  -0x30(%ebp)
8010511b:	e8 80 d1 ff ff       	call   801022a0 <nameiparent>
80105120:	83 c4 10             	add    $0x10,%esp
80105123:	85 c0                	test   %eax,%eax
80105125:	89 c6                	mov    %eax,%esi
80105127:	74 5b                	je     80105184 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105129:	83 ec 0c             	sub    $0xc,%esp
8010512c:	50                   	push   %eax
8010512d:	e8 0e c7 ff ff       	call   80101840 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105132:	83 c4 10             	add    $0x10,%esp
80105135:	8b 03                	mov    (%ebx),%eax
80105137:	39 06                	cmp    %eax,(%esi)
80105139:	75 3d                	jne    80105178 <sys_link+0xe8>
8010513b:	83 ec 04             	sub    $0x4,%esp
8010513e:	ff 73 04             	pushl  0x4(%ebx)
80105141:	57                   	push   %edi
80105142:	56                   	push   %esi
80105143:	e8 78 d0 ff ff       	call   801021c0 <dirlink>
80105148:	83 c4 10             	add    $0x10,%esp
8010514b:	85 c0                	test   %eax,%eax
8010514d:	78 29                	js     80105178 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010514f:	83 ec 0c             	sub    $0xc,%esp
80105152:	56                   	push   %esi
80105153:	e8 68 cb ff ff       	call   80101cc0 <iunlockput>
  iput(ip);
80105158:	89 1c 24             	mov    %ebx,(%esp)
8010515b:	e8 10 c8 ff ff       	call   80101970 <iput>

  end_op();
80105160:	e8 bb de ff ff       	call   80103020 <end_op>

  return 0;
80105165:	83 c4 10             	add    $0x10,%esp
80105168:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010516a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010516d:	5b                   	pop    %ebx
8010516e:	5e                   	pop    %esi
8010516f:	5f                   	pop    %edi
80105170:	5d                   	pop    %ebp
80105171:	c3                   	ret    
80105172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80105178:	83 ec 0c             	sub    $0xc,%esp
8010517b:	56                   	push   %esi
8010517c:	e8 3f cb ff ff       	call   80101cc0 <iunlockput>
    goto bad;
80105181:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105184:	83 ec 0c             	sub    $0xc,%esp
80105187:	53                   	push   %ebx
80105188:	e8 b3 c6 ff ff       	call   80101840 <ilock>
  ip->nlink--;
8010518d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105192:	89 1c 24             	mov    %ebx,(%esp)
80105195:	e8 f6 c5 ff ff       	call   80101790 <iupdate>
  iunlockput(ip);
8010519a:	89 1c 24             	mov    %ebx,(%esp)
8010519d:	e8 1e cb ff ff       	call   80101cc0 <iunlockput>
  end_op();
801051a2:	e8 79 de ff ff       	call   80103020 <end_op>
  return -1;
801051a7:	83 c4 10             	add    $0x10,%esp
}
801051aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
801051ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051b2:	5b                   	pop    %ebx
801051b3:	5e                   	pop    %esi
801051b4:	5f                   	pop    %edi
801051b5:	5d                   	pop    %ebp
801051b6:	c3                   	ret    
801051b7:	89 f6                	mov    %esi,%esi
801051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
801051c0:	83 ec 0c             	sub    $0xc,%esp
801051c3:	53                   	push   %ebx
801051c4:	e8 f7 ca ff ff       	call   80101cc0 <iunlockput>
    end_op();
801051c9:	e8 52 de ff ff       	call   80103020 <end_op>
    return -1;
801051ce:	83 c4 10             	add    $0x10,%esp
801051d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051d6:	eb 92                	jmp    8010516a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
801051d8:	e8 43 de ff ff       	call   80103020 <end_op>
    return -1;
801051dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051e2:	eb 86                	jmp    8010516a <sys_link+0xda>
801051e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801051f0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	57                   	push   %edi
801051f4:	56                   	push   %esi
801051f5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801051f6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
801051f9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801051fc:	50                   	push   %eax
801051fd:	6a 00                	push   $0x0
801051ff:	e8 fc f9 ff ff       	call   80104c00 <argstr>
80105204:	83 c4 10             	add    $0x10,%esp
80105207:	85 c0                	test   %eax,%eax
80105209:	0f 88 82 01 00 00    	js     80105391 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010520f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105212:	e8 99 dd ff ff       	call   80102fb0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105217:	83 ec 08             	sub    $0x8,%esp
8010521a:	53                   	push   %ebx
8010521b:	ff 75 c0             	pushl  -0x40(%ebp)
8010521e:	e8 7d d0 ff ff       	call   801022a0 <nameiparent>
80105223:	83 c4 10             	add    $0x10,%esp
80105226:	85 c0                	test   %eax,%eax
80105228:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010522b:	0f 84 6a 01 00 00    	je     8010539b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105231:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105234:	83 ec 0c             	sub    $0xc,%esp
80105237:	56                   	push   %esi
80105238:	e8 03 c6 ff ff       	call   80101840 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010523d:	58                   	pop    %eax
8010523e:	5a                   	pop    %edx
8010523f:	68 7c 7a 10 80       	push   $0x80107a7c
80105244:	53                   	push   %ebx
80105245:	e8 f6 cc ff ff       	call   80101f40 <namecmp>
8010524a:	83 c4 10             	add    $0x10,%esp
8010524d:	85 c0                	test   %eax,%eax
8010524f:	0f 84 fc 00 00 00    	je     80105351 <sys_unlink+0x161>
80105255:	83 ec 08             	sub    $0x8,%esp
80105258:	68 7b 7a 10 80       	push   $0x80107a7b
8010525d:	53                   	push   %ebx
8010525e:	e8 dd cc ff ff       	call   80101f40 <namecmp>
80105263:	83 c4 10             	add    $0x10,%esp
80105266:	85 c0                	test   %eax,%eax
80105268:	0f 84 e3 00 00 00    	je     80105351 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010526e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105271:	83 ec 04             	sub    $0x4,%esp
80105274:	50                   	push   %eax
80105275:	53                   	push   %ebx
80105276:	56                   	push   %esi
80105277:	e8 e4 cc ff ff       	call   80101f60 <dirlookup>
8010527c:	83 c4 10             	add    $0x10,%esp
8010527f:	85 c0                	test   %eax,%eax
80105281:	89 c3                	mov    %eax,%ebx
80105283:	0f 84 c8 00 00 00    	je     80105351 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105289:	83 ec 0c             	sub    $0xc,%esp
8010528c:	50                   	push   %eax
8010528d:	e8 ae c5 ff ff       	call   80101840 <ilock>

  if(ip->nlink < 1)
80105292:	83 c4 10             	add    $0x10,%esp
80105295:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010529a:	0f 8e 24 01 00 00    	jle    801053c4 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801052a0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052a5:	8d 75 d8             	lea    -0x28(%ebp),%esi
801052a8:	74 66                	je     80105310 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801052aa:	83 ec 04             	sub    $0x4,%esp
801052ad:	6a 10                	push   $0x10
801052af:	6a 00                	push   $0x0
801052b1:	56                   	push   %esi
801052b2:	e8 89 f5 ff ff       	call   80104840 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052b7:	6a 10                	push   $0x10
801052b9:	ff 75 c4             	pushl  -0x3c(%ebp)
801052bc:	56                   	push   %esi
801052bd:	ff 75 b4             	pushl  -0x4c(%ebp)
801052c0:	e8 4b cb ff ff       	call   80101e10 <writei>
801052c5:	83 c4 20             	add    $0x20,%esp
801052c8:	83 f8 10             	cmp    $0x10,%eax
801052cb:	0f 85 e6 00 00 00    	jne    801053b7 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801052d1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052d6:	0f 84 9c 00 00 00    	je     80105378 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801052dc:	83 ec 0c             	sub    $0xc,%esp
801052df:	ff 75 b4             	pushl  -0x4c(%ebp)
801052e2:	e8 d9 c9 ff ff       	call   80101cc0 <iunlockput>

  ip->nlink--;
801052e7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801052ec:	89 1c 24             	mov    %ebx,(%esp)
801052ef:	e8 9c c4 ff ff       	call   80101790 <iupdate>
  iunlockput(ip);
801052f4:	89 1c 24             	mov    %ebx,(%esp)
801052f7:	e8 c4 c9 ff ff       	call   80101cc0 <iunlockput>

  end_op();
801052fc:	e8 1f dd ff ff       	call   80103020 <end_op>

  return 0;
80105301:	83 c4 10             	add    $0x10,%esp
80105304:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105306:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105309:	5b                   	pop    %ebx
8010530a:	5e                   	pop    %esi
8010530b:	5f                   	pop    %edi
8010530c:	5d                   	pop    %ebp
8010530d:	c3                   	ret    
8010530e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105310:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105314:	76 94                	jbe    801052aa <sys_unlink+0xba>
80105316:	bf 20 00 00 00       	mov    $0x20,%edi
8010531b:	eb 0f                	jmp    8010532c <sys_unlink+0x13c>
8010531d:	8d 76 00             	lea    0x0(%esi),%esi
80105320:	83 c7 10             	add    $0x10,%edi
80105323:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105326:	0f 83 7e ff ff ff    	jae    801052aa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010532c:	6a 10                	push   $0x10
8010532e:	57                   	push   %edi
8010532f:	56                   	push   %esi
80105330:	53                   	push   %ebx
80105331:	e8 da c9 ff ff       	call   80101d10 <readi>
80105336:	83 c4 10             	add    $0x10,%esp
80105339:	83 f8 10             	cmp    $0x10,%eax
8010533c:	75 6c                	jne    801053aa <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010533e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105343:	74 db                	je     80105320 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105345:	83 ec 0c             	sub    $0xc,%esp
80105348:	53                   	push   %ebx
80105349:	e8 72 c9 ff ff       	call   80101cc0 <iunlockput>
    goto bad;
8010534e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105351:	83 ec 0c             	sub    $0xc,%esp
80105354:	ff 75 b4             	pushl  -0x4c(%ebp)
80105357:	e8 64 c9 ff ff       	call   80101cc0 <iunlockput>
  end_op();
8010535c:	e8 bf dc ff ff       	call   80103020 <end_op>
  return -1;
80105361:	83 c4 10             	add    $0x10,%esp
}
80105364:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105367:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010536c:	5b                   	pop    %ebx
8010536d:	5e                   	pop    %esi
8010536e:	5f                   	pop    %edi
8010536f:	5d                   	pop    %ebp
80105370:	c3                   	ret    
80105371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105378:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010537b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010537e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105383:	50                   	push   %eax
80105384:	e8 07 c4 ff ff       	call   80101790 <iupdate>
80105389:	83 c4 10             	add    $0x10,%esp
8010538c:	e9 4b ff ff ff       	jmp    801052dc <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105391:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105396:	e9 6b ff ff ff       	jmp    80105306 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010539b:	e8 80 dc ff ff       	call   80103020 <end_op>
    return -1;
801053a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053a5:	e9 5c ff ff ff       	jmp    80105306 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801053aa:	83 ec 0c             	sub    $0xc,%esp
801053ad:	68 a0 7a 10 80       	push   $0x80107aa0
801053b2:	e8 b9 af ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801053b7:	83 ec 0c             	sub    $0xc,%esp
801053ba:	68 b2 7a 10 80       	push   $0x80107ab2
801053bf:	e8 ac af ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801053c4:	83 ec 0c             	sub    $0xc,%esp
801053c7:	68 8e 7a 10 80       	push   $0x80107a8e
801053cc:	e8 9f af ff ff       	call   80100370 <panic>
801053d1:	eb 0d                	jmp    801053e0 <sys_open>
801053d3:	90                   	nop
801053d4:	90                   	nop
801053d5:	90                   	nop
801053d6:	90                   	nop
801053d7:	90                   	nop
801053d8:	90                   	nop
801053d9:	90                   	nop
801053da:	90                   	nop
801053db:	90                   	nop
801053dc:	90                   	nop
801053dd:	90                   	nop
801053de:	90                   	nop
801053df:	90                   	nop

801053e0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	57                   	push   %edi
801053e4:	56                   	push   %esi
801053e5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801053e6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
801053e9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801053ec:	50                   	push   %eax
801053ed:	6a 00                	push   $0x0
801053ef:	e8 0c f8 ff ff       	call   80104c00 <argstr>
801053f4:	83 c4 10             	add    $0x10,%esp
801053f7:	85 c0                	test   %eax,%eax
801053f9:	0f 88 9e 00 00 00    	js     8010549d <sys_open+0xbd>
801053ff:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105402:	83 ec 08             	sub    $0x8,%esp
80105405:	50                   	push   %eax
80105406:	6a 01                	push   $0x1
80105408:	e8 43 f7 ff ff       	call   80104b50 <argint>
8010540d:	83 c4 10             	add    $0x10,%esp
80105410:	85 c0                	test   %eax,%eax
80105412:	0f 88 85 00 00 00    	js     8010549d <sys_open+0xbd>
    return -1;

  begin_op();
80105418:	e8 93 db ff ff       	call   80102fb0 <begin_op>

  if(omode & O_CREATE){
8010541d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105421:	0f 85 89 00 00 00    	jne    801054b0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105427:	83 ec 0c             	sub    $0xc,%esp
8010542a:	ff 75 e0             	pushl  -0x20(%ebp)
8010542d:	e8 4e ce ff ff       	call   80102280 <namei>
80105432:	83 c4 10             	add    $0x10,%esp
80105435:	85 c0                	test   %eax,%eax
80105437:	89 c6                	mov    %eax,%esi
80105439:	0f 84 8e 00 00 00    	je     801054cd <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010543f:	83 ec 0c             	sub    $0xc,%esp
80105442:	50                   	push   %eax
80105443:	e8 f8 c3 ff ff       	call   80101840 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105448:	83 c4 10             	add    $0x10,%esp
8010544b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105450:	0f 84 d2 00 00 00    	je     80105528 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105456:	e8 15 b9 ff ff       	call   80100d70 <filealloc>
8010545b:	85 c0                	test   %eax,%eax
8010545d:	89 c7                	mov    %eax,%edi
8010545f:	74 2b                	je     8010548c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105461:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105463:	e8 38 e7 ff ff       	call   80103ba0 <myproc>
80105468:	90                   	nop
80105469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105470:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105474:	85 d2                	test   %edx,%edx
80105476:	74 68                	je     801054e0 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105478:	83 c3 01             	add    $0x1,%ebx
8010547b:	83 fb 10             	cmp    $0x10,%ebx
8010547e:	75 f0                	jne    80105470 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105480:	83 ec 0c             	sub    $0xc,%esp
80105483:	57                   	push   %edi
80105484:	e8 a7 b9 ff ff       	call   80100e30 <fileclose>
80105489:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010548c:	83 ec 0c             	sub    $0xc,%esp
8010548f:	56                   	push   %esi
80105490:	e8 2b c8 ff ff       	call   80101cc0 <iunlockput>
    end_op();
80105495:	e8 86 db ff ff       	call   80103020 <end_op>
    return -1;
8010549a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010549d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801054a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801054a5:	5b                   	pop    %ebx
801054a6:	5e                   	pop    %esi
801054a7:	5f                   	pop    %edi
801054a8:	5d                   	pop    %ebp
801054a9:	c3                   	ret    
801054aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801054b0:	83 ec 0c             	sub    $0xc,%esp
801054b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801054b6:	31 c9                	xor    %ecx,%ecx
801054b8:	6a 00                	push   $0x0
801054ba:	ba 02 00 00 00       	mov    $0x2,%edx
801054bf:	e8 dc f7 ff ff       	call   80104ca0 <create>
    if(ip == 0){
801054c4:	83 c4 10             	add    $0x10,%esp
801054c7:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801054c9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801054cb:	75 89                	jne    80105456 <sys_open+0x76>
      end_op();
801054cd:	e8 4e db ff ff       	call   80103020 <end_op>
      return -1;
801054d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054d7:	eb 43                	jmp    8010551c <sys_open+0x13c>
801054d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054e0:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801054e3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054e7:	56                   	push   %esi
801054e8:	e8 33 c4 ff ff       	call   80101920 <iunlock>
  end_op();
801054ed:	e8 2e db ff ff       	call   80103020 <end_op>

  f->type = FD_INODE;
801054f2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801054f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054fb:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801054fe:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105501:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105508:	89 d0                	mov    %edx,%eax
8010550a:	83 e0 01             	and    $0x1,%eax
8010550d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105510:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105513:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105516:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
8010551a:	89 d8                	mov    %ebx,%eax
}
8010551c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010551f:	5b                   	pop    %ebx
80105520:	5e                   	pop    %esi
80105521:	5f                   	pop    %edi
80105522:	5d                   	pop    %ebp
80105523:	c3                   	ret    
80105524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105528:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010552b:	85 c9                	test   %ecx,%ecx
8010552d:	0f 84 23 ff ff ff    	je     80105456 <sys_open+0x76>
80105533:	e9 54 ff ff ff       	jmp    8010548c <sys_open+0xac>
80105538:	90                   	nop
80105539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105540 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105546:	e8 65 da ff ff       	call   80102fb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010554b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010554e:	83 ec 08             	sub    $0x8,%esp
80105551:	50                   	push   %eax
80105552:	6a 00                	push   $0x0
80105554:	e8 a7 f6 ff ff       	call   80104c00 <argstr>
80105559:	83 c4 10             	add    $0x10,%esp
8010555c:	85 c0                	test   %eax,%eax
8010555e:	78 30                	js     80105590 <sys_mkdir+0x50>
80105560:	83 ec 0c             	sub    $0xc,%esp
80105563:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105566:	31 c9                	xor    %ecx,%ecx
80105568:	6a 00                	push   $0x0
8010556a:	ba 01 00 00 00       	mov    $0x1,%edx
8010556f:	e8 2c f7 ff ff       	call   80104ca0 <create>
80105574:	83 c4 10             	add    $0x10,%esp
80105577:	85 c0                	test   %eax,%eax
80105579:	74 15                	je     80105590 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010557b:	83 ec 0c             	sub    $0xc,%esp
8010557e:	50                   	push   %eax
8010557f:	e8 3c c7 ff ff       	call   80101cc0 <iunlockput>
  end_op();
80105584:	e8 97 da ff ff       	call   80103020 <end_op>
  return 0;
80105589:	83 c4 10             	add    $0x10,%esp
8010558c:	31 c0                	xor    %eax,%eax
}
8010558e:	c9                   	leave  
8010558f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105590:	e8 8b da ff ff       	call   80103020 <end_op>
    return -1;
80105595:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010559a:	c9                   	leave  
8010559b:	c3                   	ret    
8010559c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055a0 <sys_mknod>:

int
sys_mknod(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801055a6:	e8 05 da ff ff       	call   80102fb0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801055ab:	8d 45 ec             	lea    -0x14(%ebp),%eax
801055ae:	83 ec 08             	sub    $0x8,%esp
801055b1:	50                   	push   %eax
801055b2:	6a 00                	push   $0x0
801055b4:	e8 47 f6 ff ff       	call   80104c00 <argstr>
801055b9:	83 c4 10             	add    $0x10,%esp
801055bc:	85 c0                	test   %eax,%eax
801055be:	78 60                	js     80105620 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801055c0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055c3:	83 ec 08             	sub    $0x8,%esp
801055c6:	50                   	push   %eax
801055c7:	6a 01                	push   $0x1
801055c9:	e8 82 f5 ff ff       	call   80104b50 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801055ce:	83 c4 10             	add    $0x10,%esp
801055d1:	85 c0                	test   %eax,%eax
801055d3:	78 4b                	js     80105620 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801055d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055d8:	83 ec 08             	sub    $0x8,%esp
801055db:	50                   	push   %eax
801055dc:	6a 02                	push   $0x2
801055de:	e8 6d f5 ff ff       	call   80104b50 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801055e3:	83 c4 10             	add    $0x10,%esp
801055e6:	85 c0                	test   %eax,%eax
801055e8:	78 36                	js     80105620 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801055ea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801055ee:	83 ec 0c             	sub    $0xc,%esp
801055f1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801055f5:	ba 03 00 00 00       	mov    $0x3,%edx
801055fa:	50                   	push   %eax
801055fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801055fe:	e8 9d f6 ff ff       	call   80104ca0 <create>
80105603:	83 c4 10             	add    $0x10,%esp
80105606:	85 c0                	test   %eax,%eax
80105608:	74 16                	je     80105620 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010560a:	83 ec 0c             	sub    $0xc,%esp
8010560d:	50                   	push   %eax
8010560e:	e8 ad c6 ff ff       	call   80101cc0 <iunlockput>
  end_op();
80105613:	e8 08 da ff ff       	call   80103020 <end_op>
  return 0;
80105618:	83 c4 10             	add    $0x10,%esp
8010561b:	31 c0                	xor    %eax,%eax
}
8010561d:	c9                   	leave  
8010561e:	c3                   	ret    
8010561f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105620:	e8 fb d9 ff ff       	call   80103020 <end_op>
    return -1;
80105625:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010562a:	c9                   	leave  
8010562b:	c3                   	ret    
8010562c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105630 <sys_chdir>:

int
sys_chdir(void)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	56                   	push   %esi
80105634:	53                   	push   %ebx
80105635:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105638:	e8 63 e5 ff ff       	call   80103ba0 <myproc>
8010563d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010563f:	e8 6c d9 ff ff       	call   80102fb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105644:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105647:	83 ec 08             	sub    $0x8,%esp
8010564a:	50                   	push   %eax
8010564b:	6a 00                	push   $0x0
8010564d:	e8 ae f5 ff ff       	call   80104c00 <argstr>
80105652:	83 c4 10             	add    $0x10,%esp
80105655:	85 c0                	test   %eax,%eax
80105657:	78 77                	js     801056d0 <sys_chdir+0xa0>
80105659:	83 ec 0c             	sub    $0xc,%esp
8010565c:	ff 75 f4             	pushl  -0xc(%ebp)
8010565f:	e8 1c cc ff ff       	call   80102280 <namei>
80105664:	83 c4 10             	add    $0x10,%esp
80105667:	85 c0                	test   %eax,%eax
80105669:	89 c3                	mov    %eax,%ebx
8010566b:	74 63                	je     801056d0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010566d:	83 ec 0c             	sub    $0xc,%esp
80105670:	50                   	push   %eax
80105671:	e8 ca c1 ff ff       	call   80101840 <ilock>
  if(ip->type != T_DIR){
80105676:	83 c4 10             	add    $0x10,%esp
80105679:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010567e:	75 30                	jne    801056b0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105680:	83 ec 0c             	sub    $0xc,%esp
80105683:	53                   	push   %ebx
80105684:	e8 97 c2 ff ff       	call   80101920 <iunlock>
  iput(curproc->cwd);
80105689:	58                   	pop    %eax
8010568a:	ff 76 68             	pushl  0x68(%esi)
8010568d:	e8 de c2 ff ff       	call   80101970 <iput>
  end_op();
80105692:	e8 89 d9 ff ff       	call   80103020 <end_op>
  curproc->cwd = ip;
80105697:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010569a:	83 c4 10             	add    $0x10,%esp
8010569d:	31 c0                	xor    %eax,%eax
}
8010569f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056a2:	5b                   	pop    %ebx
801056a3:	5e                   	pop    %esi
801056a4:	5d                   	pop    %ebp
801056a5:	c3                   	ret    
801056a6:	8d 76 00             	lea    0x0(%esi),%esi
801056a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801056b0:	83 ec 0c             	sub    $0xc,%esp
801056b3:	53                   	push   %ebx
801056b4:	e8 07 c6 ff ff       	call   80101cc0 <iunlockput>
    end_op();
801056b9:	e8 62 d9 ff ff       	call   80103020 <end_op>
    return -1;
801056be:	83 c4 10             	add    $0x10,%esp
801056c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056c6:	eb d7                	jmp    8010569f <sys_chdir+0x6f>
801056c8:	90                   	nop
801056c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801056d0:	e8 4b d9 ff ff       	call   80103020 <end_op>
    return -1;
801056d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056da:	eb c3                	jmp    8010569f <sys_chdir+0x6f>
801056dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056e0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	57                   	push   %edi
801056e4:	56                   	push   %esi
801056e5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801056e6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
801056ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801056f2:	50                   	push   %eax
801056f3:	6a 00                	push   $0x0
801056f5:	e8 06 f5 ff ff       	call   80104c00 <argstr>
801056fa:	83 c4 10             	add    $0x10,%esp
801056fd:	85 c0                	test   %eax,%eax
801056ff:	78 7f                	js     80105780 <sys_exec+0xa0>
80105701:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105707:	83 ec 08             	sub    $0x8,%esp
8010570a:	50                   	push   %eax
8010570b:	6a 01                	push   $0x1
8010570d:	e8 3e f4 ff ff       	call   80104b50 <argint>
80105712:	83 c4 10             	add    $0x10,%esp
80105715:	85 c0                	test   %eax,%eax
80105717:	78 67                	js     80105780 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105719:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010571f:	83 ec 04             	sub    $0x4,%esp
80105722:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105728:	68 80 00 00 00       	push   $0x80
8010572d:	6a 00                	push   $0x0
8010572f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105735:	50                   	push   %eax
80105736:	31 db                	xor    %ebx,%ebx
80105738:	e8 03 f1 ff ff       	call   80104840 <memset>
8010573d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105740:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105746:	83 ec 08             	sub    $0x8,%esp
80105749:	57                   	push   %edi
8010574a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010574d:	50                   	push   %eax
8010574e:	e8 5d f3 ff ff       	call   80104ab0 <fetchint>
80105753:	83 c4 10             	add    $0x10,%esp
80105756:	85 c0                	test   %eax,%eax
80105758:	78 26                	js     80105780 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010575a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105760:	85 c0                	test   %eax,%eax
80105762:	74 2c                	je     80105790 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105764:	83 ec 08             	sub    $0x8,%esp
80105767:	56                   	push   %esi
80105768:	50                   	push   %eax
80105769:	e8 82 f3 ff ff       	call   80104af0 <fetchstr>
8010576e:	83 c4 10             	add    $0x10,%esp
80105771:	85 c0                	test   %eax,%eax
80105773:	78 0b                	js     80105780 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105775:	83 c3 01             	add    $0x1,%ebx
80105778:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010577b:	83 fb 20             	cmp    $0x20,%ebx
8010577e:	75 c0                	jne    80105740 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105780:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105783:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105788:	5b                   	pop    %ebx
80105789:	5e                   	pop    %esi
8010578a:	5f                   	pop    %edi
8010578b:	5d                   	pop    %ebp
8010578c:	c3                   	ret    
8010578d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105790:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105796:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105799:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801057a0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801057a4:	50                   	push   %eax
801057a5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801057ab:	e8 40 b2 ff ff       	call   801009f0 <exec>
801057b0:	83 c4 10             	add    $0x10,%esp
}
801057b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057b6:	5b                   	pop    %ebx
801057b7:	5e                   	pop    %esi
801057b8:	5f                   	pop    %edi
801057b9:	5d                   	pop    %ebp
801057ba:	c3                   	ret    
801057bb:	90                   	nop
801057bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057c0 <sys_pipe>:

int
sys_pipe(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	57                   	push   %edi
801057c4:	56                   	push   %esi
801057c5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801057c6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
801057c9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801057cc:	6a 08                	push   $0x8
801057ce:	50                   	push   %eax
801057cf:	6a 00                	push   $0x0
801057d1:	e8 ca f3 ff ff       	call   80104ba0 <argptr>
801057d6:	83 c4 10             	add    $0x10,%esp
801057d9:	85 c0                	test   %eax,%eax
801057db:	78 4a                	js     80105827 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801057dd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801057e0:	83 ec 08             	sub    $0x8,%esp
801057e3:	50                   	push   %eax
801057e4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801057e7:	50                   	push   %eax
801057e8:	e8 23 de ff ff       	call   80103610 <pipealloc>
801057ed:	83 c4 10             	add    $0x10,%esp
801057f0:	85 c0                	test   %eax,%eax
801057f2:	78 33                	js     80105827 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801057f4:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057f6:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801057f9:	e8 a2 e3 ff ff       	call   80103ba0 <myproc>
801057fe:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105800:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105804:	85 f6                	test   %esi,%esi
80105806:	74 30                	je     80105838 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105808:	83 c3 01             	add    $0x1,%ebx
8010580b:	83 fb 10             	cmp    $0x10,%ebx
8010580e:	75 f0                	jne    80105800 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105810:	83 ec 0c             	sub    $0xc,%esp
80105813:	ff 75 e0             	pushl  -0x20(%ebp)
80105816:	e8 15 b6 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
8010581b:	58                   	pop    %eax
8010581c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010581f:	e8 0c b6 ff ff       	call   80100e30 <fileclose>
    return -1;
80105824:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105827:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010582a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010582f:	5b                   	pop    %ebx
80105830:	5e                   	pop    %esi
80105831:	5f                   	pop    %edi
80105832:	5d                   	pop    %ebp
80105833:	c3                   	ret    
80105834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105838:	8d 73 08             	lea    0x8(%ebx),%esi
8010583b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010583f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105842:	e8 59 e3 ff ff       	call   80103ba0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105847:	31 d2                	xor    %edx,%edx
80105849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105850:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105854:	85 c9                	test   %ecx,%ecx
80105856:	74 18                	je     80105870 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105858:	83 c2 01             	add    $0x1,%edx
8010585b:	83 fa 10             	cmp    $0x10,%edx
8010585e:	75 f0                	jne    80105850 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105860:	e8 3b e3 ff ff       	call   80103ba0 <myproc>
80105865:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010586c:	00 
8010586d:	eb a1                	jmp    80105810 <sys_pipe+0x50>
8010586f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105870:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105874:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105877:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105879:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010587c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010587f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105882:	31 c0                	xor    %eax,%eax
}
80105884:	5b                   	pop    %ebx
80105885:	5e                   	pop    %esi
80105886:	5f                   	pop    %edi
80105887:	5d                   	pop    %ebp
80105888:	c3                   	ret    
80105889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105890 <sys_sync>:

int
sys_sync(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	83 ec 08             	sub    $0x8,%esp
  commit();
80105896:	e8 65 d8 ff ff       	call   80103100 <commit>
  return 0;
}
8010589b:	31 c0                	xor    %eax,%eax
8010589d:	c9                   	leave  
8010589e:	c3                   	ret    
8010589f:	90                   	nop

801058a0 <sys_get_log_num>:

int
sys_get_log_num(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
  return log_num();
801058a3:	5d                   	pop    %ebp
}

int
sys_get_log_num(void)
{
  return log_num();
801058a4:	e9 67 d9 ff ff       	jmp    80103210 <log_num>
801058a9:	66 90                	xchg   %ax,%ax
801058ab:	66 90                	xchg   %ax,%ax
801058ad:	66 90                	xchg   %ax,%ax
801058af:	90                   	nop

801058b0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801058b3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801058b4:	e9 87 e4 ff ff       	jmp    80103d40 <fork>
801058b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058c0 <sys_exit>:
}

int
sys_exit(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801058c6:	e8 05 e7 ff ff       	call   80103fd0 <exit>
  return 0;  // not reached
}
801058cb:	31 c0                	xor    %eax,%eax
801058cd:	c9                   	leave  
801058ce:	c3                   	ret    
801058cf:	90                   	nop

801058d0 <sys_wait>:

int
sys_wait(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801058d3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801058d4:	e9 37 e9 ff ff       	jmp    80104210 <wait>
801058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058e0 <sys_kill>:
}

int
sys_kill(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801058e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058e9:	50                   	push   %eax
801058ea:	6a 00                	push   $0x0
801058ec:	e8 5f f2 ff ff       	call   80104b50 <argint>
801058f1:	83 c4 10             	add    $0x10,%esp
801058f4:	85 c0                	test   %eax,%eax
801058f6:	78 18                	js     80105910 <sys_kill+0x30>
    return -1;
  return kill(pid);
801058f8:	83 ec 0c             	sub    $0xc,%esp
801058fb:	ff 75 f4             	pushl  -0xc(%ebp)
801058fe:	e8 5d ea ff ff       	call   80104360 <kill>
80105903:	83 c4 10             	add    $0x10,%esp
}
80105906:	c9                   	leave  
80105907:	c3                   	ret    
80105908:	90                   	nop
80105909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105915:	c9                   	leave  
80105916:	c3                   	ret    
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_getpid>:

int
sys_getpid(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105926:	e8 75 e2 ff ff       	call   80103ba0 <myproc>
8010592b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010592e:	c9                   	leave  
8010592f:	c3                   	ret    

80105930 <sys_sbrk>:

int
sys_sbrk(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105934:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105937:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010593a:	50                   	push   %eax
8010593b:	6a 00                	push   $0x0
8010593d:	e8 0e f2 ff ff       	call   80104b50 <argint>
80105942:	83 c4 10             	add    $0x10,%esp
80105945:	85 c0                	test   %eax,%eax
80105947:	78 27                	js     80105970 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105949:	e8 52 e2 ff ff       	call   80103ba0 <myproc>
  if(growproc(n) < 0)
8010594e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105951:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105953:	ff 75 f4             	pushl  -0xc(%ebp)
80105956:	e8 65 e3 ff ff       	call   80103cc0 <growproc>
8010595b:	83 c4 10             	add    $0x10,%esp
8010595e:	85 c0                	test   %eax,%eax
80105960:	78 0e                	js     80105970 <sys_sbrk+0x40>
    return -1;
  return addr;
80105962:	89 d8                	mov    %ebx,%eax
}
80105964:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105967:	c9                   	leave  
80105968:	c3                   	ret    
80105969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105975:	eb ed                	jmp    80105964 <sys_sbrk+0x34>
80105977:	89 f6                	mov    %esi,%esi
80105979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105980 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105984:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105987:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010598a:	50                   	push   %eax
8010598b:	6a 00                	push   $0x0
8010598d:	e8 be f1 ff ff       	call   80104b50 <argint>
80105992:	83 c4 10             	add    $0x10,%esp
80105995:	85 c0                	test   %eax,%eax
80105997:	0f 88 8a 00 00 00    	js     80105a27 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010599d:	83 ec 0c             	sub    $0xc,%esp
801059a0:	68 60 4c 11 80       	push   $0x80114c60
801059a5:	e8 96 ed ff ff       	call   80104740 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801059aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059ad:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801059b0:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
801059b6:	85 d2                	test   %edx,%edx
801059b8:	75 27                	jne    801059e1 <sys_sleep+0x61>
801059ba:	eb 54                	jmp    80105a10 <sys_sleep+0x90>
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801059c0:	83 ec 08             	sub    $0x8,%esp
801059c3:	68 60 4c 11 80       	push   $0x80114c60
801059c8:	68 a0 54 11 80       	push   $0x801154a0
801059cd:	e8 7e e7 ff ff       	call   80104150 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801059d2:	a1 a0 54 11 80       	mov    0x801154a0,%eax
801059d7:	83 c4 10             	add    $0x10,%esp
801059da:	29 d8                	sub    %ebx,%eax
801059dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801059df:	73 2f                	jae    80105a10 <sys_sleep+0x90>
    if(myproc()->killed){
801059e1:	e8 ba e1 ff ff       	call   80103ba0 <myproc>
801059e6:	8b 40 24             	mov    0x24(%eax),%eax
801059e9:	85 c0                	test   %eax,%eax
801059eb:	74 d3                	je     801059c0 <sys_sleep+0x40>
      release(&tickslock);
801059ed:	83 ec 0c             	sub    $0xc,%esp
801059f0:	68 60 4c 11 80       	push   $0x80114c60
801059f5:	e8 f6 ed ff ff       	call   801047f0 <release>
      return -1;
801059fa:	83 c4 10             	add    $0x10,%esp
801059fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105a02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a05:	c9                   	leave  
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	68 60 4c 11 80       	push   $0x80114c60
80105a18:	e8 d3 ed ff ff       	call   801047f0 <release>
  return 0;
80105a1d:	83 c4 10             	add    $0x10,%esp
80105a20:	31 c0                	xor    %eax,%eax
}
80105a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a25:	c9                   	leave  
80105a26:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105a27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a2c:	eb d4                	jmp    80105a02 <sys_sleep+0x82>
80105a2e:	66 90                	xchg   %ax,%ax

80105a30 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	53                   	push   %ebx
80105a34:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105a37:	68 60 4c 11 80       	push   $0x80114c60
80105a3c:	e8 ff ec ff ff       	call   80104740 <acquire>
  xticks = ticks;
80105a41:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
80105a47:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105a4e:	e8 9d ed ff ff       	call   801047f0 <release>
  return xticks;
}
80105a53:	89 d8                	mov    %ebx,%eax
80105a55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a58:	c9                   	leave  
80105a59:	c3                   	ret    

80105a5a <alltraps>:
80105a5a:	1e                   	push   %ds
80105a5b:	06                   	push   %es
80105a5c:	0f a0                	push   %fs
80105a5e:	0f a8                	push   %gs
80105a60:	60                   	pusha  
80105a61:	66 b8 10 00          	mov    $0x10,%ax
80105a65:	8e d8                	mov    %eax,%ds
80105a67:	8e c0                	mov    %eax,%es
80105a69:	54                   	push   %esp
80105a6a:	e8 e1 00 00 00       	call   80105b50 <trap>
80105a6f:	83 c4 04             	add    $0x4,%esp

80105a72 <trapret>:
80105a72:	61                   	popa   
80105a73:	0f a9                	pop    %gs
80105a75:	0f a1                	pop    %fs
80105a77:	07                   	pop    %es
80105a78:	1f                   	pop    %ds
80105a79:	83 c4 08             	add    $0x8,%esp
80105a7c:	cf                   	iret   
80105a7d:	66 90                	xchg   %ax,%ax
80105a7f:	90                   	nop

80105a80 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105a80:	31 c0                	xor    %eax,%eax
80105a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a88:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105a8f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105a94:	c6 04 c5 a4 4c 11 80 	movb   $0x0,-0x7feeb35c(,%eax,8)
80105a9b:	00 
80105a9c:	66 89 0c c5 a2 4c 11 	mov    %cx,-0x7feeb35e(,%eax,8)
80105aa3:	80 
80105aa4:	c6 04 c5 a5 4c 11 80 	movb   $0x8e,-0x7feeb35b(,%eax,8)
80105aab:	8e 
80105aac:	66 89 14 c5 a0 4c 11 	mov    %dx,-0x7feeb360(,%eax,8)
80105ab3:	80 
80105ab4:	c1 ea 10             	shr    $0x10,%edx
80105ab7:	66 89 14 c5 a6 4c 11 	mov    %dx,-0x7feeb35a(,%eax,8)
80105abe:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105abf:	83 c0 01             	add    $0x1,%eax
80105ac2:	3d 00 01 00 00       	cmp    $0x100,%eax
80105ac7:	75 bf                	jne    80105a88 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105ac9:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105aca:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105acf:	89 e5                	mov    %esp,%ebp
80105ad1:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ad4:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105ad9:	68 c1 7a 10 80       	push   $0x80107ac1
80105ade:	68 60 4c 11 80       	push   $0x80114c60
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ae3:	66 89 15 a2 4e 11 80 	mov    %dx,0x80114ea2
80105aea:	c6 05 a4 4e 11 80 00 	movb   $0x0,0x80114ea4
80105af1:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
80105af7:	c1 e8 10             	shr    $0x10,%eax
80105afa:	c6 05 a5 4e 11 80 ef 	movb   $0xef,0x80114ea5
80105b01:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6

  initlock(&tickslock, "time");
80105b07:	e8 d4 ea ff ff       	call   801045e0 <initlock>
}
80105b0c:	83 c4 10             	add    $0x10,%esp
80105b0f:	c9                   	leave  
80105b10:	c3                   	ret    
80105b11:	eb 0d                	jmp    80105b20 <idtinit>
80105b13:	90                   	nop
80105b14:	90                   	nop
80105b15:	90                   	nop
80105b16:	90                   	nop
80105b17:	90                   	nop
80105b18:	90                   	nop
80105b19:	90                   	nop
80105b1a:	90                   	nop
80105b1b:	90                   	nop
80105b1c:	90                   	nop
80105b1d:	90                   	nop
80105b1e:	90                   	nop
80105b1f:	90                   	nop

80105b20 <idtinit>:

void
idtinit(void)
{
80105b20:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105b21:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b26:	89 e5                	mov    %esp,%ebp
80105b28:	83 ec 10             	sub    $0x10,%esp
80105b2b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105b2f:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
80105b34:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105b38:	c1 e8 10             	shr    $0x10,%eax
80105b3b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105b3f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105b42:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105b45:	c9                   	leave  
80105b46:	c3                   	ret    
80105b47:	89 f6                	mov    %esi,%esi
80105b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b50 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	57                   	push   %edi
80105b54:	56                   	push   %esi
80105b55:	53                   	push   %ebx
80105b56:	83 ec 1c             	sub    $0x1c,%esp
80105b59:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105b5c:	8b 47 30             	mov    0x30(%edi),%eax
80105b5f:	83 f8 40             	cmp    $0x40,%eax
80105b62:	0f 84 88 01 00 00    	je     80105cf0 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105b68:	83 e8 20             	sub    $0x20,%eax
80105b6b:	83 f8 1f             	cmp    $0x1f,%eax
80105b6e:	77 10                	ja     80105b80 <trap+0x30>
80105b70:	ff 24 85 68 7b 10 80 	jmp    *-0x7fef8498(,%eax,4)
80105b77:	89 f6                	mov    %esi,%esi
80105b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105b80:	e8 1b e0 ff ff       	call   80103ba0 <myproc>
80105b85:	85 c0                	test   %eax,%eax
80105b87:	0f 84 d7 01 00 00    	je     80105d64 <trap+0x214>
80105b8d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105b91:	0f 84 cd 01 00 00    	je     80105d64 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105b97:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b9a:	8b 57 38             	mov    0x38(%edi),%edx
80105b9d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105ba0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105ba3:	e8 d8 df ff ff       	call   80103b80 <cpuid>
80105ba8:	8b 77 34             	mov    0x34(%edi),%esi
80105bab:	8b 5f 30             	mov    0x30(%edi),%ebx
80105bae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105bb1:	e8 ea df ff ff       	call   80103ba0 <myproc>
80105bb6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105bb9:	e8 e2 df ff ff       	call   80103ba0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bbe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105bc1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105bc4:	51                   	push   %ecx
80105bc5:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105bc6:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bc9:	ff 75 e4             	pushl  -0x1c(%ebp)
80105bcc:	56                   	push   %esi
80105bcd:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105bce:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bd1:	52                   	push   %edx
80105bd2:	ff 70 10             	pushl  0x10(%eax)
80105bd5:	68 24 7b 10 80       	push   $0x80107b24
80105bda:	e8 81 aa ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105bdf:	83 c4 20             	add    $0x20,%esp
80105be2:	e8 b9 df ff ff       	call   80103ba0 <myproc>
80105be7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105bee:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bf0:	e8 ab df ff ff       	call   80103ba0 <myproc>
80105bf5:	85 c0                	test   %eax,%eax
80105bf7:	74 0c                	je     80105c05 <trap+0xb5>
80105bf9:	e8 a2 df ff ff       	call   80103ba0 <myproc>
80105bfe:	8b 50 24             	mov    0x24(%eax),%edx
80105c01:	85 d2                	test   %edx,%edx
80105c03:	75 4b                	jne    80105c50 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105c05:	e8 96 df ff ff       	call   80103ba0 <myproc>
80105c0a:	85 c0                	test   %eax,%eax
80105c0c:	74 0b                	je     80105c19 <trap+0xc9>
80105c0e:	e8 8d df ff ff       	call   80103ba0 <myproc>
80105c13:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105c17:	74 4f                	je     80105c68 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c19:	e8 82 df ff ff       	call   80103ba0 <myproc>
80105c1e:	85 c0                	test   %eax,%eax
80105c20:	74 1d                	je     80105c3f <trap+0xef>
80105c22:	e8 79 df ff ff       	call   80103ba0 <myproc>
80105c27:	8b 40 24             	mov    0x24(%eax),%eax
80105c2a:	85 c0                	test   %eax,%eax
80105c2c:	74 11                	je     80105c3f <trap+0xef>
80105c2e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105c32:	83 e0 03             	and    $0x3,%eax
80105c35:	66 83 f8 03          	cmp    $0x3,%ax
80105c39:	0f 84 da 00 00 00    	je     80105d19 <trap+0x1c9>
    exit();
}
80105c3f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c42:	5b                   	pop    %ebx
80105c43:	5e                   	pop    %esi
80105c44:	5f                   	pop    %edi
80105c45:	5d                   	pop    %ebp
80105c46:	c3                   	ret    
80105c47:	89 f6                	mov    %esi,%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c50:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105c54:	83 e0 03             	and    $0x3,%eax
80105c57:	66 83 f8 03          	cmp    $0x3,%ax
80105c5b:	75 a8                	jne    80105c05 <trap+0xb5>
    exit();
80105c5d:	e8 6e e3 ff ff       	call   80103fd0 <exit>
80105c62:	eb a1                	jmp    80105c05 <trap+0xb5>
80105c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105c68:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105c6c:	75 ab                	jne    80105c19 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105c6e:	e8 8d e4 ff ff       	call   80104100 <yield>
80105c73:	eb a4                	jmp    80105c19 <trap+0xc9>
80105c75:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105c78:	e8 03 df ff ff       	call   80103b80 <cpuid>
80105c7d:	85 c0                	test   %eax,%eax
80105c7f:	0f 84 ab 00 00 00    	je     80105d30 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105c85:	e8 46 ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105c8a:	e9 61 ff ff ff       	jmp    80105bf0 <trap+0xa0>
80105c8f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105c90:	e8 fb cc ff ff       	call   80102990 <kbdintr>
    lapiceoi();
80105c95:	e8 36 ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105c9a:	e9 51 ff ff ff       	jmp    80105bf0 <trap+0xa0>
80105c9f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105ca0:	e8 5b 02 00 00       	call   80105f00 <uartintr>
    lapiceoi();
80105ca5:	e8 26 ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105caa:	e9 41 ff ff ff       	jmp    80105bf0 <trap+0xa0>
80105caf:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105cb0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105cb4:	8b 77 38             	mov    0x38(%edi),%esi
80105cb7:	e8 c4 de ff ff       	call   80103b80 <cpuid>
80105cbc:	56                   	push   %esi
80105cbd:	53                   	push   %ebx
80105cbe:	50                   	push   %eax
80105cbf:	68 cc 7a 10 80       	push   $0x80107acc
80105cc4:	e8 97 a9 ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105cc9:	e8 02 ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105cce:	83 c4 10             	add    $0x10,%esp
80105cd1:	e9 1a ff ff ff       	jmp    80105bf0 <trap+0xa0>
80105cd6:	8d 76 00             	lea    0x0(%esi),%esi
80105cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105ce0:	e8 2b c7 ff ff       	call   80102410 <ideintr>
80105ce5:	eb 9e                	jmp    80105c85 <trap+0x135>
80105ce7:	89 f6                	mov    %esi,%esi
80105ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105cf0:	e8 ab de ff ff       	call   80103ba0 <myproc>
80105cf5:	8b 58 24             	mov    0x24(%eax),%ebx
80105cf8:	85 db                	test   %ebx,%ebx
80105cfa:	75 2c                	jne    80105d28 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105cfc:	e8 9f de ff ff       	call   80103ba0 <myproc>
80105d01:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105d04:	e8 37 ef ff ff       	call   80104c40 <syscall>
    if(myproc()->killed)
80105d09:	e8 92 de ff ff       	call   80103ba0 <myproc>
80105d0e:	8b 48 24             	mov    0x24(%eax),%ecx
80105d11:	85 c9                	test   %ecx,%ecx
80105d13:	0f 84 26 ff ff ff    	je     80105c3f <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105d19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d1c:	5b                   	pop    %ebx
80105d1d:	5e                   	pop    %esi
80105d1e:	5f                   	pop    %edi
80105d1f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105d20:	e9 ab e2 ff ff       	jmp    80103fd0 <exit>
80105d25:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105d28:	e8 a3 e2 ff ff       	call   80103fd0 <exit>
80105d2d:	eb cd                	jmp    80105cfc <trap+0x1ac>
80105d2f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105d30:	83 ec 0c             	sub    $0xc,%esp
80105d33:	68 60 4c 11 80       	push   $0x80114c60
80105d38:	e8 03 ea ff ff       	call   80104740 <acquire>
      ticks++;
      wakeup(&ticks);
80105d3d:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105d44:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
80105d4b:	e8 b0 e5 ff ff       	call   80104300 <wakeup>
      release(&tickslock);
80105d50:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105d57:	e8 94 ea ff ff       	call   801047f0 <release>
80105d5c:	83 c4 10             	add    $0x10,%esp
80105d5f:	e9 21 ff ff ff       	jmp    80105c85 <trap+0x135>
80105d64:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d67:	8b 5f 38             	mov    0x38(%edi),%ebx
80105d6a:	e8 11 de ff ff       	call   80103b80 <cpuid>
80105d6f:	83 ec 0c             	sub    $0xc,%esp
80105d72:	56                   	push   %esi
80105d73:	53                   	push   %ebx
80105d74:	50                   	push   %eax
80105d75:	ff 77 30             	pushl  0x30(%edi)
80105d78:	68 f0 7a 10 80       	push   $0x80107af0
80105d7d:	e8 de a8 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105d82:	83 c4 14             	add    $0x14,%esp
80105d85:	68 c6 7a 10 80       	push   $0x80107ac6
80105d8a:	e8 e1 a5 ff ff       	call   80100370 <panic>
80105d8f:	90                   	nop

80105d90 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d90:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105d95:	55                   	push   %ebp
80105d96:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105d98:	85 c0                	test   %eax,%eax
80105d9a:	74 1c                	je     80105db8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d9c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105da1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105da2:	a8 01                	test   $0x1,%al
80105da4:	74 12                	je     80105db8 <uartgetc+0x28>
80105da6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dab:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105dac:	0f b6 c0             	movzbl %al,%eax
}
80105daf:	5d                   	pop    %ebp
80105db0:	c3                   	ret    
80105db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105db8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105dbd:	5d                   	pop    %ebp
80105dbe:	c3                   	ret    
80105dbf:	90                   	nop

80105dc0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	57                   	push   %edi
80105dc4:	56                   	push   %esi
80105dc5:	53                   	push   %ebx
80105dc6:	89 c7                	mov    %eax,%edi
80105dc8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105dcd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105dd2:	83 ec 0c             	sub    $0xc,%esp
80105dd5:	eb 1b                	jmp    80105df2 <uartputc.part.0+0x32>
80105dd7:	89 f6                	mov    %esi,%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105de0:	83 ec 0c             	sub    $0xc,%esp
80105de3:	6a 0a                	push   $0xa
80105de5:	e8 06 cd ff ff       	call   80102af0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105dea:	83 c4 10             	add    $0x10,%esp
80105ded:	83 eb 01             	sub    $0x1,%ebx
80105df0:	74 07                	je     80105df9 <uartputc.part.0+0x39>
80105df2:	89 f2                	mov    %esi,%edx
80105df4:	ec                   	in     (%dx),%al
80105df5:	a8 20                	test   $0x20,%al
80105df7:	74 e7                	je     80105de0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105df9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dfe:	89 f8                	mov    %edi,%eax
80105e00:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105e01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e04:	5b                   	pop    %ebx
80105e05:	5e                   	pop    %esi
80105e06:	5f                   	pop    %edi
80105e07:	5d                   	pop    %ebp
80105e08:	c3                   	ret    
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e10 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105e10:	55                   	push   %ebp
80105e11:	31 c9                	xor    %ecx,%ecx
80105e13:	89 c8                	mov    %ecx,%eax
80105e15:	89 e5                	mov    %esp,%ebp
80105e17:	57                   	push   %edi
80105e18:	56                   	push   %esi
80105e19:	53                   	push   %ebx
80105e1a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105e1f:	89 da                	mov    %ebx,%edx
80105e21:	83 ec 0c             	sub    $0xc,%esp
80105e24:	ee                   	out    %al,(%dx)
80105e25:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105e2a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105e2f:	89 fa                	mov    %edi,%edx
80105e31:	ee                   	out    %al,(%dx)
80105e32:	b8 0c 00 00 00       	mov    $0xc,%eax
80105e37:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e3c:	ee                   	out    %al,(%dx)
80105e3d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105e42:	89 c8                	mov    %ecx,%eax
80105e44:	89 f2                	mov    %esi,%edx
80105e46:	ee                   	out    %al,(%dx)
80105e47:	b8 03 00 00 00       	mov    $0x3,%eax
80105e4c:	89 fa                	mov    %edi,%edx
80105e4e:	ee                   	out    %al,(%dx)
80105e4f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105e54:	89 c8                	mov    %ecx,%eax
80105e56:	ee                   	out    %al,(%dx)
80105e57:	b8 01 00 00 00       	mov    $0x1,%eax
80105e5c:	89 f2                	mov    %esi,%edx
80105e5e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e5f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e64:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105e65:	3c ff                	cmp    $0xff,%al
80105e67:	74 5a                	je     80105ec3 <uartinit+0xb3>
    return;
  uart = 1;
80105e69:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105e70:	00 00 00 
80105e73:	89 da                	mov    %ebx,%edx
80105e75:	ec                   	in     (%dx),%al
80105e76:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e7b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105e7c:	83 ec 08             	sub    $0x8,%esp
80105e7f:	bb e8 7b 10 80       	mov    $0x80107be8,%ebx
80105e84:	6a 00                	push   $0x0
80105e86:	6a 04                	push   $0x4
80105e88:	e8 d3 c7 ff ff       	call   80102660 <ioapicenable>
80105e8d:	83 c4 10             	add    $0x10,%esp
80105e90:	b8 78 00 00 00       	mov    $0x78,%eax
80105e95:	eb 13                	jmp    80105eaa <uartinit+0x9a>
80105e97:	89 f6                	mov    %esi,%esi
80105e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105ea0:	83 c3 01             	add    $0x1,%ebx
80105ea3:	0f be 03             	movsbl (%ebx),%eax
80105ea6:	84 c0                	test   %al,%al
80105ea8:	74 19                	je     80105ec3 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105eaa:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105eb0:	85 d2                	test   %edx,%edx
80105eb2:	74 ec                	je     80105ea0 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105eb4:	83 c3 01             	add    $0x1,%ebx
80105eb7:	e8 04 ff ff ff       	call   80105dc0 <uartputc.part.0>
80105ebc:	0f be 03             	movsbl (%ebx),%eax
80105ebf:	84 c0                	test   %al,%al
80105ec1:	75 e7                	jne    80105eaa <uartinit+0x9a>
    uartputc(*p);
}
80105ec3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ec6:	5b                   	pop    %ebx
80105ec7:	5e                   	pop    %esi
80105ec8:	5f                   	pop    %edi
80105ec9:	5d                   	pop    %ebp
80105eca:	c3                   	ret    
80105ecb:	90                   	nop
80105ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ed0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105ed0:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105ed6:	55                   	push   %ebp
80105ed7:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105ed9:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105edb:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105ede:	74 10                	je     80105ef0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105ee0:	5d                   	pop    %ebp
80105ee1:	e9 da fe ff ff       	jmp    80105dc0 <uartputc.part.0>
80105ee6:	8d 76 00             	lea    0x0(%esi),%esi
80105ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ef0:	5d                   	pop    %ebp
80105ef1:	c3                   	ret    
80105ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f00 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105f06:	68 90 5d 10 80       	push   $0x80105d90
80105f0b:	e8 e0 a8 ff ff       	call   801007f0 <consoleintr>
}
80105f10:	83 c4 10             	add    $0x10,%esp
80105f13:	c9                   	leave  
80105f14:	c3                   	ret    

80105f15 <vector0>:
80105f15:	6a 00                	push   $0x0
80105f17:	6a 00                	push   $0x0
80105f19:	e9 3c fb ff ff       	jmp    80105a5a <alltraps>

80105f1e <vector1>:
80105f1e:	6a 00                	push   $0x0
80105f20:	6a 01                	push   $0x1
80105f22:	e9 33 fb ff ff       	jmp    80105a5a <alltraps>

80105f27 <vector2>:
80105f27:	6a 00                	push   $0x0
80105f29:	6a 02                	push   $0x2
80105f2b:	e9 2a fb ff ff       	jmp    80105a5a <alltraps>

80105f30 <vector3>:
80105f30:	6a 00                	push   $0x0
80105f32:	6a 03                	push   $0x3
80105f34:	e9 21 fb ff ff       	jmp    80105a5a <alltraps>

80105f39 <vector4>:
80105f39:	6a 00                	push   $0x0
80105f3b:	6a 04                	push   $0x4
80105f3d:	e9 18 fb ff ff       	jmp    80105a5a <alltraps>

80105f42 <vector5>:
80105f42:	6a 00                	push   $0x0
80105f44:	6a 05                	push   $0x5
80105f46:	e9 0f fb ff ff       	jmp    80105a5a <alltraps>

80105f4b <vector6>:
80105f4b:	6a 00                	push   $0x0
80105f4d:	6a 06                	push   $0x6
80105f4f:	e9 06 fb ff ff       	jmp    80105a5a <alltraps>

80105f54 <vector7>:
80105f54:	6a 00                	push   $0x0
80105f56:	6a 07                	push   $0x7
80105f58:	e9 fd fa ff ff       	jmp    80105a5a <alltraps>

80105f5d <vector8>:
80105f5d:	6a 08                	push   $0x8
80105f5f:	e9 f6 fa ff ff       	jmp    80105a5a <alltraps>

80105f64 <vector9>:
80105f64:	6a 00                	push   $0x0
80105f66:	6a 09                	push   $0x9
80105f68:	e9 ed fa ff ff       	jmp    80105a5a <alltraps>

80105f6d <vector10>:
80105f6d:	6a 0a                	push   $0xa
80105f6f:	e9 e6 fa ff ff       	jmp    80105a5a <alltraps>

80105f74 <vector11>:
80105f74:	6a 0b                	push   $0xb
80105f76:	e9 df fa ff ff       	jmp    80105a5a <alltraps>

80105f7b <vector12>:
80105f7b:	6a 0c                	push   $0xc
80105f7d:	e9 d8 fa ff ff       	jmp    80105a5a <alltraps>

80105f82 <vector13>:
80105f82:	6a 0d                	push   $0xd
80105f84:	e9 d1 fa ff ff       	jmp    80105a5a <alltraps>

80105f89 <vector14>:
80105f89:	6a 0e                	push   $0xe
80105f8b:	e9 ca fa ff ff       	jmp    80105a5a <alltraps>

80105f90 <vector15>:
80105f90:	6a 00                	push   $0x0
80105f92:	6a 0f                	push   $0xf
80105f94:	e9 c1 fa ff ff       	jmp    80105a5a <alltraps>

80105f99 <vector16>:
80105f99:	6a 00                	push   $0x0
80105f9b:	6a 10                	push   $0x10
80105f9d:	e9 b8 fa ff ff       	jmp    80105a5a <alltraps>

80105fa2 <vector17>:
80105fa2:	6a 11                	push   $0x11
80105fa4:	e9 b1 fa ff ff       	jmp    80105a5a <alltraps>

80105fa9 <vector18>:
80105fa9:	6a 00                	push   $0x0
80105fab:	6a 12                	push   $0x12
80105fad:	e9 a8 fa ff ff       	jmp    80105a5a <alltraps>

80105fb2 <vector19>:
80105fb2:	6a 00                	push   $0x0
80105fb4:	6a 13                	push   $0x13
80105fb6:	e9 9f fa ff ff       	jmp    80105a5a <alltraps>

80105fbb <vector20>:
80105fbb:	6a 00                	push   $0x0
80105fbd:	6a 14                	push   $0x14
80105fbf:	e9 96 fa ff ff       	jmp    80105a5a <alltraps>

80105fc4 <vector21>:
80105fc4:	6a 00                	push   $0x0
80105fc6:	6a 15                	push   $0x15
80105fc8:	e9 8d fa ff ff       	jmp    80105a5a <alltraps>

80105fcd <vector22>:
80105fcd:	6a 00                	push   $0x0
80105fcf:	6a 16                	push   $0x16
80105fd1:	e9 84 fa ff ff       	jmp    80105a5a <alltraps>

80105fd6 <vector23>:
80105fd6:	6a 00                	push   $0x0
80105fd8:	6a 17                	push   $0x17
80105fda:	e9 7b fa ff ff       	jmp    80105a5a <alltraps>

80105fdf <vector24>:
80105fdf:	6a 00                	push   $0x0
80105fe1:	6a 18                	push   $0x18
80105fe3:	e9 72 fa ff ff       	jmp    80105a5a <alltraps>

80105fe8 <vector25>:
80105fe8:	6a 00                	push   $0x0
80105fea:	6a 19                	push   $0x19
80105fec:	e9 69 fa ff ff       	jmp    80105a5a <alltraps>

80105ff1 <vector26>:
80105ff1:	6a 00                	push   $0x0
80105ff3:	6a 1a                	push   $0x1a
80105ff5:	e9 60 fa ff ff       	jmp    80105a5a <alltraps>

80105ffa <vector27>:
80105ffa:	6a 00                	push   $0x0
80105ffc:	6a 1b                	push   $0x1b
80105ffe:	e9 57 fa ff ff       	jmp    80105a5a <alltraps>

80106003 <vector28>:
80106003:	6a 00                	push   $0x0
80106005:	6a 1c                	push   $0x1c
80106007:	e9 4e fa ff ff       	jmp    80105a5a <alltraps>

8010600c <vector29>:
8010600c:	6a 00                	push   $0x0
8010600e:	6a 1d                	push   $0x1d
80106010:	e9 45 fa ff ff       	jmp    80105a5a <alltraps>

80106015 <vector30>:
80106015:	6a 00                	push   $0x0
80106017:	6a 1e                	push   $0x1e
80106019:	e9 3c fa ff ff       	jmp    80105a5a <alltraps>

8010601e <vector31>:
8010601e:	6a 00                	push   $0x0
80106020:	6a 1f                	push   $0x1f
80106022:	e9 33 fa ff ff       	jmp    80105a5a <alltraps>

80106027 <vector32>:
80106027:	6a 00                	push   $0x0
80106029:	6a 20                	push   $0x20
8010602b:	e9 2a fa ff ff       	jmp    80105a5a <alltraps>

80106030 <vector33>:
80106030:	6a 00                	push   $0x0
80106032:	6a 21                	push   $0x21
80106034:	e9 21 fa ff ff       	jmp    80105a5a <alltraps>

80106039 <vector34>:
80106039:	6a 00                	push   $0x0
8010603b:	6a 22                	push   $0x22
8010603d:	e9 18 fa ff ff       	jmp    80105a5a <alltraps>

80106042 <vector35>:
80106042:	6a 00                	push   $0x0
80106044:	6a 23                	push   $0x23
80106046:	e9 0f fa ff ff       	jmp    80105a5a <alltraps>

8010604b <vector36>:
8010604b:	6a 00                	push   $0x0
8010604d:	6a 24                	push   $0x24
8010604f:	e9 06 fa ff ff       	jmp    80105a5a <alltraps>

80106054 <vector37>:
80106054:	6a 00                	push   $0x0
80106056:	6a 25                	push   $0x25
80106058:	e9 fd f9 ff ff       	jmp    80105a5a <alltraps>

8010605d <vector38>:
8010605d:	6a 00                	push   $0x0
8010605f:	6a 26                	push   $0x26
80106061:	e9 f4 f9 ff ff       	jmp    80105a5a <alltraps>

80106066 <vector39>:
80106066:	6a 00                	push   $0x0
80106068:	6a 27                	push   $0x27
8010606a:	e9 eb f9 ff ff       	jmp    80105a5a <alltraps>

8010606f <vector40>:
8010606f:	6a 00                	push   $0x0
80106071:	6a 28                	push   $0x28
80106073:	e9 e2 f9 ff ff       	jmp    80105a5a <alltraps>

80106078 <vector41>:
80106078:	6a 00                	push   $0x0
8010607a:	6a 29                	push   $0x29
8010607c:	e9 d9 f9 ff ff       	jmp    80105a5a <alltraps>

80106081 <vector42>:
80106081:	6a 00                	push   $0x0
80106083:	6a 2a                	push   $0x2a
80106085:	e9 d0 f9 ff ff       	jmp    80105a5a <alltraps>

8010608a <vector43>:
8010608a:	6a 00                	push   $0x0
8010608c:	6a 2b                	push   $0x2b
8010608e:	e9 c7 f9 ff ff       	jmp    80105a5a <alltraps>

80106093 <vector44>:
80106093:	6a 00                	push   $0x0
80106095:	6a 2c                	push   $0x2c
80106097:	e9 be f9 ff ff       	jmp    80105a5a <alltraps>

8010609c <vector45>:
8010609c:	6a 00                	push   $0x0
8010609e:	6a 2d                	push   $0x2d
801060a0:	e9 b5 f9 ff ff       	jmp    80105a5a <alltraps>

801060a5 <vector46>:
801060a5:	6a 00                	push   $0x0
801060a7:	6a 2e                	push   $0x2e
801060a9:	e9 ac f9 ff ff       	jmp    80105a5a <alltraps>

801060ae <vector47>:
801060ae:	6a 00                	push   $0x0
801060b0:	6a 2f                	push   $0x2f
801060b2:	e9 a3 f9 ff ff       	jmp    80105a5a <alltraps>

801060b7 <vector48>:
801060b7:	6a 00                	push   $0x0
801060b9:	6a 30                	push   $0x30
801060bb:	e9 9a f9 ff ff       	jmp    80105a5a <alltraps>

801060c0 <vector49>:
801060c0:	6a 00                	push   $0x0
801060c2:	6a 31                	push   $0x31
801060c4:	e9 91 f9 ff ff       	jmp    80105a5a <alltraps>

801060c9 <vector50>:
801060c9:	6a 00                	push   $0x0
801060cb:	6a 32                	push   $0x32
801060cd:	e9 88 f9 ff ff       	jmp    80105a5a <alltraps>

801060d2 <vector51>:
801060d2:	6a 00                	push   $0x0
801060d4:	6a 33                	push   $0x33
801060d6:	e9 7f f9 ff ff       	jmp    80105a5a <alltraps>

801060db <vector52>:
801060db:	6a 00                	push   $0x0
801060dd:	6a 34                	push   $0x34
801060df:	e9 76 f9 ff ff       	jmp    80105a5a <alltraps>

801060e4 <vector53>:
801060e4:	6a 00                	push   $0x0
801060e6:	6a 35                	push   $0x35
801060e8:	e9 6d f9 ff ff       	jmp    80105a5a <alltraps>

801060ed <vector54>:
801060ed:	6a 00                	push   $0x0
801060ef:	6a 36                	push   $0x36
801060f1:	e9 64 f9 ff ff       	jmp    80105a5a <alltraps>

801060f6 <vector55>:
801060f6:	6a 00                	push   $0x0
801060f8:	6a 37                	push   $0x37
801060fa:	e9 5b f9 ff ff       	jmp    80105a5a <alltraps>

801060ff <vector56>:
801060ff:	6a 00                	push   $0x0
80106101:	6a 38                	push   $0x38
80106103:	e9 52 f9 ff ff       	jmp    80105a5a <alltraps>

80106108 <vector57>:
80106108:	6a 00                	push   $0x0
8010610a:	6a 39                	push   $0x39
8010610c:	e9 49 f9 ff ff       	jmp    80105a5a <alltraps>

80106111 <vector58>:
80106111:	6a 00                	push   $0x0
80106113:	6a 3a                	push   $0x3a
80106115:	e9 40 f9 ff ff       	jmp    80105a5a <alltraps>

8010611a <vector59>:
8010611a:	6a 00                	push   $0x0
8010611c:	6a 3b                	push   $0x3b
8010611e:	e9 37 f9 ff ff       	jmp    80105a5a <alltraps>

80106123 <vector60>:
80106123:	6a 00                	push   $0x0
80106125:	6a 3c                	push   $0x3c
80106127:	e9 2e f9 ff ff       	jmp    80105a5a <alltraps>

8010612c <vector61>:
8010612c:	6a 00                	push   $0x0
8010612e:	6a 3d                	push   $0x3d
80106130:	e9 25 f9 ff ff       	jmp    80105a5a <alltraps>

80106135 <vector62>:
80106135:	6a 00                	push   $0x0
80106137:	6a 3e                	push   $0x3e
80106139:	e9 1c f9 ff ff       	jmp    80105a5a <alltraps>

8010613e <vector63>:
8010613e:	6a 00                	push   $0x0
80106140:	6a 3f                	push   $0x3f
80106142:	e9 13 f9 ff ff       	jmp    80105a5a <alltraps>

80106147 <vector64>:
80106147:	6a 00                	push   $0x0
80106149:	6a 40                	push   $0x40
8010614b:	e9 0a f9 ff ff       	jmp    80105a5a <alltraps>

80106150 <vector65>:
80106150:	6a 00                	push   $0x0
80106152:	6a 41                	push   $0x41
80106154:	e9 01 f9 ff ff       	jmp    80105a5a <alltraps>

80106159 <vector66>:
80106159:	6a 00                	push   $0x0
8010615b:	6a 42                	push   $0x42
8010615d:	e9 f8 f8 ff ff       	jmp    80105a5a <alltraps>

80106162 <vector67>:
80106162:	6a 00                	push   $0x0
80106164:	6a 43                	push   $0x43
80106166:	e9 ef f8 ff ff       	jmp    80105a5a <alltraps>

8010616b <vector68>:
8010616b:	6a 00                	push   $0x0
8010616d:	6a 44                	push   $0x44
8010616f:	e9 e6 f8 ff ff       	jmp    80105a5a <alltraps>

80106174 <vector69>:
80106174:	6a 00                	push   $0x0
80106176:	6a 45                	push   $0x45
80106178:	e9 dd f8 ff ff       	jmp    80105a5a <alltraps>

8010617d <vector70>:
8010617d:	6a 00                	push   $0x0
8010617f:	6a 46                	push   $0x46
80106181:	e9 d4 f8 ff ff       	jmp    80105a5a <alltraps>

80106186 <vector71>:
80106186:	6a 00                	push   $0x0
80106188:	6a 47                	push   $0x47
8010618a:	e9 cb f8 ff ff       	jmp    80105a5a <alltraps>

8010618f <vector72>:
8010618f:	6a 00                	push   $0x0
80106191:	6a 48                	push   $0x48
80106193:	e9 c2 f8 ff ff       	jmp    80105a5a <alltraps>

80106198 <vector73>:
80106198:	6a 00                	push   $0x0
8010619a:	6a 49                	push   $0x49
8010619c:	e9 b9 f8 ff ff       	jmp    80105a5a <alltraps>

801061a1 <vector74>:
801061a1:	6a 00                	push   $0x0
801061a3:	6a 4a                	push   $0x4a
801061a5:	e9 b0 f8 ff ff       	jmp    80105a5a <alltraps>

801061aa <vector75>:
801061aa:	6a 00                	push   $0x0
801061ac:	6a 4b                	push   $0x4b
801061ae:	e9 a7 f8 ff ff       	jmp    80105a5a <alltraps>

801061b3 <vector76>:
801061b3:	6a 00                	push   $0x0
801061b5:	6a 4c                	push   $0x4c
801061b7:	e9 9e f8 ff ff       	jmp    80105a5a <alltraps>

801061bc <vector77>:
801061bc:	6a 00                	push   $0x0
801061be:	6a 4d                	push   $0x4d
801061c0:	e9 95 f8 ff ff       	jmp    80105a5a <alltraps>

801061c5 <vector78>:
801061c5:	6a 00                	push   $0x0
801061c7:	6a 4e                	push   $0x4e
801061c9:	e9 8c f8 ff ff       	jmp    80105a5a <alltraps>

801061ce <vector79>:
801061ce:	6a 00                	push   $0x0
801061d0:	6a 4f                	push   $0x4f
801061d2:	e9 83 f8 ff ff       	jmp    80105a5a <alltraps>

801061d7 <vector80>:
801061d7:	6a 00                	push   $0x0
801061d9:	6a 50                	push   $0x50
801061db:	e9 7a f8 ff ff       	jmp    80105a5a <alltraps>

801061e0 <vector81>:
801061e0:	6a 00                	push   $0x0
801061e2:	6a 51                	push   $0x51
801061e4:	e9 71 f8 ff ff       	jmp    80105a5a <alltraps>

801061e9 <vector82>:
801061e9:	6a 00                	push   $0x0
801061eb:	6a 52                	push   $0x52
801061ed:	e9 68 f8 ff ff       	jmp    80105a5a <alltraps>

801061f2 <vector83>:
801061f2:	6a 00                	push   $0x0
801061f4:	6a 53                	push   $0x53
801061f6:	e9 5f f8 ff ff       	jmp    80105a5a <alltraps>

801061fb <vector84>:
801061fb:	6a 00                	push   $0x0
801061fd:	6a 54                	push   $0x54
801061ff:	e9 56 f8 ff ff       	jmp    80105a5a <alltraps>

80106204 <vector85>:
80106204:	6a 00                	push   $0x0
80106206:	6a 55                	push   $0x55
80106208:	e9 4d f8 ff ff       	jmp    80105a5a <alltraps>

8010620d <vector86>:
8010620d:	6a 00                	push   $0x0
8010620f:	6a 56                	push   $0x56
80106211:	e9 44 f8 ff ff       	jmp    80105a5a <alltraps>

80106216 <vector87>:
80106216:	6a 00                	push   $0x0
80106218:	6a 57                	push   $0x57
8010621a:	e9 3b f8 ff ff       	jmp    80105a5a <alltraps>

8010621f <vector88>:
8010621f:	6a 00                	push   $0x0
80106221:	6a 58                	push   $0x58
80106223:	e9 32 f8 ff ff       	jmp    80105a5a <alltraps>

80106228 <vector89>:
80106228:	6a 00                	push   $0x0
8010622a:	6a 59                	push   $0x59
8010622c:	e9 29 f8 ff ff       	jmp    80105a5a <alltraps>

80106231 <vector90>:
80106231:	6a 00                	push   $0x0
80106233:	6a 5a                	push   $0x5a
80106235:	e9 20 f8 ff ff       	jmp    80105a5a <alltraps>

8010623a <vector91>:
8010623a:	6a 00                	push   $0x0
8010623c:	6a 5b                	push   $0x5b
8010623e:	e9 17 f8 ff ff       	jmp    80105a5a <alltraps>

80106243 <vector92>:
80106243:	6a 00                	push   $0x0
80106245:	6a 5c                	push   $0x5c
80106247:	e9 0e f8 ff ff       	jmp    80105a5a <alltraps>

8010624c <vector93>:
8010624c:	6a 00                	push   $0x0
8010624e:	6a 5d                	push   $0x5d
80106250:	e9 05 f8 ff ff       	jmp    80105a5a <alltraps>

80106255 <vector94>:
80106255:	6a 00                	push   $0x0
80106257:	6a 5e                	push   $0x5e
80106259:	e9 fc f7 ff ff       	jmp    80105a5a <alltraps>

8010625e <vector95>:
8010625e:	6a 00                	push   $0x0
80106260:	6a 5f                	push   $0x5f
80106262:	e9 f3 f7 ff ff       	jmp    80105a5a <alltraps>

80106267 <vector96>:
80106267:	6a 00                	push   $0x0
80106269:	6a 60                	push   $0x60
8010626b:	e9 ea f7 ff ff       	jmp    80105a5a <alltraps>

80106270 <vector97>:
80106270:	6a 00                	push   $0x0
80106272:	6a 61                	push   $0x61
80106274:	e9 e1 f7 ff ff       	jmp    80105a5a <alltraps>

80106279 <vector98>:
80106279:	6a 00                	push   $0x0
8010627b:	6a 62                	push   $0x62
8010627d:	e9 d8 f7 ff ff       	jmp    80105a5a <alltraps>

80106282 <vector99>:
80106282:	6a 00                	push   $0x0
80106284:	6a 63                	push   $0x63
80106286:	e9 cf f7 ff ff       	jmp    80105a5a <alltraps>

8010628b <vector100>:
8010628b:	6a 00                	push   $0x0
8010628d:	6a 64                	push   $0x64
8010628f:	e9 c6 f7 ff ff       	jmp    80105a5a <alltraps>

80106294 <vector101>:
80106294:	6a 00                	push   $0x0
80106296:	6a 65                	push   $0x65
80106298:	e9 bd f7 ff ff       	jmp    80105a5a <alltraps>

8010629d <vector102>:
8010629d:	6a 00                	push   $0x0
8010629f:	6a 66                	push   $0x66
801062a1:	e9 b4 f7 ff ff       	jmp    80105a5a <alltraps>

801062a6 <vector103>:
801062a6:	6a 00                	push   $0x0
801062a8:	6a 67                	push   $0x67
801062aa:	e9 ab f7 ff ff       	jmp    80105a5a <alltraps>

801062af <vector104>:
801062af:	6a 00                	push   $0x0
801062b1:	6a 68                	push   $0x68
801062b3:	e9 a2 f7 ff ff       	jmp    80105a5a <alltraps>

801062b8 <vector105>:
801062b8:	6a 00                	push   $0x0
801062ba:	6a 69                	push   $0x69
801062bc:	e9 99 f7 ff ff       	jmp    80105a5a <alltraps>

801062c1 <vector106>:
801062c1:	6a 00                	push   $0x0
801062c3:	6a 6a                	push   $0x6a
801062c5:	e9 90 f7 ff ff       	jmp    80105a5a <alltraps>

801062ca <vector107>:
801062ca:	6a 00                	push   $0x0
801062cc:	6a 6b                	push   $0x6b
801062ce:	e9 87 f7 ff ff       	jmp    80105a5a <alltraps>

801062d3 <vector108>:
801062d3:	6a 00                	push   $0x0
801062d5:	6a 6c                	push   $0x6c
801062d7:	e9 7e f7 ff ff       	jmp    80105a5a <alltraps>

801062dc <vector109>:
801062dc:	6a 00                	push   $0x0
801062de:	6a 6d                	push   $0x6d
801062e0:	e9 75 f7 ff ff       	jmp    80105a5a <alltraps>

801062e5 <vector110>:
801062e5:	6a 00                	push   $0x0
801062e7:	6a 6e                	push   $0x6e
801062e9:	e9 6c f7 ff ff       	jmp    80105a5a <alltraps>

801062ee <vector111>:
801062ee:	6a 00                	push   $0x0
801062f0:	6a 6f                	push   $0x6f
801062f2:	e9 63 f7 ff ff       	jmp    80105a5a <alltraps>

801062f7 <vector112>:
801062f7:	6a 00                	push   $0x0
801062f9:	6a 70                	push   $0x70
801062fb:	e9 5a f7 ff ff       	jmp    80105a5a <alltraps>

80106300 <vector113>:
80106300:	6a 00                	push   $0x0
80106302:	6a 71                	push   $0x71
80106304:	e9 51 f7 ff ff       	jmp    80105a5a <alltraps>

80106309 <vector114>:
80106309:	6a 00                	push   $0x0
8010630b:	6a 72                	push   $0x72
8010630d:	e9 48 f7 ff ff       	jmp    80105a5a <alltraps>

80106312 <vector115>:
80106312:	6a 00                	push   $0x0
80106314:	6a 73                	push   $0x73
80106316:	e9 3f f7 ff ff       	jmp    80105a5a <alltraps>

8010631b <vector116>:
8010631b:	6a 00                	push   $0x0
8010631d:	6a 74                	push   $0x74
8010631f:	e9 36 f7 ff ff       	jmp    80105a5a <alltraps>

80106324 <vector117>:
80106324:	6a 00                	push   $0x0
80106326:	6a 75                	push   $0x75
80106328:	e9 2d f7 ff ff       	jmp    80105a5a <alltraps>

8010632d <vector118>:
8010632d:	6a 00                	push   $0x0
8010632f:	6a 76                	push   $0x76
80106331:	e9 24 f7 ff ff       	jmp    80105a5a <alltraps>

80106336 <vector119>:
80106336:	6a 00                	push   $0x0
80106338:	6a 77                	push   $0x77
8010633a:	e9 1b f7 ff ff       	jmp    80105a5a <alltraps>

8010633f <vector120>:
8010633f:	6a 00                	push   $0x0
80106341:	6a 78                	push   $0x78
80106343:	e9 12 f7 ff ff       	jmp    80105a5a <alltraps>

80106348 <vector121>:
80106348:	6a 00                	push   $0x0
8010634a:	6a 79                	push   $0x79
8010634c:	e9 09 f7 ff ff       	jmp    80105a5a <alltraps>

80106351 <vector122>:
80106351:	6a 00                	push   $0x0
80106353:	6a 7a                	push   $0x7a
80106355:	e9 00 f7 ff ff       	jmp    80105a5a <alltraps>

8010635a <vector123>:
8010635a:	6a 00                	push   $0x0
8010635c:	6a 7b                	push   $0x7b
8010635e:	e9 f7 f6 ff ff       	jmp    80105a5a <alltraps>

80106363 <vector124>:
80106363:	6a 00                	push   $0x0
80106365:	6a 7c                	push   $0x7c
80106367:	e9 ee f6 ff ff       	jmp    80105a5a <alltraps>

8010636c <vector125>:
8010636c:	6a 00                	push   $0x0
8010636e:	6a 7d                	push   $0x7d
80106370:	e9 e5 f6 ff ff       	jmp    80105a5a <alltraps>

80106375 <vector126>:
80106375:	6a 00                	push   $0x0
80106377:	6a 7e                	push   $0x7e
80106379:	e9 dc f6 ff ff       	jmp    80105a5a <alltraps>

8010637e <vector127>:
8010637e:	6a 00                	push   $0x0
80106380:	6a 7f                	push   $0x7f
80106382:	e9 d3 f6 ff ff       	jmp    80105a5a <alltraps>

80106387 <vector128>:
80106387:	6a 00                	push   $0x0
80106389:	68 80 00 00 00       	push   $0x80
8010638e:	e9 c7 f6 ff ff       	jmp    80105a5a <alltraps>

80106393 <vector129>:
80106393:	6a 00                	push   $0x0
80106395:	68 81 00 00 00       	push   $0x81
8010639a:	e9 bb f6 ff ff       	jmp    80105a5a <alltraps>

8010639f <vector130>:
8010639f:	6a 00                	push   $0x0
801063a1:	68 82 00 00 00       	push   $0x82
801063a6:	e9 af f6 ff ff       	jmp    80105a5a <alltraps>

801063ab <vector131>:
801063ab:	6a 00                	push   $0x0
801063ad:	68 83 00 00 00       	push   $0x83
801063b2:	e9 a3 f6 ff ff       	jmp    80105a5a <alltraps>

801063b7 <vector132>:
801063b7:	6a 00                	push   $0x0
801063b9:	68 84 00 00 00       	push   $0x84
801063be:	e9 97 f6 ff ff       	jmp    80105a5a <alltraps>

801063c3 <vector133>:
801063c3:	6a 00                	push   $0x0
801063c5:	68 85 00 00 00       	push   $0x85
801063ca:	e9 8b f6 ff ff       	jmp    80105a5a <alltraps>

801063cf <vector134>:
801063cf:	6a 00                	push   $0x0
801063d1:	68 86 00 00 00       	push   $0x86
801063d6:	e9 7f f6 ff ff       	jmp    80105a5a <alltraps>

801063db <vector135>:
801063db:	6a 00                	push   $0x0
801063dd:	68 87 00 00 00       	push   $0x87
801063e2:	e9 73 f6 ff ff       	jmp    80105a5a <alltraps>

801063e7 <vector136>:
801063e7:	6a 00                	push   $0x0
801063e9:	68 88 00 00 00       	push   $0x88
801063ee:	e9 67 f6 ff ff       	jmp    80105a5a <alltraps>

801063f3 <vector137>:
801063f3:	6a 00                	push   $0x0
801063f5:	68 89 00 00 00       	push   $0x89
801063fa:	e9 5b f6 ff ff       	jmp    80105a5a <alltraps>

801063ff <vector138>:
801063ff:	6a 00                	push   $0x0
80106401:	68 8a 00 00 00       	push   $0x8a
80106406:	e9 4f f6 ff ff       	jmp    80105a5a <alltraps>

8010640b <vector139>:
8010640b:	6a 00                	push   $0x0
8010640d:	68 8b 00 00 00       	push   $0x8b
80106412:	e9 43 f6 ff ff       	jmp    80105a5a <alltraps>

80106417 <vector140>:
80106417:	6a 00                	push   $0x0
80106419:	68 8c 00 00 00       	push   $0x8c
8010641e:	e9 37 f6 ff ff       	jmp    80105a5a <alltraps>

80106423 <vector141>:
80106423:	6a 00                	push   $0x0
80106425:	68 8d 00 00 00       	push   $0x8d
8010642a:	e9 2b f6 ff ff       	jmp    80105a5a <alltraps>

8010642f <vector142>:
8010642f:	6a 00                	push   $0x0
80106431:	68 8e 00 00 00       	push   $0x8e
80106436:	e9 1f f6 ff ff       	jmp    80105a5a <alltraps>

8010643b <vector143>:
8010643b:	6a 00                	push   $0x0
8010643d:	68 8f 00 00 00       	push   $0x8f
80106442:	e9 13 f6 ff ff       	jmp    80105a5a <alltraps>

80106447 <vector144>:
80106447:	6a 00                	push   $0x0
80106449:	68 90 00 00 00       	push   $0x90
8010644e:	e9 07 f6 ff ff       	jmp    80105a5a <alltraps>

80106453 <vector145>:
80106453:	6a 00                	push   $0x0
80106455:	68 91 00 00 00       	push   $0x91
8010645a:	e9 fb f5 ff ff       	jmp    80105a5a <alltraps>

8010645f <vector146>:
8010645f:	6a 00                	push   $0x0
80106461:	68 92 00 00 00       	push   $0x92
80106466:	e9 ef f5 ff ff       	jmp    80105a5a <alltraps>

8010646b <vector147>:
8010646b:	6a 00                	push   $0x0
8010646d:	68 93 00 00 00       	push   $0x93
80106472:	e9 e3 f5 ff ff       	jmp    80105a5a <alltraps>

80106477 <vector148>:
80106477:	6a 00                	push   $0x0
80106479:	68 94 00 00 00       	push   $0x94
8010647e:	e9 d7 f5 ff ff       	jmp    80105a5a <alltraps>

80106483 <vector149>:
80106483:	6a 00                	push   $0x0
80106485:	68 95 00 00 00       	push   $0x95
8010648a:	e9 cb f5 ff ff       	jmp    80105a5a <alltraps>

8010648f <vector150>:
8010648f:	6a 00                	push   $0x0
80106491:	68 96 00 00 00       	push   $0x96
80106496:	e9 bf f5 ff ff       	jmp    80105a5a <alltraps>

8010649b <vector151>:
8010649b:	6a 00                	push   $0x0
8010649d:	68 97 00 00 00       	push   $0x97
801064a2:	e9 b3 f5 ff ff       	jmp    80105a5a <alltraps>

801064a7 <vector152>:
801064a7:	6a 00                	push   $0x0
801064a9:	68 98 00 00 00       	push   $0x98
801064ae:	e9 a7 f5 ff ff       	jmp    80105a5a <alltraps>

801064b3 <vector153>:
801064b3:	6a 00                	push   $0x0
801064b5:	68 99 00 00 00       	push   $0x99
801064ba:	e9 9b f5 ff ff       	jmp    80105a5a <alltraps>

801064bf <vector154>:
801064bf:	6a 00                	push   $0x0
801064c1:	68 9a 00 00 00       	push   $0x9a
801064c6:	e9 8f f5 ff ff       	jmp    80105a5a <alltraps>

801064cb <vector155>:
801064cb:	6a 00                	push   $0x0
801064cd:	68 9b 00 00 00       	push   $0x9b
801064d2:	e9 83 f5 ff ff       	jmp    80105a5a <alltraps>

801064d7 <vector156>:
801064d7:	6a 00                	push   $0x0
801064d9:	68 9c 00 00 00       	push   $0x9c
801064de:	e9 77 f5 ff ff       	jmp    80105a5a <alltraps>

801064e3 <vector157>:
801064e3:	6a 00                	push   $0x0
801064e5:	68 9d 00 00 00       	push   $0x9d
801064ea:	e9 6b f5 ff ff       	jmp    80105a5a <alltraps>

801064ef <vector158>:
801064ef:	6a 00                	push   $0x0
801064f1:	68 9e 00 00 00       	push   $0x9e
801064f6:	e9 5f f5 ff ff       	jmp    80105a5a <alltraps>

801064fb <vector159>:
801064fb:	6a 00                	push   $0x0
801064fd:	68 9f 00 00 00       	push   $0x9f
80106502:	e9 53 f5 ff ff       	jmp    80105a5a <alltraps>

80106507 <vector160>:
80106507:	6a 00                	push   $0x0
80106509:	68 a0 00 00 00       	push   $0xa0
8010650e:	e9 47 f5 ff ff       	jmp    80105a5a <alltraps>

80106513 <vector161>:
80106513:	6a 00                	push   $0x0
80106515:	68 a1 00 00 00       	push   $0xa1
8010651a:	e9 3b f5 ff ff       	jmp    80105a5a <alltraps>

8010651f <vector162>:
8010651f:	6a 00                	push   $0x0
80106521:	68 a2 00 00 00       	push   $0xa2
80106526:	e9 2f f5 ff ff       	jmp    80105a5a <alltraps>

8010652b <vector163>:
8010652b:	6a 00                	push   $0x0
8010652d:	68 a3 00 00 00       	push   $0xa3
80106532:	e9 23 f5 ff ff       	jmp    80105a5a <alltraps>

80106537 <vector164>:
80106537:	6a 00                	push   $0x0
80106539:	68 a4 00 00 00       	push   $0xa4
8010653e:	e9 17 f5 ff ff       	jmp    80105a5a <alltraps>

80106543 <vector165>:
80106543:	6a 00                	push   $0x0
80106545:	68 a5 00 00 00       	push   $0xa5
8010654a:	e9 0b f5 ff ff       	jmp    80105a5a <alltraps>

8010654f <vector166>:
8010654f:	6a 00                	push   $0x0
80106551:	68 a6 00 00 00       	push   $0xa6
80106556:	e9 ff f4 ff ff       	jmp    80105a5a <alltraps>

8010655b <vector167>:
8010655b:	6a 00                	push   $0x0
8010655d:	68 a7 00 00 00       	push   $0xa7
80106562:	e9 f3 f4 ff ff       	jmp    80105a5a <alltraps>

80106567 <vector168>:
80106567:	6a 00                	push   $0x0
80106569:	68 a8 00 00 00       	push   $0xa8
8010656e:	e9 e7 f4 ff ff       	jmp    80105a5a <alltraps>

80106573 <vector169>:
80106573:	6a 00                	push   $0x0
80106575:	68 a9 00 00 00       	push   $0xa9
8010657a:	e9 db f4 ff ff       	jmp    80105a5a <alltraps>

8010657f <vector170>:
8010657f:	6a 00                	push   $0x0
80106581:	68 aa 00 00 00       	push   $0xaa
80106586:	e9 cf f4 ff ff       	jmp    80105a5a <alltraps>

8010658b <vector171>:
8010658b:	6a 00                	push   $0x0
8010658d:	68 ab 00 00 00       	push   $0xab
80106592:	e9 c3 f4 ff ff       	jmp    80105a5a <alltraps>

80106597 <vector172>:
80106597:	6a 00                	push   $0x0
80106599:	68 ac 00 00 00       	push   $0xac
8010659e:	e9 b7 f4 ff ff       	jmp    80105a5a <alltraps>

801065a3 <vector173>:
801065a3:	6a 00                	push   $0x0
801065a5:	68 ad 00 00 00       	push   $0xad
801065aa:	e9 ab f4 ff ff       	jmp    80105a5a <alltraps>

801065af <vector174>:
801065af:	6a 00                	push   $0x0
801065b1:	68 ae 00 00 00       	push   $0xae
801065b6:	e9 9f f4 ff ff       	jmp    80105a5a <alltraps>

801065bb <vector175>:
801065bb:	6a 00                	push   $0x0
801065bd:	68 af 00 00 00       	push   $0xaf
801065c2:	e9 93 f4 ff ff       	jmp    80105a5a <alltraps>

801065c7 <vector176>:
801065c7:	6a 00                	push   $0x0
801065c9:	68 b0 00 00 00       	push   $0xb0
801065ce:	e9 87 f4 ff ff       	jmp    80105a5a <alltraps>

801065d3 <vector177>:
801065d3:	6a 00                	push   $0x0
801065d5:	68 b1 00 00 00       	push   $0xb1
801065da:	e9 7b f4 ff ff       	jmp    80105a5a <alltraps>

801065df <vector178>:
801065df:	6a 00                	push   $0x0
801065e1:	68 b2 00 00 00       	push   $0xb2
801065e6:	e9 6f f4 ff ff       	jmp    80105a5a <alltraps>

801065eb <vector179>:
801065eb:	6a 00                	push   $0x0
801065ed:	68 b3 00 00 00       	push   $0xb3
801065f2:	e9 63 f4 ff ff       	jmp    80105a5a <alltraps>

801065f7 <vector180>:
801065f7:	6a 00                	push   $0x0
801065f9:	68 b4 00 00 00       	push   $0xb4
801065fe:	e9 57 f4 ff ff       	jmp    80105a5a <alltraps>

80106603 <vector181>:
80106603:	6a 00                	push   $0x0
80106605:	68 b5 00 00 00       	push   $0xb5
8010660a:	e9 4b f4 ff ff       	jmp    80105a5a <alltraps>

8010660f <vector182>:
8010660f:	6a 00                	push   $0x0
80106611:	68 b6 00 00 00       	push   $0xb6
80106616:	e9 3f f4 ff ff       	jmp    80105a5a <alltraps>

8010661b <vector183>:
8010661b:	6a 00                	push   $0x0
8010661d:	68 b7 00 00 00       	push   $0xb7
80106622:	e9 33 f4 ff ff       	jmp    80105a5a <alltraps>

80106627 <vector184>:
80106627:	6a 00                	push   $0x0
80106629:	68 b8 00 00 00       	push   $0xb8
8010662e:	e9 27 f4 ff ff       	jmp    80105a5a <alltraps>

80106633 <vector185>:
80106633:	6a 00                	push   $0x0
80106635:	68 b9 00 00 00       	push   $0xb9
8010663a:	e9 1b f4 ff ff       	jmp    80105a5a <alltraps>

8010663f <vector186>:
8010663f:	6a 00                	push   $0x0
80106641:	68 ba 00 00 00       	push   $0xba
80106646:	e9 0f f4 ff ff       	jmp    80105a5a <alltraps>

8010664b <vector187>:
8010664b:	6a 00                	push   $0x0
8010664d:	68 bb 00 00 00       	push   $0xbb
80106652:	e9 03 f4 ff ff       	jmp    80105a5a <alltraps>

80106657 <vector188>:
80106657:	6a 00                	push   $0x0
80106659:	68 bc 00 00 00       	push   $0xbc
8010665e:	e9 f7 f3 ff ff       	jmp    80105a5a <alltraps>

80106663 <vector189>:
80106663:	6a 00                	push   $0x0
80106665:	68 bd 00 00 00       	push   $0xbd
8010666a:	e9 eb f3 ff ff       	jmp    80105a5a <alltraps>

8010666f <vector190>:
8010666f:	6a 00                	push   $0x0
80106671:	68 be 00 00 00       	push   $0xbe
80106676:	e9 df f3 ff ff       	jmp    80105a5a <alltraps>

8010667b <vector191>:
8010667b:	6a 00                	push   $0x0
8010667d:	68 bf 00 00 00       	push   $0xbf
80106682:	e9 d3 f3 ff ff       	jmp    80105a5a <alltraps>

80106687 <vector192>:
80106687:	6a 00                	push   $0x0
80106689:	68 c0 00 00 00       	push   $0xc0
8010668e:	e9 c7 f3 ff ff       	jmp    80105a5a <alltraps>

80106693 <vector193>:
80106693:	6a 00                	push   $0x0
80106695:	68 c1 00 00 00       	push   $0xc1
8010669a:	e9 bb f3 ff ff       	jmp    80105a5a <alltraps>

8010669f <vector194>:
8010669f:	6a 00                	push   $0x0
801066a1:	68 c2 00 00 00       	push   $0xc2
801066a6:	e9 af f3 ff ff       	jmp    80105a5a <alltraps>

801066ab <vector195>:
801066ab:	6a 00                	push   $0x0
801066ad:	68 c3 00 00 00       	push   $0xc3
801066b2:	e9 a3 f3 ff ff       	jmp    80105a5a <alltraps>

801066b7 <vector196>:
801066b7:	6a 00                	push   $0x0
801066b9:	68 c4 00 00 00       	push   $0xc4
801066be:	e9 97 f3 ff ff       	jmp    80105a5a <alltraps>

801066c3 <vector197>:
801066c3:	6a 00                	push   $0x0
801066c5:	68 c5 00 00 00       	push   $0xc5
801066ca:	e9 8b f3 ff ff       	jmp    80105a5a <alltraps>

801066cf <vector198>:
801066cf:	6a 00                	push   $0x0
801066d1:	68 c6 00 00 00       	push   $0xc6
801066d6:	e9 7f f3 ff ff       	jmp    80105a5a <alltraps>

801066db <vector199>:
801066db:	6a 00                	push   $0x0
801066dd:	68 c7 00 00 00       	push   $0xc7
801066e2:	e9 73 f3 ff ff       	jmp    80105a5a <alltraps>

801066e7 <vector200>:
801066e7:	6a 00                	push   $0x0
801066e9:	68 c8 00 00 00       	push   $0xc8
801066ee:	e9 67 f3 ff ff       	jmp    80105a5a <alltraps>

801066f3 <vector201>:
801066f3:	6a 00                	push   $0x0
801066f5:	68 c9 00 00 00       	push   $0xc9
801066fa:	e9 5b f3 ff ff       	jmp    80105a5a <alltraps>

801066ff <vector202>:
801066ff:	6a 00                	push   $0x0
80106701:	68 ca 00 00 00       	push   $0xca
80106706:	e9 4f f3 ff ff       	jmp    80105a5a <alltraps>

8010670b <vector203>:
8010670b:	6a 00                	push   $0x0
8010670d:	68 cb 00 00 00       	push   $0xcb
80106712:	e9 43 f3 ff ff       	jmp    80105a5a <alltraps>

80106717 <vector204>:
80106717:	6a 00                	push   $0x0
80106719:	68 cc 00 00 00       	push   $0xcc
8010671e:	e9 37 f3 ff ff       	jmp    80105a5a <alltraps>

80106723 <vector205>:
80106723:	6a 00                	push   $0x0
80106725:	68 cd 00 00 00       	push   $0xcd
8010672a:	e9 2b f3 ff ff       	jmp    80105a5a <alltraps>

8010672f <vector206>:
8010672f:	6a 00                	push   $0x0
80106731:	68 ce 00 00 00       	push   $0xce
80106736:	e9 1f f3 ff ff       	jmp    80105a5a <alltraps>

8010673b <vector207>:
8010673b:	6a 00                	push   $0x0
8010673d:	68 cf 00 00 00       	push   $0xcf
80106742:	e9 13 f3 ff ff       	jmp    80105a5a <alltraps>

80106747 <vector208>:
80106747:	6a 00                	push   $0x0
80106749:	68 d0 00 00 00       	push   $0xd0
8010674e:	e9 07 f3 ff ff       	jmp    80105a5a <alltraps>

80106753 <vector209>:
80106753:	6a 00                	push   $0x0
80106755:	68 d1 00 00 00       	push   $0xd1
8010675a:	e9 fb f2 ff ff       	jmp    80105a5a <alltraps>

8010675f <vector210>:
8010675f:	6a 00                	push   $0x0
80106761:	68 d2 00 00 00       	push   $0xd2
80106766:	e9 ef f2 ff ff       	jmp    80105a5a <alltraps>

8010676b <vector211>:
8010676b:	6a 00                	push   $0x0
8010676d:	68 d3 00 00 00       	push   $0xd3
80106772:	e9 e3 f2 ff ff       	jmp    80105a5a <alltraps>

80106777 <vector212>:
80106777:	6a 00                	push   $0x0
80106779:	68 d4 00 00 00       	push   $0xd4
8010677e:	e9 d7 f2 ff ff       	jmp    80105a5a <alltraps>

80106783 <vector213>:
80106783:	6a 00                	push   $0x0
80106785:	68 d5 00 00 00       	push   $0xd5
8010678a:	e9 cb f2 ff ff       	jmp    80105a5a <alltraps>

8010678f <vector214>:
8010678f:	6a 00                	push   $0x0
80106791:	68 d6 00 00 00       	push   $0xd6
80106796:	e9 bf f2 ff ff       	jmp    80105a5a <alltraps>

8010679b <vector215>:
8010679b:	6a 00                	push   $0x0
8010679d:	68 d7 00 00 00       	push   $0xd7
801067a2:	e9 b3 f2 ff ff       	jmp    80105a5a <alltraps>

801067a7 <vector216>:
801067a7:	6a 00                	push   $0x0
801067a9:	68 d8 00 00 00       	push   $0xd8
801067ae:	e9 a7 f2 ff ff       	jmp    80105a5a <alltraps>

801067b3 <vector217>:
801067b3:	6a 00                	push   $0x0
801067b5:	68 d9 00 00 00       	push   $0xd9
801067ba:	e9 9b f2 ff ff       	jmp    80105a5a <alltraps>

801067bf <vector218>:
801067bf:	6a 00                	push   $0x0
801067c1:	68 da 00 00 00       	push   $0xda
801067c6:	e9 8f f2 ff ff       	jmp    80105a5a <alltraps>

801067cb <vector219>:
801067cb:	6a 00                	push   $0x0
801067cd:	68 db 00 00 00       	push   $0xdb
801067d2:	e9 83 f2 ff ff       	jmp    80105a5a <alltraps>

801067d7 <vector220>:
801067d7:	6a 00                	push   $0x0
801067d9:	68 dc 00 00 00       	push   $0xdc
801067de:	e9 77 f2 ff ff       	jmp    80105a5a <alltraps>

801067e3 <vector221>:
801067e3:	6a 00                	push   $0x0
801067e5:	68 dd 00 00 00       	push   $0xdd
801067ea:	e9 6b f2 ff ff       	jmp    80105a5a <alltraps>

801067ef <vector222>:
801067ef:	6a 00                	push   $0x0
801067f1:	68 de 00 00 00       	push   $0xde
801067f6:	e9 5f f2 ff ff       	jmp    80105a5a <alltraps>

801067fb <vector223>:
801067fb:	6a 00                	push   $0x0
801067fd:	68 df 00 00 00       	push   $0xdf
80106802:	e9 53 f2 ff ff       	jmp    80105a5a <alltraps>

80106807 <vector224>:
80106807:	6a 00                	push   $0x0
80106809:	68 e0 00 00 00       	push   $0xe0
8010680e:	e9 47 f2 ff ff       	jmp    80105a5a <alltraps>

80106813 <vector225>:
80106813:	6a 00                	push   $0x0
80106815:	68 e1 00 00 00       	push   $0xe1
8010681a:	e9 3b f2 ff ff       	jmp    80105a5a <alltraps>

8010681f <vector226>:
8010681f:	6a 00                	push   $0x0
80106821:	68 e2 00 00 00       	push   $0xe2
80106826:	e9 2f f2 ff ff       	jmp    80105a5a <alltraps>

8010682b <vector227>:
8010682b:	6a 00                	push   $0x0
8010682d:	68 e3 00 00 00       	push   $0xe3
80106832:	e9 23 f2 ff ff       	jmp    80105a5a <alltraps>

80106837 <vector228>:
80106837:	6a 00                	push   $0x0
80106839:	68 e4 00 00 00       	push   $0xe4
8010683e:	e9 17 f2 ff ff       	jmp    80105a5a <alltraps>

80106843 <vector229>:
80106843:	6a 00                	push   $0x0
80106845:	68 e5 00 00 00       	push   $0xe5
8010684a:	e9 0b f2 ff ff       	jmp    80105a5a <alltraps>

8010684f <vector230>:
8010684f:	6a 00                	push   $0x0
80106851:	68 e6 00 00 00       	push   $0xe6
80106856:	e9 ff f1 ff ff       	jmp    80105a5a <alltraps>

8010685b <vector231>:
8010685b:	6a 00                	push   $0x0
8010685d:	68 e7 00 00 00       	push   $0xe7
80106862:	e9 f3 f1 ff ff       	jmp    80105a5a <alltraps>

80106867 <vector232>:
80106867:	6a 00                	push   $0x0
80106869:	68 e8 00 00 00       	push   $0xe8
8010686e:	e9 e7 f1 ff ff       	jmp    80105a5a <alltraps>

80106873 <vector233>:
80106873:	6a 00                	push   $0x0
80106875:	68 e9 00 00 00       	push   $0xe9
8010687a:	e9 db f1 ff ff       	jmp    80105a5a <alltraps>

8010687f <vector234>:
8010687f:	6a 00                	push   $0x0
80106881:	68 ea 00 00 00       	push   $0xea
80106886:	e9 cf f1 ff ff       	jmp    80105a5a <alltraps>

8010688b <vector235>:
8010688b:	6a 00                	push   $0x0
8010688d:	68 eb 00 00 00       	push   $0xeb
80106892:	e9 c3 f1 ff ff       	jmp    80105a5a <alltraps>

80106897 <vector236>:
80106897:	6a 00                	push   $0x0
80106899:	68 ec 00 00 00       	push   $0xec
8010689e:	e9 b7 f1 ff ff       	jmp    80105a5a <alltraps>

801068a3 <vector237>:
801068a3:	6a 00                	push   $0x0
801068a5:	68 ed 00 00 00       	push   $0xed
801068aa:	e9 ab f1 ff ff       	jmp    80105a5a <alltraps>

801068af <vector238>:
801068af:	6a 00                	push   $0x0
801068b1:	68 ee 00 00 00       	push   $0xee
801068b6:	e9 9f f1 ff ff       	jmp    80105a5a <alltraps>

801068bb <vector239>:
801068bb:	6a 00                	push   $0x0
801068bd:	68 ef 00 00 00       	push   $0xef
801068c2:	e9 93 f1 ff ff       	jmp    80105a5a <alltraps>

801068c7 <vector240>:
801068c7:	6a 00                	push   $0x0
801068c9:	68 f0 00 00 00       	push   $0xf0
801068ce:	e9 87 f1 ff ff       	jmp    80105a5a <alltraps>

801068d3 <vector241>:
801068d3:	6a 00                	push   $0x0
801068d5:	68 f1 00 00 00       	push   $0xf1
801068da:	e9 7b f1 ff ff       	jmp    80105a5a <alltraps>

801068df <vector242>:
801068df:	6a 00                	push   $0x0
801068e1:	68 f2 00 00 00       	push   $0xf2
801068e6:	e9 6f f1 ff ff       	jmp    80105a5a <alltraps>

801068eb <vector243>:
801068eb:	6a 00                	push   $0x0
801068ed:	68 f3 00 00 00       	push   $0xf3
801068f2:	e9 63 f1 ff ff       	jmp    80105a5a <alltraps>

801068f7 <vector244>:
801068f7:	6a 00                	push   $0x0
801068f9:	68 f4 00 00 00       	push   $0xf4
801068fe:	e9 57 f1 ff ff       	jmp    80105a5a <alltraps>

80106903 <vector245>:
80106903:	6a 00                	push   $0x0
80106905:	68 f5 00 00 00       	push   $0xf5
8010690a:	e9 4b f1 ff ff       	jmp    80105a5a <alltraps>

8010690f <vector246>:
8010690f:	6a 00                	push   $0x0
80106911:	68 f6 00 00 00       	push   $0xf6
80106916:	e9 3f f1 ff ff       	jmp    80105a5a <alltraps>

8010691b <vector247>:
8010691b:	6a 00                	push   $0x0
8010691d:	68 f7 00 00 00       	push   $0xf7
80106922:	e9 33 f1 ff ff       	jmp    80105a5a <alltraps>

80106927 <vector248>:
80106927:	6a 00                	push   $0x0
80106929:	68 f8 00 00 00       	push   $0xf8
8010692e:	e9 27 f1 ff ff       	jmp    80105a5a <alltraps>

80106933 <vector249>:
80106933:	6a 00                	push   $0x0
80106935:	68 f9 00 00 00       	push   $0xf9
8010693a:	e9 1b f1 ff ff       	jmp    80105a5a <alltraps>

8010693f <vector250>:
8010693f:	6a 00                	push   $0x0
80106941:	68 fa 00 00 00       	push   $0xfa
80106946:	e9 0f f1 ff ff       	jmp    80105a5a <alltraps>

8010694b <vector251>:
8010694b:	6a 00                	push   $0x0
8010694d:	68 fb 00 00 00       	push   $0xfb
80106952:	e9 03 f1 ff ff       	jmp    80105a5a <alltraps>

80106957 <vector252>:
80106957:	6a 00                	push   $0x0
80106959:	68 fc 00 00 00       	push   $0xfc
8010695e:	e9 f7 f0 ff ff       	jmp    80105a5a <alltraps>

80106963 <vector253>:
80106963:	6a 00                	push   $0x0
80106965:	68 fd 00 00 00       	push   $0xfd
8010696a:	e9 eb f0 ff ff       	jmp    80105a5a <alltraps>

8010696f <vector254>:
8010696f:	6a 00                	push   $0x0
80106971:	68 fe 00 00 00       	push   $0xfe
80106976:	e9 df f0 ff ff       	jmp    80105a5a <alltraps>

8010697b <vector255>:
8010697b:	6a 00                	push   $0x0
8010697d:	68 ff 00 00 00       	push   $0xff
80106982:	e9 d3 f0 ff ff       	jmp    80105a5a <alltraps>
80106987:	66 90                	xchg   %ax,%ax
80106989:	66 90                	xchg   %ax,%ax
8010698b:	66 90                	xchg   %ax,%ax
8010698d:	66 90                	xchg   %ax,%ax
8010698f:	90                   	nop

80106990 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	57                   	push   %edi
80106994:	56                   	push   %esi
80106995:	53                   	push   %ebx
80106996:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106998:	c1 ea 16             	shr    $0x16,%edx
8010699b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010699e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801069a1:	8b 07                	mov    (%edi),%eax
801069a3:	a8 01                	test   $0x1,%al
801069a5:	74 29                	je     801069d0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801069a7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069ac:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801069b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801069b5:	c1 eb 0a             	shr    $0xa,%ebx
801069b8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
801069be:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
801069c1:	5b                   	pop    %ebx
801069c2:	5e                   	pop    %esi
801069c3:	5f                   	pop    %edi
801069c4:	5d                   	pop    %ebp
801069c5:	c3                   	ret    
801069c6:	8d 76 00             	lea    0x0(%esi),%esi
801069c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801069d0:	85 c9                	test   %ecx,%ecx
801069d2:	74 2c                	je     80106a00 <walkpgdir+0x70>
801069d4:	e8 77 be ff ff       	call   80102850 <kalloc>
801069d9:	85 c0                	test   %eax,%eax
801069db:	89 c6                	mov    %eax,%esi
801069dd:	74 21                	je     80106a00 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801069df:	83 ec 04             	sub    $0x4,%esp
801069e2:	68 00 10 00 00       	push   $0x1000
801069e7:	6a 00                	push   $0x0
801069e9:	50                   	push   %eax
801069ea:	e8 51 de ff ff       	call   80104840 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069ef:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801069f5:	83 c4 10             	add    $0x10,%esp
801069f8:	83 c8 07             	or     $0x7,%eax
801069fb:	89 07                	mov    %eax,(%edi)
801069fd:	eb b3                	jmp    801069b2 <walkpgdir+0x22>
801069ff:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106a00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106a03:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106a05:	5b                   	pop    %ebx
80106a06:	5e                   	pop    %esi
80106a07:	5f                   	pop    %edi
80106a08:	5d                   	pop    %ebp
80106a09:	c3                   	ret    
80106a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106a10 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
80106a14:	56                   	push   %esi
80106a15:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106a16:	89 d3                	mov    %edx,%ebx
80106a18:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a1e:	83 ec 1c             	sub    $0x1c,%esp
80106a21:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a24:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106a28:	8b 7d 08             	mov    0x8(%ebp),%edi
80106a2b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106a30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a33:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a36:	29 df                	sub    %ebx,%edi
80106a38:	83 c8 01             	or     $0x1,%eax
80106a3b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106a3e:	eb 15                	jmp    80106a55 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106a40:	f6 00 01             	testb  $0x1,(%eax)
80106a43:	75 45                	jne    80106a8a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a45:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106a48:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a4b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106a4d:	74 31                	je     80106a80 <mappages+0x70>
      break;
    a += PGSIZE;
80106a4f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a58:	b9 01 00 00 00       	mov    $0x1,%ecx
80106a5d:	89 da                	mov    %ebx,%edx
80106a5f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106a62:	e8 29 ff ff ff       	call   80106990 <walkpgdir>
80106a67:	85 c0                	test   %eax,%eax
80106a69:	75 d5                	jne    80106a40 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a6b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80106a6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a73:	5b                   	pop    %ebx
80106a74:	5e                   	pop    %esi
80106a75:	5f                   	pop    %edi
80106a76:	5d                   	pop    %ebp
80106a77:	c3                   	ret    
80106a78:	90                   	nop
80106a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a80:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106a83:	31 c0                	xor    %eax,%eax
}
80106a85:	5b                   	pop    %ebx
80106a86:	5e                   	pop    %esi
80106a87:	5f                   	pop    %edi
80106a88:	5d                   	pop    %ebp
80106a89:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106a8a:	83 ec 0c             	sub    $0xc,%esp
80106a8d:	68 f0 7b 10 80       	push   $0x80107bf0
80106a92:	e8 d9 98 ff ff       	call   80100370 <panic>
80106a97:	89 f6                	mov    %esi,%esi
80106a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106aa0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	57                   	push   %edi
80106aa4:	56                   	push   %esi
80106aa5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106aa6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106aac:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106aae:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ab4:	83 ec 1c             	sub    $0x1c,%esp
80106ab7:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106aba:	39 d3                	cmp    %edx,%ebx
80106abc:	73 66                	jae    80106b24 <deallocuvm.part.0+0x84>
80106abe:	89 d6                	mov    %edx,%esi
80106ac0:	eb 3d                	jmp    80106aff <deallocuvm.part.0+0x5f>
80106ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106ac8:	8b 10                	mov    (%eax),%edx
80106aca:	f6 c2 01             	test   $0x1,%dl
80106acd:	74 26                	je     80106af5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106acf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106ad5:	74 58                	je     80106b2f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106ad7:	83 ec 0c             	sub    $0xc,%esp
80106ada:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106ae0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ae3:	52                   	push   %edx
80106ae4:	e8 b7 bb ff ff       	call   801026a0 <kfree>
      *pte = 0;
80106ae9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106aec:	83 c4 10             	add    $0x10,%esp
80106aef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106af5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106afb:	39 f3                	cmp    %esi,%ebx
80106afd:	73 25                	jae    80106b24 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106aff:	31 c9                	xor    %ecx,%ecx
80106b01:	89 da                	mov    %ebx,%edx
80106b03:	89 f8                	mov    %edi,%eax
80106b05:	e8 86 fe ff ff       	call   80106990 <walkpgdir>
    if(!pte)
80106b0a:	85 c0                	test   %eax,%eax
80106b0c:	75 ba                	jne    80106ac8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106b0e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106b14:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106b1a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b20:	39 f3                	cmp    %esi,%ebx
80106b22:	72 db                	jb     80106aff <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106b24:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b27:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b2a:	5b                   	pop    %ebx
80106b2b:	5e                   	pop    %esi
80106b2c:	5f                   	pop    %edi
80106b2d:	5d                   	pop    %ebp
80106b2e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106b2f:	83 ec 0c             	sub    $0xc,%esp
80106b32:	68 86 75 10 80       	push   $0x80107586
80106b37:	e8 34 98 ff ff       	call   80100370 <panic>
80106b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b40 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106b46:	e8 35 d0 ff ff       	call   80103b80 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b4b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106b51:	31 c9                	xor    %ecx,%ecx
80106b53:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106b58:	66 89 90 f8 27 11 80 	mov    %dx,-0x7feed808(%eax)
80106b5f:	66 89 88 fa 27 11 80 	mov    %cx,-0x7feed806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b66:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106b6b:	31 c9                	xor    %ecx,%ecx
80106b6d:	66 89 90 00 28 11 80 	mov    %dx,-0x7feed800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b74:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b79:	66 89 88 02 28 11 80 	mov    %cx,-0x7feed7fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b80:	31 c9                	xor    %ecx,%ecx
80106b82:	66 89 90 08 28 11 80 	mov    %dx,-0x7feed7f8(%eax)
80106b89:	66 89 88 0a 28 11 80 	mov    %cx,-0x7feed7f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b90:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106b95:	31 c9                	xor    %ecx,%ecx
80106b97:	66 89 90 10 28 11 80 	mov    %dx,-0x7feed7f0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b9e:	c6 80 fc 27 11 80 00 	movb   $0x0,-0x7feed804(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106ba5:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106baa:	c6 80 fd 27 11 80 9a 	movb   $0x9a,-0x7feed803(%eax)
80106bb1:	c6 80 fe 27 11 80 cf 	movb   $0xcf,-0x7feed802(%eax)
80106bb8:	c6 80 ff 27 11 80 00 	movb   $0x0,-0x7feed801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106bbf:	c6 80 04 28 11 80 00 	movb   $0x0,-0x7feed7fc(%eax)
80106bc6:	c6 80 05 28 11 80 92 	movb   $0x92,-0x7feed7fb(%eax)
80106bcd:	c6 80 06 28 11 80 cf 	movb   $0xcf,-0x7feed7fa(%eax)
80106bd4:	c6 80 07 28 11 80 00 	movb   $0x0,-0x7feed7f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106bdb:	c6 80 0c 28 11 80 00 	movb   $0x0,-0x7feed7f4(%eax)
80106be2:	c6 80 0d 28 11 80 fa 	movb   $0xfa,-0x7feed7f3(%eax)
80106be9:	c6 80 0e 28 11 80 cf 	movb   $0xcf,-0x7feed7f2(%eax)
80106bf0:	c6 80 0f 28 11 80 00 	movb   $0x0,-0x7feed7f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106bf7:	66 89 88 12 28 11 80 	mov    %cx,-0x7feed7ee(%eax)
80106bfe:	c6 80 14 28 11 80 00 	movb   $0x0,-0x7feed7ec(%eax)
80106c05:	c6 80 15 28 11 80 f2 	movb   $0xf2,-0x7feed7eb(%eax)
80106c0c:	c6 80 16 28 11 80 cf 	movb   $0xcf,-0x7feed7ea(%eax)
80106c13:	c6 80 17 28 11 80 00 	movb   $0x0,-0x7feed7e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106c1a:	05 f0 27 11 80       	add    $0x801127f0,%eax
80106c1f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106c23:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106c27:	c1 e8 10             	shr    $0x10,%eax
80106c2a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106c2e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c31:	0f 01 10             	lgdtl  (%eax)
}
80106c34:	c9                   	leave  
80106c35:	c3                   	ret    
80106c36:	8d 76 00             	lea    0x0(%esi),%esi
80106c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c40 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c40:	a1 a4 54 11 80       	mov    0x801154a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106c45:	55                   	push   %ebp
80106c46:	89 e5                	mov    %esp,%ebp
80106c48:	05 00 00 00 80       	add    $0x80000000,%eax
80106c4d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106c50:	5d                   	pop    %ebp
80106c51:	c3                   	ret    
80106c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c60 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 1c             	sub    $0x1c,%esp
80106c69:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106c6c:	85 f6                	test   %esi,%esi
80106c6e:	0f 84 cd 00 00 00    	je     80106d41 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106c74:	8b 46 08             	mov    0x8(%esi),%eax
80106c77:	85 c0                	test   %eax,%eax
80106c79:	0f 84 dc 00 00 00    	je     80106d5b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106c7f:	8b 7e 04             	mov    0x4(%esi),%edi
80106c82:	85 ff                	test   %edi,%edi
80106c84:	0f 84 c4 00 00 00    	je     80106d4e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106c8a:	e8 d1 d9 ff ff       	call   80104660 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106c8f:	e8 6c ce ff ff       	call   80103b00 <mycpu>
80106c94:	89 c3                	mov    %eax,%ebx
80106c96:	e8 65 ce ff ff       	call   80103b00 <mycpu>
80106c9b:	89 c7                	mov    %eax,%edi
80106c9d:	e8 5e ce ff ff       	call   80103b00 <mycpu>
80106ca2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ca5:	83 c7 08             	add    $0x8,%edi
80106ca8:	e8 53 ce ff ff       	call   80103b00 <mycpu>
80106cad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106cb0:	83 c0 08             	add    $0x8,%eax
80106cb3:	ba 67 00 00 00       	mov    $0x67,%edx
80106cb8:	c1 e8 18             	shr    $0x18,%eax
80106cbb:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106cc2:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106cc9:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106cd0:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106cd7:	83 c1 08             	add    $0x8,%ecx
80106cda:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106ce0:	c1 e9 10             	shr    $0x10,%ecx
80106ce3:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106ce9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106cee:	e8 0d ce ff ff       	call   80103b00 <mycpu>
80106cf3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106cfa:	e8 01 ce ff ff       	call   80103b00 <mycpu>
80106cff:	b9 10 00 00 00       	mov    $0x10,%ecx
80106d04:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106d08:	e8 f3 cd ff ff       	call   80103b00 <mycpu>
80106d0d:	8b 56 08             	mov    0x8(%esi),%edx
80106d10:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106d16:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d19:	e8 e2 cd ff ff       	call   80103b00 <mycpu>
80106d1e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106d22:	b8 28 00 00 00       	mov    $0x28,%eax
80106d27:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d2a:	8b 46 04             	mov    0x4(%esi),%eax
80106d2d:	05 00 00 00 80       	add    $0x80000000,%eax
80106d32:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106d35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d38:	5b                   	pop    %ebx
80106d39:	5e                   	pop    %esi
80106d3a:	5f                   	pop    %edi
80106d3b:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106d3c:	e9 5f d9 ff ff       	jmp    801046a0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106d41:	83 ec 0c             	sub    $0xc,%esp
80106d44:	68 f6 7b 10 80       	push   $0x80107bf6
80106d49:	e8 22 96 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106d4e:	83 ec 0c             	sub    $0xc,%esp
80106d51:	68 21 7c 10 80       	push   $0x80107c21
80106d56:	e8 15 96 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106d5b:	83 ec 0c             	sub    $0xc,%esp
80106d5e:	68 0c 7c 10 80       	push   $0x80107c0c
80106d63:	e8 08 96 ff ff       	call   80100370 <panic>
80106d68:	90                   	nop
80106d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d70 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 1c             	sub    $0x1c,%esp
80106d79:	8b 75 10             	mov    0x10(%ebp),%esi
80106d7c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d7f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106d82:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106d88:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106d8b:	77 49                	ja     80106dd6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106d8d:	e8 be ba ff ff       	call   80102850 <kalloc>
  memset(mem, 0, PGSIZE);
80106d92:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106d95:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106d97:	68 00 10 00 00       	push   $0x1000
80106d9c:	6a 00                	push   $0x0
80106d9e:	50                   	push   %eax
80106d9f:	e8 9c da ff ff       	call   80104840 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106da4:	58                   	pop    %eax
80106da5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106dab:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106db0:	5a                   	pop    %edx
80106db1:	6a 06                	push   $0x6
80106db3:	50                   	push   %eax
80106db4:	31 d2                	xor    %edx,%edx
80106db6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106db9:	e8 52 fc ff ff       	call   80106a10 <mappages>
  memmove(mem, init, sz);
80106dbe:	89 75 10             	mov    %esi,0x10(%ebp)
80106dc1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106dc4:	83 c4 10             	add    $0x10,%esp
80106dc7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106dca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dcd:	5b                   	pop    %ebx
80106dce:	5e                   	pop    %esi
80106dcf:	5f                   	pop    %edi
80106dd0:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106dd1:	e9 1a db ff ff       	jmp    801048f0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106dd6:	83 ec 0c             	sub    $0xc,%esp
80106dd9:	68 35 7c 10 80       	push   $0x80107c35
80106dde:	e8 8d 95 ff ff       	call   80100370 <panic>
80106de3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106df0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	57                   	push   %edi
80106df4:	56                   	push   %esi
80106df5:	53                   	push   %ebx
80106df6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106df9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106e00:	0f 85 91 00 00 00    	jne    80106e97 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106e06:	8b 75 18             	mov    0x18(%ebp),%esi
80106e09:	31 db                	xor    %ebx,%ebx
80106e0b:	85 f6                	test   %esi,%esi
80106e0d:	75 1a                	jne    80106e29 <loaduvm+0x39>
80106e0f:	eb 6f                	jmp    80106e80 <loaduvm+0x90>
80106e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e18:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e1e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106e24:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106e27:	76 57                	jbe    80106e80 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106e29:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e2c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e2f:	31 c9                	xor    %ecx,%ecx
80106e31:	01 da                	add    %ebx,%edx
80106e33:	e8 58 fb ff ff       	call   80106990 <walkpgdir>
80106e38:	85 c0                	test   %eax,%eax
80106e3a:	74 4e                	je     80106e8a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106e3c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e3e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106e41:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106e46:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106e4b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e51:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e54:	01 d9                	add    %ebx,%ecx
80106e56:	05 00 00 00 80       	add    $0x80000000,%eax
80106e5b:	57                   	push   %edi
80106e5c:	51                   	push   %ecx
80106e5d:	50                   	push   %eax
80106e5e:	ff 75 10             	pushl  0x10(%ebp)
80106e61:	e8 aa ae ff ff       	call   80101d10 <readi>
80106e66:	83 c4 10             	add    $0x10,%esp
80106e69:	39 c7                	cmp    %eax,%edi
80106e6b:	74 ab                	je     80106e18 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106e6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106e70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106e75:	5b                   	pop    %ebx
80106e76:	5e                   	pop    %esi
80106e77:	5f                   	pop    %edi
80106e78:	5d                   	pop    %ebp
80106e79:	c3                   	ret    
80106e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106e83:	31 c0                	xor    %eax,%eax
}
80106e85:	5b                   	pop    %ebx
80106e86:	5e                   	pop    %esi
80106e87:	5f                   	pop    %edi
80106e88:	5d                   	pop    %ebp
80106e89:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106e8a:	83 ec 0c             	sub    $0xc,%esp
80106e8d:	68 4f 7c 10 80       	push   $0x80107c4f
80106e92:	e8 d9 94 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106e97:	83 ec 0c             	sub    $0xc,%esp
80106e9a:	68 f0 7c 10 80       	push   $0x80107cf0
80106e9f:	e8 cc 94 ff ff       	call   80100370 <panic>
80106ea4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106eb0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	57                   	push   %edi
80106eb4:	56                   	push   %esi
80106eb5:	53                   	push   %ebx
80106eb6:	83 ec 0c             	sub    $0xc,%esp
80106eb9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106ebc:	85 ff                	test   %edi,%edi
80106ebe:	0f 88 ca 00 00 00    	js     80106f8e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106ec4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106ec7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106eca:	0f 82 82 00 00 00    	jb     80106f52 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106ed0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106ed6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106edc:	39 df                	cmp    %ebx,%edi
80106ede:	77 43                	ja     80106f23 <allocuvm+0x73>
80106ee0:	e9 bb 00 00 00       	jmp    80106fa0 <allocuvm+0xf0>
80106ee5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106ee8:	83 ec 04             	sub    $0x4,%esp
80106eeb:	68 00 10 00 00       	push   $0x1000
80106ef0:	6a 00                	push   $0x0
80106ef2:	50                   	push   %eax
80106ef3:	e8 48 d9 ff ff       	call   80104840 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106ef8:	58                   	pop    %eax
80106ef9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106eff:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f04:	5a                   	pop    %edx
80106f05:	6a 06                	push   $0x6
80106f07:	50                   	push   %eax
80106f08:	89 da                	mov    %ebx,%edx
80106f0a:	8b 45 08             	mov    0x8(%ebp),%eax
80106f0d:	e8 fe fa ff ff       	call   80106a10 <mappages>
80106f12:	83 c4 10             	add    $0x10,%esp
80106f15:	85 c0                	test   %eax,%eax
80106f17:	78 47                	js     80106f60 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106f19:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f1f:	39 df                	cmp    %ebx,%edi
80106f21:	76 7d                	jbe    80106fa0 <allocuvm+0xf0>
    mem = kalloc();
80106f23:	e8 28 b9 ff ff       	call   80102850 <kalloc>
    if(mem == 0){
80106f28:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106f2a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106f2c:	75 ba                	jne    80106ee8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106f2e:	83 ec 0c             	sub    $0xc,%esp
80106f31:	68 6d 7c 10 80       	push   $0x80107c6d
80106f36:	e8 25 97 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106f3b:	83 c4 10             	add    $0x10,%esp
80106f3e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106f41:	76 4b                	jbe    80106f8e <allocuvm+0xde>
80106f43:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f46:	8b 45 08             	mov    0x8(%ebp),%eax
80106f49:	89 fa                	mov    %edi,%edx
80106f4b:	e8 50 fb ff ff       	call   80106aa0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106f50:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106f52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f55:	5b                   	pop    %ebx
80106f56:	5e                   	pop    %esi
80106f57:	5f                   	pop    %edi
80106f58:	5d                   	pop    %ebp
80106f59:	c3                   	ret    
80106f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106f60:	83 ec 0c             	sub    $0xc,%esp
80106f63:	68 85 7c 10 80       	push   $0x80107c85
80106f68:	e8 f3 96 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106f6d:	83 c4 10             	add    $0x10,%esp
80106f70:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106f73:	76 0d                	jbe    80106f82 <allocuvm+0xd2>
80106f75:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f78:	8b 45 08             	mov    0x8(%ebp),%eax
80106f7b:	89 fa                	mov    %edi,%edx
80106f7d:	e8 1e fb ff ff       	call   80106aa0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106f82:	83 ec 0c             	sub    $0xc,%esp
80106f85:	56                   	push   %esi
80106f86:	e8 15 b7 ff ff       	call   801026a0 <kfree>
      return 0;
80106f8b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106f8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106f91:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106f93:	5b                   	pop    %ebx
80106f94:	5e                   	pop    %esi
80106f95:	5f                   	pop    %edi
80106f96:	5d                   	pop    %ebp
80106f97:	c3                   	ret    
80106f98:	90                   	nop
80106f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fa0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106fa3:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106fa5:	5b                   	pop    %ebx
80106fa6:	5e                   	pop    %esi
80106fa7:	5f                   	pop    %edi
80106fa8:	5d                   	pop    %ebp
80106fa9:	c3                   	ret    
80106faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fb0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fb6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106fbc:	39 d1                	cmp    %edx,%ecx
80106fbe:	73 10                	jae    80106fd0 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106fc0:	5d                   	pop    %ebp
80106fc1:	e9 da fa ff ff       	jmp    80106aa0 <deallocuvm.part.0>
80106fc6:	8d 76 00             	lea    0x0(%esi),%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106fd0:	89 d0                	mov    %edx,%eax
80106fd2:	5d                   	pop    %ebp
80106fd3:	c3                   	ret    
80106fd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106fda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106fe0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	57                   	push   %edi
80106fe4:	56                   	push   %esi
80106fe5:	53                   	push   %ebx
80106fe6:	83 ec 0c             	sub    $0xc,%esp
80106fe9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106fec:	85 f6                	test   %esi,%esi
80106fee:	74 59                	je     80107049 <freevm+0x69>
80106ff0:	31 c9                	xor    %ecx,%ecx
80106ff2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106ff7:	89 f0                	mov    %esi,%eax
80106ff9:	e8 a2 fa ff ff       	call   80106aa0 <deallocuvm.part.0>
80106ffe:	89 f3                	mov    %esi,%ebx
80107000:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107006:	eb 0f                	jmp    80107017 <freevm+0x37>
80107008:	90                   	nop
80107009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107010:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107013:	39 fb                	cmp    %edi,%ebx
80107015:	74 23                	je     8010703a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107017:	8b 03                	mov    (%ebx),%eax
80107019:	a8 01                	test   $0x1,%al
8010701b:	74 f3                	je     80107010 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
8010701d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107022:	83 ec 0c             	sub    $0xc,%esp
80107025:	83 c3 04             	add    $0x4,%ebx
80107028:	05 00 00 00 80       	add    $0x80000000,%eax
8010702d:	50                   	push   %eax
8010702e:	e8 6d b6 ff ff       	call   801026a0 <kfree>
80107033:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107036:	39 fb                	cmp    %edi,%ebx
80107038:	75 dd                	jne    80107017 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010703a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010703d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107040:	5b                   	pop    %ebx
80107041:	5e                   	pop    %esi
80107042:	5f                   	pop    %edi
80107043:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80107044:	e9 57 b6 ff ff       	jmp    801026a0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80107049:	83 ec 0c             	sub    $0xc,%esp
8010704c:	68 a1 7c 10 80       	push   $0x80107ca1
80107051:	e8 1a 93 ff ff       	call   80100370 <panic>
80107056:	8d 76 00             	lea    0x0(%esi),%esi
80107059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107060 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107060:	55                   	push   %ebp
80107061:	89 e5                	mov    %esp,%ebp
80107063:	56                   	push   %esi
80107064:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107065:	e8 e6 b7 ff ff       	call   80102850 <kalloc>
8010706a:	85 c0                	test   %eax,%eax
8010706c:	74 6a                	je     801070d8 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
8010706e:	83 ec 04             	sub    $0x4,%esp
80107071:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107073:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80107078:	68 00 10 00 00       	push   $0x1000
8010707d:	6a 00                	push   $0x0
8010707f:	50                   	push   %eax
80107080:	e8 bb d7 ff ff       	call   80104840 <memset>
80107085:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107088:	8b 43 04             	mov    0x4(%ebx),%eax
8010708b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010708e:	83 ec 08             	sub    $0x8,%esp
80107091:	8b 13                	mov    (%ebx),%edx
80107093:	ff 73 0c             	pushl  0xc(%ebx)
80107096:	50                   	push   %eax
80107097:	29 c1                	sub    %eax,%ecx
80107099:	89 f0                	mov    %esi,%eax
8010709b:	e8 70 f9 ff ff       	call   80106a10 <mappages>
801070a0:	83 c4 10             	add    $0x10,%esp
801070a3:	85 c0                	test   %eax,%eax
801070a5:	78 19                	js     801070c0 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070a7:	83 c3 10             	add    $0x10,%ebx
801070aa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801070b0:	75 d6                	jne    80107088 <setupkvm+0x28>
801070b2:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
801070b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801070b7:	5b                   	pop    %ebx
801070b8:	5e                   	pop    %esi
801070b9:	5d                   	pop    %ebp
801070ba:	c3                   	ret    
801070bb:	90                   	nop
801070bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
801070c0:	83 ec 0c             	sub    $0xc,%esp
801070c3:	56                   	push   %esi
801070c4:	e8 17 ff ff ff       	call   80106fe0 <freevm>
      return 0;
801070c9:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
801070cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
801070cf:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
801070d1:	5b                   	pop    %ebx
801070d2:	5e                   	pop    %esi
801070d3:	5d                   	pop    %ebp
801070d4:	c3                   	ret    
801070d5:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
801070d8:	31 c0                	xor    %eax,%eax
801070da:	eb d8                	jmp    801070b4 <setupkvm+0x54>
801070dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801070e0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
801070e0:	55                   	push   %ebp
801070e1:	89 e5                	mov    %esp,%ebp
801070e3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801070e6:	e8 75 ff ff ff       	call   80107060 <setupkvm>
801070eb:	a3 a4 54 11 80       	mov    %eax,0x801154a4
801070f0:	05 00 00 00 80       	add    $0x80000000,%eax
801070f5:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
801070f8:	c9                   	leave  
801070f9:	c3                   	ret    
801070fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107100 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107100:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107101:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107103:	89 e5                	mov    %esp,%ebp
80107105:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107108:	8b 55 0c             	mov    0xc(%ebp),%edx
8010710b:	8b 45 08             	mov    0x8(%ebp),%eax
8010710e:	e8 7d f8 ff ff       	call   80106990 <walkpgdir>
  if(pte == 0)
80107113:	85 c0                	test   %eax,%eax
80107115:	74 05                	je     8010711c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107117:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010711a:	c9                   	leave  
8010711b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010711c:	83 ec 0c             	sub    $0xc,%esp
8010711f:	68 b2 7c 10 80       	push   $0x80107cb2
80107124:	e8 47 92 ff ff       	call   80100370 <panic>
80107129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107130 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	57                   	push   %edi
80107134:	56                   	push   %esi
80107135:	53                   	push   %ebx
80107136:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107139:	e8 22 ff ff ff       	call   80107060 <setupkvm>
8010713e:	85 c0                	test   %eax,%eax
80107140:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107143:	0f 84 c5 00 00 00    	je     8010720e <copyuvm+0xde>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107149:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010714c:	85 c9                	test   %ecx,%ecx
8010714e:	0f 84 9c 00 00 00    	je     801071f0 <copyuvm+0xc0>
80107154:	31 ff                	xor    %edi,%edi
80107156:	eb 4a                	jmp    801071a2 <copyuvm+0x72>
80107158:	90                   	nop
80107159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107160:	83 ec 04             	sub    $0x4,%esp
80107163:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107169:	68 00 10 00 00       	push   $0x1000
8010716e:	53                   	push   %ebx
8010716f:	50                   	push   %eax
80107170:	e8 7b d7 ff ff       	call   801048f0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107175:	58                   	pop    %eax
80107176:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010717c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107181:	5a                   	pop    %edx
80107182:	ff 75 e4             	pushl  -0x1c(%ebp)
80107185:	50                   	push   %eax
80107186:	89 fa                	mov    %edi,%edx
80107188:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010718b:	e8 80 f8 ff ff       	call   80106a10 <mappages>
80107190:	83 c4 10             	add    $0x10,%esp
80107193:	85 c0                	test   %eax,%eax
80107195:	78 69                	js     80107200 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107197:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010719d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801071a0:	76 4e                	jbe    801071f0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801071a2:	8b 45 08             	mov    0x8(%ebp),%eax
801071a5:	31 c9                	xor    %ecx,%ecx
801071a7:	89 fa                	mov    %edi,%edx
801071a9:	e8 e2 f7 ff ff       	call   80106990 <walkpgdir>
801071ae:	85 c0                	test   %eax,%eax
801071b0:	74 6d                	je     8010721f <copyuvm+0xef>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
801071b2:	8b 00                	mov    (%eax),%eax
801071b4:	a8 01                	test   $0x1,%al
801071b6:	74 5a                	je     80107212 <copyuvm+0xe2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801071b8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
801071ba:	25 ff 0f 00 00       	and    $0xfff,%eax
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801071bf:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
801071c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801071c8:	e8 83 b6 ff ff       	call   80102850 <kalloc>
801071cd:	85 c0                	test   %eax,%eax
801071cf:	89 c6                	mov    %eax,%esi
801071d1:	75 8d                	jne    80107160 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801071d3:	83 ec 0c             	sub    $0xc,%esp
801071d6:	ff 75 e0             	pushl  -0x20(%ebp)
801071d9:	e8 02 fe ff ff       	call   80106fe0 <freevm>
  return 0;
801071de:	83 c4 10             	add    $0x10,%esp
801071e1:	31 c0                	xor    %eax,%eax
}
801071e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071e6:	5b                   	pop    %ebx
801071e7:	5e                   	pop    %esi
801071e8:	5f                   	pop    %edi
801071e9:	5d                   	pop    %ebp
801071ea:	c3                   	ret    
801071eb:	90                   	nop
801071ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
801071f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071f6:	5b                   	pop    %ebx
801071f7:	5e                   	pop    %esi
801071f8:	5f                   	pop    %edi
801071f9:	5d                   	pop    %ebp
801071fa:	c3                   	ret    
801071fb:	90                   	nop
801071fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80107200:	83 ec 0c             	sub    $0xc,%esp
80107203:	56                   	push   %esi
80107204:	e8 97 b4 ff ff       	call   801026a0 <kfree>
      goto bad;
80107209:	83 c4 10             	add    $0x10,%esp
8010720c:	eb c5                	jmp    801071d3 <copyuvm+0xa3>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010720e:	31 c0                	xor    %eax,%eax
80107210:	eb d1                	jmp    801071e3 <copyuvm+0xb3>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107212:	83 ec 0c             	sub    $0xc,%esp
80107215:	68 d6 7c 10 80       	push   $0x80107cd6
8010721a:	e8 51 91 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010721f:	83 ec 0c             	sub    $0xc,%esp
80107222:	68 bc 7c 10 80       	push   $0x80107cbc
80107227:	e8 44 91 ff ff       	call   80100370 <panic>
8010722c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107230 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107230:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107231:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107233:	89 e5                	mov    %esp,%ebp
80107235:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107238:	8b 55 0c             	mov    0xc(%ebp),%edx
8010723b:	8b 45 08             	mov    0x8(%ebp),%eax
8010723e:	e8 4d f7 ff ff       	call   80106990 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107243:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107245:	89 c2                	mov    %eax,%edx
80107247:	83 e2 05             	and    $0x5,%edx
8010724a:	83 fa 05             	cmp    $0x5,%edx
8010724d:	75 11                	jne    80107260 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010724f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107254:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107255:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010725a:	c3                   	ret    
8010725b:	90                   	nop
8010725c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107260:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107262:	c9                   	leave  
80107263:	c3                   	ret    
80107264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010726a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107270 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	57                   	push   %edi
80107274:	56                   	push   %esi
80107275:	53                   	push   %ebx
80107276:	83 ec 1c             	sub    $0x1c,%esp
80107279:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010727c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010727f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107282:	85 db                	test   %ebx,%ebx
80107284:	75 40                	jne    801072c6 <copyout+0x56>
80107286:	eb 70                	jmp    801072f8 <copyout+0x88>
80107288:	90                   	nop
80107289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107290:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107293:	89 f1                	mov    %esi,%ecx
80107295:	29 d1                	sub    %edx,%ecx
80107297:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010729d:	39 d9                	cmp    %ebx,%ecx
8010729f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801072a2:	29 f2                	sub    %esi,%edx
801072a4:	83 ec 04             	sub    $0x4,%esp
801072a7:	01 d0                	add    %edx,%eax
801072a9:	51                   	push   %ecx
801072aa:	57                   	push   %edi
801072ab:	50                   	push   %eax
801072ac:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801072af:	e8 3c d6 ff ff       	call   801048f0 <memmove>
    len -= n;
    buf += n;
801072b4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072b7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801072ba:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801072c0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072c2:	29 cb                	sub    %ecx,%ebx
801072c4:	74 32                	je     801072f8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801072c6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801072c8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801072cb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801072ce:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801072d4:	56                   	push   %esi
801072d5:	ff 75 08             	pushl  0x8(%ebp)
801072d8:	e8 53 ff ff ff       	call   80107230 <uva2ka>
    if(pa0 == 0)
801072dd:	83 c4 10             	add    $0x10,%esp
801072e0:	85 c0                	test   %eax,%eax
801072e2:	75 ac                	jne    80107290 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801072e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801072e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801072ec:	5b                   	pop    %ebx
801072ed:	5e                   	pop    %esi
801072ee:	5f                   	pop    %edi
801072ef:	5d                   	pop    %ebp
801072f0:	c3                   	ret    
801072f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801072fb:	31 c0                	xor    %eax,%eax
}
801072fd:	5b                   	pop    %ebx
801072fe:	5e                   	pop    %esi
801072ff:	5f                   	pop    %edi
80107300:	5d                   	pop    %ebp
80107301:	c3                   	ret    
