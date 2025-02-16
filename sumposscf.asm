section .data
    format: db "%d", 0  ; Format string for scanf

section .text
    global sum_range

sum_range:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Initialize sum to 0
    mov eax, 0
    
    ; Load vector size into ecx
    mov ecx, [ebp + 8]  ; Access the vector size argument
    
    ; Load vector address into edi
    mov edi, [ebp + 12] ; Access the vector argument
    
    ; Read starting position (a) from user
    push eax
    push ebx
    lea ebx, [ebp - 4]   ; Reserve space for a
    push ebx
    push format
    call scanf
    add esp, 12
    
    ; Read ending position (b) from user
    push eax
    push ebx
    lea ebx, [ebp - 8]   ; Reserve space for b
    push ebx
    push format
    call scanf
    add esp, 12

    ; Load starting position (a) from memory
    mov ebx, [ebp - 4]
    
    ; Calculate the effective starting address
    lea edi, [edi + ebx * 4] ; Multiply by 4 to get the byte offset

    ; Calculate the number of elements to sum (b - a + 1)
    sub ecx, ebx
    inc ecx

sum_loop:
    ; Check if position b has been reached
    cmp ebx, [ebp - 8] ; Compare with ending position (b)
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
