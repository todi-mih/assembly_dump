;add elemts of an array
;if you need to do array of words replace dw,use movzx with word,add esi with 2
%include "utils/printf32.asm"
section .data
    array1 db 1, 2, 3, 4, 5 ,6        ; First array of bytes
    array1_len equ 6               ; Length of the first array
    format db "Result: %d %d %d %d %d %d %d %d %d %d\n", 0  ; Format string for printf


section .text
    extern printf
    global main

count:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 12] 
   
    mov esi, [ebp + 8]  
    xor edx, edx
    looop:

    cmp ecx, 0
    je done
     
    movzx eax, byte [esi] 
    add edx, eax
    ;PRINTF32 `%d\n` , edx
    add esi, 1
    sub ecx, 1

    jmp looop
    


    
main:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    push array1_len
    push array1
    call count
    
    done:
    PRINTF32 `%d\n`, edx
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main
