section.text
	global _ft_strcpy

;rsi arg2
;rdi arg1

_ft_strcpy:									; dst = rdi, src = rsi
			mov		rcx, 0				; i = 0
			mov		rdx, 0				; tmp = 0
			cmp		rsi, 0					; !rsi
			je		return ;quelle difference je/jz? jump if zero, jump if equal (saut si ZF = 1)
			jmp		copy
increment:
			inc		rcx
copy:
			mov		dl, BYTE [rsi + rcx]
			mov		BYTE [rdi + rcx], dl
			cmp		dl, 0
			jne		increment ;ou jnz?
			;pas besoin de mettre le \0 car il a ete copie??
return:
			mov		rax, rdi				; return dst
			ret
