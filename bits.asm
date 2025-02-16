; This program performs bitwise operations on a given number:
; 1. Prints the least significant 2 bits of the second most significant byte.
; 2. Counts and prints the number of bits set at odd positions.
; 3. Counts and prints the number of groups of 3 consecutive bits set.

%include "utils/printf32.asm"

section .data
    num dd 55555123

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; Exercise a: Print least significant 2 bits of the second most significant byte of num
    mov eax, dword [num]
    shr eax, 16               ; Shift to the 2nd most significant byte
    and eax, 0x03             ; Mask the least significant 2 bits
    push eax
    push fmt_decimal
    call printf32
    add esp, 8

    ; Exercise b: Print number of bits set on odd positions
    mov eax, dword [num]
    xor ebx, ebx             ; Counter for set bits
    xor ecx, ecx             ; Position counter

count_loop:
    test eax, 0xaaaaaaaa     ; Test if the bit at the odd position is set
    jnz increment_counter    ; Jump if the bit is set
    shr eax, 1               ; Shift the number to the next position
    inc ecx                  ; Increment the position counter
    cmp ecx, 32              ; Check if all positions have been checked
    jl count_loop            ; Jump to the loop if not all positions have been checked

increment_counter:
    inc ebx                  ; Increment the set bit counter
    shr eax, 1               ; Shift the number to the next position
    inc ecx                  ; Increment the position counter
    cmp ecx, 32              ; Check if all positions have been checked
    jl count_loop            ; Jump to the loop if not all positions have been checked

    push ebx
    push fmt_decimal
    call printf32
    add esp, 8

    ; Exercise c: Print number of groups of 3 consecutive bits set
    mov eax, dword [num]
    xor ebx, ebx              ; Counter for 3-bit groups
    xor ecx, ecx              ; Position counter

group_loop:
    test eax, 0x7              ; Test if the 3-bit group is set
    jz shift_mask             ; Jump if the group is not set
    inc ebx                   ; Increment the group counter

shift_mask:
    shr eax, 1                ; Shift the number to the next position
    inc ecx                   ; Increment the position counter
    cmp ecx, 30               ; Check if all positions have been checked
    jl group_loop             ; Jump to the loop if not all positions have been checked

    push ebx
    push fmt_decimal
    call printf32
    add esp, 8

    xor eax, eax
    leave
    ret

section .data
    fmt_decimal db "%d", 0
