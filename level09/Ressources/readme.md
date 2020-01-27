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

```bash
level09@SnowCrash:~$ ltrace ./level09 token
__libc_start_main(0x80487ce, 2, 0xbffff7a4, 0x8048aa0, 0x8048b10 <unfinished ...>
ptrace(0, 0, 1, 0, 0xb7e2fe38)                                                                     = -1
puts("You should not reverse this"You should not reverse this
)                                                                = 28
+++ exited (status 1) +++
```

```bash
level09@SnowCrash:~$ mktemp -d
/tmp/tmp.DgWOUNSEPO

level09@SnowCrash:/tmp/tmp.DgWOUNSEPO$ cat ptrace_inject.c
// This is a redefinition of ptrace to get around the
// ptrace anti-debug trick.

long ptrace(int a, int b, void *c, void *d) {
        return 0;
}

level09@SnowCrash:/tmp/tmp.DgWOUNSEPO$ gcc -shared -fPIC -o ptrace_inject.so ptrace_inject.c
```


Documentation :
* https://aaronyoo.github.io/ptrace-anti-debug.html
