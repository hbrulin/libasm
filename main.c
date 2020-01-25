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
	int ret = ft_strlen(s);
	printf("%i\n", ret);

	char cpy[7];
	ft_strcpy(cpy, s);
	printf("%s\n", cpy);

	ret = ft_strcmp(cpy, s);
	printf("%i\n", ret);

	ret = ft_strcmp("bonjout", s);
	printf("%i\n", ret);

	ft_write(1, "c", 1);
	ft_write(1, "\n", 1);

	int fd = open("ft_strlen.s", O_RDONLY);
	char buf[100];
	ret = ft_read(fd, buf, 10);
	printf("%i\n", ret);
	printf("%s\n", buf);

	char *v = ft_strdup(s);
	printf("%s\n", v);

	ret = ft_atoi_base("ff", "abcdef");
	printf("%i\n", ret);

	t_list	list;
	t_list	list_next;
	t_list	list_last;
	list.data = strdup("toto");
	list.next = &list_next;
	list_next.data = strdup("tata");
	list_next.next = &list_last;
	list_last.data = strdup("tutu");
	list_last.next = NULL;
	printf_list(&list);
	t_list	*push = &list;
	ft_list_push_front(&push, strdup("bonjour"));
	printf("added: `%s` (next: %p)\n", push->data, push->next);
	ft_list_push_front(&push, strdup("salut"));
	printf("added: `%s` (next: %p)\n", push->data, push->next);
	printf_list(&list);
}
