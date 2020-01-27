#include <stdio.h> 
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

size_t		ft_strlen(const char *s);
char		*ft_strcpy(char * dst, const char * src);
int			ft_strcmp(const char *s1, const char *s2);
ssize_t		ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t		ft_read(int fildes, void *buf, size_t nbyte);
char		*ft_strdup(const char *s1);

int main(void)
{
	char	*s = "bonjour";
	int		ret;
	char	cpy[7];
	int		fd;
	char	buf[100];
	char	buf2[100];
	char	buf3[100];
	char	buf4[100];
	char	buf5[100];
	char	buf6[100];
	char	*v;

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
	ft_write(1, "", 1);
	printf("The real write does : \n");
	write(1, "c", 1);
	write(1, "\n", 1);
	write(1, "", 1);

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

	printf("FT_READ_WRONG_FD\n");
	fd = open("ft_strlen.", O_RDONLY);
	ret = ft_read(fd, buf5, 10);
	printf("My read does : \n");
	printf("%i\n", ret);
	printf("%s\n", buf5);
	fd = open("ft_strlen.", O_RDONLY);
	ret = read(fd, buf6, 10);
	printf("The real read does : \n");
	printf("%i\n", ret);
	printf("%s\n", buf6);

	printf("\n");

	/*printf("FT_READ_STDIN\n");
	ret = ft_read(STDIN_FILENO, buf2, 10);
	printf("My read does : \n");
	printf("%i\n", ret);
	printf("%s\n", buf2);
	printf("\n");
	ret = read(STDIN_FILENO, buf3, 10);
	printf("The real read does : \n");
	printf("%i\n", ret);
	printf("%s\n", buf3);

	printf("\n");*/

	printf("FT_STRDUP\n");
	v = ft_strdup(s);
	printf("%s\n", v);

	free(v);
	v = NULL;

	return (0);
}
