;find sum of elemts between 2 positions
%include "utils/printf32.asm"
section .data
    array1 db 1, 2, 3, 4, 5 ,6        ; First array of bytes
    array1_len equ 1               ; Length of the first array
    array2 db 7 , 8, 9 , 10, 11
    array2_len equ 4
    format db "Result: %d %d %d %d %d %d %d %d %d %d\n", 0  ; Format string for printf


section .text
    extern printf
    global main

count:
    push ebp
    mov ebp, esp
    
    mov ecx, [ebp + 16]
    mov edx, [ebp + 12] 
    xor ebx, ebx
    mov esi, [ebp + 8]  
       PRINTF32 `%d\n` , edx
add edx, 1
    looop:

    cmp ecx, edx
    je done
     
    movzx eax, byte [esi + ecx] 
    add ebx, eax
    ;PRINTF32 `%d\n` , ebx
    ;add esi, 1
    add ecx, 1

    jmp looop
    


    
main:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    push array1_len
    push array2_len
    push array1
    call count
    
    done:
    PRINTF32 `%d\n`, ebx
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main
