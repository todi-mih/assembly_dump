;sum of digits of an integer
section .data
    prompt db "Enter an integer: ", 0
    result db "Sum of digits: %d", 10, 0
    format db "%d", 0

section .bss
    number resd 1   ; Reserve a doubleword (4 bytes) for the input number

section .text
    global main
    extern printf, scanf

main:
    push ebp
    mov ebp, esp

    ; Print prompt
    push prompt
    call printf
    add esp, 4

    ; Read integer
    push number
    push format
    call scanf
    add esp, 8

    ; Calculate sum of digits
    mov eax, [number]
    xor ebx, ebx    ; Use ebx to store the sum, initialize to 0

sum_loop:
    xor edx, edx    ; Clear edx for division
    mov ecx, 10
    div ecx         ; Divide eax by 10, quotient in eax, remainder in edx
    add ebx, edx    ; Add remainder (last digit) to sum
    test eax, eax   ; Check if quotient is 0
    jnz sum_loop    ; If not zero, continue loop

    ; Print result
    push ebx        ; Push sum of digits
    push result
    call printf
    add esp, 8

    ; Exit program
    xor eax, eax
    leave
    ret