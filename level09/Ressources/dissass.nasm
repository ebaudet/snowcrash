Dump of assembler code for function main:
   0x080487ce <+0>:     push   ebp                             ; backup stack frame base pointer RBP
   0x080487cf <+1>:     mov    ebp,esp                         ; stack end pointer ESP
   0x080487d1 <+3>:     push   edi                             ; push 1 arg EDI
   0x080487d2 <+4>:     push   ebx                             ; keep EBX on stack
   0x080487d3 <+5>:     and    esp,0xfffffff0                  ; allign stack
   0x080487d6 <+8>:     sub    esp,0x130                       ; substract 304
   0x080487dc <+14>:    mov    eax,DWORD PTR [ebp+0xc]         ;
   0x080487df <+17>:    mov    DWORD PTR [esp+0x1c],eax        ;
   0x080487e3 <+21>:    mov    eax,gs:0x14
   0x080487e9 <+27>:    mov    DWORD PTR [esp+0x12c],eax
   0x080487f0 <+34>:    xor    eax,eax                         ; eax = 0
   0x080487f2 <+36>:    mov    DWORD PTR [esp+0x24],0x0        ; data = 0
   0x080487fa <+44>:    mov    DWORD PTR [esp+0x20],0xffffffff ; addr =  0xffffffff
   0x08048802 <+52>:    mov    DWORD PTR [esp+0xc],0x0
   0x0804880a <+60>:    mov    DWORD PTR [esp+0x8],0x1         ; pid = 1 : PT_READ_I
   0x08048812 <+68>:    mov    DWORD PTR [esp+0x4],0x0
   0x0804881a <+76>:    mov    DWORD PTR [esp],0x0             ; request = 0
   0x08048821 <+83>:    call   0x80484e0 <ptrace@plt>          ; int ptrace(int request EDI, pid_t(signed int) pid ESI, caddr_t(char *) addr EDX, int data E10|ECX);
   0x08048826 <+88>:    test   eax,eax                         ; if EAX == 0 (return ptrace)
   0x08048828 <+90>:    jns    0x8048840 <main+114>            ; if EAX >= 0 jump <main+114>
   0x0804882a <+92>:    mov    DWORD PTR [esp],0x8048b70       ; s = 0x8048b70"You should not reverse this"
   0x08048831 <+99>:    call   0x8048480 <puts@plt>            ; int fputs(const char *restrict s EDI, FILE *restrict stream ESI);
   0x08048836 <+104>:   mov    eax,0x1                         ; return 1
   0x0804883b <+109>:   jmp    0x8048a77 <main+681>            ; goto end.
   0x08048840 <+114>:   mov    DWORD PTR [esp],0x8048b8c       ; name = 0x8048b8c"LD_PRELOAD"
   0x08048847 <+121>:   call   0x8048470 <getenv@plt>          ; char *getenv(const char *name);
   0x0804884c <+126>:   test   eax,eax                         ; if EAX == 0
   0x0804884e <+128>:   je     0x8048882 <main+180>            ; goto <main+180>
   0x08048850 <+130>:   mov    eax,ds:0x804a040
   0x08048855 <+135>:   mov    edx,eax
   0x08048857 <+137>:   mov    eax,0x8048b98                   ;
   0x0804885c <+142>:   mov    DWORD PTR [esp+0xc],edx         ; stream EDX
   0x08048860 <+146>:   mov    DWORD PTR [esp+0x8],0x25        ; nitems = 37
   0x08048868 <+154>:   mov    DWORD PTR [esp+0x4],0x1         ; size = 1
   0x08048870 <+162>:   mov    DWORD PTR [esp],eax             ; ptr = EAX 0x8048b98"Injection Linked lib detected exit..\n"
   0x08048873 <+165>:   call   0x8048460 <fwrite@plt>          ; size_t fwrite(const void *restrict ptr, size_t size, size_t nitems, FILE *restrict stream);
   0x08048878 <+170>:   mov    eax,0x1                         ; return 1
   0x0804887d <+175>:   jmp    0x8048a77 <main+681>            ; goto end.
   0x08048882 <+180>:   mov    DWORD PTR [esp+0x4],0x0         ; oflag = 0 (O_RDONLY)
   0x0804888a <+188>:   mov    DWORD PTR [esp],0x8048bbe       ; path = 0x8048bbe"/etc/ld.so.preload"
   0x08048891 <+195>:   call   0x80484a0 <open@plt>            ; int open(const char *path, int oflag, ...);
   0x08048896 <+200>:   test   eax,eax                         ; test EAX == 0
   0x08048898 <+202>:   jle    0x80488cc <main+254>            ; if <= 0 jump <main+254>
   0x0804889a <+204>:   mov    eax,ds:0x804a040                ; ? woiejrowejr
   0x0804889f <+209>:   mov    edx,eax
   0x080488a1 <+211>:   mov    eax,0x8048b98
   0x080488a6 <+216>:   mov    DWORD PTR [esp+0xc],edx         ; ds:0x804a040 -> 0x8048c68"LD_PRELOAD detected through memory maps exit"
   0x080488aa <+220>:   mov    DWORD PTR [esp+0x8],0x25        ; nitems = 0x25 = 37
   0x080488b2 <+228>:   mov    DWORD PTR [esp+0x4],0x1         ; size = 1
   0x080488ba <+236>:   mov    DWORD PTR [esp],eax             ; ptr = EAX 0x8048b98"Injection Linked lib detected exit..\n"
   0x080488bd <+239>:   call   0x8048460 <fwrite@plt>          ; size_t fwrite(const void *restrict ptr, size_t size, size_t nitems, FILE *restrict stream);
   0x080488c2 <+244>:   mov    eax,0x1
   0x080488c7 <+249>:   jmp    0x8048a77 <main+681>            ; goto end.
   0x080488cc <+254>:   mov    DWORD PTR [esp+0x4],0x0         ; p2 = 0
   0x080488d4 <+262>:   mov    DWORD PTR [esp],0x8048bd1       ; p1 = /proc/self/maps
   0x080488db <+269>:   call   0x80485a4 <syscall_open>        ; syscall_open(char *p1, int p2)
   0x080488e0 <+274>:   mov    DWORD PTR [esp+0x28],eax
   0x080488e4 <+278>:   cmp    DWORD PTR [esp+0x28],0xffffffff
   0x080488e9 <+283>:   jne    0x8048a50 <main+642>            ; if ((return of syscall_open) != 0xffffffff) goto  <main+642>
   0x080488ef <+289>:   mov    eax,ds:0x804a040                ;
   0x080488f4 <+294>:   mov    edx,eax
   0x080488f6 <+296>:   mov    eax,0x8048be4
   0x080488fb <+301>:   mov    DWORD PTR [esp+0xc],edx         ; stream..
   0x080488ff <+305>:   mov    DWORD PTR [esp+0x8],0x46        ; nitems = 0x46 = 70
   0x08048907 <+313>:   mov    DWORD PTR [esp+0x4],0x1         ; size = 1
   0x0804890f <+321>:   mov    DWORD PTR [esp],eax             ; ptr = 0x8048be4"/proc/self/maps is unaccessible, probably a LD_PRELOAD attempt exit"
   0x08048912 <+324>:   call   0x8048460 <fwrite@plt>          ; size_t fwrite(const void *restrict ptr, size_t size, size_t nitems, FILE *restrict stream);
   0x08048917 <+329>:   mov    eax,0x1                         ; return 1
   0x0804891c <+334>:   jmp    0x8048a77 <main+681>            ; goto end.
   0x08048921 <+339>:   mov    DWORD PTR [esp+0x4],0x8048c2b
   0x08048929 <+347>:   lea    eax,[esp+0x2c]
   0x0804892d <+351>:   mov    DWORD PTR [esp],eax
   0x08048930 <+354>:   call   0x80486cb <isLib>
   0x08048935 <+359>:   test   eax,eax
   0x08048937 <+361>:   je     0x8048946 <main+376>
   0x08048939 <+363>:   mov    DWORD PTR [esp+0x24],0x1
   0x08048941 <+371>:   jmp    0x8048a51 <main+643>
   0x08048946 <+376>:   cmp    DWORD PTR [esp+0x24],0x0
   0x0804894b <+381>:   je     0x8048a51 <main+643>
   0x08048951 <+387>:   mov    DWORD PTR [esp+0x4],0x8048c30
   0x08048959 <+395>:   lea    eax,[esp+0x2c]
   0x0804895d <+399>:   mov    DWORD PTR [esp],eax
   0x08048960 <+402>:   call   0x80486cb <isLib>
   0x08048965 <+407>:   test   eax,eax
   0x08048967 <+409>:   je     0x8048a0e <main+576>
   0x0804896d <+415>:   cmp    DWORD PTR [ebp+0x8],0x2
   0x08048971 <+419>:   jne    0x80489e4 <main+534>
   0x08048973 <+421>:   jmp    0x8048996 <main+456>
   0x08048975 <+423>:   mov    eax,DWORD PTR [esp+0x1c]
   0x08048979 <+427>:   add    eax,0x4
   0x0804897c <+430>:   mov    edx,DWORD PTR [eax]
   0x0804897e <+432>:   mov    eax,DWORD PTR [esp+0x20]
   0x08048982 <+436>:   add    eax,edx
   0x08048984 <+438>:   movzx  eax,BYTE PTR [eax]
   0x08048987 <+441>:   movsx  eax,al
   0x0804898a <+444>:   add    eax,DWORD PTR [esp+0x20]
   0x0804898e <+448>:   mov    DWORD PTR [esp],eax
   0x08048991 <+451>:   call   0x80484c0 <putchar@plt>
   0x08048996 <+456>:   add    DWORD PTR [esp+0x20],0x1
   0x0804899b <+461>:   mov    ebx,DWORD PTR [esp+0x20]
   0x0804899f <+465>:   mov    eax,DWORD PTR [esp+0x1c]
   0x080489a3 <+469>:   add    eax,0x4
   0x080489a6 <+472>:   mov    eax,DWORD PTR [eax]
   0x080489a8 <+474>:   mov    DWORD PTR [esp+0x18],0xffffffff
   0x080489b0 <+482>:   mov    edx,eax
   0x080489b2 <+484>:   mov    eax,0x0
   0x080489b7 <+489>:   mov    ecx,DWORD PTR [esp+0x18]
   0x080489bb <+493>:   mov    edi,edx
   0x080489bd <+495>:   repnz scas al,BYTE PTR es:[edi]
   0x080489bf <+497>:   mov    eax,ecx
   0x080489c1 <+499>:   not    eax
   0x080489c3 <+501>:   sub    eax,0x1
   0x080489c6 <+504>:   cmp    ebx,eax
   0x080489c8 <+506>:   jb     0x8048975 <main+423>
   0x080489ca <+508>:   mov    eax,ds:0x804a060
   0x080489cf <+513>:   mov    DWORD PTR [esp+0x4],eax
   0x080489d3 <+517>:   mov    DWORD PTR [esp],0xa
   0x080489da <+524>:   call   0x80484d0 <fputc@plt>
   0x080489df <+529>:   jmp    0x8048a75 <main+679>
   0x080489e4 <+534>:   mov    eax,ds:0x804a040
   0x080489e9 <+539>:   mov    edx,eax
   0x080489eb <+541>:   mov    eax,0x8048c34
   0x080489f0 <+546>:   mov    DWORD PTR [esp+0xc],edx
   0x080489f4 <+550>:   mov    DWORD PTR [esp+0x8],0x22
   0x080489fc <+558>:   mov    DWORD PTR [esp+0x4],0x1
   0x08048a04 <+566>:   mov    DWORD PTR [esp],eax
   0x08048a07 <+569>:   call   0x8048460 <fwrite@plt>
   0x08048a0c <+574>:   jmp    0x8048a75 <main+679>
   0x08048a0e <+576>:   mov    DWORD PTR [esp+0x4],0x8048c57
   0x08048a16 <+584>:   lea    eax,[esp+0x2c]
   0x08048a1a <+588>:   mov    DWORD PTR [esp],eax
   0x08048a1d <+591>:   call   0x8048646 <afterSubstr>
   0x08048a22 <+596>:   test   eax,eax
   0x08048a24 <+598>:   jne    0x8048a51 <main+643>
   0x08048a26 <+600>:   mov    eax,ds:0x804a040
   0x08048a2b <+605>:   mov    edx,eax
   0x08048a2d <+607>:   mov    eax,0x8048c68
   0x08048a32 <+612>:   mov    DWORD PTR [esp+0xc],edx
   0x08048a36 <+616>:   mov    DWORD PTR [esp+0x8],0x30
   0x08048a3e <+624>:   mov    DWORD PTR [esp+0x4],0x1
   0x08048a46 <+632>:   mov    DWORD PTR [esp],eax
   0x08048a49 <+635>:   call   0x8048460 <fwrite@plt>
   0x08048a4e <+640>:   jmp    0x8048a75 <main+679>
   0x08048a50 <+642>:   nop
   0x08048a51 <+643>:   mov    eax,DWORD PTR [esp+0x28]
   0x08048a55 <+647>:   mov    DWORD PTR [esp+0x8],eax
   0x08048a59 <+651>:   mov    DWORD PTR [esp+0x4],0x100
   0x08048a61 <+659>:   lea    eax,[esp+0x2c]
   0x08048a65 <+663>:   mov    DWORD PTR [esp],eax
   0x08048a68 <+666>:   call   0x80485d4 <syscall_gets>
   0x08048a6d <+671>:   test   eax,eax
   0x08048a6f <+673>:   jne    0x8048921 <main+339>
   0x08048a75 <+679>:   jmp    0x8048a77 <main+681>
   0x08048a77 <+681>:   mov    edx,DWORD PTR [esp+0x12c]
   0x08048a7e <+688>:   xor    edx,DWORD PTR gs:0x14
   0x08048a85 <+695>:   je     0x8048a8c <main+702>
   0x08048a87 <+697>:   call   0x8048450 <__stack_chk_fail@plt>
   0x08048a8c <+702>:   lea    esp,[ebp-0x8]
   0x08048a8f <+705>:   pop    ebx
   0x08048a90 <+706>:   pop    edi
   0x08048a91 <+707>:   pop    ebp
   0x08048a92 <+708>:   ret
