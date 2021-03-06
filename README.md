# libasm
<strong>#brew</strong> \
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update 

<strong>#nasm</strong> \
brew install nasm 

<strong>#compiling</strong> \
nasm -f macho64 test.s -o test.o \
macho64 is object file for mac os 

<strong>#Prologue</strong> \
Passage de paramètres par pile/stack. \
RSP : indique l'adresse du sommet de la stack. \
La stack est composée de stack frames, pour chaque fonction en cours d'appel avec ses variables locales. \
On lit le contenu de la stack frame avec RBP. 
```asm
_global_start : 
	push rbp		;fait pointer RBP sur le sommet de la stack - sauvegarde 
	mov rbp, rsp 
```
The prologue sets-up the stack frame for the function by saving (push) the base \
pointer to the stack and moving the base pointer to the top of the stack. \
Bonne pratique pour garder trace stack. 

<strong>#Epilogue</strong> 
```asm
	leave 
	ret 
```
The epilogue cleans up the stack frame and restores the stack and base pointers to the pre-call values and jumps to the saved return address. \
leave remet la stack à l'état initial -> pop rbp. On récupère rbp.

<strong>#Registres</strong> \
	- rax : \
		-> stocke le retour de la fonction, recupéré par ret \
		-> prend le retour d'une fonction appelée après retour de la stack frame, ou d'un syscall \
	- rcx : utilisé comme compteur \
	- Passage arguments : rdi (arg1), rsi (arg2), rdx (arg3), r8 (arg4), r9 (arg5) - user space calls \
	- Pour le kernel : rdi (arg1), rsi (arg2), rdx (arg3), r10 (arg4), r8 (arg5), r9 (arg6) - kernel space calls \
		-> pour les sycalls, récupération automatique sans mov jusque 3 arguments. Au-delà, il faut mov les registres. 

<strong>#Incrémentation, décrémentation</strong> \
Operateurs inc, dec.

<strong>#Déréférencer un pointeur</strong>
```asm
[rsi]
```

<strong>#mov</strong> \
	- mov : necessite registre de tailles égales \
	- movsx/movzx : permet de copier un registre de taille inférieure : <code> movsx rax, dl </code> 
	movsx mets a 0 les bits non existants dans le registre de taille inferieur. Permet de ne pas avoir a mov 0 (out xor registre, registre), car tout est set a 0.
	- alternative a mov R, 0 : xor R, R. OU EXCLUSIF : 1 xor 1 = 0. Mettre le meme registre va tout setter à 0. Operation plus rapide qu'un mov à 0.
<strong>#Jump</strong> \
	- jmp -> jump à une adresse sans condition. Utile pour eviter de passer par certaines adresses d'incrementation.

<strong>#Jump conditionnels</strong> \
L'indicateur ZF va stocker le retour des commandes cmp ou scasb. ZF est à 1 en cas d'égalité, 0 en cas d'inégalité. \
Les jump conditionnels vont vérifier ZF. \
	- je : jump if equal (si ZF == 1) \
	- jne : jump if not equal (ZF == 0) \
	- jz : jump si la valeur comparée est 0, peut importe aue ZF soit à 1 ou 0. \
Les jump conditionnels vont changer le registre RIP, qui stocke l'adresse suivante à exécuter.

<strong>Jumps +  condition d'infériorité/supériorité</strong>
- Non signé :
		- JA : est supérieur (a > b). \
		- JAE ou JNB ou JNC : est supérieur ou égal (a => b). \
		- JB ou JC : est inférieur (a < b). \
		- JBE : est inférieur ou égal (a <= b). 
- Signé :
		- JG : est supérieur (a > b). \
		- JGE : est supérieur ou égal (a => b). \
		- JL : est inférieur (a < b). \
		- JLE : est inférieur ou égal (a <= b).

<strong>#Acces à un caractère d'une string - Pointer Directives</strong> \
	- opérateur BYTE - caste en un octet \
