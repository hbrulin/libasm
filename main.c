#include <stdio.h> //mettre bon header pour size_t
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

size_t ft_strlen(const char *s);
char *ft_strcpy(char * dst, const char * src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t ft_read(int fildes, void *buf, size_t nbyte);
char *ft_strdup(const char *s1);

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

	printf("FT_READ_STDIN\n");
	//fd = open(STDIN_FILENO, O_RDONLY);
	char buf2[100];
	ret = ft_read(STDIN_FILENO, buf2, 10);
	printf("My read does : \n");
	printf("%i\n", ret);
	printf("%s\n", buf2);
	printf("\n");
	char buf3[100];
	ret = read(STDIN_FILENO, buf3, 10);
	printf("The real read does : \n");
	printf("%i\n", ret);
	printf("%s\n", buf3);

	printf("\n");

	printf("FT_STRDUP\n");
	char *v = ft_strdup(s);
	printf("%s\n", v);

	printf("\n");

	printf("FT_STRDUP_NULL_INPUT\n");
	v = ft_strdup(t);
	printf("%s\n", v);

	return (0);
}
