section .data
    msg: db "Sum is: "
    msgLen: equ $ - msg
    newline: db 10

section .bss
    sum: resb 1

section .text
    global start            ; Note: MacOS uses 'start' not '_start'
    
start:
    ; Add two numbers
    mov rax, 5             ; First number
    mov rbx, 3             ; Second number
    add rax, rbx           ; Add them together
    
    ; Convert to ASCII
    add rax, '0'           ; Convert to ASCII
    mov [rel sum], al      ; Store result, using relative addressing
    
    ; Print "Sum is: "
    mov rax, 0x2000004     ; MacOS write syscall
    mov rdi, 1             ; stdout
    lea rsi, [rel msg]     ; Load message address relatively
    mov rdx, msgLen        ; Message length
    syscall
    
    ; Print sum
    mov rax, 0x2000004     ; MacOS write syscall
    mov rdi, 1             ; stdout
    lea rsi, [rel sum]     ; Load sum address relatively
    mov rdx, 1             ; Length is 1 byte
    syscall
    
    ; Print newline
    mov rax, 0x2000004     ; MacOS write syscall
    mov rdi, 1             ; stdout
    lea rsi, [rel newline] ; Load newline address relatively
    mov rdx, 1             ; Length is 1 byte
    syscall
    
    ; Exit program
    mov rax, 0x2000001     ; MacOS exit syscall
    xor rdi, rdi           ; Exit code 0
    syscall