Ex : 
```asm
	cmp BYTE [rdi + rcx], 0 
	je end 
```
rcx etant un compteur qu'on peut incrementer. peut être rax si c'est la valeur incrémentée qu'on souhaite retourner (ex :ft_strlen). 

Egalement : \
	- Word - 2 bytes \
	- DWORD - 4 bytes \
	- QWORD - 8 bytes -> utile pour aller de 8 en 8, exemple pour une liste chainee

<strong>#SCAS et REP</strong> \
Permet de scanner une string byte par byte, avec une condition, sans devoir gérer l'incrémentation. \
Mix entre jump conditionnel et BYTE. \
Préalable : \
	-	le scan va utiliser RCX comme compteur. Il va le décrémenter au lieu de l'incrémenter. On le met donc au maximum (valeur maximum pour un registre 64 bits), en le mettant à 0 puis en inversant tous ses bits (de 0 à 1). \
	Ex : 
```asm
	mov rcx 0 
	not rcx 
```
-	l'indicateur DF - Direction Flag _ spécifie la direction dans laquelle la string sera lue. Il faut le mettre à 0 (en cas de modif préalable) pour qu'elle soit lue de gauche à droite, avec 'cld'. \
	'cld' met le DF à 0 pour RDI et RSI à la fois. \

Scan byte par byte : \
	- l'operateur 'scasb' prend le premier byte de rdi (sans besoin de le spécifier). Si je veux utiliser rsi ou autre registre, il faut mov dans rdi. \
	- l'opérateur 'repnz'(repeat if not zero) : tant que le byte n'est pas egal à 0 (comme pour jz, peu importe valeur de ZF, on regarde la valeur réelle du byte), repeat. \
	Le byte scanné est incrémenté tout seul. \
	rcx est décrémenté tout seul. \
	Ex: 
```asm
	repnz scasb
```
Fin: \
	- on réinverse rcx avec 'not' pour avoir la valeur du compteur. \
	On peut la décrémenter si besoin de retirer \0. 

Autres opérateurs : 
- scasw (word by word, 2 bytes), scasd (4 bytes at a time). Tjrs sur RDI. \
- rep, repe (repeat if equality), repne (repeat if not equlity), repnz (repeat if not zero) 

<strong>#Faire un syscall</strong> \
	- mov dans rax le nb correspondant à l'appel systeme : 0x2000003 read, 0x2000004 write \
	- 'syscall' \
	- le syscall va récupérer tout seul les arguments qui sont dans les registres : rdi (arg1), rsi (arg2), rdx (arg3), r10 (arg4), r8 (arg5), r9 (arg6) - kernel space order, pas le même que le user space order. \
	- rax prend le retour du syscall. Pour write ou read, nb de bytes écrites ou lues. 

<strong>#Appeler une fonction externe</strong> \
	- déclarer la fonction sous la déclaration de la section. \
	Ex : 
