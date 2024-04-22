section .data
    msg db "Hello World!",10
    lmsg equ $-msg
    nmsg db "Hi How are you?",10
    lnmsg equ $-nmsg
section .bss
    ;print
    %macro print 2
        mov rax,1
        mov rdi,1
        mov rsi,%1
        mov rdx,%2
        syscall 
    %endmacro

    ;read
    %macro read 2
        mov rax,0
        mov rdi,0
        mov rsi,%1
        mov rdx,%2
        syscall
     %endmacro

    ;exit
    %macro exit 0
        mov rax,60
        mov rdi,0
        syscall 
    %endmacro

section .text
    global _start

_start:
    print msg,lmsg
    print nmsg,lnmsg
exit