End of assembler dump.



Dump of assembler code for function afterSubstr:
   0x08048646 <+0>:     push   ebp
   0x08048647 <+1>:     mov    ebp,esp
   0x08048649 <+3>:     sub    esp,0x10
   0x0804864c <+6>:     mov    DWORD PTR [ebp-0x8],0x0
   0x08048653 <+13>:    mov    eax,DWORD PTR [ebp+0x8]
   0x08048656 <+16>:    mov    DWORD PTR [ebp-0x4],eax
   0x08048659 <+19>:    jmp    0x80486a9 <afterSubstr+99>
   0x0804865b <+21>:    mov    DWORD PTR [ebp-0x8],0x1
   0x08048662 <+28>:    mov    DWORD PTR [ebp-0xc],0x0
   0x08048669 <+35>:    jmp    0x804868c <afterSubstr+70>
   0x0804866b <+37>:    mov    eax,DWORD PTR [ebp-0xc]
   0x0804866e <+40>:    add    eax,DWORD PTR [ebp+0xc]
   0x08048671 <+43>:    movzx  edx,BYTE PTR [eax]
   0x08048674 <+46>:    mov    eax,DWORD PTR [ebp-0xc]
   0x08048677 <+49>:    add    eax,DWORD PTR [ebp-0x4]
   0x0804867a <+52>:    movzx  eax,BYTE PTR [eax]
   0x0804867d <+55>:    cmp    dl,al
   0x0804867f <+57>:    je     0x8048688 <afterSubstr+66>
   0x08048681 <+59>:    mov    DWORD PTR [ebp-0x8],0x0
   0x08048688 <+66>:    add    DWORD PTR [ebp-0xc],0x1
   0x0804868c <+70>:    cmp    DWORD PTR [ebp-0x8],0x1
   0x08048690 <+74>:    jne    0x804869f <afterSubstr+89>
   0x08048692 <+76>:    mov    eax,DWORD PTR [ebp-0xc]
   0x08048695 <+79>:    add    eax,DWORD PTR [ebp+0xc]
   0x08048698 <+82>:    movzx  eax,BYTE PTR [eax]
   0x0804869b <+85>:    test   al,al
   0x0804869d <+87>:    jne    0x804866b <afterSubstr+37>
   0x0804869f <+89>:    cmp    DWORD PTR [ebp-0x8],0x1
   0x080486a3 <+93>:    je     0x80486b5 <afterSubstr+111>
   0x080486a5 <+95>:    add    DWORD PTR [ebp-0x4],0x1
   0x080486a9 <+99>:    mov    eax,DWORD PTR [ebp-0x4]
   0x080486ac <+102>:   movzx  eax,BYTE PTR [eax]
   0x080486af <+105>:   test   al,al
   0x080486b1 <+107>:   jne    0x804865b <afterSubstr+21>
   0x080486b3 <+109>:   jmp    0x80486b6 <afterSubstr+112>
   0x080486b5 <+111>:   nop
   0x080486b6 <+112>:   cmp    DWORD PTR [ebp-0x8],0x0
   0x080486ba <+116>:   jne    0x80486c3 <afterSubstr+125>
   0x080486bc <+118>:   mov    eax,0x0
   0x080486c1 <+123>:   jmp    0x80486c9 <afterSubstr+131>
   0x080486c3 <+125>:   mov    eax,DWORD PTR [ebp-0xc]
   0x080486c6 <+128>:   add    eax,DWORD PTR [ebp-0x4]
   0x080486c9 <+131>:   leave
   0x080486ca <+132>:   ret
