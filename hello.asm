section .data
    hello db 'haaaaaaaa',10,0
    
section .text
    global _start

_start:
    ; write "Hello, world!" to stdout
    mov eax, 4      ; system call for write
    mov ebx, 1      ; file descriptor for stdout
    mov ecx, hello  ; message to write
    mov edx, 14     ; message length
    int 0x80        ; call kernel
    
    ; exit program
    mov eax, 1      ; system call for exit
    xor ebx, ebx    ; exit status code
    int 0x80        ; call kernel
