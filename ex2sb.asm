;This program counts the divisors of a given integer n, starting from 2, and prints the number of divisors. 
;It iterates through potential divisors up to the square root of n,
; checks for divisibility, and increments the counter for each divisor. 
;The result is then printed using printf
extern printf

section .data
    format db "%d", 0   ; Format string for printing an integer

section .text

global count_divisors

count_divisors:
    push ebp
    mov ebp, esp

    ; Retrieve the parameter
    mov eax, [ebp + 8]   ; n

    xor ebx, ebx  ; Counter for the number of divisors

    mov ecx, 2    ; Start with divisor 2

    divisors_loop:
        mov edx, 0  ; Clear the EDX register for division

        div ecx    ; Divide EAX (n) by ECX (divisor)

        cmp edx, 0  ; Check the remainder
        je increment_counter

        inc ecx     ; Increment the divisor
        cmp ecx, eax  ; Check if the divisor exceeds the square root of n
        jle divisors_loop

        jmp print_result

    increment_counter:
        inc ebx  ; Increment the divisor counter
        inc ecx  ; Increment the divisor
        cmp ecx, eax  ; Check if the divisor exceeds the square root of n
        jle divisors_loop

    print_result:
        push ebx         ; Push the number of divisors onto the stack (argument for printf)
        push format      ; Push the format string onto the stack
        call printf      ; Call the printf function to print the result
        add esp, 8       ; Adjust the stack pointer after the printf call

    leave
    ret
