;program that multiplies by 2 elements in the n-th and q-th pos ,divide the rest 
%include "utils/printf32.asm"
section .data
    vec dd 10, 20, 30, 40, 50, 60, 70, 80   ; Predefined vector
    len dd 8                                ; Length of the vector
    n dd 2                                  ; Starting position (0-based index)
    q dd 5                                  ; Ending position (0-based index)
    format db "%d ", 0                      ; Format for printing numbers

section .text
    global main
    extern printf

main:
    ; Load parameters
    mov ecx, [len]        ; Load vector length into ECX
    mov edi, vec          ; Load the address of the vector into EDI
    mov ebx, [n]          ; Load starting position n into EBX
    mov edx, [q]          ; Load ending position q into EDX

    ; Iterate over the vector
.loop:
    cmp ecx, 0            ; Check if we've processed all elements
    je .done              ; If so, jump to done

    ; Process elements between n and q (inclusive)
    mov eax, ecx
    dec eax
   
    cmp eax, ebx          ; Check if the current index is >= n
    jl .divide            ; If not, divide the element

    cmp eax, edx          ; Check if the current index is <= q
    jg .divide            ; If not, divide the element

    ; Multiply the element by 2
    mov eax, [edi]        ; Load the current element
    shl eax, 1            ; Multiply by 2 (shift left by 1)
    mov [edi], eax        ; Store the result back
    jmp .print

.divide:
    ; Divide the element by 2
    mov eax, [edi]        ; Load the current element
    shr eax, 1            ; Divide by 2 (shift right by 1)
    mov [edi], eax        ; Store the result back

.print:
    ; Print the current element
   PRINTF32 `%d\n `,eax

    ; Move to the next element
    add edi, 4            ; Move to the next element (4 bytes for each int)
    dec ecx               ; Decrement the counter
    jmp .loop             ; Repeat the loop

.done:
    ; Exit the program
    mov eax, 1            ; Syscall number for exit
    xor ebx, ebx          ; Exit code 0
    int 0x80              ; Make the syscall
