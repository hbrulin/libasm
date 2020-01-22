#include <stdio.h> //mettre bon header pour size_t

size_t ft_strlen(const char *s);
char *ft_strcpy(char * dst, const char * src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fildes, const void *buf, size_t nbyte);

int main(void)
{
	char *s = "bonjour";
	int i = ft_strlen(s);
	printf("%i\n", i);

	char cpy[7];
	ft_strcpy(cpy, s);
	printf("%s\n", cpy);

	int ret = ft_strcmp(cpy, s);
	printf("%i\n", ret);

	ret = ft_strcmp("bonjout", s);
	printf("%i\n", ret);

	ft_write(1, "c", 1);
}
