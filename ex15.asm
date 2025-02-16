;program to get the last pos of a char and modify it to get the no of the char in str not using strlen
%include "utils/printf32.asm"

section .data
    my_string db "Hello, world!", 0
    format_string db "%s", 0
    my_char db "o", 0
    char_format db "%c", 0  ; Format string for character

section .text
    global main
    extern printf, strlen

fn1:
    ; Function to count occurrences of a character in a string
    push ebp
    mov ebp, esp
  
    ; Load the string parameter from the stack
    mov esi, [ebp + 8]    ; Load the address of the string into ESI
    ; Load the character parameter from the stack
     ; Load the character (byte) into EDX, zero-extend it
    
    push esi
    call strlen
    add esp, 4
    mov ecx, eax        ; Store string length in ECX
    
    xor ebx, ebx        ; Use EBX as counter, initialize to 0
  movzx edx, byte [ebp + 12]
loop2:
    cmp ecx, 0
    je done
    movzx  eax, byte [esi]       ; Load current character into AL
    
    cmp eax, edx          ; Compare with the target character
    ;PRINTF32 `%c %c\n` ,eax,edx
    jne skip_increment
    xor ebx, ebx
    mov  ebx, ecx             ; Increment counter if character matches
skip_increment:
    inc esi             ; Move to next character
    dec ecx             ; Decrement loop counter
    jmp loop2
    loop loop2

done:
    PRINTF32 `Number of occurrences: %d\n`, ebx
    mov eax, ebx        ; Return count in EAX
    pop ebp
    ret

main:
    ; Call fn1 to count occurrences
    movzx eax, byte [my_char] ; Load the character directly into EAX
    push eax             ; Push the character onto the stack
    push my_string
    call fn1
    add esp, 8           ; Clean up the stack (2 arguments * 4 bytes)

    ; Exit the program
    mov eax, 0          ; Return code 0
    ret