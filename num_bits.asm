;The program counts the number of odd and even numbers 
;in different arrays (of 32-bit and 16-bit elements) and prints the results.
%include "utils/printf32.asm"

section .rodata
    arr1 dd 9, 11, 13, 15, 16, 18, 20
    len1 equ 7
    arr2 dd 11, 22, 33, 44, 55, 66, 77, 88, 99
    len2 equ 9
    arr3 dw 2, 4, 6, 8, 9, 11
    len3 equ 6
    odd_fmt db "number of odd numbers in array: %u", 10, 0
    even_fmt db "number of even numbers in array: %u", 10, 0

section .text
global main
extern puts
extern printf

num_bits:
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ebx

    mov esi, [ebp + 8]  ; array
    mov ecx, [ebp + 12] ; len
    mov edi, [ebp + 16] ; odd flag
    xor eax, eax        ; counter
    xor edx, edx        ; index

.loop:
    cmp edx, ecx
    je .done
    mov ebx, [esi + edx * 4]
    and ebx, 0x1
    cmp ebx, edi
    jne .continue
    inc eax

.continue:
    inc edx
    jmp .loop

.done:
    pop ebx
    pop edi
    pop esi
    leave
    ret

num_odd:
    push ebp
    mov ebp, esp
    push dword 1        ; odd flag
    push dword [ebp + 12] ; len
    push dword [ebp + 8]  ; array
    call num_bits
    add esp, 12
    leave
    ret

num_even:
    push ebp
    mov ebp, esp
    push dword 0        ; even flag
    push dword [ebp + 12] ; len
    push dword [ebp + 8]  ; array
    call num_bits
    add esp, 12
    leave
    ret

num_bits_size:
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ebx

    mov esi, [ebp + 8]  ; array
    mov ecx, [ebp + 12] ; size (2 or 4)
    mov edx, [ebp + 16] ; number of elements
    mov ebx, [ebp + 20] ; odd/even flag
    xor eax, eax        ; Initialize count to 0

.loop:
    test edx, edx
    jz .done

    cmp ecx, 4
    je .dword_element

    ; Handle word (2 bytes) elements
    movzx edi, word [esi]
    add esi, 2
    jmp .check_parity

.dword_element:
    ; Handle dword (4 bytes) elements
    mov edi, [esi]
    add esi, 4

.check_parity:
    and edi, 1
    cmp edi, ebx
    jne .continue
    inc eax

.continue:
    dec edx
    jmp .loop

.done:
    pop ebx
    pop edi
    pop esi
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; Test num_odd
    push dword len1
    push dword arr1
    call num_odd
    add esp, 8
    push eax
    push odd_fmt
    call printf
    add esp, 8

    ; Test num_even
    push dword len1
    push dword arr1
    call num_even
    add esp, 8
    push eax
    push even_fmt
    call printf
    add esp, 8

    ; Test num_bits_size with arr3 (16-bit elements)
    push dword 1        ; odd flag
    push dword len3     ; number of elements
    push dword 2        ; size of each element (2 bytes)
    push dword arr3     ; array
    call num_bits_size
    add esp, 16
    push eax
    push odd_fmt
    call printf
    add esp, 8

    ; Return 0
    xor eax, eax
    leave
    ret