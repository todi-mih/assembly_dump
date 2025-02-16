;The print_vector function prints all elements of an integer array, separated by spaces, and ends with a newline.
extern printf

section .data
    format db "%d ", 0    ; Format string for printing an integer followed by a space
    newline db 10, 0      ; Newline character for printing a new line

section .text

global print_vector

print_vector:
    push ebp
    mov ebp, esp

    ; Retrieve the parameters
    mov edi, [ebp + 8]    ; Address of the vector
    mov ecx, [ebp + 12]   ; Number of elements (len)

    xor edx, edx         ; Counter for the loop

    print_loop:
        cmp edx, ecx     ; Compare the counter with the number of elements
        jge print_end    ; Exit the loop if all elements have been printed

        push dword [edi + edx * 4]  ; Push the element onto the stack (argument for printf)
        push format                 ; Push the format string onto the stack
        call printf                 ; Call the printf function to print the element
        add esp, 8                  ; Adjust the stack pointer after the printf call

        inc edx         ; Increment the counter
        jmp print_loop  ; Continue the loop

    print_end:
        push newline    ; Push the newline character onto the stack
        call printf     ; Call printf to print the newline
        add esp, 4      ; Adjust the stack pointer after the printf call

    leave
    ret
