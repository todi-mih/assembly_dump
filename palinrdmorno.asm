section .text
    global is_palindrome

is_palindrome:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Save registers
    push ebx
    push esi
    push edi

    ; Get the string pointer
    mov edi, [ebp + 8]

    ; Find the end of the string
    xor ecx, ecx
    mov eax, edi
    not ecx
    xor al, byte [eax + ecx]
    inc ecx
    jnz .find_end

.find_end:
    xor ebx, ebx
    mov bl, byte [eax + ecx]
    test bl, bl
    jz .check_palindrome

    inc ecx
    jmp .find_end

.check_palindrome:
    dec ecx
    mov esi, edi

.check_characters:
    cmp byte [edi], byte [esi]
    jne .not_palindrome

    inc edi
    dec esi
    cmp edi, esi
    jle .check_characters

    ; String is a palindrome
    mov eax, 1
    jmp .exit

.not_palindrome:
    ; String is not a palindrome
    xor eax, eax

.exit:
    ; Restore registers
    pop edi
    pop esi
    pop ebx

    ; Epilogue
    mov esp, ebp
    pop ebp
    ret
