#include <stdio.h> //mettre bon header pour size_t
#include <fcntl.h>
#include <unistd.h>

size_t ft_strlen(const char *s);
char *ft_strcpy(char * dst, const char * src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t ft_read(int fildes, void *buf, size_t nbyte);

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

}
