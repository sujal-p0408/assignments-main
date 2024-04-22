section .data
    nline db 10,10
    nlen equ $-nline
    msg db "Enter the BCD number: ",10,10
    msgl equ $-msg
    smsg db "The Hex Number is: ",10,10
    smsgl equ $-smsg

section .bss 
    buf resb 6
    char_ans resb 4
    ans resw 1
    
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
    call bcd_hex
exit
bcd_hex:
    print msg,msgl
    read buf,6
    mov rsi,buf 
    xor ax,ax
    mov rbp,5 
    mov rbx,10

next:
    xor cx,cx 
    mul bx 
    mov cl,[rsi]
    sub cl,30h
    add ax,cx

    inc rsi 
    dec rbp 
    jnz next 

    mov [ans],ax 
    print smsg,smsgl
    mov ax,[ans]
    call display
ret
display:
    mov rbx,16 
    mov rcx,4
    mov rsi,char_ans+3

cnt:
    mov rdx,0
    div rbx 

    cmp dl,09h
    jbe add30
    add dl,07h

add30:
    add dl,30h
    mov [rsi],dl 
    dec rsi 
    dec rcx 
    jnz cnt 
    print char_ans,4
ret