```asm
	section .text 
		global _ft_strdup 
		extern _ft_strlen 
```
- Appel : 'call _ft_strlen'. Ce call va prendre en argument ce qu'il y a dans rdi, si la fonction prend un argument. Puis rsi si 2 arguments appelés etc.... - Verifier si ordre kernel ou ordre "user application". 
- la fonction return dans rax. 
- Avant d'appeler la fonction qui appelle rdi, si on veut sauver un rdi précédent : push rdi. Puis après appel fonction, pop rdi. 
Ex : voir ft_strdup :  
	- j'appelle strlen, qui renvoie la len à malloc. strlen a pris en parametre rdi, qui contient la string inputée à strdup. 
	- je push rdi sur la stack (car avant l'adresse de la string etait uniquement dans la stack frame) pour garder cette string, puis dans rdi je met la len à malloc, car malloc va prendre en parametre ce qu'il y a dans rdi, et non ce qu'il a dans rax. 
	- le malloc return, je pop rdi pour recuperer ma rdi de la stack. 
	- rdi sera ma source a copier avec strcpy, je la met dans rsi (arg2) et je met l'adresse returned par malloc dans rdi (arg 1 de strcpy). 
	Si je ne le fais pas, il peut y avoir apres des fails de malloc.
	- Note : si je push rdi pour le sauver, je le push sur la stack. Quand je le pop, je peux le pop dans rsi. Je ne suis pas obliger de pop en utilisant le meme registre. Je peux pop ce que j'ai push n'importe où.

ATTENTION : en appelant une fonction, certains registres peuvent etre modifies : scratch registers. D'autres sont préservés : preserved registers.
Il faut push pop les scratch registers avant l'appel d'une fonction, sinon leur contenu peut être modifié. \
Preserved Registers	==> rbx	rsp	rbp	r12	r13	r14	r15		\
Scratch Registers	==> rax	rdi	rsi	rdx	rcx	r8	r9	r10	r11

<strong>#mul</strong> 
- mul multiplie le registre qui lui est passé en arg par ce qui est dans al. 
Ex:
```asm
	mov rax, 5
	mul rdi
```
-> rdi est multiplié par 5.
Le résultat est envoyé dans rax.

<strong>#Sections data et bss</strong> 
- BSS :global variables et objets statiques non initialisés en entrant dans le main : à 0.
- DATA : utilisée pour réserver de l'espace pour les objects statiques ou global variables initialisés.

```asm
unsigned char var;		; 8 bit variable uninitialized variable allocated into the .bss section.
static int svar;		; 16 bit static uninitialized variable allocated into the .bss section.

unsigned char var2 = 25;	; 8 bit initialized variable allocated into the .data section.
static unsigned int svar2 = 3;	; 16 bit initialized variable allocated into the .data section.
```

<strong>#Heap vs stack</strong>  \
Heap variables are simply those that aren't in your stack frames. You can use any register to access them. \
Heap use with malloc. \
RSP and RBP both point to adresses on the stack : RSP points to top of stack. RBP points to the bottom of the stack frame. \
Usually RBP is not necessary so you can use it as another general purpose processor. \
The entire memory is organized into 4 segments. Code, Data, Stack and Extra. The heap is for multipurpose storage (like dynamic allocation (malloc etc)) while stack is used specifically for instruction pointer and for storing your variables (push) when you call another procedure/function (like during recursion). The data segment is for global variables and static variables.

<strong>#Pratiques</strong> \
	- Check if nul : 
```asm
	cmp	rdi, 0 
	je end 
```

	- Tester le malloc fail:
```asm
	call _malloc
	test rax, rax ;je test rax (utile de test plutot que cmp si juste besoin de savoir si jz)
	jz return ;si le return de malloc est 0, alors return
```

<strong>#Notes sur mon atoi_base :</strong> avant d'utiliser r10, r11, r12, je ne push pas ces registres. Donc pb s'ils sont déjà utilisés par un programme tiers, qui perd sa data.
Il y a les registres utilisé en paramètres qui sont à sauver par l’appelant s’il veut les garder, et des registres a sauver par l’appelé s’il veut les utiliser, pour ne par faire planter l'appelant.
RDI RSI RDX RCX R8 R9 c’est a la fonction appelante de sauver.
RBP RBX R12 R13 R14 R15 c’est a la fonction appelée de sauver.

<strong>#Ressources</strong> 
- list of x86 instructions : https://c9x.me/x86/ \
- calling conventions : https://stackoverflow.com/questions/2535989/what-are-the-calling-conventions-for-unix-linux-system-calls-on-i386-and-x86-6 \
- calling conventions : https://courses.cs.washington.edu/courses/cse378/10au/sections/Section1_recap.pdf \
- jumps : https://www.commentcamarche.net/contents/21-branchements-en-assembleur 
- https://asm.developpez.com/intro/ 
- heap vs stack : https://stackoverflow.com/questions/13016736/assembly-stack-vs-heap , https://stackoverflow.com/questions/6204834/heap-vs-data-segment-vs-stack-allocation 
- linked lists : https://codehost.wordpress.com/2011/07/29/59/
- https://github.com/agavrel/LibftASM
<strong>#Notes</strong> 
- list_remove_if ne marche pas
- atoi_base : pb si whitespace avant une base binaire.
