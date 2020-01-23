# Level 01 : found flag01

```bash
flag00@SnowCrash:~$ su level01
Password: x24ti5gi3x0ol2eh4esiuxias
level01@SnowCrash:~$
```

```bash
level01@SnowCrash:~$ cat /etc/passwd | grep flag01
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
```

```bash
# copy the password localy
$ scp -p -P 4242 level01@192.168.1.37:/etc/passwd .
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          192.168.1.37 2a01:e0a:249:ce90:7d2a:afe7:a6f:5762 2a01:e0a:249:ce90:a00:27ff:fe20:2cd4
level01@192.168.1.37's password: x24ti5gi3x0ol2eh4esiuxias
passwd                                      100% 2477     3.0MB/s   00:00
# install John The Ripper (john-jumbo) (http://macappstore.org/john-jumbo/)
$ brew install john-jumbo
...
# how to use john :
$ john --help
John the Ripper 1.9.0-jumbo-1 [darwin18.6.0 64-bit x86_64 SSE4.2 AC]
Copyright (c) 1996-2019 by Solar Designer and others
Homepage: http://www.openwall.com/john/

Usage: john [OPTIONS] [PASSWORD-FILES]
--single[=SECTION[,..]]    "single crack" mode, using default or named rules
--single=:rule[,..]        same, using "immediate" rule(s)
--wordlist[=FILE] --stdin  wordlist mode, read words from FILE or stdin
                  --pipe   like --stdin, but bulk reads, and allows rules
--loopback[=FILE]          like --wordlist, but extract words from a .pot file
--dupe-suppression         suppress all dupes in wordlist (and force preload)
--prince[=FILE]            PRINCE mode, read words from FILE
--encoding=NAME            input encoding (eg. UTF-8, ISO-8859-1). See also
                           doc/ENCODINGS and --list=hidden-options.
--rules[=SECTION[,..]]     enable word mangling rules (for wordlist or PRINCE
                           modes), using default or named rules
--rules=:rule[;..]]        same, using "immediate" rule(s)
--rules-stack=SECTION[,..] stacked rules, applied after regular rules or to
                           modes that otherwise don't support rules
--rules-stack=:rule[;..]   same, using "immediate" rule(s)
--incremental[=MODE]       "incremental" mode [using section MODE]
--mask[=MASK]              mask mode using MASK (or default from john.conf)
--markov[=OPTIONS]         "Markov" mode (see doc/MARKOV)
--external=MODE            external mode or word filter
--subsets[=CHARSET]        "subsets" mode (see doc/SUBSETS)
--stdout[=LENGTH]          just output candidate passwords [cut at LENGTH]
--restore[=NAME]           restore an interrupted session [called NAME]
--session=NAME             give a new session the NAME
--status[=NAME]            print status of a session [called NAME]
--make-charset=FILE        make a charset file. It will be overwritten
--show[=left]              show cracked passwords [if =left, then uncracked]
--test[=TIME]              run tests and benchmarks for TIME seconds each
--users=[-]LOGIN|UID[,..]  [do not] load this (these) user(s) only
--groups=[-]GID[,..]       load users [not] of this (these) group(s) only
--shells=[-]SHELL[,..]     load users with[out] this (these) shell(s) only
--salts=[-]COUNT[:MAX]     load salts with[out] COUNT [to MAX] hashes
--costs=[-]C[:M][,...]     load salts with[out] cost value Cn [to Mn]. For
                           tunable cost parameters, see doc/OPTIONS
--save-memory=LEVEL        enable memory saving, at LEVEL 1..3
--node=MIN[-MAX]/TOTAL     this node's number range out of TOTAL count
--fork=N                   fork N processes
--pot=NAME                 pot file to use
--list=WHAT                list capabilities, see --list=help or doc/OPTIONS
--devices=N[,..]           set OpenCL device(s) (see --list=opencl-devices)
--format=NAME              force hash of type NAME. The supported formats can
                           be seen with --list=formats and --list=subformats
# search password for user flag01
$ john --user=flag01 passwd
Warning: detected hash type "descrypt", but the string is also recognized as "descrypt-opencl"
Use the "--format=descrypt-opencl" option to force loading these as that type instead
Using default input encoding: UTF-8
Loaded 1 password hash (descrypt, traditional crypt(3) [DES 128/128 SSE2])
Proceeding with single, rules:Single
Press 'q' or Ctrl-C to abort, almost any other key for status
Almost done: Processing the remaining buffered candidate passwords, if any.
Warning: Only 9 candidates buffered for the current salt, minimum 128 needed for performance.
Proceeding with wordlist:/usr/local/Cellar/john-jumbo/1.9.0/share/john/password.lst, rules:Wordlist
abcdefg          (flag01)
1g 0:00:00:00 DONE 2/3 (2020-01-23 10:53) 100.0g/s 142600p/s 142600c/s 142600C/s raquel..bigman
Use the "--show" option to display all of the cracked passwords reliably
Session completed
# once finished, we can see the password in the verbose of function
# or by using with this option
$ john --show passwd
flag01:abcdefg:3001:3001::/home/flag/flag01:/bin/bash

1 password hash cracked, 0 left
# John the Riper save the founded correspondance in ~/.john/
$ ls ~/.john
john.log john.pot
$ cat ~/.john/john.pot
42hDRfypTqqnw:abcdefg
```

```bash
level01@SnowCrash:~$ su flag01
Password: abcdefg
Don't forget to launch getflag !
flag01@SnowCrash:~$ getflag
Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```

****************************************

Documentations :
* https://null-byte.wonderhowto.com/how-to/crack-shadow-hashes-after-getting-root-linux-system-0186386/
* https://null-byte.wonderhowto.com/how-to/hack-like-pro-crack-user-passwords-linux-system-0147164/

