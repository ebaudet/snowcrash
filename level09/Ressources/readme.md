# Level 09 : found flag09
```bash
ssh level09@192.168.1.37 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          192.168.1.37
level09@192.168.1.37's password: 25749xKZ8L7DkSCwJkT9dyv6f
level09@SnowCrash:~$
```

```bash
level09@SnowCrash:~$ ls -la
total 24
dr-x------ 1 level09 level09  140 Mar  5  2016 .
d--x--x--x 1 root    users    340 Aug 30  2015 ..
-r-x------ 1 level09 level09  220 Apr  3  2012 .bash_logout
-r-x------ 1 level09 level09 3518 Aug 30  2015 .bashrc
-r-x------ 1 level09 level09  675 Apr  3  2012 .profile
-rwsr-sr-x 1 flag09  level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09  level09   26 Mar  5  2016 token
```


## 1. Observation

```bash
level09@SnowCrash:~$ ./level09
You need to provied only one arg.
level09@SnowCrash:~$ ./level09 token
tpmhr
```

We launch `ltrace` to see what is inside..

```bash
level09@SnowCrash:~$ ltrace ./level09 token
__libc_start_main(0x80487ce, 2, 0xbffff7a4, 0x8048aa0, 0x8048b10 <unfinished ...>
ptrace(0, 0, 1, 0, 0xb7e2fe38)                                                                     = -1
puts("You should not reverse this"You should not reverse this
)                                                                = 28
+++ exited (status 1) +++
```

So the solutions is not by reversing the file *(see point 3. More about the reverse part)*.

```bash
level09@SnowCrash:~$ ./level09 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
abcdefghijklmnopqrstuvwxyz{|}~
```

As we can see, the programme `./level09` change the value of the string by adding 1 at each letters.

```bash
level09@SnowCrash:~$ cat token
f4kmm6p|=�p�n��DB�Du{��
level09@SnowCrash:~$ cat -e token
f4kmm6p|=M-^B^?pM-^BnM-^CM-^BDBM-^CDu{^?M-^LM-^I$
```

## 2. Solution

```bash
# We make a python script that will reverse in inverse order.
level09@SnowCrash:~$ echo "
import sys
file = sys.argv[1]
with open(file, 'r') as f:
    row = f.read()[:-1]
    result = ''
    for i, c in enumerate(row):
        result = result + chr(ord(c) - i)
    print (result)
">/tmp/eb09
# By launching this script on the content file token, we have a good string
level09@SnowCrash:~$ python /tmp/eb09 token
f3iji1ju5yuevaus41q1afiuq
# that we can use to pass flag09
level09@SnowCrash:~$ su flag09
Password: f3iji1ju5yuevaus41q1afiuq
Don't forget to launch getflag !
# and get the flag.
flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```

*******************************************************************************

## 3. More about the reverse part.

When trying to reverse the file, we saw this.

