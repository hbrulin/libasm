section .text
	global _ft_strdup
	extern _ft_strlen
	extern _ft_strcpy
	extern _malloc

_ft_strdup:	

	call _ft_strlen ;s'exerce sur rdi
	inc rax ;pour rajouter le \0
	push rdi 		;saving rdi before calling a function
	mov	rdi, rax 		;rdi = rax; (because rdi will be used by malloc), on alloue nb de bytes
	call _malloc ;malloc len bytes, renvoie une adresse, dans rax
	test rax, rax ;je test rax, si jz 
	jz return
	pop rdi ;return mon rdi (ma src) ;je peux pop dans rsi directement
	mov rsi, rdi ;je mets ma src dans rsi, deuxieme arg qui sera appele par strcpy
	mov rdi, rax ;je mets rax, mon adresse, dans rdi pour utilisation dans strcpy come dst, rsi etant ma src
	call _ft_strcpy

return:
	ret
