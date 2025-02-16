;store into another array of words the reminder of numbers divided by 23
%include "utils/printf32.asm"

section .data
    vector dw 1, 58, 91, 22, 133, 56, 889, 25  ; Original vector of 16-bit numbers (words)
    vector_len equ 8                            ; Length of the vector
    mod_value dw 23                             ; The divisor
    format db "Result vector: %d %d %d %d %d %d %d %d\n", 0  ; Format string for printf

section .bss
    result_vector resw vector_len               ; Result vector to store remainders

section .text
    extern printf
    global main

compute_remainders:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    mov esi, [ebp + 8]                  ; Load the address of the input vector into ESI
    mov edi, [ebp + 12]                 ; Load the address of the result vector into EDI
    mov ecx, [ebp + 16]                 ; Load the length of the vector into ECX
    mov bx, [ebp + 20]              ; Load the divisor into BX
   
    xor edx, edx                        ; Clear EDX (to use as high-order word for division)
    xor eax, eax                        ; Clear EAX (to use as low-order word for division)

loop:
;PRINTF32 `%d \n`, ecx
 
    cmp ecx, 0

    je done

    mov ax, word [esi]                  ; Load the word from the input vector into AX
    
    div bx                              ; Divide AX by BX, quotient in AX, remainder in DX

    mov word [edi], dx                  ; Store the remainder in the result vector

    add esi, 2                          ; Move to the next word in the input vector
    add edi, 2                          ; Move to the next word in the result vector
    dec ecx   
    xor eax, eax  
    mov edx, 0                     ; Decrement the loop counter
    jmp loop                            ; Repeat the loop

done:

    mov esp, ebp
    pop ebp
    ret

main:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    ; Call compute_remainders with the original vector, result vector, length, and divisor
    push word [mod_value]
    push dword vector_len
    push dword result_vector
    push dword vector
    call compute_remainders
    add esp, 12                         ; Clean up the stack

mov ebx, 0
mov ecx, 16
loop2:
  cmp ebx, ecx
  je finish
  movzx eax, word [result_vector + ebx]       ; Load the first element of the result array
  PRINTF32 `%d\n`,eax
  add ebx, 2
  jmp loop2
 
finish:
    ; Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main
