section .text
	global _ft_list_remove_if
	extern _free 

ft_list_remove_if:
	jmp comp

move:
	mov rdi, [rdi + 8] ;si pas d'egalite j'avance
	jmp comp

del:
	mov rcx, [rdi + 16] ;j'assigne a rcx le node suivant
	mov r14, [rdi + 8] ;je save le next precedent
	call _free ;va prendre rdi
	mov r14, rcx ;set next precedent a rcx
	mov rdi, rcx

comp:
	call rdx ;prend rdi et rsi tout seul
	test rax, rax
	jz del
	jnz move

	ret
