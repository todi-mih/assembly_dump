%include "utils/printf32.asm"

section .data
    h: dw 65
    L: dw 40
    H: dw 60 
    arr: dw 21, 32, 9, 56, 69, 43, 56, 80, 49, 58  
    len: equ ($-arr)/2
    
section .bss
    warn_arr: resw len

section .text
extern printf
global main


main:
    push ebp
    mov ebp, esp


    ; TODO a: Find out if the humidity h value stricly falls outside the L and H limits
    ;         and print appropriate messages for all cases on a single line
    movzx eax,word [h]
	movzx ebx,word [H]
	movzx ecx,word [L]

	cmp eax, ebx
	jg bigger

	cmp eax, ecx
	jl smaller
	
	PRINTF32 `ITS inside\n`
	jmp done
	smaller:
    PRINTF32 `ITs less\n`
	jmp done
	bigger:
    PRINTF32 `ITs more bro\n`

    ; TODO b: Given arr of humidity levels find out which of its values fall outside
    ;         of L and H limits. Store these values in the array given by warn_arr
    ;         and print the indexes where they were found in arr on a single line separated by spaces.


    ; TODO c: Print (only) previosly stored values in warn_arr 
    ;         on single line separated by spaces in order.
    
	done:
    leave
    ret
