;The program concatenates two byte arrays into a third array and prints the resulting values.
%include "utils/printf32.asm"
section .data
    array1 db 1, 2, 3, 4, 5        ; First array of bytes
    array1_len equ 5               ; Length of the first array

    array2 db 6, 7, 8, 9, 100       ; Second array of bytes
    array2_len equ 5               ; Length of the second array

    format db "Result: %d %d %d %d %d %d %d %d %d %d\n", 0  ; Format string for printf

section .bss
    ; Allocate space for the concatenated array
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
    mov [edi], al 
    ;mov [edi], [esi]         ; Store byte into the result array
    push dword [edi]
    inc esi                ; Increment source pointer
    inc edi                ; Increment destination pointer
    loop copy_array1       ; Loop until ECX is zero

    ; Copy the second array to the result array
    mov esi, array2        ; Load address of the second array into ESI
    mov ecx, array2_len    ; Load the length of the second array into ECX
copy_array2:
    mov al, [esi]          ; Load byte from the second array into AL
    mov [edi], al          ; Store byte into the result array
   push dword [edi]
    inc esi                ; Increment source pointer
    inc edi                ; Increment destination pointer
    loop copy_array2       ; Loop until ECX is zero


;mov ecx, 10
;mov edx, 0
    ;print_array:
    ;cmp edx, ecx

    ; Print the result array

    push format
    call printf
    add esp, 40 + 4               ; Clean up the stack (10 integers + 1 format string)

    ; Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main
