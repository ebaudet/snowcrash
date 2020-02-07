# Level 13

```bash
$ ssh level13@10.11.200.180 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          10.11.200.180
level12@10.11.200.180's password: g1qKMiRpXf53AWhDaU7FEkczr
```

```bash
$ level13@SnowCrash:~$ ls -la
total 20
dr-x------ 1 level13 level13  120 Mar  5  2016 .
d--x--x--x 1 root    users    340 Aug 30  2015 ..
-r-x------ 1 level13 level13  220 Apr  3  2012 .bash_logout
-r-x------ 1 level13 level13 3518 Aug 30  2015 .bashrc
-r-x------ 1 level13 level13  675 Apr  3  2012 .profile
-rwsr-sr-x 1 flag13  level13 7303 Aug 30  2015 level13
```

```bash
level13@SnowCrash:~$ ./level13
UID 2013 started us but we we expect 4242
level13@SnowCrash:~$ gdb level13
GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2.1) 7.4-2012.04
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-linux-gnu".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /home/user/level13/level13...(no debugging symbols found)...done.
(gdb) disassemble main
Dump of assembler code for function main:
   0x0804858c <+0>: 	push   %ebp
   0x0804858d <+1>: 	mov    %esp,%ebp
   0x0804858f <+3>: 	and    $0xfffffff0,%esp
   0x08048592 <+6>: 	sub    $0x10,%esp
   0x08048595 <+9>: 	call   0x8048380 <getuid@plt>
   0x0804859a <+14>:	cmp    $0x1092,%eax           # compare EAX to 0x1092 (4242)
   0x0804859f <+19>:	je     0x80485cb <main+63>
   0x080485a1 <+21>:	call   0x8048380 <getuid@plt>
   0x080485a6 <+26>:	mov    $0x80486c8,%edx
   0x080485ab <+31>:	movl   $0x1092,0x8(%esp)
   0x080485b3 <+39>:	mov    %eax,0x4(%esp)
   0x080485b7 <+43>:	mov    %edx,(%esp)
   0x080485ba <+46>:	call   0x8048360 <printf@plt>
   0x080485bf <+51>:	movl   $0x1,(%esp)
   0x080485c6 <+58>:	call   0x80483a0 <exit@plt>
   0x080485cb <+63>:	movl   $0x80486ef,(%esp)
   0x080485d2 <+70>:	call   0x8048474 <ft_des>
   0x080485d7 <+75>:	mov    $0x8048709,%edx
   0x080485dc <+80>:	mov    %eax,0x4(%esp)
   0x080485e0 <+84>:	mov    %edx,(%esp)
   0x080485e3 <+87>:	call   0x8048360 <printf@plt>
   0x080485e8 <+92>:	leave
   0x080485e9 <+93>:	ret
End of assembler dump.
(gdb) b getuid
Breakpoint 1 at 0x8048380
(gdb) r
Starting program: /home/user/level13/level13

Breakpoint 1, 0xb7ee4cc0 in getuid () from /lib/i386-linux-gnu/libc.so.6
(gdb) n
Single stepping until exit from function getuid,
which has no line number information.
0x0804859a in main ()
(gdb) info registers
eax            0x7dd	2013    # old EAX value, this is the GID
ecx            0xbffff784	-1073743996
edx            0xbffff714	-1073744108
ebx            0xb7fd0ff4	-1208152076
esp            0xbffff6d0	0xbffff6d0
ebp            0xbffff6e8	0xbffff6e8
esi            0x0	0
edi            0x0	0
eip            0x804859a	0x804859a <main+14>
eflags         0x200246	[ PF ZF IF ID ]
cs             0x73	115
ss             0x7b	123
ds             0x7b	123
es             0x7b	123
fs             0x0	0
gs             0x33	51
(gdb) set $eax = 4242
(gdb) info registers
eax            0x1092	4242    # new EAX value : 4242
ecx            0xbffff784	-1073743996
edx            0xbffff714	-1073744108
ebx            0xb7fd0ff4	-1208152076
esp            0xbffff6d0	0xbffff6d0
ebp            0xbffff6e8	0xbffff6e8
esi            0x0	0
edi            0x0	0
eip            0x804859a	0x804859a <main+14>
eflags         0x200246	[ PF ZF IF ID ]
cs             0x73	115
ss             0x7b	123
ds             0x7b	123
es             0x7b	123
fs             0x0	0
gs             0x33	51
(gdb) n
Single stepping until exit from function main,
which has no line number information.
your token is 2A31L79asukciNyi8uppkEuSx
0xb7e454d3 in __libc_start_main () from /lib/i386-linux-gnu/libc.so.6
(gdb)
```

-----

#### GDB usage :

```
quit (q)						quitter gdb
run (r)							lancer l’exécution

break,watch,clear,delete (b,w,cl,d)	introduire un point d’arrêt, ou bien “surveiller” une variable

step,next,continue (s,n,c)		avancer d’un pas (en entrant ou pas dans les sous-fonctions), relancer
								jusqu’au prochain point d’arrêt
stepi (si)						steps by one machine instruction

print,backtrace,list (p,bt,l)	afficher la valeur d’une variable, la pile d’exécution, afficher l’endroit où
								l’on se trouve dans le code

disassemble /m my_function		disas function my_function

info registers					print register values

x/20w $rsp						print 20 word a partir du pointeur de pile

commands						lists of commands to execute at each breakpoints

set $eax = 1					set EAX register to 1
```

----
Documentation:


