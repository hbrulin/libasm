section .text
	global _ft_strcmp

_ft_strcmp:
	mov rax, 0 ;return
	mov rcx, 0 ;i = 0, rcx registre de compteur
	mov rdx, 0 ;tmp

increment:
	inc rcx

comp:
	mov dl, BYTE [rdi + rcx]
	cmp dl, 0
	je return ;si fin de s1, on return
	mov dh, BYTE [rsi + rcx]
	cmp dh, 0
	je return ;si fin de s2, on return
	cmp dl, dh
	je increment ;saut si ZF = 1, donc egalite
	jz calc ;si ZF = 0, pas d'egalite
	;last char : pas besoin

calc:
	sub dl, dh
	movsx rax, dl ;instruction qui permet de copier un registre de taille inf

return:
	ret
