section .text
    global sum_range

sum_range:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Initialize sum to 0
    mov eax, 0
    
    ; Load vector size into ecx
    mov ecx, [ebp + 12] ; Access the vector size argument
    
    ; Load vector address into edi
    mov edi, [ebp + 16] ; Access the vector argument
    
    ; Load position a into ebx
    mov ebx, [ebp + 8] ; Access the starting position argument
    
    ; Calculate the sum
    ; Check if position a is within the vector size
    cmp ebx, ecx
    jge sum_exit ; If a >= size, exit with sum = 0

    ; Calculate the effective starting address
    lea edi, [edi + ebx * 4] ; Multiply by 4 to get the byte offset

    ; Calculate the number of elements to sum (b - a + 1)
    sub ecx, ebx
    inc ecx

sum_loop:
    ; Check if position b has been reached
    cmp ebx, [ebp + 20] ; Access the ending position argument
    jg sum_exit ; If a > b, exit with the current sum
    
    ; Load current number into edx
    mov edx, [edi]
    
    ; Add current number to sum
    add eax, edx
    
    ; Move to the next element in the vector
    add edi, 4
    
    ; Increase the position counter
    inc ebx
    
    ; Continue the loop
    jmp sum_loop

sum_exit:
    ; Epilogue
    mov esp, ebp
    pop ebp

    ; Return the sum
    ret
