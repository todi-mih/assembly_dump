; Computes, stores, and prints a sequence based on 7*i+3, then counts numbers below a limit.

section .bss
    int_arr resd len

section .data
    format db "%d ", 0
    len equ 10
    limit dd 50          ; Variable representing the limit

section .text
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ; Calculate and store the numbers in int_arr
    mov ecx, len
    xor esi, esi  ; i

calc_loop:
    mov eax, esi
    shl eax, 3    ; 7 * i
    add eax, 3    ; 7 * i + 3
    mov dword [int_arr + esi*4], eax
    inc esi
    loop calc_loop

    ; Print the numbers in int_arr
    mov ecx, len
    xor esi, esi  ; i

print_loop:
    mov eax, dword [int_arr + esi*4]
    push eax
    push format
    call printf
    add esp, 8
    inc esi
    loop print_loop

    ; Count the numbers strictly smaller than the limit
    xor ecx, ecx        ; Counter for the numbers
    mov esi, 0          ; i

count_loop:
    cmp dword [int_arr + esi*4], [limit]
    jge skip_count
    inc ecx

skip_count:
    inc esi
    loop count_loop

    ; Print the count
    push ecx
    push format
    call printf
    add esp, 8

    ; Return 0
    xor eax, eax
    leave
    ret
