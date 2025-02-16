section .data
    format db "Length of string: %d", 10, 0  ; Format string for printf

section .text
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ; Retrieve the parameter (address of the string)
    mov edi, [ebp + 8]

    ; Calculate the length of the string
    xor ecx, ecx                ; Counter for string length
loop_start:
    cmp byte [edi + ecx], 0     ; Check if current byte is null terminator
    je loop_end                 ; If null terminator is found, exit the loop
    inc ecx                     ; Increment the counter
    jmp loop_start

loop_end:
    ; Prepare arguments for printf
    push ecx                    ; Push the length of the string
    push format                 ; Push the format string

    ; Call printf to print the length
    call printf

    ; Clean up the stack
    add esp, 8

    ; Return 0
    xor eax, eax
    leave
    ret
