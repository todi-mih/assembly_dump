;fn to print an array
extern printf

section .rodata
    fmt db "%d ", 0
    newline_fmt: db 0xd, 0xa, 0x0


section .data
   ; val dd 100
    ; val dd 0
     val dd -9
    arr dd -10, 20, 30, -40, -50, 60, 70, 80, -90, -100
    ;arr dd  0, 0, 0, -40, -50, -60, 70, 80, 90, 100
    len equ 10

section .bss
    res resd 10

section .text
global main

print_arr:
   push ebp
    mov ebp, esp

    ; Arguments:
    ; [ebp + 8] = array pointer
    ; [ebp + 12] = array length

    mov esi, [ebp + 8]   ; Load the pointer to array into esi
    mov ecx, [ebp + 12]  ; Load the length into ecx for loop counter

.loop:
    push ecx             ; Save loop counter

    mov eax, [esi] ; Load a word from array, zero-extend to 32 bits
    push eax             ; Push the value to be printed
    push fmt   ; Push the format string
    call printf          ; Print the value
    add esp, 8           ; Clean up the stack (2 arguments * 4 bytes)

    pop ecx              ; Restore loop counter
    add esi, 4           ; Move to next word in array
    loop .loop

    ; Print a newline
    push newline_fmt
    call printf
    add esp, 4

    mov esp, ebp
    pop ebp
    ret

sign:
    push ebp
    mov ebp, esp

    ;TODO a: Implement int sign(int val); to return the sign of an integer
    ; function should return 1 if the number is positive, -1 if the number is negative or 0 if the number is 0
    
    mov eax, [ebp + 8]

	
    shr eax, 31
    leave
    ret

compute_sign:
    push ebp
    mov ebp, esp

    ; Get arguments
    mov esi, [ebp + 8]  ; Pointer to the input array (arr)
    mov ecx, [ebp + 12] ; Length of the array (n)
    mov edi, [ebp + 16] ; Pointer to the result array (res)

    xor edx, edx        ; Index for array iteration

.loop:
    cmp ecx, 0          ; Check if we've processed all elements
    je .done            ; If ecx (counter) is 0, we're done

    ; Load the current element from arr
    mov eax, [esi + edx * 4]
    
    ; Call the sign function
    push eax            ; Push the current element
    call sign
    add esp, 4          ; Clean up the stack

    ; Store the result in res
    mov [edi + edx * 4], eax

   
    inc edx
    dec ecx
    jmp .loop           ; Repeat loop

.done:
    mov esp, ebp
    pop ebp
    ret


main:
    push ebp
    mov ebp, esp

    ; TODO a: test sign function
    push dword [val]
    call sign
    add esp, 4

    push eax
    push fmt
    call printf
    add esp, 8
    
    pusha
    push newline_fmt
    call printf
    add esp, 4
    popa

    ; TODO b: print arr elements separated by a space
    push dword len
    push arr
    call print_arr
    add esp, 8
    
    pusha
    push newline_fmt
    call printf
    add esp, 4
    popa

    ; TODO c: compute sign for each element of arr and store the result in res array
    push res
    push dword len
    push arr
    call compute_sign
    add esp, 12

    ; print the result
    push dword len
    push res
    call print_arr
    add esp, 8
    
    pusha
    push newline_fmt
    call printf
    add esp, 4
    popa

    ; Return 0.
    xor eax, eax
    leave
    ret


