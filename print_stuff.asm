%include "utils/printf32.asm"
;print using printf and  and the costum printf32 (not mine if you are curious)
section .data
    M dw 24           ; 16-bit integer
    N dw 2            ; 16-bit integer
    fmt db "%d",10, 0    ; Format string for printf

section .text
    extern printf
    global main

main:
    ; Prologue: Set up the stack frame
    push ebp
    mov ebp, esp

    ; Load 16-bit values into 32-bit registers
    movzx eax, word [M]  ; Load M into EAX (zero-extended to 32 bits)
    movzx ebx, word [N]  ; Load N into EBX (zero-extended to 32 bits)

    ; Multiply EAX by EBX
    mul  ebx        ; EAX = EAX * EBX (result in EAX)
    PRINTF32 `%d\n`, eax
    ; Print the result
    push eax             ; Push result onto the stack
    push fmt             ; Push format string onto the stack
    call printf          ; Call printf
    add esp, 8           ; Clean up the stack (2 pushes, each 4 bytes)

    ; Epilogue: Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax         ; Return code 0
    ret
