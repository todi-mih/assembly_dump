;find length of string without using strlen
section .data
    string db "He", 0    ; Null-terminated string
    format db "Length of the string: %d\n", 0

section .text
    extern printf
    global main

find_length:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]              ; Load the address of the string into ESI
    xor ecx, ecx                    ; Clear ECX (will use as the counter)

count_loop:
    cmp byte [esi + ecx], 0         ; Compare the byte at [esi + ecx] with 0
    je done                         ; If zero, end of string reached
    inc ecx                         ; Increment the counter
    jmp count_loop                  ; Repeat the loop

done:
    mov eax, ecx                    ; Move the counter to EAX
    mov esp, ebp
    pop ebp
    ret

main:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    ; Call find_length with the string
    push dword string               ; Push string address
    call find_length
    add esp, 4                      ; Clean up the stack

    ; Print the length
    push eax                        ; Push the length of the string
    push dword format               ; Push the format string
    call printf
    add esp, 8                      ; Clean up the stack

    ; Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main
