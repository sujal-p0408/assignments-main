section .data
    msg db "Enter the string: ",10
    lmsg equ $-msg

    smsg db "The length of the string is: ",10
    lsmsg equ $-smsg
    
section .bss
    string resb 50
    string1 equ $-string
    count resb 1
    char_ans resb 2


    ; print
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
    read string,string1
    mov [count],rax 
    print smsg,lsmsg 
    mov rax,[count]
    call display

exit


display: 
    mov rbx,10
    mov rcx,2
    mov rsi, char_ans+1

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
