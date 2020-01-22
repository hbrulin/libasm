#include <stdio.h>

size_t ft_strlen(const char *s);
char *ft_strcpy(char * dst, const char * src);
int ft_strcmp(const char *s1, const char *s2);

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
}
