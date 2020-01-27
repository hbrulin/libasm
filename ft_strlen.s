section .text
	global _ft_strlen

_ft_strlen:
	mov rax, 0

comp:
	cmp BYTE [rdi + rax], 0 
	je end

	inc rax
	jmp comp

end:
	ret
