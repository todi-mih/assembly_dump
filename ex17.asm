;program to read a vector and allocate mem
section .data
    prompt_size db "Enter the number of integers: ", 0
    prompt_nums db "Enter %d integers: ", 0
    format_scan db "%d", 0
    format_print db "%d ", 0
    format_newline db 10, 0  ; newline character

section .bss
    num_ints resd 1  ; Reserve space for number of integers

section .text
    extern malloc
    extern free
    extern printf
    extern scanf

global main

main:
    push ebp
    mov ebp, esp

    ; Print prompt for size
    push prompt_size
    call printf
    add esp, 4

    ; Read number of integers
    push num_ints
    push format_scan
    call scanf
    add esp, 8

    ; Allocate memory
    mov eax, [num_ints]
    shl eax, 2  ; Multiply by 4 (size of int)
    push eax
    call malloc
    add esp, 4
    mov esi, eax  ; Store pointer in esi

    ; Print prompt for numbers
    push dword [num_ints]
    push prompt_nums
    call printf
    add esp, 8

    ; Read integers from user
    mov ecx, [num_ints]
    xor edx, edx
input_loop:
    push ecx  ; Save loop counter
    push edx  ; Save index

    lea eax, [esi + edx * 4]  ; Calculate address for current integer
    push eax
    push format_scan
    call scanf
    add esp, 8

    pop edx  ; Restore index
    pop ecx  ; Restore loop counter
    inc edx
    loop input_loop

    ; Print the array
    mov ecx, [num_ints]
    xor edx, edx
print_loop:
    push ecx  ; Save loop counter
    push edx  ; Save index

    push dword [esi + edx * 4]
    push format_print
    call printf
    add esp, 8

    pop edx  ; Restore index
    pop ecx  ; Restore loop counter
    inc edx
    loop print_loop

    ; Print newline
    push format_newline
    call printf
    add esp, 4

    ; Free allocated memory
    push esi
    call free
    add esp, 4

    ; Exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret