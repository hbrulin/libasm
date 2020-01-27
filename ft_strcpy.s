section .text
	global _ft_strcpy

_ft_strcpy:
	mov	rcx, 0 ; i = 0
	mov	rdx, 0 ; tmp = 0
	jmp	copy
increment:
	inc	rcx
copy:
	mov	dl, BYTE [rsi + rcx]
	mov	BYTE [rdi + rcx], dl
	cmp	dl, 0
	jne	increment ;ou jnz
	;pas besoin de mettre le \0 car il a ete copie
return:
	mov	rax, rdi ; return dst
	ret
