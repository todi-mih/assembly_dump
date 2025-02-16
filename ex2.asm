%include "utils/printf32.asm"
;first 20 letters of the alphabet
section .data
    format db "%s\n", 0  ; Format string for printf

section .text
    extern printf
    global main

main:
    push ebp
    mov ebp, esp

    ; Allocate 21 bytes on the stack (20 for characters + 1 for null terminator)
    sub esp, 21

    ; Calculate the end address of the allocated space
    lea ecx, [esp + 20]  ; ECX points to the end of the allocated space

    ; Initialize the vector incrementally starting from 'A'
    mov ebx, esp       ; Set EBX to point to the start of the allocated space
    mov al, 'A'        ; Start with the character 'A'

init_loop:
    mov [ebx], al      ; Store the current character in the vector
    inc al             ; Increment the character (A -> B -> C ...)
    inc ebx            ; Move to the next byte in the vector
    cmp ebx, ecx       ; Compare EBX with the end address
    jne init_loop      ; Loop until EBX reaches ECX

    ; Null-terminate the string
    mov byte [ebx], 0  ; Store the null terminator at the end

    ; Prepare to call printf
    mov edx, esp       ; Set EDX to point to the start of the vector
    PRINTF32 `%s\n`, edx

    ; Restore the stack pointer
    add esp, 21        ; Remove the allocated vector

    ; Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
