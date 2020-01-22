section.text
	global _ft_strlen

_ft_strlen:
	;passage de param par pile (stack) -> RSP sert a indiquer l'adresse du sommet d'une pile. La pile est composee de cadres de pile, ou stack frames, piur chaque fonction en cours d'appel avec ses variables locales.
	;on lit le contenu de la pile grace a un registre special : BP ->pour stack frame
	;MOV BP, SP fait pointer BP sur le sommet de la stack
	; commencer par push rbp, puis mov rbp, rsp
	mov rax, 0 ;c'est mon i qui va etre incremente
	cmp	rdi, 0					; !rdi
	je end
	;RDI registre qui stocke le premier argument d'une fonction
	;indicateur ZF = 1 si egalite. ZF permet de savoir si le resultat de ;a derniere operation etait nul.
;mettre increment avant sinon ne marche pas, car alors RPI va a end et pas a comp
inc:
	inc rax
comp:
	cmp BYTE [rdi + rax], 0  ;byte caste en un octet
	jne inc;jump if not equal, saute a l'adresse si ZF = 0, ca s'arrete si ZF = 1
	;jump adresse, RIP contient alors adresse, registre RIP indique adresse suivante a executer
end:
	ret
;je return ce qui est dans RAX, calling convention
;le vrai strlen return-til 0 si ligne NULL?

;check stack frame, leave + ret
;section data vs section bss
