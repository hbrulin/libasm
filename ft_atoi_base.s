section .text
	global _ft_atoi_base
	extern _ft_strlen

_ft_atoi_base:

	mov rax, 0
	cmp rdi, 0
	je end ;renvoie 0 si pas de str
	cmp rsi, 0
	je end ;renvoie 0 si pas de base

	mov rcx, 0 ;compteur
	mov r8, 0 ;nb
	mov r9, -1 ;neg
;whitespace
;checks
	push rdi ;je save rdi (str) car ma ft_strlen va le prendre en arg
	mov rdi, rsi ; je mets base dans rdi pour que strlen calcule la len de la base
	call _ft_strlen ;renvoie la len dans rax
	mov r10, rax ; je mets len dans r10
	pop rdi ; je recup str
	;cmp neg -> comment je fais pour avoir valeur neg vu que tout est signed?instruction neg

	dec rcx ;car mon pos va etre incrementer a apres le signe, donc je le baisse

neg:
	neg r9 ;devient pos, puis revient a -1 si c'est bien neg

pos:
	inc rcx

check_sign:
	cmp BYTE [rdi + rcx], 45 ;'-'
	je neg
	cmp BYTE [rdi + rcx], 43 ;'+'
	je pos

comp:
	mov rbx, 0
	mov bl, BYTE [rdi + rcx]
	cmp bl, BYTE [rsi + 0] ;base[0]
	jb end ;si inferieur a base[0]
	cmp bl, BYTE [rsi + r10 - 1] ;base[len - 1]
	ja end ;si superieur a base[len -1]

calc:
	;mul multiplie parce qui est dans al
	mov rax, 0 ;je reset
	mov rax, r10 ; je remet ma len dans rax qui recup a chaque fois le result de mul
	mul r8 ;multiplie r8 par ce qui est dans al
	mov r8, rax ;rax result de mul
	mov rbx, 0
	movsx rbx, BYTE [rdi + rcx]
	add r8, rbx
	mov rbx, 0
	movsx rbx, BYTE [rsi + 0]
	sub r8, rbx
	inc rcx
	jmp comp

end:
	mov rax, r9
	mul r8
	ret
