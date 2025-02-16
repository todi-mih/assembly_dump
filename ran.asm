section .data
    res dd 10, 20, 30, 40, 50
    len equ ($ - res) / 4   ; Calculate the number of elements in the vector
    format db "%d ", 0      ; Format string for printing an integer followed by a space

section .text
    extern printf

global main

main:
    push ebp
    mov ebp, esp

    ; Print the vector elements
    mov ecx, len      ; Initialize loop counter with the number of elements
    mov esi, 0        ; Initialize index for accessing vector elements

print_loop:
    cmp ecx, 0        ; Check if all elements have been printed
    jle print_end

    ; Print the current vector element
    mov eax, [res + esi * 4]    ; Load the element from the vector
    push eax                   ; Push the element onto the stack
    push format                ; Push the format string onto the stack
    call printf                ; Call the printf function
    add esp, 8                 ; Adjust the stack pointer after the printf call

    add esi, 1        ; Increment the index to access the next element
    sub ecx, 1        ; Decrement the loop counter
    jmp print_loop    ; Continue the loop

print_end:
    ; Print a new line
    push 0
    push newline
    call printf
    add esp, 8

    ; Return 0
    xor eax, eax
    leave
    ret

section .data
    newline db "\n", 0
