section.text
	global _ft_strlen

_ft_strlen:
	mov RAX, 0 ;c'est mon i qui va etre incremente

	;RDI registre qui stocke le premier argument d'une fonction
	;indicateur ZF = 1 si egalite. ZF permet de savoir si le resultat de ;a derniere operation etait nul.
	CMP RDI, 0 ;quel registre contient le result de ma comparaison, comment comparer mon char et l'incrementer?
	JNE adress;jump if not equal, saute a l'adresse si ZF = 0, ca s'arrete si ZF = 1
	;jump adresse, RIP contient alors adresse, registre RIP indique adresse suivante a executer
adress:
	INC RAX
end:
	ret
;je return ce qui est dans RAX, calling convention
;check stack frame, leave + ret

;section data vs section bss
