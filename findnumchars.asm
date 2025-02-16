;The program counts occurrences of a given character in a null-terminated string and prints the count,
; or -1 if not found.
section .data
    format db "%d", 10, 0         ; Format string for printf

section .text
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ; Retrieve the parameters
    mov edi, [ebp + 8]          ; Address of the string
    movzx eax, byte [ebp + 12]  ; Character to search for

    ; Initialize the counter
    xor ecx, ecx                ; Counter for character occurrences

    ; Search for the character in the string
search_loop:
    cmp byte [edi], 0           ; Check if end of string is reached
    je search_end               ; If end of string is reached, exit the loop

    cmp byte [edi], al          ; Compare current character with the search character
    je increment_counter        ; If characters match, increment the counter

    inc edi                     ; Move to the next character in the string
    jmp search_loop

increment_counter:
    inc ecx                     ; Increment the counter
    inc edi                     ; Move to the next character in the string
    jmp search_loop

search_end:
    ; Prepare arguments for printf
    push ecx                    ; Push the counter

    ; Check if the character was found
    cmp ecx, 0
    je character_not_found

    ; Call printf to print the counter
    push format
    call printf

    ; Clean up the stack
    add esp, 8
    jmp exit_program

character_not_found:
    ; Print -1
    push dword -1
    push format
    call printf

    ; Clean up the stack
    add esp, 8

exit_program:
    ; Return 0
    xor eax, eax
    leave
    ret