End of assembler dump.



Dump of assembler code for function isLib:
   0x080486cb <+0>:     push   ebp
   0x080486cc <+1>:     mov    ebp,esp
   0x080486ce <+3>:     sub    esp,0x18
   0x080486d1 <+6>:     mov    eax,DWORD PTR [ebp+0xc]
   0x080486d4 <+9>:     mov    DWORD PTR [esp+0x4],eax
   0x080486d8 <+13>:    mov    eax,DWORD PTR [ebp+0x8]
   0x080486db <+16>:    mov    DWORD PTR [esp],eax
   0x080486de <+19>:    call   0x8048646 <afterSubstr>
   0x080486e3 <+24>:    mov    DWORD PTR [ebp-0x4],eax
   0x080486e6 <+27>:    cmp    DWORD PTR [ebp-0x4],0x0
   0x080486ea <+31>:    jne    0x80486f6 <isLib+43>
   0x080486ec <+33>:    mov    eax,0x0
   0x080486f1 <+38>:    jmp    0x80487cc <isLib+257>
   0x080486f6 <+43>:    mov    eax,DWORD PTR [ebp-0x4]
   0x080486f9 <+46>:    movzx  eax,BYTE PTR [eax]
   0x080486fc <+49>:    cmp    al,0x2d
   0x080486fe <+51>:    je     0x804870a <isLib+63>
   0x08048700 <+53>:    mov    eax,0x0
   0x08048705 <+58>:    jmp    0x80487cc <isLib+257>
   0x0804870a <+63>:    mov    DWORD PTR [ebp-0x8],0x0
   0x08048711 <+70>:    add    DWORD PTR [ebp-0x4],0x1
   0x08048715 <+74>:    jmp    0x8048722 <isLib+87>
   0x08048717 <+76>:    mov    DWORD PTR [ebp-0x8],0x1
   0x0804871e <+83>:    add    DWORD PTR [ebp-0x4],0x1
   0x08048722 <+87>:    mov    eax,DWORD PTR [ebp-0x4]
   0x08048725 <+90>:    movzx  eax,BYTE PTR [eax]
   0x08048728 <+93>:    cmp    al,0x2f
   0x0804872a <+95>:    jle    0x8048736 <isLib+107>
   0x0804872c <+97>:    mov    eax,DWORD PTR [ebp-0x4]
   0x0804872f <+100>:   movzx  eax,BYTE PTR [eax]
   0x08048732 <+103>:   cmp    al,0x39
   0x08048734 <+105>:   jle    0x8048717 <isLib+76>
   0x08048736 <+107>:   cmp    DWORD PTR [ebp-0x8],0x0
   0x0804873a <+111>:   je     0x8048746 <isLib+123>
   0x0804873c <+113>:   mov    eax,DWORD PTR [ebp-0x4]
   0x0804873f <+116>:   movzx  eax,BYTE PTR [eax]
   0x08048742 <+119>:   cmp    al,0x2e
   0x08048744 <+121>:   je     0x804874d <isLib+130>
   0x08048746 <+123>:   mov    eax,0x0
   0x0804874b <+128>:   jmp    0x80487cc <isLib+257>
   0x0804874d <+130>:   mov    DWORD PTR [ebp-0x8],0x0
   0x08048754 <+137>:   add    DWORD PTR [ebp-0x4],0x1
   0x08048758 <+141>:   jmp    0x8048765 <isLib+154>
   0x0804875a <+143>:   mov    DWORD PTR [ebp-0x8],0x1
   0x08048761 <+150>:   add    DWORD PTR [ebp-0x4],0x1
   0x08048765 <+154>:   mov    eax,DWORD PTR [ebp-0x4]
   0x08048768 <+157>:   movzx  eax,BYTE PTR [eax]
   0x0804876b <+160>:   cmp    al,0x2f
   0x0804876d <+162>:   jle    0x8048779 <isLib+174>
   0x0804876f <+164>:   mov    eax,DWORD PTR [ebp-0x4]
   0x08048772 <+167>:   movzx  eax,BYTE PTR [eax]
   0x08048775 <+170>:   cmp    al,0x39
   0x08048777 <+172>:   jle    0x804875a <isLib+143>
   0x08048779 <+174>:   cmp    DWORD PTR [ebp-0x8],0x0
   0x0804877d <+178>:   jne    0x8048786 <isLib+187>
   0x0804877f <+180>:   mov    eax,0x0
   0x08048784 <+185>:   jmp    0x80487cc <isLib+257>
   0x08048786 <+187>:   mov    DWORD PTR [ebp-0xc],0x0
   0x0804878d <+194>:   jmp    0x80487b5 <isLib+234>
   0x0804878f <+196>:   mov    edx,DWORD PTR ds:0x804a030
   0x08048795 <+202>:   mov    eax,DWORD PTR [ebp-0xc]
   0x08048798 <+205>:   add    eax,edx
   0x0804879a <+207>:   movzx  edx,BYTE PTR [eax]
   0x0804879d <+210>:   mov    eax,DWORD PTR [ebp-0xc]
   0x080487a0 <+213>:   add    eax,DWORD PTR [ebp-0x4]
   0x080487a3 <+216>:   movzx  eax,BYTE PTR [eax]
   0x080487a6 <+219>:   cmp    dl,al
   0x080487a8 <+221>:   je     0x80487b1 <isLib+230>
   0x080487aa <+223>:   mov    eax,0x0
   0x080487af <+228>:   jmp    0x80487cc <isLib+257>
   0x080487b1 <+230>:   add    DWORD PTR [ebp-0xc],0x1
   0x080487b5 <+234>:   mov    edx,DWORD PTR ds:0x804a030
   0x080487bb <+240>:   mov    eax,DWORD PTR [ebp-0xc]
   0x080487be <+243>:   add    eax,edx
   0x080487c0 <+245>:   movzx  eax,BYTE PTR [eax]
   0x080487c3 <+248>:   test   al,al
   0x080487c5 <+250>:   jne    0x804878f <isLib+196>
   0x080487c7 <+252>:   mov    eax,0x1
   0x080487cc <+257>:   leave
   0x080487cd <+258>:   ret
