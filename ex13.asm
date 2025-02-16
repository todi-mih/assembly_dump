;program to allocate mem in heap for a string read in stdin and print it
%include "utils/printf32.asm"

section .data
    prompt db "Enter a string (max 64 characters): ", 0
    newline db 10, 0
    output_string_format db "You entered: %s", 10, 0
    string_format db "%64s", 0            ; Format specifier for scanf (limit to 64 characters)
    mem_fail db "Memory allocation failed", 10, 0

section .bss
    input_buffer resb 65  ; 64 bytes for input + 1 for null terminator

section .text
    global main
    extern printf, scanf, malloc, free, strlen, strcpy

main:
    push ebp
    mov ebp, esp
    sub esp, 4  ; Allocate space for a local variable

    ; Print prompt
    push prompt
    call printf
    add esp, 4

    ; Read input using scanf
    push input_buffer
    push string_format
    call scanf
    add esp, 8

    ; Get string length using strlen
    push input_buffer
    call strlen
    add esp, 4

    ; Allocate memory on heap
    inc eax  ; Add 1 for null terminator
    push eax
    call malloc
    add esp, 4

    ; Check if malloc succeeded
    test eax, eax
    jz mem_alloc_fail

    ; Store the allocated memory address in our local variable
    mov [ebp-4], eax

    ; Copy string to allocated memory using strcpy
    push input_buffer
    push dword [ebp-4]
    call strcpy
    add esp, 8

    ; Print the string from input_buffer
    push input_buffer
    push output_string_format
    call printf
    add esp, 8

    ; Print the string from allocated memory
    push dword [ebp-4]
    push output_string_format
    call printf
    add esp, 8

    ; Free allocated memory
    push dword [ebp-4]
    call free
    add esp, 4

    ; Exit program
    xor eax, eax
    leave
    ret

mem_alloc_fail:
    PRINTF32 `Memory allocation failed\n`
    xor eax, eax
    leave
    ret