; Checks if n is divisible by i and prints the result (1 for divisible, 0 for not).

extern printf

section .text

is_divizor:
    push ebp
    mov ebp, esp

    ; Retrieve the parameters
    mov eax, [ebp + 8]   ; n
    mov ebx, [ebp + 12]  ; i

    xor edx, edx  ; Clear the EDX register for division

    div ebx       ; Divide EAX (n) by EBX (i)

    cmp edx, 0    ; Check the remainder
    jne not_divizor

    ; Remainder is zero, n is divisible by i
    mov eax, 1
    jmp print_result

not_divizor:
    ; Remainder is non-zero, n is not divisible by i
    xor eax, eax

print_result:
    push eax         ; Push the result onto the stack (argument for printf)
    push result_fmt  ; Push the format string onto the stack
    call printf      ; Call the printf function to print the result
    add esp, 8       ; Adjust the stack pointer after the printf call

    leave
    ret

section .data
    result_fmt db "%d", 10, 0  ; Format string for printing an integer followed by a newline

