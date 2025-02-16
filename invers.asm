section .text
    global array_reverse

array_reverse:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Load function arguments
    mov edi, [ebp + 8]      ; arr (pointer to the array)
    mov ecx, [ebp + 12]     ; length (length of the array)

    ; Calculate the end position of the array
    mov esi, edi            ; Copy arr to esi (source pointer)
    add esi, ecx            ; Calculate the end position (source pointer + length)

    ; Reverse the array
reverse_loop:
    cmp edi, esi            ; Compare the current position with the end position
    jge reverse_exit        ; If current position >= end position, exit the loop

    ; Swap elements
    mov al, [edi]           ; Load the current element into al
    mov dl, [esi]           ; Load the element at the end position into dl
    mov [edi], dl           ; Store dl at the current position
    mov [esi], al           ; Store al at the end position

    ; Move to the next position
    inc edi                 ; Increment the source pointer
    dec esi                 ; Decrement the end position pointer

    ; Continue the loop
    jmp reverse_loop

reverse_exit:
    ; Epilogue
    mov esp, ebp
    pop ebp

    ; Return
    ret
