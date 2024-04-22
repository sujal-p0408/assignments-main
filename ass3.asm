section .data
    msg db "Positive/Negative Numbers ",10,10
    msgl equ $-msg
    pmsg db "Positive numbers: ",10,10
    pmsgl equ $-pmsg 
    nmsg db 10,"Negative numbers: ",10,10
    nmsgl equ $-nmsg 

    arr64 dq -10h,-20h,-40h,49h,29h
    n equ 5
        
section .bss
    p_count resq 1
    n_count resq 1
    
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
    print msg,msgl
    mov rsi,arr64
    mov rcx,n 

    mov rbx,0
    mov rdx,0

    next_byte:
        mov rax,[rsi]
        rol rax,1 
        jc negative
    positive:
        inc rbx 
        jmp next 

    negative:
        inc rdx 

    next:
        add rsi,8
        dec rcx 
        jnz next_byte 

    mov [p_count],rbx 
    mov [n_count],rdx 

    print pmsg,pmsgl 
    mov rax,[p_count]
    call display 

    print nmsg,nmsgl
    mov rax,[n_count]
    call display
    
exit

display:
    mov rbx,10
    mov rcx,2
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