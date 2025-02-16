;sum of elemets with postitions INCLUSIVE ,using scanf
%include "utils/printf32.asm"

section .data
    array1 db 1, 2, 3, 4, 5, 6      ; First array of bytes
    array1_len equ 6                ; Length of the first array
    format db "Sum: %d\n", 0        ; Format string for printf
    scanf_format db "%d %d", 0      ; Format string for scanf

section .bss
    start resd 1                    ; Reserve space for start position
    end resd 1                      ; Reserve space for end position

section .text
    extern printf, scanf
    global main

count:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]              ; Load the address of the array into ESI
    mov edx, [ebp + 12]             ; Load the start position into EDX
    mov ecx, [ebp + 16]             ; Load the end position into ECX
    xor ebx, ebx                    ; Clear EBX (to use as the sum)

    PRINTF32 `Start: %d, End: %d\n`, edx, ecx
    add ecx, 1
    ;add edx, 1                      ; Adjust start position (inclusive range)
    loop_sum:
        cmp edx, ecx                ; Compare start position with end position
        je done                     ; If equal, jump to done

        movzx eax, byte [esi + edx] ; Load the byte from the array at position EDX
        add ebx, eax                ; Add the value to EBX
        add edx, 1                  ; Increment the start position
        jmp loop_sum                ; Repeat until end position is reached

done:
    mov esp, ebp
    pop ebp
    ret

main:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    ; Read start and end positions using scanf
    lea eax, [start]
    push dword eax
    lea eax, [end]
    push dword eax
    push dword scanf_format
    call scanf
    add esp, 12                     ; Clean up the stack after scanf

    ; Call count with the array and the read positions
    push dword [end]                ; Push end position
    push dword [start]              ; Push start position
    push dword array1               ; Push array address
    call count

    PRINTF32 `Sum: %d\n`, ebx

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main