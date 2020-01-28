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

But the program is protected.\
As we can see on this [page](https://aaronyoo.github.io/ptrace-anti-debug.html), the protection
of `ltrace` is by lauching a debugger, so no two tracers can trace the same tracee.

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
level09@SnowCrash:~$ ltrace env LD_PRELOAD="/tmp/tmp.BoEzZcCi0q/ptrace_inject.s" ./level09 token
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

Documentation :
* https://aaronyoo.github.io/ptrace-anti-debug.html
