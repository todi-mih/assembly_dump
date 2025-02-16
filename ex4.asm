;program to  get 1 byte numbers and store their square in a 2 byte array 
section .data
    vec1 db 1, 2, 3, 4, 5        ; 1-byte numbers
    vec1_len equ 5               ; Length of the 1-byte numbers vector
    format db "Result: %d %d %d %d %d\n", 0  ; Format string for printf

section .bss
    vec2 resw 5                  ; Reserve space for 5 2-byte numbers

section .text
    extern printf
    global main
    global pow_array

; Function to calculate squares of elements in a byte array and store them in a word array
; void pow_array(char* arr, unsigned int length, short* result)
pow_array:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame
    
    mov ecx, [ebp + 12] ; Load the length of the array into ECX
    ; ECX = length

    mov esi, [ebp + 8]  ; Load the pointer to the input array into ESI
    ; ESI = arr (input array)

    mov edi, [ebp + 16] ; Load the pointer to the result array into EDI
    ; EDI = result (output array)

calculate_square:
    cmp ecx, 0          ; Compare the length (ECX) with 0
    je done             ; If ECX is 0, jump to 'done'

    movzx eax, byte [esi] ; Load a byte from the input array and zero-extend it to EAX
    ; EAX = arr[i]

    imul eax, eax       ; Calculate the square of EAX
    ; EAX = arr[i] * arr[i]

    mov [edi], ax       ; Store the lower 16 bits of EAX into the result array
    ; result[i] = arr[i] * arr[i]

    add esi, 1          ; Move to the next byte in the input array
    ; Increment input array pointer (ESI)

    add edi, 2          ; Move to the next word in the result array
    ; Increment output array pointer (EDI)

    dec ecx             ; Decrement the counter (ECX)
    ; ECX = ECX - 1

    jmp calculate_square ; Repeat the loop
    ; Jump to the start of the loop

done:
    mov esp, ebp
    pop ebp
    ; Epilogue: Restore the stack frame
    ret
    ; Return from the function

main:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    ; Call pow_array with vec1, vec1_len, and vec2
    push vec2                     ; Push the pointer to the result array
    push vec1_len                 ; Push the length of the input array
    push vec1                     ; Push the pointer to the input array
    call pow_array                ; Call the pow_array function
    add esp, 12                   ; Clean up the stack (3 pushes * 4 bytes each)

    ; Print the result array

    movzx eax, word [vec2 + 8]       ; Load the first element of the result array
    push ax
    movzx eax, word [vec2 + 6]    ; Load the second element 
    movzx eax, word [vec2 + 2]    ; Load the fourth element of the result array
    push eaxof the result array
    push eax
    movzx eax, word [vec2 + 4]    ; Load the third element of the result array
    push eax
    movzx eax, word [vec2]     ; Load the fifth element of the result array
    push eax
    push format
    call printf
    add esp, 20 + 4               ; Clean up the stack (5 integers + 1 format string)

    ; Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main
