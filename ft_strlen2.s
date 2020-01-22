section .text
	global _ft_strlen

_ft_strlen:

	mov rcx 0
	not rcx ;car rcx est decremente avec le scan
	cld ;met le DF direction flag a 0, pour specifier dans quel sens lire la string dans rdi ( et rsi en emem temps)
	repnz scasb    ;scasb prend le premier byte de rdi tout seul, pas besoin de specifier rdi car l'appel se fait dessus. si je veux m'en servir sur autre registre, je mets ce registre dans rdi
					;repnz : tant que le byte n'est pas egal a 0, repeat le scan. ca s'incremente tout seul. et decremente rcx tout seul.
	not rcx ; j'inverse
	dec rcx ;je decremente pour retirer le \0
	mov rax, rcx ;

	ret
