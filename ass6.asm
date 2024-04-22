section .data
    msg db "S-block before transfer: ",10,10
    lmsg equ $-msg

    msg1 db "D-block before transfer: ",10,10
    lmsg1 equ $-msg1

    smsg db "S-block after transfer: ",10,10
    lsmsg equ $-smsg

    smsg1 db "D-block after transfer: ",10,10
    lsmsg1 equ $-smsg1

    space db "",10
    
    sblock db 10h,20h,30h,40h,50h
    dblock db 0h,0h,0h,0h,0h
        
section .bss
    char_ans resb 2
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
    print msg,lmsg
    mov rsi,sblock
    call displayBlock 

    print msg1,lmsg1
    mov rsi,dblock
    call displayBlock

    call blockTransfer

    print smsg,lsmsg
    mov rsi,sblock
    call displayBlock

    print smsg1,lsmsg1
    mov rsi,dblock
    call displayBlock

exit

blockTransfer:
    mov rsi,sblock
    mov rdi,dblock
    mov rcx,5

    nextBlock:
        mov al,[rsi]
        mov [rdi],al
        inc rsi
        inc rdi 
        dec rcx 
        jnz nextBlock
        ret 

displayBlock:
    mov rbp,5

next:   
    mov rax,[rsi]
    push rsi 
    call display
    print space,1
    pop rsi 
    inc rsi 
    dec rbp 
    jnz next 
ret

display:
    mov rbx,16
    mov rcx,5
    mov rsi,char_ans+1

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
    print char_ans,2
ret