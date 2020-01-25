#include <stdio.h> //mettre bon header pour size_t
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

typedef struct s_list
{
	void	*data;
	struct s_list *next;
}				t_list;


size_t ft_strlen(const char *s);
char *ft_strcpy(char * dst, const char * src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t ft_read(int fildes, void *buf, size_t nbyte);
char *ft_strdup(const char *s1);
int	ft_atoi_base(char *str, char *base);
void ft_list_push_front(t_list **begin_list, void *data);
int ft_list_size(t_list *begin_list);


void printf_list(t_list *list)
{
	while (list)
	{
		printf("%s\n", list->data);
		list = list->next;
	}
}

int main(void)
{
	char *s = "bonjour";
	char *t = NULL;

	printf("FT_STRLEN\n");
	int ret = ft_strlen(s);
	printf("%i\n", ret);

	printf("\n");

	printf("FT_STRCPY\n");
	char cpy[7];
	ft_strcpy(cpy, s);
	printf("%s\n", cpy);

	printf("\n");

	printf("FT_STRCMP_SAME\n");
	ret = ft_strcmp(cpy, s);
	printf("%i\n", ret);

	printf("\n");

	printf("FT_STRCMP_DIFF\n");
	ret = ft_strcmp("bonjout", s);
	printf("%i\n", ret);

	printf("\n");

	printf("FT_WRITE\n");
	ft_write(1, "c", 1);
	ft_write(1, "\n", 1);

	printf("\n");

	printf("FT_READ\n");
	int fd = open("ft_strlen.s", O_RDONLY);
	char buf[100];
	ret = ft_read(fd, buf, 10);
	printf("%i\n", ret);
	printf("%s\n", buf);

	printf("\n");

	printf("FT_STRDUP\n");
	char *v = ft_strdup(s);
	printf("%s\n", v);

	printf("\n");

	printf("FT_STRDUP_NULL_INPUT\n");
	v = ft_strdup(t);
	printf("%s\n", v);

	printf("\n");

	printf("ATOI_BASE\n");
	ret = ft_atoi_base("ff", "abcdef");
	printf("%i\n", ret);

	printf("\n");

	printf("ATOI_BASE_BINAIRE\n");
	ret = ft_atoi_base("0011", "01");
	printf("%i\n", ret);

	printf("\n");

	printf("ATOI_BASE_NEG\n");
	ret = ft_atoi_base("-10", "0123456789");
	printf("%i\n", ret);

	printf("\n");

	printf("ATOI_BASE_WRONG_BASE\n");
	ret = ft_atoi_base("ff", "abcdeff");
	printf("%i\n", ret);

	printf("\n");

	printf("ATOI_BASE_WRONG_STR\n");
	ret = ft_atoi_base("ffg", "abcdef");
	printf("%i\n", ret);

	printf("\n");

	printf("ATOI_BASE_WHITESPACE\n");
	ret = ft_atoi_base("12", "0123456789");
	printf("%i\n", ret);

	printf("\n");

	printf("ATOI_BASE_MISSING\n");
	ret = ft_atoi_base("", "abcdef");
	printf("%i\n", ret);

	printf("\n");

	printf("PUSH_FRONT\n");
	t_list	list;
	t_list	list_next;
	t_list	list_last;
	list.data = strdup("toto");
	list.next = &list_next;
	list_next.data = strdup("tata");
	list_next.next = &list_last;
	list_last.data = strdup("tutu");
	list_last.next = NULL;
	t_list	*push = &list;
	printf("original list :\n");
	printf_list(push);
	ft_list_push_front(&push, s);
	printf("new list :\n");
	printf_list(push);

	printf("\n");

	printf("PUSH_FRONT_NULL_T_LIST\n");
	t_list *nul = NULL;
	ft_list_push_front(&nul, s);
	printf_list(nul);

	printf("\n");

	printf("PUSH_LIST_SIZE\n");
	ret = ft_list_size(push);
	printf("list 1 has %i nodes\n", ret);
	ret = ft_list_size(nul);
	printf("list 2 has %i nodes\n", ret);
}
