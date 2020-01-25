section .text
	global _ft_list_push_front
	extern _malloc

_ft_list_push_front:

;argument rdi t_list **begin_list
; arg rsi void *data

;comment par creer un nouveau t_list * avec data -> avec malloc de size_of t_list. ;pas besoin d'element tmp, je peux faire *list = malloc, car je passe un ptr sur ptr
;set element->data a data
;set element->next a NULL.

	push rsp ;align stack

	push rdi; je save rdi car malloc va s'exercer dessus
	mov rdi, 16 ;je malloc de la size de t_list 16
	xor rax, rax
cal:
	call _malloc ;malloc de taille t_list *
	test rax, rax
	jz return
	pop rdi

;en assembleur, si la structure est a l'adresse A, alors le champ data est aussi a A et le champ ptr est a l'adresse A + nb de bits du champ data
	mov [rax], rsi ;je met data dans element->data 
	mov rcx, [rdi] ;dereference le **
	mov [rax + 8], rcx ;list->next = *begin
	mov [rdi], rax ;*begin = new->element

;comment faire une fonction qui return void??
return:
	pop rsp ;align stack
	ret

;QUID SI BGIN_LIST == NULL

