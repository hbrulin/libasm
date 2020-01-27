section .text
	global _ft_read

_ft_read:
	mov	rax, 0x2000003
	syscall
	jc err              ; jump if carry flag set
    ret
err:
    mov rax, -0x1 ;-1
    ret
