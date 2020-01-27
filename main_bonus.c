#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

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
	char *s = "hello";
	char *t = NULL;
	int ret;
	char cpy[7];
	int fd;
	char buf[100];
	char buf2[100];
	char buf3[100];
	char buf4[100];
	char *v;
	t_list *lst;
	t_list *tmp;
	
	lst = NULL;
	v = NULL;

	printf("FT_STRLEN\n");
	ret = ft_strlen(s);
	printf("My strlen does : \n");
	printf("%i\n", ret);
	printf("The real strlen does : \n");
	ret = strlen(s);
	printf("%i\n", ret);

	printf("\n");

	printf("FT_STRCPY\n");
	ft_strcpy(cpy, s);
	printf("%s\n", cpy);

	printf("\n");

	printf("FT_STRCMP_SAME\n");
	printf("My strcmp does : \n");
	ret = ft_strcmp(cpy, s);
	printf("%i\n", ret);
	printf("The real strcmp does : \n");
	ret = strcmp(cpy, s);
	printf("%i\n", ret);

	printf("\n");

	printf("FT_STRCMP_DIFF\n");
	printf("My strcmp does : \n");
	ret = ft_strcmp("bonjout", s);
	printf("%i\n", ret);
	printf("The real strcmp does : \n");
	ret = ft_strcmp("bonjout", s);
	printf("%i\n", ret);

	printf("\n");

	printf("FT_WRITE\n");
	printf("My write does : \n");
	ft_write(1, "c", 1);
	ft_write(1, "\n", 1);
	printf("The real write does : \n");
	write(1, "c", 1);
	write(1, "\n", 1);

	printf("\n");

	printf("FT_READ\n");
	fd = open("ft_strlen.s", O_RDONLY);
	ret = ft_read(fd, buf, 10);
	printf("My read does : \n");
	printf("%i\n", ret);
	printf("%s\n", buf);
	fd = open("ft_strlen.s", O_RDONLY);
	ret = read(fd, buf4, 10);
	printf("The real read does : \n");
	printf("%i\n", ret);
	printf("%s\n", buf4);

	printf("\n");

	printf("FT_STRDUP\n");
	v = ft_strdup(s);
	printf("%s\n", v);

	printf("\n");

	free(v);
	v = NULL;

	printf("FT_STRDUP_NULL_INPUT\n");
	v = ft_strdup(t);
	printf("%s\n", v);

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
	ret = ft_atoi_base("     12", "      0123456789");
	printf("%i\n", ret);

	printf("\n");

	printf("ATOI_BASE_MISSING\n");
	ret = ft_atoi_base("", "abcdef");
	printf("%i\n", ret);

	printf("\n");

	printf("LIST_PUSH_FRONT\n");
	ft_list_push_front(&lst, "blabla");
	ft_list_push_front(&lst, "blibli");
	ft_list_push_front(&lst, "blob");
	printf_list(lst);

	printf("\n");

	printf("PUSH_LIST_SIZE\n");
	ret = ft_list_size(lst);
	printf("list 1 has %i nodes\n", ret);

	while (1);

	return (0);
}
