;program to add 2 vectors in 1
%include "utils/printf32.asm"
section .data
    array1 db 1, 2, 3, 4, 5        ; First array of bytes
    array1_len equ 5               ; Length of the first array

    array2 db 6, 7, 8, 9, 10       ; Second array of bytes
    array2_len equ 5               ; Length of the second array

    format db "Result: %d %d %d %d %d %d %d %d %d %d\n", 0  ; Format string for printf

section .bss
    array3 resb array1_len + array2_len  ; Reserve space for 10 bytes

section .text
    extern printf
    global main

main:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    ; Pointers to the arrays
    mov esi, array1        ; Load address of the first array into ESI
    mov edi, array3        ; Load address of the result array into EDI

    ; Copy the first array to the result array
    mov ecx, array1_len    ; Load the length of the first array into ECX
copy_array1:
    mov al, [esi]          ; Load byte from the first array into AL
    mov [edi], al          ; Store byte into the result array
    inc esi                ; Increment source pointer
    inc edi                ; Increment destination pointer
    loop copy_array1       ; Loop until ECX is zero

    ; Copy the second array to the result array
    mov esi, array2        ; Load address of the second array into ESI
    mov ecx, array2_len    ; Load the length of the second array into ECX
copy_array2:
    mov al, [esi]          ; Load byte from the second array into AL
    mov [edi], al          ; Store byte into the result array
    inc esi                ; Increment source pointer
    inc edi                ; Increment destination pointer
    loop copy_array2       ; Loop until ECX is zero
mov ecx, 20
mov edx, 0
print:

    cmp edx, ecx
    je done
    movzx eax, byte [array3 + edx]
    PRINTF32 `%d\n`, eax
    inc edx
  
    loop  print



    ; Clean up and exit
    done:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main
