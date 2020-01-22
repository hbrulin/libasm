section .text
	global _ft_strlen

_ft_strlen:
	mov rax, 0
	cmp	rdi, 0					; !rdi le vrai n'est pas protege contre segfault
	je end

comp:
	cmp BYTE [rdi + rax], 0 
	je end

	inc rax
	jmp comp

end:
	ret
