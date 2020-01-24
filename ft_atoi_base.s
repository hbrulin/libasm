section .text
	global _ft_atoi_base
	extern _ft_strlen

_ft_atoi_base:
	mov rax, 0
	cmp rdi, 0
	je end ;renvoie 0 si pas de str
	cmp rsi, 0
	je end ;renvoie 0 si pas de base

init:
	mov rcx, -1 ;compteur str, a -1 car pour le whitespace on incremente au debut
	mov r12, -1 ;compteur base
	mov r8, 0 ;nb
	mov r9, -1 ;neg
;checks

skip:
	inc rcx

whitespace:
	cmp BYTE [rdi + rcx], 32
	je skip
	cmp BYTE [rdi + rcx], 9
	je skip
	cmp BYTE [rdi + rcx], 10
	je skip
	cmp BYTE [rdi + rcx], 13
	je skip
	cmp BYTE [rdi + rcx], 11
	je skip
	cmp BYTE [rdi + rcx], 12
	je skip
	jmp skip_base

skip_base:
	inc r12

whitespace_base:
	cmp BYTE [rsi + r12], 32
	je skip_base
	cmp BYTE [rsi + r12], 9
	je skip_base
	cmp BYTE [rsi + r12], 10
	je skip_base
	cmp BYTE [rsi + r12], 13
	je skip_base
	cmp BYTE [rsi + r12], 11
	je skip_base
	cmp BYTE [rsi + r12], 12
	je skip_base
	jmp len

len:
	push rdi ;je save rdi (str) car ma ft_strlen va le prendre en arg
	mov rdi, rsi ; je mets base dans rdi pour que strlen calcule la len de la base
	call _ft_strlen ;renvoie la len dans rax -CHECK SI STRLEN NE CHANGE PAS RCX??
	sub rax, r12
	mov r10, rax ; je mets len dans r10, je lui retire la valeur de r12 si whitespace
	pop rdi ; je recup str

	dec rcx ;car mon compteur dans pos va etre incrementé, donc je le baisse
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
	cmp bl, BYTE [rsi + r12] ;base[0]
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
	movsx rbx, BYTE [rsi + r12]
	sub r8, rbx
	inc rcx
	jmp comp

end:
	mov rax, r9
	mul r8
	ret
