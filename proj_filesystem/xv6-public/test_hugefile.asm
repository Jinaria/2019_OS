
_test_hugefile:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#define BLOCK_SIZE (512)
#define STRESS_NUM (4)

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 18 04 00 00    	sub    $0x418,%esp
  int fd, i, j; 
  int r;
  int total;
  char *path = (argc > 1) ? argv[1] : "hugefile";
  17:	83 39 01             	cmpl   $0x1,(%ecx)
#define BLOCK_SIZE (512)
#define STRESS_NUM (4)

int
main(int argc, char *argv[])
{
  1a:	8b 41 04             	mov    0x4(%ecx),%eax
  int fd, i, j; 
  int r;
  int total;
  char *path = (argc > 1) ? argv[1] : "hugefile";
  1d:	c7 85 e4 fb ff ff c0 	movl   $0x9c0,-0x41c(%ebp)
  24:	09 00 00 
  27:	7e 09                	jle    32 <main+0x32>
  29:	8b 40 04             	mov    0x4(%eax),%eax
  2c:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
  char data[BLOCK_SIZE];
  char buf[BLOCK_SIZE];

  printf(1, "hugefiletest starting\n");
  32:	83 ec 08             	sub    $0x8,%esp
  35:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
  3b:	68 c9 09 00 00       	push   $0x9c9
  40:	6a 01                	push   $0x1
  42:	e8 59 06 00 00       	call   6a0 <printf>
  47:	83 c4 10             	add    $0x10,%esp
  const int sz = sizeof(data);
  for (i = 0; i < sz; i++) {
  4a:	31 c0                	xor    %eax,%eax
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      data[i] = i % 128;
  50:	89 c2                	mov    %eax,%edx
  52:	83 e2 7f             	and    $0x7f,%edx
  55:	88 14 03             	mov    %dl,(%ebx,%eax,1)
  char data[BLOCK_SIZE];
  char buf[BLOCK_SIZE];

  printf(1, "hugefiletest starting\n");
  const int sz = sizeof(data);
  for (i = 0; i < sz; i++) {
  58:	83 c0 01             	add    $0x1,%eax
  5b:	3d 00 02 00 00       	cmp    $0x200,%eax
  60:	75 ee                	jne    50 <main+0x50>
  }

// ============================================================================
// ============================================================================

  printf(1, "1. create test\n");
  62:	83 ec 08             	sub    $0x8,%esp
  65:	68 e0 09 00 00       	push   $0x9e0
  6a:	6a 01                	push   $0x1
  6c:	e8 2f 06 00 00       	call   6a0 <printf>
  fd = open(path, O_CREATE | O_RDWR);
  71:	5f                   	pop    %edi
  72:	58                   	pop    %eax
  73:	68 02 02 00 00       	push   $0x202
  78:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
  for(i = 0; i < BLOCK_NUM; i++){
  7e:	31 ff                	xor    %edi,%edi

// ============================================================================
// ============================================================================

  printf(1, "1. create test\n");
  fd = open(path, O_CREATE | O_RDWR);
  80:	e8 fd 04 00 00       	call   582 <open>
  85:	83 c4 10             	add    $0x10,%esp
  88:	89 c6                	mov    %eax,%esi
  8a:	eb 28                	jmp    b4 <main+0xb4>
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < BLOCK_NUM; i++){
    if (i % 100 == 0){
      printf(1, "%d bytes written\n", i * BLOCK_SIZE);
    }
    if ((r = write(fd, data, sizeof(data))) != sizeof(data)){
  90:	83 ec 04             	sub    $0x4,%esp
  93:	68 00 02 00 00       	push   $0x200
  98:	53                   	push   %ebx
  99:	56                   	push   %esi
  9a:	e8 c3 04 00 00       	call   562 <write>
  9f:	83 c4 10             	add    $0x10,%esp
  a2:	3d 00 02 00 00       	cmp    $0x200,%eax
  a7:	75 3d                	jne    e6 <main+0xe6>
// ============================================================================
// ============================================================================

  printf(1, "1. create test\n");
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < BLOCK_NUM; i++){
  a9:	83 c7 01             	add    $0x1,%edi
  ac:	81 ff 00 80 00 00    	cmp    $0x8000,%edi
  b2:	74 47                	je     fb <main+0xfb>
    if (i % 100 == 0){
  b4:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
  b9:	f7 ef                	imul   %edi
  bb:	89 f8                	mov    %edi,%eax
  bd:	c1 f8 1f             	sar    $0x1f,%eax
  c0:	c1 fa 05             	sar    $0x5,%edx
  c3:	29 c2                	sub    %eax,%edx
  c5:	6b d2 64             	imul   $0x64,%edx,%edx
  c8:	39 d7                	cmp    %edx,%edi
  ca:	75 c4                	jne    90 <main+0x90>
      printf(1, "%d bytes written\n", i * BLOCK_SIZE);
  cc:	89 f8                	mov    %edi,%eax
  ce:	83 ec 04             	sub    $0x4,%esp
  d1:	c1 e0 09             	shl    $0x9,%eax
  d4:	50                   	push   %eax
  d5:	68 f0 09 00 00       	push   $0x9f0
  da:	6a 01                	push   $0x1
  dc:	e8 bf 05 00 00       	call   6a0 <printf>
  e1:	83 c4 10             	add    $0x10,%esp
  e4:	eb aa                	jmp    90 <main+0x90>
      for(j = 0; j < BLOCK_NUM; j++){
        if (j % 100 == 0){
          printf(1, "%d bytes totally written\n", total);
        }
        if ((r = write(fd, data, sizeof(data))) != sizeof(data)){
          printf(1, "write returned %d : failed\n", r);
  e6:	83 ec 04             	sub    $0x4,%esp
  e9:	50                   	push   %eax
  ea:	68 02 0a 00 00       	push   $0xa02
  ef:	6a 01                	push   $0x1
  f1:	e8 aa 05 00 00       	call   6a0 <printf>
          exit();
  f6:	e8 47 04 00 00       	call   542 <exit>
    if ((r = write(fd, data, sizeof(data))) != sizeof(data)){
      printf(1, "write returned %d : failed\n", r);
      exit();
    }
  }
  printf(1, "%d bytes written\n", BLOCK_NUM * BLOCK_SIZE);
  fb:	50                   	push   %eax
  fc:	68 00 00 00 01       	push   $0x1000000
 101:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 107:	68 f0 09 00 00       	push   $0x9f0
 10c:	6a 01                	push   $0x1
 10e:	e8 8d 05 00 00       	call   6a0 <printf>
  close(fd);
 113:	89 34 24             	mov    %esi,(%esp)
 116:	e8 4f 04 00 00       	call   56a <close>

// ============================================================================
// ============================================================================

  printf(1, "2. read test\n");
 11b:	58                   	pop    %eax
 11c:	5a                   	pop    %edx
 11d:	68 1e 0a 00 00       	push   $0xa1e
 122:	6a 01                	push   $0x1
 124:	e8 77 05 00 00       	call   6a0 <printf>
  fd = open(path, O_RDONLY);
 129:	59                   	pop    %ecx
 12a:	5e                   	pop    %esi
 12b:	6a 00                	push   $0x0
 12d:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
  for (i = 0; i < BLOCK_NUM; i++){
 133:	31 f6                	xor    %esi,%esi

// ============================================================================
// ============================================================================

  printf(1, "2. read test\n");
  fd = open(path, O_RDONLY);
 135:	e8 48 04 00 00       	call   582 <open>
 13a:	83 c4 10             	add    $0x10,%esp
 13d:	89 85 e0 fb ff ff    	mov    %eax,-0x420(%ebp)
  for (i = 0; i < BLOCK_NUM; i++){
    if (i % 100 == 0){
 143:	89 f0                	mov    %esi,%eax
 145:	b9 64 00 00 00       	mov    $0x64,%ecx
 14a:	99                   	cltd   
 14b:	f7 f9                	idiv   %ecx
 14d:	85 d2                	test   %edx,%edx
 14f:	74 4d                	je     19e <main+0x19e>
      printf(1, "%d bytes read\n", i * BLOCK_SIZE);
    }
    if ((r = read(fd, buf, sizeof(data))) != sizeof(data)){
 151:	51                   	push   %ecx
 152:	68 00 02 00 00       	push   $0x200
 157:	57                   	push   %edi
 158:	ff b5 e0 fb ff ff    	pushl  -0x420(%ebp)
 15e:	e8 f7 03 00 00       	call   55a <read>
 163:	83 c4 10             	add    $0x10,%esp
 166:	3d 00 02 00 00       	cmp    $0x200,%eax
 16b:	0f 85 2e 01 00 00    	jne    29f <main+0x29f>
 171:	31 c0                	xor    %eax,%eax
 173:	eb 0d                	jmp    182 <main+0x182>
 175:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "read returned %d : failed\n", r);
      exit();
    }
    for (j = 0; j < sz; j++) {
 178:	83 c0 01             	add    $0x1,%eax
 17b:	3d 00 02 00 00       	cmp    $0x200,%eax
 180:	74 34                	je     1b6 <main+0x1b6>
      if (buf[j] != data[j]) {
 182:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
 186:	38 0c 07             	cmp    %cl,(%edi,%eax,1)
 189:	74 ed                	je     178 <main+0x178>
        printf(1, "data inconsistency detected\n");
 18b:	57                   	push   %edi
 18c:	57                   	push   %edi
 18d:	68 56 0a 00 00       	push   $0xa56
 192:	6a 01                	push   $0x1
 194:	e8 07 05 00 00       	call   6a0 <printf>
        exit();
 199:	e8 a4 03 00 00       	call   542 <exit>

  printf(1, "2. read test\n");
  fd = open(path, O_RDONLY);
  for (i = 0; i < BLOCK_NUM; i++){
    if (i % 100 == 0){
      printf(1, "%d bytes read\n", i * BLOCK_SIZE);
 19e:	50                   	push   %eax
 19f:	89 f0                	mov    %esi,%eax
 1a1:	c1 e0 09             	shl    $0x9,%eax
 1a4:	50                   	push   %eax
 1a5:	68 2c 0a 00 00       	push   $0xa2c
 1aa:	6a 01                	push   $0x1
 1ac:	e8 ef 04 00 00       	call   6a0 <printf>
 1b1:	83 c4 10             	add    $0x10,%esp
 1b4:	eb 9b                	jmp    151 <main+0x151>
// ============================================================================
// ============================================================================

  printf(1, "2. read test\n");
  fd = open(path, O_RDONLY);
  for (i = 0; i < BLOCK_NUM; i++){
 1b6:	83 c6 01             	add    $0x1,%esi
 1b9:	81 fe 00 80 00 00    	cmp    $0x8000,%esi
 1bf:	75 82                	jne    143 <main+0x143>
        printf(1, "data inconsistency detected\n");
        exit();
      }
    }
  }
  printf(1, "%d bytes read\n", BLOCK_NUM * BLOCK_SIZE);
 1c1:	50                   	push   %eax
 1c2:	68 00 00 00 01       	push   $0x1000000
// ============================================================================
// ============================================================================

  printf(1, "3. stress test\n");
  total = 0;
  for (i = 0; i < STRESS_NUM; i++) {
 1c7:	31 ff                	xor    %edi,%edi
        printf(1, "data inconsistency detected\n");
        exit();
      }
    }
  }
  printf(1, "%d bytes read\n", BLOCK_NUM * BLOCK_SIZE);
 1c9:	68 2c 0a 00 00       	push   $0xa2c
 1ce:	6a 01                	push   $0x1
 1d0:	e8 cb 04 00 00       	call   6a0 <printf>
  close(fd);
 1d5:	5a                   	pop    %edx
 1d6:	ff b5 e0 fb ff ff    	pushl  -0x420(%ebp)
 1dc:	e8 89 03 00 00       	call   56a <close>

// ============================================================================
// ============================================================================

  printf(1, "3. stress test\n");
 1e1:	59                   	pop    %ecx
 1e2:	5e                   	pop    %esi
 1e3:	68 73 0a 00 00       	push   $0xa73
 1e8:	6a 01                	push   $0x1
  total = 0;
 1ea:	31 f6                	xor    %esi,%esi
  close(fd);

// ============================================================================
// ============================================================================

  printf(1, "3. stress test\n");
 1ec:	e8 af 04 00 00       	call   6a0 <printf>
 1f1:	83 c4 10             	add    $0x10,%esp
  total = 0;
  for (i = 0; i < STRESS_NUM; i++) {
    printf(1, "stress test...%d \n", i);
 1f4:	50                   	push   %eax
 1f5:	57                   	push   %edi
 1f6:	68 83 0a 00 00       	push   $0xa83
 1fb:	6a 01                	push   $0x1
 1fd:	e8 9e 04 00 00       	call   6a0 <printf>
    if(unlink(path) < 0){
 202:	58                   	pop    %eax
 203:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
 209:	e8 84 03 00 00       	call   592 <unlink>
 20e:	83 c4 10             	add    $0x10,%esp
 211:	85 c0                	test   %eax,%eax
 213:	0f 88 99 00 00 00    	js     2b2 <main+0x2b2>
      printf(1, "rm: %s failed to delete\n", path);
      exit();
    }
    
    fd = open(path, O_CREATE | O_RDWR);
 219:	50                   	push   %eax
 21a:	50                   	push   %eax
 21b:	68 02 02 00 00       	push   $0x202
 220:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
 226:	e8 57 03 00 00       	call   582 <open>
 22b:	83 c4 10             	add    $0x10,%esp
 22e:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
      for(j = 0; j < BLOCK_NUM; j++){
 234:	c7 85 e0 fb ff ff 00 	movl   $0x0,-0x420(%ebp)
 23b:	00 00 00 
 23e:	eb 3a                	jmp    27a <main+0x27a>
        if (j % 100 == 0){
          printf(1, "%d bytes totally written\n", total);
        }
        if ((r = write(fd, data, sizeof(data))) != sizeof(data)){
 240:	51                   	push   %ecx
 241:	68 00 02 00 00       	push   $0x200
 246:	53                   	push   %ebx
 247:	ff b5 dc fb ff ff    	pushl  -0x424(%ebp)
 24d:	e8 10 03 00 00       	call   562 <write>
 252:	83 c4 10             	add    $0x10,%esp
 255:	3d 00 02 00 00       	cmp    $0x200,%eax
 25a:	0f 85 86 fe ff ff    	jne    e6 <main+0xe6>
      printf(1, "rm: %s failed to delete\n", path);
      exit();
    }
    
    fd = open(path, O_CREATE | O_RDWR);
      for(j = 0; j < BLOCK_NUM; j++){
 260:	83 85 e0 fb ff ff 01 	addl   $0x1,-0x420(%ebp)
 267:	81 c6 00 02 00 00    	add    $0x200,%esi
 26d:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
 273:	3d 00 80 00 00       	cmp    $0x8000,%eax
 278:	74 50                	je     2ca <main+0x2ca>
        if (j % 100 == 0){
 27a:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
 280:	b9 64 00 00 00       	mov    $0x64,%ecx
 285:	99                   	cltd   
 286:	f7 f9                	idiv   %ecx
 288:	85 d2                	test   %edx,%edx
 28a:	75 b4                	jne    240 <main+0x240>
          printf(1, "%d bytes totally written\n", total);
 28c:	50                   	push   %eax
 28d:	56                   	push   %esi
 28e:	68 af 0a 00 00       	push   $0xaaf
 293:	6a 01                	push   $0x1
 295:	e8 06 04 00 00       	call   6a0 <printf>
 29a:	83 c4 10             	add    $0x10,%esp
 29d:	eb a1                	jmp    240 <main+0x240>
  for (i = 0; i < BLOCK_NUM; i++){
    if (i % 100 == 0){
      printf(1, "%d bytes read\n", i * BLOCK_SIZE);
    }
    if ((r = read(fd, buf, sizeof(data))) != sizeof(data)){
      printf(1, "read returned %d : failed\n", r);
 29f:	52                   	push   %edx
 2a0:	50                   	push   %eax
 2a1:	68 3b 0a 00 00       	push   $0xa3b
 2a6:	6a 01                	push   $0x1
 2a8:	e8 f3 03 00 00       	call   6a0 <printf>
      exit();
 2ad:	e8 90 02 00 00       	call   542 <exit>
  printf(1, "3. stress test\n");
  total = 0;
  for (i = 0; i < STRESS_NUM; i++) {
    printf(1, "stress test...%d \n", i);
    if(unlink(path) < 0){
      printf(1, "rm: %s failed to delete\n", path);
 2b2:	50                   	push   %eax
 2b3:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
 2b9:	68 96 0a 00 00       	push   $0xa96
 2be:	6a 01                	push   $0x1
 2c0:	e8 db 03 00 00       	call   6a0 <printf>
      exit();
 2c5:	e8 78 02 00 00       	call   542 <exit>
          printf(1, "write returned %d : failed\n", r);
          exit();
        }
        total += sizeof(data);
      }
      printf(1, "%d bytes written\n", total);
 2ca:	50                   	push   %eax
 2cb:	56                   	push   %esi
// ============================================================================
// ============================================================================

  printf(1, "3. stress test\n");
  total = 0;
  for (i = 0; i < STRESS_NUM; i++) {
 2cc:	83 c7 01             	add    $0x1,%edi
          printf(1, "write returned %d : failed\n", r);
          exit();
        }
        total += sizeof(data);
      }
      printf(1, "%d bytes written\n", total);
 2cf:	68 f0 09 00 00       	push   $0x9f0
 2d4:	6a 01                	push   $0x1
 2d6:	e8 c5 03 00 00       	call   6a0 <printf>
    close(fd);
 2db:	5a                   	pop    %edx
 2dc:	ff b5 dc fb ff ff    	pushl  -0x424(%ebp)
 2e2:	e8 83 02 00 00       	call   56a <close>
// ============================================================================
// ============================================================================

  printf(1, "3. stress test\n");
  total = 0;
  for (i = 0; i < STRESS_NUM; i++) {
 2e7:	83 c4 10             	add    $0x10,%esp
 2ea:	83 ff 04             	cmp    $0x4,%edi
 2ed:	0f 85 01 ff ff ff    	jne    1f4 <main+0x1f4>
      }
      printf(1, "%d bytes written\n", total);
    close(fd);
  }

  exit();
 2f3:	e8 4a 02 00 00       	call   542 <exit>
 2f8:	66 90                	xchg   %ax,%ax
 2fa:	66 90                	xchg   %ax,%ax
 2fc:	66 90                	xchg   %ax,%ax
 2fe:	66 90                	xchg   %ax,%ax

00000300 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	53                   	push   %ebx
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 30a:	89 c2                	mov    %eax,%edx
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 310:	83 c1 01             	add    $0x1,%ecx
 313:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 317:	83 c2 01             	add    $0x1,%edx
 31a:	84 db                	test   %bl,%bl
 31c:	88 5a ff             	mov    %bl,-0x1(%edx)
 31f:	75 ef                	jne    310 <strcpy+0x10>
    ;
  return os;
}
 321:	5b                   	pop    %ebx
 322:	5d                   	pop    %ebp
 323:	c3                   	ret    
 324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 32a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000330 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	8b 55 08             	mov    0x8(%ebp),%edx
 338:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 33b:	0f b6 02             	movzbl (%edx),%eax
 33e:	0f b6 19             	movzbl (%ecx),%ebx
 341:	84 c0                	test   %al,%al
 343:	75 1e                	jne    363 <strcmp+0x33>
 345:	eb 29                	jmp    370 <strcmp+0x40>
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 350:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 353:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 356:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 359:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 35d:	84 c0                	test   %al,%al
 35f:	74 0f                	je     370 <strcmp+0x40>
 361:	89 f1                	mov    %esi,%ecx
 363:	38 d8                	cmp    %bl,%al
 365:	74 e9                	je     350 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 367:	29 d8                	sub    %ebx,%eax
}
 369:	5b                   	pop    %ebx
 36a:	5e                   	pop    %esi
 36b:	5d                   	pop    %ebp
 36c:	c3                   	ret    
 36d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 370:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 372:	29 d8                	sub    %ebx,%eax
}
 374:	5b                   	pop    %ebx
 375:	5e                   	pop    %esi
 376:	5d                   	pop    %ebp
 377:	c3                   	ret    
 378:	90                   	nop
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000380 <strlen>:

uint
strlen(const char *s)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 386:	80 39 00             	cmpb   $0x0,(%ecx)
 389:	74 12                	je     39d <strlen+0x1d>
 38b:	31 d2                	xor    %edx,%edx
 38d:	8d 76 00             	lea    0x0(%esi),%esi
 390:	83 c2 01             	add    $0x1,%edx
 393:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 397:	89 d0                	mov    %edx,%eax
 399:	75 f5                	jne    390 <strlen+0x10>
    ;
  return n;
}
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 39d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 39f:	5d                   	pop    %ebp
 3a0:	c3                   	ret    
 3a1:	eb 0d                	jmp    3b0 <memset>
 3a3:	90                   	nop
 3a4:	90                   	nop
 3a5:	90                   	nop
 3a6:	90                   	nop
 3a7:	90                   	nop
 3a8:	90                   	nop
 3a9:	90                   	nop
 3aa:	90                   	nop
 3ab:	90                   	nop
 3ac:	90                   	nop
 3ad:	90                   	nop
 3ae:	90                   	nop
 3af:	90                   	nop

000003b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bd:	89 d7                	mov    %edx,%edi
 3bf:	fc                   	cld    
 3c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3c2:	89 d0                	mov    %edx,%eax
 3c4:	5f                   	pop    %edi
 3c5:	5d                   	pop    %ebp
 3c6:	c3                   	ret    
 3c7:	89 f6                	mov    %esi,%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <strchr>:

char*
strchr(const char *s, char c)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 45 08             	mov    0x8(%ebp),%eax
 3d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 3da:	0f b6 10             	movzbl (%eax),%edx
 3dd:	84 d2                	test   %dl,%dl
 3df:	74 1d                	je     3fe <strchr+0x2e>
    if(*s == c)
 3e1:	38 d3                	cmp    %dl,%bl
 3e3:	89 d9                	mov    %ebx,%ecx
 3e5:	75 0d                	jne    3f4 <strchr+0x24>
 3e7:	eb 17                	jmp    400 <strchr+0x30>
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3f0:	38 ca                	cmp    %cl,%dl
 3f2:	74 0c                	je     400 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3f4:	83 c0 01             	add    $0x1,%eax
 3f7:	0f b6 10             	movzbl (%eax),%edx
 3fa:	84 d2                	test   %dl,%dl
 3fc:	75 f2                	jne    3f0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 3fe:	31 c0                	xor    %eax,%eax
}
 400:	5b                   	pop    %ebx
 401:	5d                   	pop    %ebp
 402:	c3                   	ret    
 403:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <gets>:

char*
gets(char *buf, int max)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 416:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 418:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 41b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 41e:	eb 29                	jmp    449 <gets+0x39>
    cc = read(0, &c, 1);
 420:	83 ec 04             	sub    $0x4,%esp
 423:	6a 01                	push   $0x1
 425:	57                   	push   %edi
 426:	6a 00                	push   $0x0
 428:	e8 2d 01 00 00       	call   55a <read>
    if(cc < 1)
 42d:	83 c4 10             	add    $0x10,%esp
 430:	85 c0                	test   %eax,%eax
 432:	7e 1d                	jle    451 <gets+0x41>
      break;
    buf[i++] = c;
 434:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 438:	8b 55 08             	mov    0x8(%ebp),%edx
 43b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 43d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 43f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 443:	74 1b                	je     460 <gets+0x50>
 445:	3c 0d                	cmp    $0xd,%al
 447:	74 17                	je     460 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 449:	8d 5e 01             	lea    0x1(%esi),%ebx
 44c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 44f:	7c cf                	jl     420 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 451:	8b 45 08             	mov    0x8(%ebp),%eax
 454:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 458:	8d 65 f4             	lea    -0xc(%ebp),%esp
 45b:	5b                   	pop    %ebx
 45c:	5e                   	pop    %esi
 45d:	5f                   	pop    %edi
 45e:	5d                   	pop    %ebp
 45f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 460:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 463:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 465:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 469:	8d 65 f4             	lea    -0xc(%ebp),%esp
 46c:	5b                   	pop    %ebx
 46d:	5e                   	pop    %esi
 46e:	5f                   	pop    %edi
 46f:	5d                   	pop    %ebp
 470:	c3                   	ret    
 471:	eb 0d                	jmp    480 <stat>
 473:	90                   	nop
 474:	90                   	nop
 475:	90                   	nop
 476:	90                   	nop
 477:	90                   	nop
 478:	90                   	nop
 479:	90                   	nop
 47a:	90                   	nop
 47b:	90                   	nop
 47c:	90                   	nop
 47d:	90                   	nop
 47e:	90                   	nop
 47f:	90                   	nop

00000480 <stat>:

int
stat(const char *n, struct stat *st)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	56                   	push   %esi
 484:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 485:	83 ec 08             	sub    $0x8,%esp
 488:	6a 00                	push   $0x0
 48a:	ff 75 08             	pushl  0x8(%ebp)
 48d:	e8 f0 00 00 00       	call   582 <open>
  if(fd < 0)
 492:	83 c4 10             	add    $0x10,%esp
 495:	85 c0                	test   %eax,%eax
 497:	78 27                	js     4c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 499:	83 ec 08             	sub    $0x8,%esp
 49c:	ff 75 0c             	pushl  0xc(%ebp)
 49f:	89 c3                	mov    %eax,%ebx
 4a1:	50                   	push   %eax
 4a2:	e8 f3 00 00 00       	call   59a <fstat>
 4a7:	89 c6                	mov    %eax,%esi
  close(fd);
 4a9:	89 1c 24             	mov    %ebx,(%esp)
 4ac:	e8 b9 00 00 00       	call   56a <close>
  return r;
 4b1:	83 c4 10             	add    $0x10,%esp
 4b4:	89 f0                	mov    %esi,%eax
}
 4b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4b9:	5b                   	pop    %ebx
 4ba:	5e                   	pop    %esi
 4bb:	5d                   	pop    %ebp
 4bc:	c3                   	ret    
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4c5:	eb ef                	jmp    4b6 <stat+0x36>
 4c7:	89 f6                	mov    %esi,%esi
 4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	53                   	push   %ebx
 4d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4d7:	0f be 11             	movsbl (%ecx),%edx
 4da:	8d 42 d0             	lea    -0x30(%edx),%eax
 4dd:	3c 09                	cmp    $0x9,%al
 4df:	b8 00 00 00 00       	mov    $0x0,%eax
 4e4:	77 1f                	ja     505 <atoi+0x35>
 4e6:	8d 76 00             	lea    0x0(%esi),%esi
 4e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 4f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4f3:	83 c1 01             	add    $0x1,%ecx
 4f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4fa:	0f be 11             	movsbl (%ecx),%edx
 4fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 500:	80 fb 09             	cmp    $0x9,%bl
 503:	76 eb                	jbe    4f0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 505:	5b                   	pop    %ebx
 506:	5d                   	pop    %ebp
 507:	c3                   	ret    
 508:	90                   	nop
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000510 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	56                   	push   %esi
 514:	53                   	push   %ebx
 515:	8b 5d 10             	mov    0x10(%ebp),%ebx
 518:	8b 45 08             	mov    0x8(%ebp),%eax
 51b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 51e:	85 db                	test   %ebx,%ebx
 520:	7e 14                	jle    536 <memmove+0x26>
 522:	31 d2                	xor    %edx,%edx
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 528:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 52c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 52f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 532:	39 da                	cmp    %ebx,%edx
 534:	75 f2                	jne    528 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 536:	5b                   	pop    %ebx
 537:	5e                   	pop    %esi
 538:	5d                   	pop    %ebp
 539:	c3                   	ret    

0000053a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 53a:	b8 01 00 00 00       	mov    $0x1,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <exit>:
SYSCALL(exit)
 542:	b8 02 00 00 00       	mov    $0x2,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <wait>:
SYSCALL(wait)
 54a:	b8 03 00 00 00       	mov    $0x3,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <pipe>:
SYSCALL(pipe)
 552:	b8 04 00 00 00       	mov    $0x4,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <read>:
SYSCALL(read)
 55a:	b8 05 00 00 00       	mov    $0x5,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <write>:
SYSCALL(write)
 562:	b8 10 00 00 00       	mov    $0x10,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <close>:
SYSCALL(close)
 56a:	b8 15 00 00 00       	mov    $0x15,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <kill>:
SYSCALL(kill)
 572:	b8 06 00 00 00       	mov    $0x6,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <exec>:
SYSCALL(exec)
 57a:	b8 07 00 00 00       	mov    $0x7,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <open>:
SYSCALL(open)
 582:	b8 0f 00 00 00       	mov    $0xf,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <mknod>:
SYSCALL(mknod)
 58a:	b8 11 00 00 00       	mov    $0x11,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <unlink>:
SYSCALL(unlink)
 592:	b8 12 00 00 00       	mov    $0x12,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <fstat>:
SYSCALL(fstat)
 59a:	b8 08 00 00 00       	mov    $0x8,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <link>:
SYSCALL(link)
 5a2:	b8 13 00 00 00       	mov    $0x13,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <mkdir>:
SYSCALL(mkdir)
 5aa:	b8 14 00 00 00       	mov    $0x14,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <chdir>:
SYSCALL(chdir)
 5b2:	b8 09 00 00 00       	mov    $0x9,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <dup>:
SYSCALL(dup)
 5ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <getpid>:
SYSCALL(getpid)
 5c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <sbrk>:
SYSCALL(sbrk)
 5ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <sleep>:
SYSCALL(sleep)
 5d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <uptime>:
SYSCALL(uptime)
 5da:	b8 0e 00 00 00       	mov    $0xe,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <sync>:
SYSCALL(sync)
 5e2:	b8 16 00 00 00       	mov    $0x16,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <get_log_num>:
SYSCALL(get_log_num)
 5ea:	b8 17 00 00 00       	mov    $0x17,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    
 5f2:	66 90                	xchg   %ax,%ax
 5f4:	66 90                	xchg   %ax,%ax
 5f6:	66 90                	xchg   %ax,%ax
 5f8:	66 90                	xchg   %ax,%ax
 5fa:	66 90                	xchg   %ax,%ax
 5fc:	66 90                	xchg   %ax,%ax
 5fe:	66 90                	xchg   %ax,%ax

00000600 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	89 c6                	mov    %eax,%esi
 608:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 60e:	85 db                	test   %ebx,%ebx
 610:	74 7e                	je     690 <printint+0x90>
 612:	89 d0                	mov    %edx,%eax
 614:	c1 e8 1f             	shr    $0x1f,%eax
 617:	84 c0                	test   %al,%al
 619:	74 75                	je     690 <printint+0x90>
    neg = 1;
    x = -xx;
 61b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 61d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 624:	f7 d8                	neg    %eax
 626:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 629:	31 ff                	xor    %edi,%edi
 62b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 62e:	89 ce                	mov    %ecx,%esi
 630:	eb 08                	jmp    63a <printint+0x3a>
 632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 638:	89 cf                	mov    %ecx,%edi
 63a:	31 d2                	xor    %edx,%edx
 63c:	8d 4f 01             	lea    0x1(%edi),%ecx
 63f:	f7 f6                	div    %esi
 641:	0f b6 92 d0 0a 00 00 	movzbl 0xad0(%edx),%edx
  }while((x /= base) != 0);
 648:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 64a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 64d:	75 e9                	jne    638 <printint+0x38>
  if(neg)
 64f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 652:	8b 75 c0             	mov    -0x40(%ebp),%esi
 655:	85 c0                	test   %eax,%eax
 657:	74 08                	je     661 <printint+0x61>
    buf[i++] = '-';
 659:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 65e:	8d 4f 02             	lea    0x2(%edi),%ecx
 661:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 665:	8d 76 00             	lea    0x0(%esi),%esi
 668:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 66b:	83 ec 04             	sub    $0x4,%esp
 66e:	83 ef 01             	sub    $0x1,%edi
 671:	6a 01                	push   $0x1
 673:	53                   	push   %ebx
 674:	56                   	push   %esi
 675:	88 45 d7             	mov    %al,-0x29(%ebp)
 678:	e8 e5 fe ff ff       	call   562 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 67d:	83 c4 10             	add    $0x10,%esp
 680:	39 df                	cmp    %ebx,%edi
 682:	75 e4                	jne    668 <printint+0x68>
    putc(fd, buf[i]);
}
 684:	8d 65 f4             	lea    -0xc(%ebp),%esp
 687:	5b                   	pop    %ebx
 688:	5e                   	pop    %esi
 689:	5f                   	pop    %edi
 68a:	5d                   	pop    %ebp
 68b:	c3                   	ret    
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 690:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 692:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 699:	eb 8b                	jmp    626 <printint+0x26>
 69b:	90                   	nop
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006a0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6a9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ac:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6af:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6b5:	0f b6 1e             	movzbl (%esi),%ebx
 6b8:	83 c6 01             	add    $0x1,%esi
 6bb:	84 db                	test   %bl,%bl
 6bd:	0f 84 b0 00 00 00    	je     773 <printf+0xd3>
 6c3:	31 d2                	xor    %edx,%edx
 6c5:	eb 39                	jmp    700 <printf+0x60>
 6c7:	89 f6                	mov    %esi,%esi
 6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6d0:	83 f8 25             	cmp    $0x25,%eax
 6d3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 6d6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6db:	74 18                	je     6f5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6dd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6e6:	6a 01                	push   $0x1
 6e8:	50                   	push   %eax
 6e9:	57                   	push   %edi
 6ea:	e8 73 fe ff ff       	call   562 <write>
 6ef:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6f2:	83 c4 10             	add    $0x10,%esp
 6f5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6fc:	84 db                	test   %bl,%bl
 6fe:	74 73                	je     773 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 700:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 702:	0f be cb             	movsbl %bl,%ecx
 705:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 708:	74 c6                	je     6d0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 70a:	83 fa 25             	cmp    $0x25,%edx
 70d:	75 e6                	jne    6f5 <printf+0x55>
      if(c == 'd'){
 70f:	83 f8 64             	cmp    $0x64,%eax
 712:	0f 84 f8 00 00 00    	je     810 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 718:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 71e:	83 f9 70             	cmp    $0x70,%ecx
 721:	74 5d                	je     780 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 723:	83 f8 73             	cmp    $0x73,%eax
 726:	0f 84 84 00 00 00    	je     7b0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 72c:	83 f8 63             	cmp    $0x63,%eax
 72f:	0f 84 ea 00 00 00    	je     81f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 735:	83 f8 25             	cmp    $0x25,%eax
 738:	0f 84 c2 00 00 00    	je     800 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 741:	83 ec 04             	sub    $0x4,%esp
 744:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 748:	6a 01                	push   $0x1
 74a:	50                   	push   %eax
 74b:	57                   	push   %edi
 74c:	e8 11 fe ff ff       	call   562 <write>
 751:	83 c4 0c             	add    $0xc,%esp
 754:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 757:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 75a:	6a 01                	push   $0x1
 75c:	50                   	push   %eax
 75d:	57                   	push   %edi
 75e:	83 c6 01             	add    $0x1,%esi
 761:	e8 fc fd ff ff       	call   562 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 766:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 76a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 76d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 76f:	84 db                	test   %bl,%bl
 771:	75 8d                	jne    700 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 773:	8d 65 f4             	lea    -0xc(%ebp),%esp
 776:	5b                   	pop    %ebx
 777:	5e                   	pop    %esi
 778:	5f                   	pop    %edi
 779:	5d                   	pop    %ebp
 77a:	c3                   	ret    
 77b:	90                   	nop
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 780:	83 ec 0c             	sub    $0xc,%esp
 783:	b9 10 00 00 00       	mov    $0x10,%ecx
 788:	6a 00                	push   $0x0
 78a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 78d:	89 f8                	mov    %edi,%eax
 78f:	8b 13                	mov    (%ebx),%edx
 791:	e8 6a fe ff ff       	call   600 <printint>
        ap++;
 796:	89 d8                	mov    %ebx,%eax
 798:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 79b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 79d:	83 c0 04             	add    $0x4,%eax
 7a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7a3:	e9 4d ff ff ff       	jmp    6f5 <printf+0x55>
 7a8:	90                   	nop
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 7b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7b3:	8b 18                	mov    (%eax),%ebx
        ap++;
 7b5:	83 c0 04             	add    $0x4,%eax
 7b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 7bb:	b8 c9 0a 00 00       	mov    $0xac9,%eax
 7c0:	85 db                	test   %ebx,%ebx
 7c2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 7c5:	0f b6 03             	movzbl (%ebx),%eax
 7c8:	84 c0                	test   %al,%al
 7ca:	74 23                	je     7ef <printf+0x14f>
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7d0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7d3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7d6:	83 ec 04             	sub    $0x4,%esp
 7d9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 7db:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7de:	50                   	push   %eax
 7df:	57                   	push   %edi
 7e0:	e8 7d fd ff ff       	call   562 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7e5:	0f b6 03             	movzbl (%ebx),%eax
 7e8:	83 c4 10             	add    $0x10,%esp
 7eb:	84 c0                	test   %al,%al
 7ed:	75 e1                	jne    7d0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7ef:	31 d2                	xor    %edx,%edx
 7f1:	e9 ff fe ff ff       	jmp    6f5 <printf+0x55>
 7f6:	8d 76 00             	lea    0x0(%esi),%esi
 7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 800:	83 ec 04             	sub    $0x4,%esp
 803:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 806:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 809:	6a 01                	push   $0x1
 80b:	e9 4c ff ff ff       	jmp    75c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 810:	83 ec 0c             	sub    $0xc,%esp
 813:	b9 0a 00 00 00       	mov    $0xa,%ecx
 818:	6a 01                	push   $0x1
 81a:	e9 6b ff ff ff       	jmp    78a <printf+0xea>
 81f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 822:	83 ec 04             	sub    $0x4,%esp
 825:	8b 03                	mov    (%ebx),%eax
 827:	6a 01                	push   $0x1
 829:	88 45 e4             	mov    %al,-0x1c(%ebp)
 82c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 82f:	50                   	push   %eax
 830:	57                   	push   %edi
 831:	e8 2c fd ff ff       	call   562 <write>
 836:	e9 5b ff ff ff       	jmp    796 <printf+0xf6>
 83b:	66 90                	xchg   %ax,%ax
 83d:	66 90                	xchg   %ax,%ax
 83f:	90                   	nop

00000840 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 840:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 841:	a1 74 0d 00 00       	mov    0xd74,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 846:	89 e5                	mov    %esp,%ebp
 848:	57                   	push   %edi
 849:	56                   	push   %esi
 84a:	53                   	push   %ebx
 84b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 850:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 853:	39 c8                	cmp    %ecx,%eax
 855:	73 19                	jae    870 <free+0x30>
 857:	89 f6                	mov    %esi,%esi
 859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 860:	39 d1                	cmp    %edx,%ecx
 862:	72 1c                	jb     880 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 864:	39 d0                	cmp    %edx,%eax
 866:	73 18                	jae    880 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 868:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86e:	72 f0                	jb     860 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 870:	39 d0                	cmp    %edx,%eax
 872:	72 f4                	jb     868 <free+0x28>
 874:	39 d1                	cmp    %edx,%ecx
 876:	73 f0                	jae    868 <free+0x28>
 878:	90                   	nop
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 880:	8b 73 fc             	mov    -0x4(%ebx),%esi
 883:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 886:	39 d7                	cmp    %edx,%edi
 888:	74 19                	je     8a3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 88a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 88d:	8b 50 04             	mov    0x4(%eax),%edx
 890:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 893:	39 f1                	cmp    %esi,%ecx
 895:	74 23                	je     8ba <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 897:	89 08                	mov    %ecx,(%eax)
  freep = p;
 899:	a3 74 0d 00 00       	mov    %eax,0xd74
}
 89e:	5b                   	pop    %ebx
 89f:	5e                   	pop    %esi
 8a0:	5f                   	pop    %edi
 8a1:	5d                   	pop    %ebp
 8a2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a3:	03 72 04             	add    0x4(%edx),%esi
 8a6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a9:	8b 10                	mov    (%eax),%edx
 8ab:	8b 12                	mov    (%edx),%edx
 8ad:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8b0:	8b 50 04             	mov    0x4(%eax),%edx
 8b3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8b6:	39 f1                	cmp    %esi,%ecx
 8b8:	75 dd                	jne    897 <free+0x57>
    p->s.size += bp->s.size;
 8ba:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 8bd:	a3 74 0d 00 00       	mov    %eax,0xd74
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8c2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8c5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8c8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8ca:	5b                   	pop    %ebx
 8cb:	5e                   	pop    %esi
 8cc:	5f                   	pop    %edi
 8cd:	5d                   	pop    %ebp
 8ce:	c3                   	ret    
 8cf:	90                   	nop

000008d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	57                   	push   %edi
 8d4:	56                   	push   %esi
 8d5:	53                   	push   %ebx
 8d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8dc:	8b 15 74 0d 00 00    	mov    0xd74,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e2:	8d 78 07             	lea    0x7(%eax),%edi
 8e5:	c1 ef 03             	shr    $0x3,%edi
 8e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8eb:	85 d2                	test   %edx,%edx
 8ed:	0f 84 a3 00 00 00    	je     996 <malloc+0xc6>
 8f3:	8b 02                	mov    (%edx),%eax
 8f5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8f8:	39 cf                	cmp    %ecx,%edi
 8fa:	76 74                	jbe    970 <malloc+0xa0>
 8fc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 902:	be 00 10 00 00       	mov    $0x1000,%esi
 907:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 90e:	0f 43 f7             	cmovae %edi,%esi
 911:	ba 00 80 00 00       	mov    $0x8000,%edx
 916:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 91c:	0f 46 da             	cmovbe %edx,%ebx
 91f:	eb 10                	jmp    931 <malloc+0x61>
 921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 928:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 92a:	8b 48 04             	mov    0x4(%eax),%ecx
 92d:	39 cf                	cmp    %ecx,%edi
 92f:	76 3f                	jbe    970 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 931:	39 05 74 0d 00 00    	cmp    %eax,0xd74
 937:	89 c2                	mov    %eax,%edx
 939:	75 ed                	jne    928 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 93b:	83 ec 0c             	sub    $0xc,%esp
 93e:	53                   	push   %ebx
 93f:	e8 86 fc ff ff       	call   5ca <sbrk>
  if(p == (char*)-1)
 944:	83 c4 10             	add    $0x10,%esp
 947:	83 f8 ff             	cmp    $0xffffffff,%eax
 94a:	74 1c                	je     968 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 94c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 94f:	83 ec 0c             	sub    $0xc,%esp
 952:	83 c0 08             	add    $0x8,%eax
 955:	50                   	push   %eax
 956:	e8 e5 fe ff ff       	call   840 <free>
  return freep;
 95b:	8b 15 74 0d 00 00    	mov    0xd74,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 961:	83 c4 10             	add    $0x10,%esp
 964:	85 d2                	test   %edx,%edx
 966:	75 c0                	jne    928 <malloc+0x58>
        return 0;
 968:	31 c0                	xor    %eax,%eax
 96a:	eb 1c                	jmp    988 <malloc+0xb8>
 96c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 970:	39 cf                	cmp    %ecx,%edi
 972:	74 1c                	je     990 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 974:	29 f9                	sub    %edi,%ecx
 976:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 979:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 97c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 97f:	89 15 74 0d 00 00    	mov    %edx,0xd74
      return (void*)(p + 1);
 985:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 988:	8d 65 f4             	lea    -0xc(%ebp),%esp
 98b:	5b                   	pop    %ebx
 98c:	5e                   	pop    %esi
 98d:	5f                   	pop    %edi
 98e:	5d                   	pop    %ebp
 98f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 990:	8b 08                	mov    (%eax),%ecx
 992:	89 0a                	mov    %ecx,(%edx)
 994:	eb e9                	jmp    97f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 996:	c7 05 74 0d 00 00 78 	movl   $0xd78,0xd74
 99d:	0d 00 00 
 9a0:	c7 05 78 0d 00 00 78 	movl   $0xd78,0xd78
 9a7:	0d 00 00 
    base.s.size = 0;
 9aa:	b8 78 0d 00 00       	mov    $0xd78,%eax
 9af:	c7 05 7c 0d 00 00 00 	movl   $0x0,0xd7c
 9b6:	00 00 00 
 9b9:	e9 3e ff ff ff       	jmp    8fc <malloc+0x2c>
