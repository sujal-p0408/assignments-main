section .text
    hmg db 10,"Enter the hex num: "
    hmgl equ $-hmg
    ehmg db 10,"The bcd num: "
    ehmgl equ $-ehmg
    erhmg db 10,"Enter correct num only "
    erhmgl equ $-erhmg

section .bss
    charans resb 1
    buf resb 5

%macro print 2
    mov rax,1
    mov rdi,1
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro read 2
    mov rax,0
    mov rdi,0
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro exit 0
    mov rax,60
    mov rdi,0
    syscall
%endmacro

section .text
    global _start

_start:
    call hexbcd
    exit

hexbcd:
    print hmg,hmgl
    call accept
    mov ax,bx
    mov bx,10
    xor bp,bp
back:
    xor dx,dx
    div bx
    push dx
    inc bp
    cmp ax,0
    jne back
    print ehmg,ehmgl
back1:
    pop dx
    add dl,30h
    mov [charans],dl
    print charans,1
    dec bp
    jnz back1
    ret

accept:
    read buf,5
    mov rcx,4
    mov rsi,buf
    xor bx,bx
nextbyte:
    shl bx,4
    mov al,[rsi]
    cmp al,'0'
    jb error
    cmp al,'9'
    jbe sub30
    cmp al,'A'
    jb error
    cmp al,'F'
    jbe sub37
    cmp al,'a'
    jb error
    cmp al,'f'
    jbe sub57
error:
    print erhmg,erhmgl
    exit
    sub57:  
        sub al,20h
    sub37:  
        sub al,07h
    sub30:  
        sub al,30h
        add bx,ax
        inc rsi
        dec rcx
        jnz nextbyte
        ret
