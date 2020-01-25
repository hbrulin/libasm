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
	mov rcx, 0 ;compteur str
	mov r8, 0
	mov r12, 0 ;compteur base
	mov r8, 0 ;nb
	mov r9, 0 ;neg
	jmp whitespace ;pour eviter d'incrementer

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
	jmp check_base

skip_base:
	inc r12

check_base:
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
	cmp BYTE [rsi + r12], 45 ;return si signe + ou - dans base
	je end
	cmp BYTE [rsi + r12], 43 ;return si signe + ou - dans base
	je end
	jmp len

len:
	push rdi ;je save rdi (str) car ma ft_strlen va le prendre en arg
	mov rdi, rsi ; je mets base dans rdi pour que strlen calcule la len de la base
	call _ft_strlen ;renvoie la len dans rax -CHECK SI STRLEN NE CHANGE PAS RCX??
	sub rax, r12
	mov r10, rax ; je mets len dans r10, je lui retire la valeur de r12 si whitespace
	mov rax, 0 ; je remets rax a 0 si pb de len de base, cmme ca ca return 0
	cmp r10, 1 ;si len base == 1
	je end
	pop rdi ; je recup str ;ici si je realigne, segfault??

	mov r13, r12 ;je stocke mon compteur pour la suite
	mov r14, r12 ; je stocke mon compteur une deuxieme fois, pour boucle imbriquee
	jmp check_char_base 

inc_c:
	inc r13
	mov r14, r12
	jmp check_char_base

inc_cc:
	inc r14

check_char_base:
	mov rbx, 0
	mov bl, BYTE [rsi + r13] ;je stocke mon char r13
	cmp bl, 0 ;si fin de rsi sur r13
	je check_sign
	cmp BYTE [rsi + r14], 0 ;si mon r14 == fin, alors j'incremente r13 et je remet r14 a 0
	je inc_c
	cmp r13, r14 ;si egalite des compteurs, normal qu'egalite, donc j'incremente r14
	je inc_cc
	cmp bl, BYTE [rsi + r14] ;je compare le char r13 a char r14, si egalite, erreur
	je end
	jne inc_cc ;si pas egalite, j'incremente r14

neg:
	mov r9, -1
	inc rcx
	jmp init_check_str
pos:
	mov r9, 1
	inc rcx
	jmp init_check_str

pos_no_sign:
	mov r9, 1
	jmp init_check_str

check_sign:
	cmp BYTE [rdi + rcx], 45 ;'-'
	je neg
	cmp BYTE [rdi + rcx], 43 ;'+'
	je pos
	jne pos_no_sign

init_check_str:
	mov r13, rcx ;je stocke mon compteur pour la suite
	mov r14, r12 ; je stocke mon compteur une deuxieme fois, pour boucle imbriquee
	mov r15, 0 ;compteur d'inegalite
	jmp check_str

inc_thirteen:
	inc r13
	mov r14, r12
	mov r15, 0
	jmp check_str

inc_fourteen:
	inc r14
	inc r15 ;si inegalite j'augmente cet indicateur de 1

check_str:
	mov rbx, 0
	mov bl, BYTE [rdi + r13] ;je stocke mon char de ma str r13
	cmp r15, r10 ; si r15 == taille base, ca veut dire que le char n'est pas dans la
	je end
	cmp bl, 0 ;si fin de rsi sur r13
	je comp
	cmp bl, BYTE [rsi + r14] ; comparaison str[r13] et base[r14]
	je inc_thirteen  ;si egalite c'est bon, je passe a r13 suivant
	jne inc_fourteen ;sinon j'augmente r15, et je passe au char r14 suivant de la base

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
	mov rbx, 0 ;pas besoin car movsx
	movsx rbx, BYTE [rdi + rcx] ;sinon mov bl
	add r8, rbx
	mov rbx, 0 ;mais movsx
	movsx rbx, BYTE [rsi + r12] ;idem
	sub r8, rbx
	inc rcx
	jmp comp

end:
	mov rax, r9
	mul r8
	ret


;xor ou exclusif car si je xor la meme chose tout est a 0 acr 1 xor 1 = 0
