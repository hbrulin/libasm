section .text
	global _ft_write

_ft_write:
	
	push rbp
    mov rbp, rsp ;SP fait pointer BP sur le sommet de la stack. bonne pratique pour retrouver dans stack trace
	
	mov rax, 0
	
	cmp	rdi, 0	; !rdi fd
	je return 
	cmp	rsi, 0	; !rsi buf
	je return 
	cmp	rdx, 0	; !rdx nbyte
	je return 

	;sub rsp, rdx ;alloue nbyte dans la pile pour le buf -> pas besoin d'allouer de la stack car on ne read pas dans un buffer

	mov rax, 0x000004 ;nb correspondant a l'appel systeme de write
	syscall ;prend tout seul les 3 arguments dans rdi, rsi, rdx ;car le kernel a les memes registres pour 1, 2 et 3 arguments : 
	;User-level applications use as integer registers for passing the sequence %rdi, %rsi, %rdx, %rcx, %r8 and %r9. The kernel interface uses %rdi, %rsi, %rdx, %r10, %r8 and %r9.

	;rax prend le retour du syscall

	return:
		leave ;remet la stack : pop rbp, meme si on  fait n'imp la stack revient normal
		ret ;return RAX, nb of byte printed, syscall le fait
