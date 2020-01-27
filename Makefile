NAME = libasm.a

SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
SRCS_BONUS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s \
	ft_strdup.s ft_atoi_base_bonus.s ft_list_push_front_bonus.s \
	ft_list_size_bonus.s

SFLAGS = -f macho64
CFLAGS = -Wall -Werror -Wextra -g

OBJS =	$(SRCS:.s=.o)
OBJS_BONUS = $(SRCS_BONUS:.s=.o)

all : $(NAME)

$(NAME): $(OBJS) Makefile
	ar rcs $(NAME) $(OBJS)
	@echo "$(NAME) created"

bonus: $(OBJS_BONUS) Makefile
	ar rcs $(NAME) $(OBJS_BONUS)
	@echo "$(NAME) created"

%.o: %.s
	nasm $(SFLAGS) $< -o $@ -g

clean:
	@/bin/rm -f $(OBJS)
	@echo "Object files deleted"

fclean: clean
	@/bin/rm -f $(NAME)
	@echo "lib deleted"

test:
	gcc -c main.c
	gcc $(CFLAGS) main.o $(NAME)

test_bonus:
	gcc -c main_bonus.c
	gcc $(CFLAGS) main_bonus.o $(NAME)

clean_bonus:
	@/bin/rm -f $(OBJS_BONUS)
	@echo "Object files deleted"

fclean_bonus: clean_bonus
	@/bin/rm -f $(NAME)
	@echo "lib deleted"

re : 
	@make fclean all

re_bonus : 
	@make fclean_bonus all

.PHONY: all, clean, fclean, test, re, bonus, tes_bonus, clean_bonus, fclean_bonus, re_bonus
