section .text
    global is_vowel

is_vowel:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Load function argument (char parameter)
    mov al, [ebp + 8]   ; Move the character to al register

    ; Check if the character is a vowel
    cmp al, 'A'
    je vowel_found
    cmp al, 'E'
    je vowel_found
    cmp al, 'I'
    je vowel_found
    cmp al, 'O'
    je vowel_found
    cmp al, 'U'
    je vowel_found

    ; Character is not a vowel
    mov eax, 0          ; Return 0 (false)
    jmp exit_function

vowel_found:
    ; Character is a vowel
    mov eax, 1          ; Return 1 (true)

exit_function:
    ; Epilogue
    mov esp, ebp
    pop ebp

    ; Return
    ret
