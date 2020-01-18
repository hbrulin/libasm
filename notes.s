
;dire a nasm ou sera stocke le programme, avec une directive, pour que nasm puisse trouver les differents donnes du code en incrementant a partir de la
org 0x0100 ;pas besoin de ca sous linux, seulement DOS

;mov : indique que l'on va affecter a un registre une valeur.
;1er parametre un registre, le deuxieme un registre ou un nombre. Interdit si nb differents de bits dans un registre : ax-bl
;nb de combinaison de valeurs diff selon ah, al, ax, eax

mov ax, 53 ;ax contient la valeur 53
mov bx, ax ;

;inserer un octet de donnees 
db 45 ;00101101, 2D
;inserer un mot ou double-mot
dw 45 ;00101101 00000000, 2D00 - 2 octets, les 2 sont intervertis en binaire (l'octet de poids fort est a droite)
dd 12000000 - 4 octets

;caracteres
db "A"
mov AX, "CU" ;2 caracteres dans un registre 16bits
mov BH, "U" ;1 seul registre 8bits

db "Hello, World !" ;marche, attribue un octet a chaque lettre

;pour reperer un endroit du programme, on utilise une etiquette 
etiquette:
mov ax, bx

donnee: 
db 47

mov dx, donnee ;une etiquette est une valeur immediate, pas besoin d'attendre l'execution, on peut l'utiliser avant de la definir

;interruption
int 0x21 ;effectue une action en fonction de ce qu'on a mis dans AH. Si on y met 0x09, cela correspond pour l'interruption 0x21 a un affichage de texte.
;ceci prend en entree une adresse, une etiquette, a travers dx, et l'affiche
mov  dx, texte
mov  ah, 0x09
int  0x21      
ret            
texte: db 'Hello, World !!', 10, 13, '$'
