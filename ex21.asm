%include "utils/printf32.asm"

section .data
    M: dd 69
    k: dd 32 
    arr dd 1, 32, 9, 11, 69  
	
    len equ ($-arr)/4
    

section .bss
    res_arr resd 32

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Find out if M has the form 2*k + 5 and
    ; output the correponding messages on a separate line
    
	;mov  eax, [M]
	
	;sub eax, 5
    
	;mov bl, 2
	;div bl
	;xor ecx, ecx
	;cmp ah, 0 
	;je yes
	;PRINTF32 `NOOO %d \n` ,eax
     ;jmp done
	;yes: 
	;PRINTF32 `YESSS %d\n`, eax
    
    ; TODO b: Given arr find out which of its values has the form 2*i + 5, 
    ;         where i is the current index in arr.
    ;         Print the index i for these values and store them at 
    ;         succesive indexes j of res_arr. 
    xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
    
	mov eax, [arr]
	mov ecx, len
	mov edi, [res_arr] 
	xor esi, esi
    xor edx, edx
 
    loop1:
	 
	cmp edx, ecx
	je done
	
	mov ebx, edx
	shl ebx , 1 
	add ebx, 5
    mov eax , [arr + 4 * esi]
	cmp ebx, eax
	jne loop2
	mov [res_arr + 4 * esi], ebx
    ;PRINTF32 `%d `, ebx
    
	loop2:
	inc edx
	inc esi
	jmp loop1

    ; TODO c: Print (only) stored values from the res_arr array 
    ; on single line separated by spaces in order 
done:
    mov eax , [res_arr + 4 * 2]
    PRINTF32 `%d ` , eax 
	mov eax , [res_arr + 4 * 3]
    PRINTF32 `%d ` , eax 
    leave
    ret
