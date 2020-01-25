section .text
	global _ft_list_push_front
	extern _malloc

_ft_list_push_front:
		push	rdi
		push	rsi
		mov		rdi, 16 ; sizeof(t_list)
		call	_malloc
		test rax, rax
		jz return
		pop		rsi
		pop		rdi
;en assembleur, si la structure est a l'adresse A, alors le champ data est aussi a A et le champ ptr est a l'adresse A + nb de bits du champ data
		mov		[rax], rsi ; rax->data = rsi
		mov		rcx, [rdi]
		mov		[rax + 8], rcx ; rax->next = *rdi
		mov		[rdi], rax
return:
		ret

