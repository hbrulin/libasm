section .text
	global _ft_write

_ft_write:
	
	push rbp
    mov rbp, rsp 
	
	mov rax, 0
	
	cmp	rdi, 0	; !rdi fd
	je return 
	cmp	rsi, 0	; !rsi buf
	je return 
	cmp	rdx, 0	; !rdx nbyte
	je return 

	mov rax, 0x2000004 ;nb correspondant a l'appel systeme de write
	syscall ;prend tout seul les 3 arguments dans rdi, rsi, rdx ;car le kernel a les memes registres pour 1, 2 et 3 arguments : 

	;rax prend le retour du syscall

	return:
		leave 
		ret ;return RAX, nb of byte printed, syscall le fait
