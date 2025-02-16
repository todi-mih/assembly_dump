section .data
    format db "%c", 0          ; Format string for printing a character followed by a space

section .text
    extern printf

global print_string

print_string:
    push ebp
    mov ebp, esp

    ; Retrieve the parameters
    mov edi, [ebp + 8]          ; Address of the string
    mov ecx, [ebp + 12]         ; Size of the string

    ; Print each letter followed by a space
print_loop:
    movzx eax, byte [edi]       ; Load the next byte (letter) from the string into AL
    test al, al                 ; Check if the byte is null (end of the string)
    jz print_end

    push eax                    ; Push the letter onto the stack (argument for printf)
    push format                 ; Push the format string onto the stack
    call printf                 ; Call the printf function to print the letter
    add esp, 8                  ; Adjust the stack pointer after the printf call

    inc edi                     ; Move to the next letter in the string

    ; Print the space character
    push ' '                    ; Push the space character onto the stack (argument for printf)
    push format                 ; Push the format string onto the stack
    call printf                 ; Call the printf function to print the space
    add esp, 8                  ; Adjust the stack pointer after the printf call

    loop print_loop             ; Continue the loop until all letters are printed

print_end:
    ; Epilogue
    mov esp, ebp
    pop ebp

    ret
