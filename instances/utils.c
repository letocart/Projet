#include "utils.h"

int		int_len(int n)
{
	int	i;

	if (n == 0)
		return (1);
	i = 0;
	if (n < 0)
		i++;
	while (n != 0)
	{
		n = n / 10;
		i++;
	}
	return (i);
}

int create_json(int game, int level)
{
	char *name;
	char *str_level;
	int len;
	int fd;

	/*creation du nom de fichier*/
	if (game == 1)
		len = 9 + 5;
	len += int_len(level);
	if ((name = (char*)malloc(sizeof(char) * (len + 1))) == NULL)
		return (-1);
	if ((str_level = (ft_itoa(level))) == NULL)
		return -1;
	if (game == 1)
	{
		strncpy(name, "Immeuble_", 9);
		strncpy(name + 9, str_level, strlen(str_level));
		strncpy(name + 9 + int_len(level), ".json", 5);
		name[len] = 0;
	}
	free(str_level);
	
	/*création du fichier*/
	fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
	free(name);
	if (fd >= 0)
		write(fd, "{\n", 2);
	return fd;
}

int create_file(int game, int level)
{
	char *name;
	char *str_level;
	int len;
	int fd;

	/*creation du nom du fichier*/
	if (game == 1)
		len = 9;
	len += int_len(level);
	if ((name = (char*)malloc(sizeof(char) * (len + 1))) == NULL)
		return (-1);
	if ((str_level = (ft_itoa(level))) == NULL)
		return -1;
	if (game == 1)
	{
		strncpy(name, "Immeuble_", 9);
		strncpy(name + 9, str_level, strlen(str_level));
		name[len] = 0;
	}
	free(str_level);
	
	/*creation du fichier*/
	fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
	free(name);
	if (fd >= 0)
	{
		write(fd, "level = ", 8);
		putnbr_fd(level, fd);
		write(fd, "\n", 1);
	}
	return fd;
}



void	gestion_min(char *c, int *i, int *n)
{
	c[*i - 1] = '8';
	*n = *n / 10;
	*i = *i - 1;
}

char	*ft_itoa(int n)
{
	char	*c;
	int		i;

	i = int_len(n);
	if ((c = (char*)malloc(sizeof(char) * (i + 1))) == NULL)
		return (NULL);
	c[i] = '\0';
	if (n == -2147483648)
		gestion_min(c, &i, &n);
	if (n == 0)
		c[0] = '0';
	if (n < 0)
	{
		c[0] = '-';
		n = n * (-1);
	}
	while (n != 0)
	{
		c[i - 1] = '0' + (n % 10);
		n = n / 10;
		i--;
	}
	return (c);
}


void	putnbr_fd(int n, int fd)
{
	unsigned int nb;
	char c;

	if (n < 0)
	{
		write(fd, "-", 1);
		nb = -n;
	}
	else
		nb = n;
	if (nb == 2147483648)
		write(fd, "2147483648", 10);
	else if (nb >= 10)
	{
		putnbr_fd(nb / 10, fd);
		c = nb % 10 + '0';
		write(fd, &c, 1);
	}
	else
	{
		c = nb % 10 + '0';
		write(fd, &c, 1);
	}
}
