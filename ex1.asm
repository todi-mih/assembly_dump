; Counts and prints groups of three consecutive 1 bits in a 32-bit number.
section .data
    num dd 0x12345678         ; Define a 32-bit integer for testing (change this value to test other cases)

    ; Format string for printf
    format db "Number of groups of three consecutive 1 bits: %d\n", 0

section .text
    global main
    extern printf

main:
    ; Set up stack frame
    push ebp
    mov ebp, esp

    ; Load the value of num into eax
    mov eax, [num]

    ; Initialize counter to 0
    xor ecx, ecx            ; ECX will be our counter

count_groups:
    ; Check if the least significant 3 bits are all 1s
    mov ebx, eax
    and ebx, 0x7            ; Isolate the least significant 3 bits (0b111 in binary is 0x7 in hexadecimal)
    cmp ebx, 0x7            ; Compare with 0x7 (which is 0b111)
    jne no_increment        ; If they are not equal, skip increment

    ; Increment counter
    inc ecx

no_increment:
    ; Shift right by 1 to check the next group of 3 bits
    shr eax, 1

    ; Check if we've processed all bits
    test eax, eax
    jnz count_groups        ; If EAX is not zero, continue loop

    ; Prepare to call printf
    push ecx                ; Push the count of groups of three 1s
    push format
    call printf
    add esp, 8              ; Clean up the stack (2 pushes * 4 bytes each)

    ; Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
