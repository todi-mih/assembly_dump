;for elements of a vector of bytes ,transform them intp sqaure and put them in a vector of words

%include "utils/printf32.asm"

section .data
    format_print db "%d ", 0     ; Format string for printing integers
    format_newline db 10, 0      ; Newline character
    array1 db 1, 12, 3, 4, 5      ; First array of bytes (8-bit integers)
    array1_len equ 5             ; Length of the array in bytes

section .bss
    array2 resw array1_len       ; Allocate space for an array of words (16-bit integers)

section .text
    extern printf
    global main

; Function to transform byte array to word array with squares
pow_array:
    push ebp
    mov ebp, esp

    ; Arguments:
    ; [ebp + 8] = array1 pointer
    ; [ebp + 12] = array1 length
    ; [ebp + 16] = array2 pointer

    mov esi, [ebp + 8]   ; Load the pointer to array1 into esi
    mov edi, [ebp + 16]  ; Load the pointer to array2 into edi
    mov ecx, [ebp + 12]  ; Load the length into ecx for loop counter
    
    
.loop:
    xor eax, eax         ; Clear eax
    mov al, [esi]        ; Load a byte from array1 into al

    imul eax, eax               
    ;ose mul ax             ; Square the value (al * al = ax)
    mov [edi], ax        ; Store the result in array2
    
    inc esi              ; Move to next byte in array1
    add edi, 2           ; Move to next word in array2
    loop .loop           ; Decrement ecx and continue if not zero

    mov esp, ebp
    pop ebp
    ret

; Function to print the word array
print_array:
    push ebp
    mov ebp, esp

    ; Arguments:
    ; [ebp + 8] = array pointer
    ; [ebp + 12] = array length

    mov esi, [ebp + 8]   ; Load the pointer to array into esi
    mov ecx, [ebp + 12]  ; Load the length into ecx for loop counter

.loop:
    push ecx             ; Save loop counter

    movzx eax, word [esi] ; Load a word from array, zero-extend to 32 bits
    push eax             ; Push the value to be printed
    push format_print    ; Push the format string
    call printf          ; Print the value
    add esp, 8           ; Clean up the stack (2 arguments * 4 bytes)

    pop ecx              ; Restore loop counter
    add esi, 2           ; Move to next word in array
    loop .loop

    ; Print a newline
    push format_newline
    call printf
    add esp, 4

    mov esp, ebp
    pop ebp
    ret

main:
    push ebp
    mov ebp, esp

    ; Call pow_array to transform array1 to array2
    push array2
    push array1_len
    push array1
    call pow_array
    add esp, 12

;po do ta printosh manual
;movzx eax, word [array2 + 2]
;PRINTF32 `%d\n` , eax
    ; Print the resulting array2
    push array1_len
    push array2
    call print_array
    add esp, 8

    ; Exit the program
    mov eax, 0
    mov esp, ebp
    pop ebp
    ret