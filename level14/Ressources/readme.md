# level14

```bash
ssh  level14@10.11.200.180 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          10.11.200.180
level14@10.11.200.180's password:
Permission denied, please try again.
level14@10.11.200.180's password: 2A31L79asukciNyi8uppkEuSx
level14@SnowCrash:~$
```

```bash
level14@SnowCrash:~$ ls -la
total 12
dr-x------ 1 level14 level14  100 Mar  5  2016 .
d--x--x--x 1 root    users    340 Aug 30  2015 ..
-r-x------ 1 level14 level14  220 Apr  3  2012 .bash_logout
-r-x------ 1 level14 level14 3518 Aug 30  2015 .bashrc
-r-x------ 1 level14 level14  675 Apr  3  2012 .profile
level14@SnowCrash:~$ which getflag
/bin/getflag
```

On peut voir que getflag contient des strings avec les flags dans le code et qu'il a l'air d'y appliquer une hash.

```bash
level14@SnowCrash:~$ strings /bin/getflag
[..]
I`fA>_88eEd:=`85h0D8HE>,D   # flag 00
7`4Ci4=^d=J,?>i;6,7d416,7
<>B16\AD<C6,G_<1>^7ci>l4B
B8b:6,3fj7:,;bh>D@>8i:6@D
?4d@:,C>8C60G>8:h:Gb4?l,A
G8H.6,=4k5J0<cd/D@>>B:>:4
H8B8h_20B4J43><8>\ED<;j@3
78H:J4<4<9i_I4k0J^5>B1j`9
bci`mC{)jxkn<"uD~6%g7FK`7
Dc6m~;}f8Cj#xFkel;#&ycfbK
74H9D^3ed7k05445J0E4e;Da4
70hCi,E44Df[A4B/J@3f<=:`D
8_Dw"4#?+3i]q&;p6 gtw88EC
boe]!ai0FB@.:|L6l@A?>qJ}I   #  flag 13
g <t61:|4_|!@IF.-62FH&G~DCK/Ekrvvdwz?v|     # flag 14 ?
[..]
```

Après on peut désassembler le code -> [getflag.asm](getflag.asm)

```bash
level14@SnowCrash:~$ cat /etc/group
[..]
flag00:x:3000:
flag01:x:3001:
flag02:x:3002:
flag03:x:3003:
flag04:x:3004:
flag05:x:3005:
flag06:x:3006:
flag07:x:3007:
flag08:x:3008:
flag09:x:3009:
flag10:x:3010:
flag11:x:3011:
flag12:x:3012:
flag13:x:3013:
flag14:x:3014: # on veut celui-ci. pour getuid
[..]
```

Avec gdb, on changer le retour de ptrace à `1` pour qu'on puisse continuer, et changer le retour de getuid à `3014` pour avoir le bon flag.

```gdb
level14@SnowCrash:~$ gdb /bin/getflag
GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2.1) 7.4-2012.04
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-linux-gnu".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /bin/getflag...(no debugging symbols found)...done.
(gdb) b main
Breakpoint 1 at 0x804894a
(gdb) r
Starting program: /bin/getflag

Breakpoint 1, 0x0804894a in main ()
(gdb) b ptrace
Breakpoint 2 at 0xb7f146d0
(gdb) n
Single stepping until exit from function main,
which has no line number information.

Breakpoint 2, 0xb7f146d0 in ptrace () from /lib/i386-linux-gnu/libc.so.6
(gdb) n
Single stepping until exit from function ptrace,
which has no line number information.
0x0804898e in main ()
(gdb) set $eax=1
(gdb) b getuid
Breakpoint 3 at 0xb7ee4cc0
(gdb) n
Single stepping until exit from function main,
which has no line number information.

Breakpoint 3, 0xb7ee4cc0 in getuid () from /lib/i386-linux-gnu/libc.so.6
(gdb) n
Single stepping until exit from function getuid,
which has no line number information.
0x08048b02 in main ()
(gdb) set $eax=3014
(gdb) n
Single stepping until exit from function main,
which has no line number information.
Check flag.Here is your token : 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
0xb7e454d3 in __libc_start_main () from /lib/i386-linux-gnu/libc.so.6
(gdb)
```

Et voici le flag : `7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ`

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

```bash
level09@SnowCrash:~$ gdb ./level09
(gdb) run
Starting program: /home/user/level09/level09
You should not reverse this
[Inferior 1 (process 2978) exited with code 01]
(gdb)
```

```
(gdb) show disassembly-flavor
The disassembly flavor is "att".
(gdb) set disassembly-flavor intel
(gdb) layout asm
```

Documentation :
* https://linux.die.net/man/1/strings
* https://aaronyoo.github.io/ptrace-anti-debug.html
* https://devarea.developpez.com/dix-choses-faisables-avec-GDB/
* https://sourceware.org/gdb/current/onlinedocs/gdb/Registers.html
