# libasm
#brew \
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update 

#nasm \
brew install nasm 

#compiling \
nasm -f macho64 test.s -o test.o \
#macho64 is object file for mac os \

#Prologue \
Passage de paramètres par pile/stack.
RSP : indique l'adresse du sommet de la stack.
La stack est composée de stack frames, pour chaque fonction en cours d'appel avec ses variables locales.
On lit le contenu de la stack frame avec RBP.
//
_global_start :
	push rbp		;fait pointer RBP sur le sommet de la stack - sauvegarde
	mov rbp, rsp
//
The prologue sets-up the stack frame for the function by saving (push) the base
pointer to the stack and moving the base pointer to the top of the stack.
Bonne pratique pour garder trace stack.

#Epilogue \
//
	leave
	ret
//
The epilogue cleans up the stack frame and restores the stack and base
pointers to the pre-call values and jumps to the saved return address.
leave remet la stack à l'état initial -> pop rbp. On récupère rbp.

#Registres \
	- rax :
		-> stocke le retour de la fonction, recupéré par ret
		-> prend le retour d'une fonction appelée après retour de la stack frame, ou d'un syscall
	- rcx : utilisé comme compteur
	- Passage arguments : rdi (arg1), rsi (arg2), rdx (arg3), r8 (arg4), r9 (arg5) - user space calls
	- Pour le kernel : rdi (arg1), rsi (arg2), rdx (arg3), r10 (arg4), r8 (arg5), r9 (arg6) - kernel space calls
		-> pour les sycalls, récupération automatique sans mov jusque 3 arguments. Au-delà, il faut mov les registres.

#Incrémentation, décrémentation
Operateurs inc, dec.

#mov
	- mov : necessite registre de tailles égales
	- movsx : permet de copier un registre de taille inférieure : <movsx rax, dl>

#Jump \
	- jmp -> jump à une adresse sans condition

#Jump conditionnels \
L'indicateur ZF va stocker le retour des commandes cmp ou scasb. ZF est à 1 en cas d'égalité, 0 en cas d'inégalité.
Les jump conditionnels vont vérifier ZF.
	- je : jump if equal (si ZF == 1)
	- jne : jump if not equal (ZF == 0)
	- jz : jump si la valeur comparée est 0, peut importe aue ZF soit à 1 ou 0.
Les jump conditionnels vont changer le registre RIP, qui stocke l'adresse suivante à exécuter.

#Acces à un caractère d'une string - Pointer Directives
	- opérateur BYTE - caste en un octet
Ex :
	cmp BYTE [rdi + rcx], 0  
	je end
rcx etant un compteur qu'on peut incrementer. peut être rax si c'est la valeur incrémentée qu'on souhaite retourner (ex :ft_strlen).

Egalement :
	- Word - 2 bytes
	- DWORD - 4 bytes
	- QWORD - 8 bytes

#SCAS et REP \
Permet de scanner une string byte par byte, avec une condition, sans devoir gérer l'incrémentation.
Mix entre jump conditionnel et BYTE.
Préalable :
	-	le scan va utiliser RCX comme compteur. Il va le décrémenter au lieu de l'incrémenter. On le met donc au maximum (valeur maximum pour un registre 64 bits), en le mettant à 0 puis en inversant tous ses bits (de 0 à 1).
	Ex :
		mov rcx 0
		not rcx
	-	l'indicateur DF - Direction Flag _ spécifie la direction dans laquelle la string sera lue. Il faut le mettre à 0 (en cas de modif préalable) pour qu'elle soit lue de gauche à droite, avec <cld>.
	<cld> met le DF à 0 pour RDI et RSI à la fois.
Scan byte par byte :
	- l'operateur <scasb> prend le premier byte de rdi (sans besoin de le spécifier). Si je veux utiliser rsi ou autre registre, il faut mov dans rdi.
	- l'opérateur repnz(repeat if not zero) : tant que le byte n'est pas egal à 0 (comme pour jz, peu importe valeur de ZF, on regarde la valeur réelle du byte), repeat. 
	Le byte scanné est incrémenté tout seul.
	rcx est décrémenté tout seul.
	Ex:
		< repnz scasb >
Fin:
	- on réinverse rx avec <not> pour avoir la valeur du compteur. 
	On peut la décrémenter si besoin de retirer \0.

Autres opérateurs : 
- scasw (word by word, 2 bytes), scasd (4 bytes at a time). Tjrs sur RDI.
- rep, repe (repeat if equality), repne (repeat if not equlity), repnz (repeat if not zero)

#Faire un syscall \
	- mov dans rax le nb correspondant à l'appel systeme : 0x2000003 read, 0x2000004 read
	- <syscall>
	- le syscall va récupérer tout seul les arguments qui sont dans les registres : rdi (arg1), rsi (arg2), rdx (arg3), r10 (arg4), r8 (arg5), r9 (arg6) - kernel space order, pas le même que le user space order.
	- rax prend le retour du syscall. Pour write ou read, nb de bytes écrites ou lues.

#Appeler une fonction externe \ 
	- déclarer la fonction sous la déclaration de la section.
	Ex :
		section .text
			global _ft_strdup
			extern _ft_strlen
	- Appel : <call _ft_strlen>. Ce call va prendre en argument ce qu'il y a dans rdi, si la fonction prend un argument. Puis rsi si 2 arguments appelés etc.... - Verifier si ordre kernel ou ordre "user application".
	- la fonction return dans rax.
	- Avant d'appeler la fonction qui appelle rdi, si on veut sauver un rdi précédent : push rdi. Puis après appel fonction, pop rdi.
	Ex : voir ft_strdup : 
		- j'appelle strlen, qui renvoie la len à malloc. strlen a pris en parametre rdi, qui contient la string inputée à strdup. 
		- je push rdi sur la stack (car avant l'adresse de la string etait uniquement dans la stack frame) pour garder cette string, puis dans rdi je met la len à malloc, car malloc va prendre en parametre ce qu'il y a dans rdi, et non ce qu'il a dans rax.
		- le malloc return, je pop rdi pour recuperer ma rdi de la stack.
		- rdi sera ma source a copier avec strcpy, je la met dans rsi (arg2) et je met l'adresse returned par malloc dans rdi (arg 1 de strcpy).

#Pratiques \
	- Check if nul :
		cmp	rdi, 0
		je end

#Ressources
- list of x86 instructions : https://c9x.me/x86/
- calling conventions : https://stackoverflow.com/questions/2535989/what-are-the-calling-conventions-for-unix-linux-system-calls-on-i386-and-x86-6
- calling conventions : https://courses.cs.washington.edu/courses/cse378/10au/sections/Section1_recap.pdf 
- jumps : https://www.commentcamarche.net/contents/21-branchements-en-assembleur

