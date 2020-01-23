# Level 01 : found flag01

```bash
flag01@SnowCrash:~$  su level02
Password: f2av5il02puano7naaf6adaaf
level02@SnowCrash:~$ ls
level02.pcap
```

`PCAP file` (Packet Capture Data) is a data file created by Wireshark (formely Ethereal) and contains network packet data created during a live capture of red.\
It can be analysed using software that includes the libcap libraries.\
[[source](https://fileinfo.com/extension/pcap)]

So we get the file in our system.
```bash
$ scp -p -P 4242 level02@192.168.1.37:~/level02.pcap .
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          192.168.1.37 2a01:e0a:249:ce90:7d2a:afe7:a6f:5762 2a01:e0a:249:ce90:a00:27ff:fe20:2cd4
level02@192.168.1.37's password: f2av5il02puano7naaf6adaaf
level02.pcap                                100% 8302     5.8MB/s   00:00
# and we change the permissions to read it. (or we can scp without -p option)
$ chmod +rw level02.pcap
```

## Wireshirk command line : `tshark`

Install wireshark to read the file

```bash
$ brew install wireshark
```
Here how to use wireshark. With the command `tshark`
```bash
$ man tshark
$ tshark --help
TShark (Wireshark) 3.2.1 (Git commit bf38a67724d0)
Dump and analyze network traffic.
See https://www.wireshark.org for more information.

Usage: tshark [options] ...

Capture interface:
  -i <interface>, --interface <interface>
                           name or idx of interface (def: first non-loopback)
  -f <capture filter>      packet filter in libpcap filter syntax
  -s <snaplen>, --snapshot-length <snaplen>
                           packet snapshot length (def: appropriate maximum)
  -p, --no-promiscuous-mode
                           don't capture in promiscuous mode
  -I, --monitor-mode       capture in monitor mode, if available
  -B <buffer size>, --buffer-size <buffer size>
                           size of kernel buffer (def: 2MB)
  -y <link type>, --linktype <link type>
                           link layer type (def: first appropriate)
  --time-stamp-type <type> timestamp method for interface
  -D, --list-interfaces    print list of interfaces and exit
  -L, --list-data-link-types
                           print list of link-layer types of iface and exit
  --list-time-stamp-types  print list of timestamp types for iface and exit

Capture stop conditions:
  -c <packet count>        stop after n packets (def: infinite)
  -a <autostop cond.> ..., --autostop <autostop cond.> ...
                           duration:NUM - stop after NUM seconds
                           filesize:NUM - stop this file after NUM KB
                              files:NUM - stop after NUM files
                            packets:NUM - stop after NUM packets
Capture output:
  -b <ringbuffer opt.> ..., --ring-buffer <ringbuffer opt.>
                           duration:NUM - switch to next file after NUM secs
                           filesize:NUM - switch to next file after NUM KB
                              files:NUM - ringbuffer: replace after NUM files
                            packets:NUM - switch to next file after NUM packets
                           interval:NUM - switch to next file when the time is
                                          an exact multiple of NUM secs
Input file:
  -r <infile>, --read-file <infile>
                           set the filename to read from (or '-' for stdin)

Processing:
  -2                       perform a two-pass analysis
  -M <packet count>        perform session auto reset
  -R <read filter>, --read-filter <read filter>
                           packet Read filter in Wireshark display filter syntax
                           (requires -2)
  -Y <display filter>, --display-filter <display filter>
                           packet displaY filter in Wireshark display filter
                           syntax
  -n                       disable all name resolutions (def: all enabled)
  -N <name resolve flags>  enable specific name resolution(s): "mnNtdv"
  -d <layer_type>==<selector>,<decode_as_protocol> ...
                           "Decode As", see the man page for details
                           Example: tcp.port==8888,http
  -H <hosts file>          read a list of entries from a hosts file, which will
                           then be written to a capture file. (Implies -W n)
  --enable-protocol <proto_name>
                           enable dissection of proto_name
  --disable-protocol <proto_name>
                           disable dissection of proto_name
  --enable-heuristic <short_name>
                           enable dissection of heuristic protocol
  --disable-heuristic <short_name>
                           disable dissection of heuristic protocol
Output:
  -w <outfile|->           write packets to a pcapng-format file named "outfile"
                           (or '-' for stdout)
  --capture-comment <comment>
                           set the capture file comment, if supported
  -C <config profile>      start with specified configuration profile
  -F <output file type>    set the output file type, default is pcapng
                           an empty "-F" option will list the file types
  -V                       add output of packet tree        (Packet Details)
  -O <protocols>           Only show packet details of these protocols, comma
                           separated
  -P, --print              print packet summary even when writing to a file
  -S <separator>           the line separator to print between packets
  -x                       add output of hex and ASCII dump (Packet Bytes)
  -T pdml|ps|psml|json|jsonraw|ek|tabs|text|fields|?
                           format of text output (def: text)
  -j <protocolfilter>      protocols layers filter if -T ek|pdml|json selected
                           (e.g. "ip ip.flags text", filter does not expand child
                           nodes, unless child is specified also in the filter)
  -J <protocolfilter>      top level protocol filter if -T ek|pdml|json selected
                           (e.g. "http tcp", filter which expands all child nodes)
  -e <field>               field to print if -Tfields selected (e.g. tcp.port,
                           _ws.col.Info)
                           this option can be repeated to print multiple fields
  -E<fieldsoption>=<value> set options for output when -Tfields selected:
     bom=y|n               print a UTF-8 BOM
     header=y|n            switch headers on and off
     separator=/t|/s|<char> select tab, space, printable character as separator
     occurrence=f|l|a      print first, last or all occurrences of each field
     aggregator=,|/s|<char> select comma, space, printable character as
                           aggregator
     quote=d|s|n           select double, single, no quotes for values
  -t a|ad|adoy|d|dd|e|r|u|ud|udoy
                           output format of time stamps (def: r: rel. to first)
  -u s|hms                 output format of seconds (def: s: seconds)
  -l                       flush standard output after each packet
  -q                       be more quiet on stdout (e.g. when using statistics)
  -Q                       only log true errors to stderr (quieter than -q)
  -g                       enable group read access on the output file(s)
  -W n                     Save extra information in the file, if supported.
                           n = write network address resolution information
  -X <key>:<value>         eXtension options, see the man page for details
  -U tap_name              PDUs export mode, see the man page for details
  -z <statistics>          various statistics, see the man page for details
  --export-objects <protocol>,<destdir>
                           save exported objects for a protocol to a directory
                           named "destdir"
  --color                  color output text similarly to the Wireshark GUI,
                           requires a terminal with 24-bit color support
                           Also supplies color attributes to pdml and psml formats
                           (Note that attributes are nonstandard)
  --no-duplicate-keys      If -T json is specified, merge duplicate keys in an object
                           into a single key with as value a json array containing all
                           values
  --elastic-mapping-filter <protocols> If -G elastic-mapping is specified, put only the
                           specified protocols within the mapping file

Miscellaneous:
  -h, --help               display this help and exit
  -v, --version            display version info and exit
  -o <name>:<value> ...    override preference setting
  -K <keytab>              keytab file to use for kerberos decryption
  -G [report]              dump one of several available reports and exit
                           default report="fields"
                           use "-G help" for more help
```
Util option of `tshark`
```
-e <field>
        Add a field to the list of fields to display if -T ek|fields|json|pdml is selected. This option can be used multiple times on the command line. At least one field must be provided if the -T fields option is selected. Column names may be used prefixed with "_ws.col."

        Example: tshark -e frame.number -e ip.addr -e udp -e _ws.col.Info

        Giving a protocol rather than a single field will print multiple items of data about the protocol as a single field. Fields are separated by tab characters by default. -E controls the format of the printed fields.

-T ek|fields|json|jsonraw|pdml|ps|psml|tabs|text
        Set the format of the output when viewing decoded packet data. The options are one of:

        ek Newline delimited JSON format for bulk import into Elasticsearch. It can be used with -j or -J to specify which protocols to include or with -x to include raw hex-encoded packet data. If -P is specified it will print the packet summary only, with both -P and -V it will print the packet summary and packet details. If neither -P or -V are used it will print the packet details only. Example of usage to import data into Elasticsearch:

        tshark -T ek -j "http tcp ip" -P -V -x -r file.pcap > file.json
        curl -H "Content-Type: application/x-ndjson" -XPOST http://elasticsearch:9200/_bulk --data-binary "@file.json"
        Elastic requires a mapping file to be loaded as template for packets-* index in order to convert wireshark types to elastic types. This file can be auto-generated with the command "tshark -G elastic-mapping". Since the mapping file can be huge, protocols can be selected by using the option --elastic-mapping-filter:

        tshark -G elastic-mapping --elastic-mapping-filter ip,udp,dns
        fields The values of fields specified with the -e option, in a form specified by the -E option. For example,

        tshark -T fields -E separator=, -E quote=d
        would generate comma-separated values (CSV) output suitable for importing into your favorite spreadsheet program.

        json JSON file format. It can be used with -j or -J to specify which protocols to include or with -x option to include raw hex-encoded packet data. Example of usage:

        tshark -T json -r file.pcap
        tshark -T json -j "http tcp ip" -x -r file.pcap
        jsonraw JSON file format including only raw hex-encoded packet data. It can be used with -j or -J to specify which protocols to include. Example of usage:

        tshark -T jsonraw -r file.pcap
        tshark -T jsonraw -j "http tcp ip" -x -r file.pcap
        pdml Packet Details Markup Language, an XML-based format for the details of a decoded packet. This information is equivalent to the packet details printed with the -V option. Using the --color option will add color attributes to pdml output. These attributes are nonstandard.

        ps PostScript for a human-readable one-line summary of each of the packets, or a multi-line view of the details of each of the packets, depending on whether the -V option was specified.

        psml Packet Summary Markup Language, an XML-based format for the summary information of a decoded packet. This information is equivalent to the information shown in the one-line summary printed by default. Using the --color option will add color attributes to pdml output. These attributes are nonstandard.

        tabs Similar to the default text report except the human-readable one-line summary of each packet will include an ASCII horizontal tab (0x09) character as a delimiter between each column.

        text Text of a human-readable one-line summary of each of the packets, or a multi-line view of the details of each of the packets, depending on whether the -V option was specified. This is the default.

-Y|--display-filter <displaY filter>
        Cause the specified filter (which uses the syntax of read/display filters, rather than that of capture filters) to be applied before printing a decoded form of packets or writing packets to a file. Packets matching the filter are printed or written to file; packets that the matching packets depend upon (e.g., fragments), are not printed but are written to file; packets not matching the filter nor depended upon are discarded rather than being printed or written.

        Use this instead of -R for filtering using single-pass analysis. If doing two-pass analysis (see -2) then only packets matching the read filter (if there is one) will be checked against this filter.
```

So we can found the fieds to print with:

```bash
$ tshark -r level02.pcap -T json | less
```

```bash
# see all data with ip source
$ tshark -r level02.pcap -T fields -e ip.src -e data
$ tshark -r level02.pcap -T fields -e ip.src -e data -Y "ip.src == 59.233.235.218"
```

```bash
$ tshark -r level02.pcap -T fields -e data | tr -d '\n' | python3 readit.py
data: fffd25fffc25fffb26fffd18fffd20fffd23fffd27fffd24fffe26fffb18fffb20fffb23fffb27fffc24fffa2001fff0fffa2301fff0fffa2701fff0fffa1801fff0fffa200033383430302c3338343030fff0fffa2300536f646143616e3a30fff0fffa270000444953504c415901536f646143616e3a30fff0fffa1800787465726dfff0fffb03fffd01fffd22fffd1ffffb05fffd21fffd03fffc01fffb22fffa220301000003620304020f05000007621c08020409421a0a027f0b02150f02111002131102ffff1202fffffff0fffb1ffffa1f00b10031fff0fffd05fffb21fffa220103fff0fffa220107fff0fffa2103fff0fffb01fffd00fffe22fffd01fffb00fffc22fffa220303e20304820f07e21c08820409c21a0a827f0b82150f82111082131182ffff1282fffffff00d0a4c696e757820322e362e33382d382d67656e657269632d70616520283a3a666666663a31302e312e312e322920287074732f3130290d0a0a010077777762756773206c6f67696e3a206c006c6500657600766500656c006c5800580d01000d0a50617373776f72643a2066745f77616e64727f7f7f4e4452656c7f4c304c0d000d0a01000d0a4c6f67696e20696e636f72726563740d0a77777762756773206c6f67696e3a20
unhexify: b'\xff\xfd%\xff\xfc%\xff\xfb&\xff\xfd\x18\xff\xfd \xff\xfd#\xff\xfd\'\xff\xfd$\xff\xfe&\xff\xfb\x18\xff\xfb \xff\xfb#\xff\xfb\'\xff\xfc$\xff\xfa \x01\xff\xf0\xff\xfa#\x01\xff\xf0\xff\xfa\'\x01\xff\xf0\xff\xfa\x18\x01\xff\xf0\xff\xfa \x0038400,38400\xff\xf0\xff\xfa#\x00SodaCan:0\xff\xf0\xff\xfa\'\x00\x00DISPLAY\x01SodaCan:0\xff\xf0\xff\xfa\x18\x00xterm\xff\xf0\xff\xfb\x03\xff\xfd\x01\xff\xfd"\xff\xfd\x1f\xff\xfb\x05\xff\xfd!\xff\xfd\x03\xff\xfc\x01\xff\xfb"\xff\xfa"\x03\x01\x00\x00\x03b\x03\x04\x02\x0f\x05\x00\x00\x07b\x1c\x08\x02\x04\tB\x1a\n\x02\x7f\x0b\x02\x15\x0f\x02\x11\x10\x02\x13\x11\x02\xff\xff\x12\x02\xff\xff\xff\xf0\xff\xfb\x1f\xff\xfa\x1f\x00\xb1\x001\xff\xf0\xff\xfd\x05\xff\xfb!\xff\xfa"\x01\x03\xff\xf0\xff\xfa"\x01\x07\xff\xf0\xff\xfa!\x03\xff\xf0\xff\xfb\x01\xff\xfd\x00\xff\xfe"\xff\xfd\x01\xff\xfb\x00\xff\xfc"\xff\xfa"\x03\x03\xe2\x03\x04\x82\x0f\x07\xe2\x1c\x08\x82\x04\t\xc2\x1a\n\x82\x7f\x0b\x82\x15\x0f\x82\x11\x10\x82\x13\x11\x82\xff\xff\x12\x82\xff\xff\xff\xf0\r\nLinux 2.6.38-8-generic-pae (::ffff:10.1.1.2) (pts/10)\r\n\n\x01\x00wwwbugs login: l\x00le\x00ev\x00ve\x00el\x00lX\x00X\r\x01\x00\r\nPassword: ft_wandr\x7f\x7f\x7fNDRel\x7fL0L\r\x00\r\n\x01\x00\r\nLogin incorrect\r\nwwwbugs login: '
```

So we found the folowing password:
`ft_wandr\x7f\x7f\x7fNDRel\x7fL0L\r`\
with `\x7f` for <kbd>⌫ Delete</kbd> and `\r`for <kbd>enter</kbd>\
so the password is : `ft_waNDReL0L`

## Wireshark GUI 
Or with the application Wireshark on graphical mode:

```bash
$ brew cask install wireshark
```

Open Wireshark, and the file `level02.pcap` in the app, an search on the Data in each lines.\
On line `43`, we found "Password" asked by `59.233.235.223` and just after the password type by `59.233.235.218` the user char for char with <kbd>⌫ Delete</kbd> (`7f`) and <kbd>enter</kbd> (`0d`) for the lines `45` to `85`


level02@SnowCrash:~$ su flag02
Password: ft_waNDReL0L
Don't forget to launch getflag !
flag02@SnowCrash:~$ getflag
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq

****************************************

__Documentations__ :
* https://fileinfo.com/extension/pcap
* https://stackoverflow.com/questions/26242156/install-wireshark-on-macos-x-via-brew
* https://www.wireshark.org/docs/man-pages/tshark.html
* https://osqa-ask.wireshark.org/questions/15374/dump-raw-packet-data-field-only
* https://osqa-ask.wireshark.org/questions/45418/specific-ip-address-display-filter-using-tshark
