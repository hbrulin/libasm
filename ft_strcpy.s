section.text
	global _ft_strcpy

_ft_strcpy:									; dst = rdi, src = rsi
			mov		rcx, 0				; i = 0
			mov		rdx, 0				; tmp = 0
			cmp		rsi, 0					; !rsi
			je		return ;quelle difference je/jz? jump if zero, jump if equal
			jmp		copy
increment:
			inc		rcx
copy:
			mov		dl, BYTE [rsi + rcx]
			mov		BYTE [rdi + rcx], dl
			cmp		dl, 0
			jnz		increment
return:
			mov		rax, rdi				; return dst
			ret
