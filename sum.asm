section .text
    global sum_vector

sum_vector:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Initialize sum to 0
    mov eax, 0
    
    ; Load vector size into ecx
    mov ecx, [ebp + 8] ; Access the vector size argument
    
    ; Load vector address into edi
    mov edi, [ebp + 12] ; Access the vector argument
    
    ; Calculate the sum
sum_loop:
    ; Load current number into ebx
    mov ebx, [edi]
    
    ; Add current number to sum
    add eax, ebx
    
    ; Move to the next element in the vector
    add edi, 4
    
    ; Decrease the loop counter
    loop sum_loop
    
    ; Epilogue
    mov esp, ebp
    pop ebp

    ; Return the sum
    ret
