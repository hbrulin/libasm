section.text
	global _ft_write

_ft_write:
	cmp	rdi, 0	; !rdi fd
	je return 
	cmp	rsi, 0	; !rsi buf
	je return 
	cmp	rdx, 0	; !rdx nbyte
	je return 

	push rbp
    mov rbp, rsp ;SP fait pointer BP sur le sommet de la stack
	sub rsp, rdx ;alloue nbyte dans la pile pour le buf

	mov rbp, rsi ;dépose au sommet de la pile l’adresse mémoire debuf

	mov rax, 0x000004 ;nb correspondant a l'appel systeme de write
	syscall 

	;xor?

	return:
		ret ;return RAX, nb of byte printed, syscall le fait
