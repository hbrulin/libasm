section .text
	global _ft_write

_ft_write:
	mov rax, 0x2000004 ;nb correspondant a l'appel systeme de write
	syscall ;prend tout seul les 3 arguments dans rdi, rsi, rdx ;car le kernel a les memes registres pour 1, 2 et 3 arguments : 
	jc err              ; jump if carry flag set
    ret
err:
    mov rax, -0x1 ;-1
    ret
