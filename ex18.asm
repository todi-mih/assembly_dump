;allocate predefined vec
%include "utils/printf32.asm"

section .data
    format_print db "%d ", 0
    format_newline db 10, 0  ; newline character
    array1 dd 1, 2, 3, 4, 5  ; First array of dwords (32-bit integers)
    array1_len equ 5   

section .text
    extern malloc
    extern free
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ; Allocate memory
    mov eax, array1_len
    ;shl eax, 2  ; Multiply by 4 (size of dword)
    imul eax, 4
    push eax
    call malloc
    add esp, 4
    mov esi, eax  ; Store pointer in esi

    ; Fill the allocated memory
    mov ecx, array1_len
    mov ebx, array1
    xor edx, edx
fill:
    mov eax, [ebx + edx * 4]
    mov [esi + edx * 4], eax
    inc edx
    loop fill

    ; Print the allocated array
    mov ecx, array1_len
    xor edx, edx
print_loop:
    PRINTF32 `%d `, [esi + edx * 4]
    inc edx
    loop print_loop

    ; Print newline
    PRINTF32 `\n`

    ; Free allocated memory
    push esi
    call free
    add esp, 4

    ; Exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret