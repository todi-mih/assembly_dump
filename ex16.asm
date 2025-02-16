;program to turn a string to uppercase
section .data
    format_string db "%s", 0
    upper_format db "%s", 0
    input_string db "hello world, how are you?", 0

section .text
    global main
    extern printf

main:
    ; Print original string
    push input_string
    push format_string
    call printf
    add esp, 8

    ; Convert string to uppercase
    push input_string      ; Address of the string
    call convert_to_uppercase
    add esp, 4

    ; Print modified string
    push input_string
    push format_string
    call printf
    add esp, 8

    ; Exit the program
    mov eax, 0
    ret

; Function to convert characters to uppercase
convert_to_uppercase:
    push ebp
    mov ebp, esp

    ; Load the address of the string
    mov esi, [ebp + 8]     ; Load the address of the string into ESI

convert_loop:
    mov al, [esi]          ; Load the current character from the string
    test al, al            ; Check for null terminator
    jz done                ; If null terminator, end the loop
    cmp al, 'a'            ; Check if character is lowercase
    jl not_lower           ; If not lowercase, skip conversion
    cmp al, 'z'            ; Check if character is lowercase
    jg not_lower           ; If greater than 'z', skip conversion
    sub al, 0x20           ; Convert to uppercase (subtract 0x20 from ASCII value)
    mov [esi], al          ; Store the converted character back
not_lower:
    inc esi                ; Move to the next character
    jmp convert_loop

done:
    pop ebp
    ret
