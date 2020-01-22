NAME = libasm.a

SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s

SFLAGS = -f macho64
CFLAGS = -Wall -Werror -Wextra

OBJS =	$(SRCS:.o=.s)

all : $(NAME)

$(NAME): $(OBJ) Makefile
	ar -rc $(NAME) $(OBJS)
	@echo "$(NAME) created"

$(OBJ)/%.o:%.s
	nasm $(SFLAGS) $< $@

clean:
	@/bin/rm -f $(OBJS)
	@echo "Object files deleted"

fclean: clean
	@/bin/rm -f $(NAME)
	@echo "lib deleted"

test:
	gcc $(CFLAGS) main.c $(NAME)

re : 
	@make fclean all

.PHONY: all, clean, fclean, test, re