End of assembler dump.


Dump of assembler code for function syscall_open:
   0x080485a4 <+0>:     push   ebp
   0x080485a5 <+1>:     mov    ebp,esp
   0x080485a7 <+3>:     push   esi
   0x080485a8 <+4>:     push   ebx
   0x080485a9 <+5>:     sub    esp,0x10
   0x080485ac <+8>:     mov    DWORD PTR [ebp-0xc],0xffffffff
   0x080485b3 <+15>:    mov    eax,0x5
   0x080485b8 <+20>:    mov    ebx,DWORD PTR [ebp+0x8]
   0x080485bb <+23>:    mov    ecx,DWORD PTR [ebp+0xc]
   0x080485be <+26>:    mov    edx,0x0
   0x080485c3 <+31>:    int    0x80
   0x080485c5 <+33>:    mov    esi,eax
   0x080485c7 <+35>:    mov    DWORD PTR [ebp-0xc],esi
   0x080485ca <+38>:    mov    eax,DWORD PTR [ebp-0xc]
   0x080485cd <+41>:    add    esp,0x10
   0x080485d0 <+44>:    pop    ebx
   0x080485d1 <+45>:    pop    esi
   0x080485d2 <+46>:    pop    ebp
   0x080485d3 <+47>:    ret
End of assembler dump.