But the program is protected.\
As we can see on this [page](https://aaronyoo.github.io/ptrace-anti-debug.html), the protection
of `ltrace` is by launching a debugger, so no two tracers can trace the same trace.

```bash
level09@SnowCrash:~$ mktemp -d
/tmp/tmp.BoEzZcCi0q

level09@SnowCrash:/tmp/tmp.BoEzZcCi0q$ cat ptrace_inject.c
// This is a redefinition of ptrace to get around the
// ptrace anti-debug trick.

long ptrace(int a, int b, void *c, void *d) {
        return 0;
}

level09@SnowCrash:/tmp/tmp.BoEzZcCi0q$ gcc -shared -fPIC -o ptrace_inject.so ptrace_inject.c
```

```bash
level09@SnowCrash:~$ ltrace env LD_PRELOAD="/tmp/tmp.BoEzZcCi0q/ptrace_inject.so" ./level09 token
__libc_start_main(0x8048db0, 4, 0xbffff734, 0x804b700, 0x804b770 <unfinished ...>
strrchr("env", '/')                           = NULL
setlocale(6, "")                              = NULL
bindtextdomain("coreutils", "/usr/share/locale") = "/usr/share/locale"
textdomain("coreutils")                       = "coreutils"
__cxa_atexit(0x8049500, 0, 0, 0xbffff734, 4)  = 0
getopt_long(4, 0xbffff734, "+iu:0", 0x0804bc40, NULL) = -1
getopt_long(4, 0xbffff734, "+iu:0", 0x0804bc40, NULL) = -1
strchr("LD_PRELOAD=/tmp/tmp.BoEzZcCi0q/p"..., '=') = "=/tmp/tmp.BoEzZcCi0q/ptrace_inje"...
putenv("LD_PRELOAD=/tmp/tmp.BoEzZcCi0q/p"...) = 0
strchr("./level09", '=')                      = NULL
execvp(0xbffff893, 0xbffff73c, 0x804bbea, 0x804bc40, 0 <unfinished ...>
--- Called exec() ---
__libc_start_main(0x80487ce, 2, 0xbffff734, 0x8048aa0, 0x8048b10 <unfinished ...>
ptrace(0, 0, 1, 0, 0xb7e2ce38)                = 0
getenv("LD_PRELOAD")                          = "/tmp/tmp.BoEzZcCi0q/ptrace_injec"...
fwrite("Injection Linked lib detected ex"..., 1, 37, 0xb7fce980Injection Linked lib detected exit..
) = 37
+++ exited (status 1) +++
```

But the is a test done on the variable `LD_PRELOAD`.\
So we change our script a little:

```bash
level09@SnowCrash:/tmp/tmp.BoEzZcCi0q$ cat ptrace_inject.c
// This is a redefinition of ptrace to get around the
// ptrace anti-debug trick.
#include <stdlib.h>
long ptrace(int a, int b, void *c, void *d) {
        unsetenv("LD_PRELOAD");
        return 0;
}
```

```bash
level09@SnowCrash:~$ ltrace env LD_PRELOAD="/tmp/tmp.BoEzZcCi0q/ptrace_inject.s" ./level09 token
__libc_start_main(0x8048db0, 4, 0xbffff714, 0x804b700, 0x804b770 <unfinished ...>
strrchr("env", '/')                           = NULL
setlocale(6, "")                              = NULL
bindtextdomain("coreutils", "/usr/share/locale") = "/usr/share/locale"
textdomain("coreutils")                       = "coreutils"
__cxa_atexit(0x8049500, 0, 0, 0xbffff714, 4)  = 0
getopt_long(4, 0xbffff714, "+iu:0", 0x0804bc40, NULL) = -1
getopt_long(4, 0xbffff714, "+iu:0", 0x0804bc40, NULL) = -1
strchr("LD_PRELOAD=/tmp/tmp.BoEzZcCi0q/p"..., '=') = "=/tmp/tmp.BoEzZcCi0q/ptrace_inje"...
putenv("LD_PRELOAD=/tmp/tmp.BoEzZcCi0q/p"...) = 0
strchr("./level09", '=')                      = NULL
execvp(0xbffff887, 0xbffff71c, 0x804bbea, 0x804bc40, 0 <unfinished ...>
--- Called exec() ---
__libc_start_main(0x80487ce, 2, 0xbffff734, 0x8048aa0, 0x8048b10 <unfinished ...>
ptrace(0, 0, 1, 0, 0xb7e2ce38)                = 0
getenv("LD_PRELOAD")                          = NULL
open("/etc/ld.so.preload", 0, 01)             = -1
fwrite("LD_PRELOAD detected through memo"..., 1, 48, 0xb7fce980LD_PRELOAD detected through memory maps exit ..
) = 48
+++ exited (status 48) +++
```

### With gdb

```bash
level09@SnowCrash:~$ nm level09
08049f28 d _DYNAMIC
08049ff4 d _GLOBAL_OFFSET_TABLE_
08048b6c R _IO_stdin_used
         w _Jv_RegisterClasses
08049f18 d __CTOR_END__
08049f14 d __CTOR_LIST__
08049f20 D __DTOR_END__
08049f1c d __DTOR_LIST__
08048e50 r __FRAME_END__
08049f24 d __JCR_END__
08049f24 d __JCR_LIST__
0804a034 A __bss_start
0804a028 D __data_start
08048b20 t __do_global_ctors_aux
08048520 t __do_global_dtors_aux
0804a02c D __dso_handle
         w __gmon_start__
08048b12 T __i686.get_pc_thunk.bx
08049f14 d __init_array_end
08049f14 d __init_array_start
08048b10 T __libc_csu_fini
08048aa0 T __libc_csu_init
         U __libc_start_main@@GLIBC_2.0 # block hear
         U __stack_chk_fail@@GLIBC_2.4
0804a034 A _edata
0804a06c A _end
08048b4c T _fini
08048b68 R _fp_hw
08048408 T _init
080484f0 T _start
08048646 T afterSubstr
0804a064 b completed.6159
0804a028 W data_start
0804a068 b dtor_idx.6161
0804a030 d end.3170
         U fputc@@GLIBC_2.0
08048580 t frame_dummy
         U fwrite@@GLIBC_2.0
         U getenv@@GLIBC_2.0
080486cb T isLib
080487ce T main # pass here
         U open@@GLIBC_2.0
         U ptrace@@GLIBC_2.0
         U putchar@@GLIBC_2.0
         U puts@@GLIBC_2.0
0804a040 B stderr@@GLIBC_2.0
0804a060 B stdout@@GLIBC_2.0
080485d4 T syscall_gets
080485a4 T syscall_open
```

#### GDB usage :

```
quit (q)							quitter gdb
run (r)								lancer l’exécution

break,watch,clear,delete (b,w,cl,d)	introduire un point d’arrêt, ou bien “surveiller” une variable

step,next,continue (s,n,c)			avancer d’un pas (en entrant ou pas dans les sous-fonctions), relancer
									jusqu’au prochain point d’arrêt
stepi (si)							steps by one machine instruction

print,backtrace,list (p,bt,l)		afficher la valeur d’une variable, la pile d’exécution, afficher l’endroit où
									l’on se trouve dans le code

disassemble /m my_function			disas function my_function

info registers						print register values

x/20w $rsp							print 20 word a partir du pointeur de pile

commands							lists of commands to execute at each breakpoints
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
* https://aaronyoo.github.io/ptrace-anti-debug.html
* https://devarea.developpez.com/dix-choses-faisables-avec-GDB/
