#include <stdio.h>

int	ft_strlen(char *s);
char *ft_strcpy(char *dst, char *src);

int main(void)
{
	char *s = "bonjour";
	int i = ft_strlen(s);
	printf("%i\n", i);

	char cpy[7];
	ft_strcpy(cpy, s);
	printf("%s\n", cpy);
}
