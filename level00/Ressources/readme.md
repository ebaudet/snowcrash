# Level 00 : found flag00
```bash
level00@192.168.1.37's password: level00
level00@SnowCrash:~$
```

```bash
$ man find
...
-user uname
             True if the file belongs to the user uname.  If uname is numeric
             and there is no such user name, then uname is treated as a user ID.
```

Et plus [ici](https://www.ostechnix.com/find-files-based-permissions/).

`2>/dev/null` : clear error from standard output.

```bash
level00@SnowCrash:~$ find / -user flag00  2>/dev/null
/usr/sbin/john
/rofs/usr/sbin/john
```

```bash
level00@SnowCrash:~$ cat /usr/sbin/john
cdiiddwpgswtgt
```

Mais ce n'est pas suffisant car `cdiiddwpgswtgt` est crypté.

Documentation :
* https://fr.wikipedia.org/wiki/Portail:Cryptologie 
* https://www.dcode.fr/liste-outils#dcode

Trying a lot of different encryption. ROT (chiffre de césar) semble fonctionner.
* https://www.dcode.fr/chiffre-cesar

```bash
level00@SnowCrash:~$ cat /usr/sbin/john | tr {a-z,l-za-k}
nottoohardhere
level00@SnowCrash:~$ su flag00
Password: nottoohardhere
Don't forget to launch getflag !
flag00@SnowCrash:~$ getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```
