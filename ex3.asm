;reverse array in place
%include "utils/printf32.asm"
section .data
    example db 'ABCDEFGHIJ', 0 ; Example array to be reversed
    length dd 10               ; Length of the example array
    format db "%s\n\x0", 0        ; Format string for printf

section .bss
    res resb 11                ; Buffer to hold the reversed result

section .text
    extern printf
    global main
    global array_reverse

; Function to reverse an array of bytes in place
; void array_reverse(char* arr, unsigned int length)
array_reverse:
    push ebp
    mov ebp, esp

    ; Get parameters
    mov ecx, [ebp + 12] ; length
    mov esi, [ebp + 8]  ; arr

    ; Calculate end pointer
    lea edi, [esi + ecx - 1]

    ; Loop to reverse the array in place
reverse_loop:
    cmp esi, edi
    jge reverse_done  ; If start index is greater than or equal to end index, we're done

    ; Swap bytes
    mov al, [esi]
    mov bl, [edi]
    mov [esi], bl
    mov [edi], al

    ; Move pointers
    inc esi
    dec edi

    jmp reverse_loop

reverse_done:
    pop ebp
    ret

main:
    push ebp
    mov ebp, esp

    ; Print original array
    push example
    push format
    call printf
    add esp, 8  ; Clean up stack

    ; Call array_reverse
    push dword [length]
    push example
    call array_reverse
    add esp, 8  ; Clean up stack

    ; Print reversed array
    push example
    push format
    call printf
    add esp, 8  ; Clean up stack

    ; Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
