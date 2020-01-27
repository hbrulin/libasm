section .text
	global _ft_list_size

_ft_list_size:

;rdi begin list
	xor rax, rax

inc:
	mov	rdi, [rdi + 8] ; rdi = rdi->next
	inc rax

cmp:
	cmp rdi, 0
	jne inc
	je end

end:
	ret
