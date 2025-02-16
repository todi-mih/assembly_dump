;store in a third vector the vectorial product of 2
%include "utils/printf32.asm"
section .data
    vector1 dd 1, 2, 3, 4, 5      ; First vector
    vector2 dd 3, 4, 5, 6, 7      ; Second vector
    length equ 5                  ; Length of the vectors

section .bss
    result resd length            ; Reserve space for the result vector

section .text
    global main
    extern printf                 ; For printing, if needed

main:
    ; Set up base pointers to the vectors
    mov esi, vector1              ; ESI will point to vector1
    mov edi, vector2              ; EDI will point to vector2
    mov edx, result               ; EDX will point to the result vector
    mov ecx, length               ; ECX will hold the length (counter for the loop)

.loop_start:
    ; Check if we've finished processing the vectors
    cmp ecx, 0                    ; Compare ECX (counter) with 0
    je .done                      ; If ECX is 0, we're done, so jump to the end

    ; Load elements from each vector
    mov eax, [esi]                ; Load element from vector1 into EAX
    mov ebx, [edi]                ; Load element from vector2 into EBX

    ; Multiply the elements
    imul eax, ebx                 ; EAX = EAX * EBX (product of corresponding elements)
    
    ; Store the result in the result vector
    mov [edx], eax                ; Store the product in the result vector

    ; Increment pointers to move to the next elements
    add esi, 4                    ; Move to the next element in vector1 (4 bytes per element)
    add edi, 4                    ; Move to the next element in vector2 (4 bytes per element)
    add edx, 4                    ; Move to the next position in the result vector

    ; Decrement the counter and loop
    dec ecx                       ; Decrement the counter (ECX)
    jmp .loop_start               ; Jump back to the start of the loop

.done:
    ; Print the result vector (optional)
    ; Use printf or other methods to print the result
    ; Example: call printf with format specifier "%d"

    xor ecx,ecx

    sec_loop:
    cmp ecx, length
    je done2

    PRINTF32 `%d\n`, [result + ecx * 4]
    add ecx, 1
    jmp sec_loop


    ; Exit the program
    done2:
    xor eax, eax                  ; Set EAX to 0 (indicating successful exit)
    ret
