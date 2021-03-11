#include "game1.h"

int main(int c, char **v)
{
	int fd, level, max;

	srand(time(NULL));

	level = (c > 1 ? atoi(v[1]) : -1);
	if (level < 0)
		level = get_level(1);
	fd = create_file(1, level);
	if (fd < 0)
	{
		printf("Erreur lors de la creation du fichier Immeuble_%d\n", level);
		return 1;
	}
	nb_buildings(c, v, fd);
	max = clients(c, v, fd);
	floor_prices(c, v, fd, max);
	write(fd, "optimum = ???\n", 14);
	close(fd);
	printf("Niveau Immeuble_%d genere !\n", level);
	return 0;
}

void nb_buildings(int c, char **v, int fd)
{
	int nb_bd;

	nb_bd = -1;
	if (c > 2)
		nb_bd = atoi(v[2]);
	if (nb_bd < 1 || nb_bd > BD_MAX)
		nb_bd = rand() % BD_MAX + 1;
	write(fd, "buildings_number = ", 19);
	putnbr_fd(nb_bd, fd);
	write(fd, "\n", 1);
}

int clients(int c, char **v, int fd)
{
	int nb_cli;							//nombre de clients
	int fl_cli[CLI_MAX - CLI_MIN + 1];	//etages de chaque client
	int mid;							//le gain de chaque client varira
	int var;							//dans une porte de var autour de mid
	int max;							//nombre max d'etage de chaque immeuble
	int gain;
	int i;


	//partie qui s'occupe du nombre de clients
	nb_cli = -1;
	if (c > 3)
		nb_cli = atoi(v[3]);
	if (nb_cli < CLI_MIN || nb_cli > CLI_MAX)
		nb_cli = rand() % (CLI_MAX - CLI_MIN + 1) + CLI_MIN;
	write(fd, "clients_number = ", 17);
	putnbr_fd(nb_cli, fd);
	write(fd, "\n", 1);

	//partie qui s'occupe de la taille des clients (et calcule la taille max de chaque immeuble)
	max = 0;
	write(fd, "clients_floors = [", 18);
	for (i = 0; i < nb_cli; i++)
	{
		if (i)
			write(fd, " ", 1);
		fl_cli[i] = rand() % (FL_MAX - FL_MIN + 1) + FL_MIN;
		max += fl_cli[i];
		putnbr_fd(fl_cli[i], fd);
	}
	write(fd, "]\n", 2);

	//partie qui s'occupe des gains des clients
	mid = -1;
	var = -1;
	if (c > 4)
		mid = atoi(v[4]);
	if (c > 5)
		var = atoi(v[5]);
	if (mid <= 0)
		mid = DEFAULT_MID;
	if (var < 0)
		var = DEFAULT_VAR;
	write(fd, "clients_gains = [", 17);
	for (i = 0; i < nb_cli; i++)
	{
		if (i)
			write(fd, " ", 1);
		gain = rand() % (2 * var + 1) + (fl_cli[i] * mid - var);
		if (gain < 0)
			gain = 0;
		putnbr_fd(gain, fd);
	}
	write(fd, "]\n", 2);

	//affiche le max d'etages
	write(fd, "building_max_size = ", 20);
	putnbr_fd(max, fd);
	write(fd, "\n", 1);

	return max;
}

void floor_prices(int c, char **v, int fd, int max)
{
	int price;
	int range;
	int i;

	price = -1;
	range = -1;
	if (c > 6)
		price = atoi(v[6]);
	if (c > 7)
		range = atoi(v[7]);
	if (price < 0)
		price = rand() % (PRI_MAX - PRI_MIN + 1) + PRI_MIN;
	if (range < 0)
		range = DEFAULT_RANGE;
	write(fd, "floor_prices = [", 16);
	for (i = 0; i < max; i++)
	{
		if (i)
			write(fd, " ", 1);
		price += rand() % range;
		putnbr_fd(price, fd);
	}
	write(fd, "]\n", 2);
}