Dump of assembler code for function syscall_gets:
   0x080485d4 <+0>:     push   ebp
   0x080485d5 <+1>:     mov    ebp,esp
   0x080485d7 <+3>:     push   esi
   0x080485d8 <+4>:     push   ebx
   0x080485d9 <+5>:     sub    esp,0x10
   0x080485dc <+8>:     mov    DWORD PTR [ebp-0x10],0x0
   0x080485e3 <+15>:    jmp    0x8048623 <syscall_gets+79>
   0x080485e5 <+17>:    mov    eax,DWORD PTR [ebp-0x10]
   0x080485e8 <+20>:    mov    edx,DWORD PTR [ebp+0x8]
   0x080485eb <+23>:    lea    esi,[edx+eax*1]
   0x080485ee <+26>:    mov    eax,0x3
   0x080485f3 <+31>:    mov    ebx,DWORD PTR [ebp+0x10]
   0x080485f6 <+34>:    mov    ecx,esi
   0x080485f8 <+36>:    mov    edx,0x1
   0x080485fd <+41>:    int    0x80
   0x080485ff <+43>:    mov    esi,eax
   0x08048601 <+45>:    mov    DWORD PTR [ebp-0xc],esi
   0x08048604 <+48>:    cmp    DWORD PTR [ebp-0xc],0x1
   0x08048608 <+52>:    jne    0x8048630 <syscall_gets+92>
   0x0804860a <+54>:    mov    eax,DWORD PTR [ebp-0x10]
   0x0804860d <+57>:    mov    edx,DWORD PTR [ebp+0x8]
   0x08048610 <+60>:    add    eax,edx
   0x08048612 <+62>:    movzx  eax,BYTE PTR [eax]
   0x08048615 <+65>:    cmp    al,0xa
   0x08048617 <+67>:    jne    0x804861f <syscall_gets+75>
   0x08048619 <+69>:    add    DWORD PTR [ebp-0x10],0x1
   0x0804861d <+73>:    jmp    0x8048631 <syscall_gets+93>
   0x0804861f <+75>:    add    DWORD PTR [ebp-0x10],0x1
   0x08048623 <+79>:    mov    eax,DWORD PTR [ebp+0xc]
   0x08048626 <+82>:    sub    eax,0x1
   0x08048629 <+85>:    cmp    eax,DWORD PTR [ebp-0x10]
   0x0804862c <+88>:    ja     0x80485e5 <syscall_gets+17>
   0x0804862e <+90>:    jmp    0x8048631 <syscall_gets+93>
   0x08048630 <+92>:    nop
   0x08048631 <+93>:    mov    eax,DWORD PTR [ebp-0x10]
   0x08048634 <+96>:    mov    edx,DWORD PTR [ebp+0x8]
   0x08048637 <+99>:    add    eax,edx
   0x08048639 <+101>:   mov    BYTE PTR [eax],0x0
   0x0804863c <+104>:   mov    eax,DWORD PTR [ebp-0x10]
   0x0804863f <+107>:   add    esp,0x10
   0x08048642 <+110>:   pop    ebx
   0x08048643 <+111>:   pop    esi
   0x08048644 <+112>:   pop    ebp
   0x08048645 <+113>:   ret
End of assembler dump.
