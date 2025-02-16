   section .data
    procs:
        dq 13, 1, 28
        dq 28, 3, 16
        dq 54, 3, 16
        dq 34, 2, 49
        dq 53, 1, 51
        dq 63, 5, 50
        dq 21, 5, 60
        dq 58, 2, 39
        dq 37, 1, 41
        dq 64, 1, 14
        dq 36, 5, 56
        dq 51, 3, 11
        dq 40, 5, 10
        dq 99, 2, 57
    len:
        equ ($ - procs) / 24
    format db "%d %d %d", 10, 0
    format2 db "%d %d", 10, 0

section .text
    global _main
    extern _printf

_sort_procs:
    push rbp
    mov rbp, rsp
    mov rdi, rsi
    mov ecx, edx
    mov ebx, 1

outer_loop:
    cmp ebx, ecx
    jge outer_end
    mov esi, 0
    mov eax, 0
    mov ebx, ecx
    sub ebx, 1

inner_loop:
    cmp eax, ebx
    jg outer_end

    mov rdi, [rsi + rax * 24 + 8]
    mov r8, [rsi + rax * 24 + 24 + 8]

    cmp rdi, r8
    jl swap
    jmp next

swap:
    lea r9, [rsi + rax * 24]
    mov r10, [r9]
    mov r11, [r9 + 8]
    mov r12, [r9 + 16]
    
    mov rdi, [r9 + 24]
    mov r8, [r9 + 24 + 8]
    mov r13, [r9 + 24 + 16]

    mov [r9], rdi
    mov [r9 + 8], r8
    mov [r9 + 16], r13
    
    mov [r9 + 24], r10
    mov [r9 + 24 + 8], r11
    mov [r9 + 24 + 16], r12
    mov ebx, 1

next:
    inc rax
    jmp inner_loop

outer_end:
    inc ebx
    jmp outer_loop

_main:
    push rbp
    mov rbp, rsp
    sub rsp, 16  ; Align stack to 16 bytes before call

    lea rdi, [procs]
    mov esi, len
    call _sort_procs

    xor esi, esi

    .loop:
        cmp esi, len
        jge .end

        mov eax, [procs + rsi * 24]
        mov edx, [procs + rsi * 24 + 8]
        mov ecx, [procs + rsi * 24 + 16]

        sub rsp, 8
        push ecx
        push edx
        push eax
                lea rdi, [format]
        xor eax, eax
        call _printf
        add rsp, 32  ; remove pushed arguments and align the stack

        inc esi
        jmp .loop

    .end:
        sub rsp, 8  ; align stack
        mov eax, [procs + 8]
        push eax
        mov eax, 35
        push eax
        lea rdi, [format2]
        xor eax, eax
        call _printf
        add rsp, 24  ; remove pushed arguments and align the stack

        sub rsp, 8  ; align stack
        mov eax, [procs + 24]
        push eax
        mov eax, 48
        push eax
        lea rdi, [format2]
        xor eax, eax
        call _printf
        add rsp, 24  ; remove pushed arguments and align the stack

        sub rsp, 8  ; align stack
        mov eax, [procs + 32]
        push eax
        mov eax, 14
        push eax
        lea rdi, [format2]
        xor eax, eax
        call _printf
        add rsp, 24  ; remove pushed arguments and align the stack

        sub rsp, 8  ; align stack
        mov eax, [procs]
        push eax
        mov eax, 0
        push eax
        lea rdi, [format2]
        xor eax, eax
        call _printf
        add rsp, 24  ; remove pushed arguments and align the stack

        sub rsp, 8  ; align stack
        mov eax, [procs + 8 * len]
        push eax
        mov eax, len
        shr eax, 1
        push eax
        lea rdi, [format2]
        xor eax, eax
        call _printf
        add rsp, 24  ; remove pushed arguments and align the stack

        leave
        ret