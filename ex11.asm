;calculate teh product of the number of even elements with the number of odd elemtsn
section .data
    array dw 2, 3, 4, 5, 6, 8, 8, 9       ; Original array of 16-bit numbers
    array_len equ 8                        ; Length of the array
    format db "Result array: %d\n", 0

section .bss
    result_array resw array_len           

section .text
    extern printf
    global main

compute_product:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]               
    mov edi, [ebp + 12]                 
    mov ecx, [ebp + 16]           

    xor ebx, ebx                      
    xor edx, edx                     
    xor eax, eax                       

count_loop:
    cmp ecx, 0                         
    je compute_product_done            

    mov ax, word [esi]                  ; Load the word from the input array into AX
    test ax, 1                          ; Test the least significant bit
    jz even_number                      ; If zero, it's even


    inc edx                             ; Increment the odd count
    jmp next_element

even_number:
    ; Even number
    inc ebx                             ; Increment the even count

next_element:
    add esi, 2                          ; Move to the next word in the input array
    dec ecx                             ; Decrement the loop counter
    jmp count_loop                      ; Repeat the loop

compute_product_done:
    mov eax, ebx                        ; Move even count to EAX
    imul eax, edx                       ; Multiply EAX by odd count
    mov [edi], eax                      ; Store the product in the result array

    ; Zero out the rest of the result array
    mov ecx, array_len                  ; Load the length of the array into ECX
    xor ebx, ebx                        ; Clear EBX (index for result array)
    add ebx, 2                          ; Skip the first word (where the product is stored)

zero_loop:
    cmp ebx, ecx
    jge done
    mov word [edi + ebx], 0             ; Set the current word to 0
    add ebx, 2                          ; Move to the next word in the result array
    jmp zero_loop

done:
    mov esp, ebp
    pop ebp
    ret

main:
    push ebp
    mov ebp, esp
    ; Prologue: Set up the stack frame

    ; Call compute_product with the original array, result array, and length
    push dword array_len
    push dword result_array
    push dword array
    call compute_product
    add esp, 12                         ; Clean up the stack

    ; Print the result array

    push word [result_array + 2]
    push word [result_array]
    push dword format
    call printf
    add esp, 18                         ; Clean up the stack (8 words + format string)

    ; Clean up and exit
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    ; Return from main
