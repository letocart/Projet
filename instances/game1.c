#include "game1.h"

int main(int c, char **v)
{
	int fd1, fd2, level, max;

	srand(time(NULL));
	if (c <= 1)
	{
		printf("Erreur : il faut entrer un num2ro de niveau en 1er argument\n");
		return 1;
	}
	level = atoi(v[1]);
	fd1 = create_file(1, level);
	if (fd1 < 0)
	{
		printf("Erreur lors de la creation du fichier Immeuble_%d\n", level);
		return 1;
	}
	fd2 = create_json(1, level);
	if (fd2 < 0)
	{
		printf("Erreur lors de la creation du fichier Immeuble_%d.json\n", level);
		return 1;
	}
	nb_buildings(c, v, fd1, fd2);
	max = clients(c, v, fd1, fd2);
	floor_prices(c, v, fd1, fd2, max);
	write(fd1, "optimum = ???\n", 14);
	close(fd1);
	write(fd2, "\t\"solutionValue\":???\n}\n", 23);
	close(fd2);
	printf("Niveau Immeuble_%d genere !\n", level);
	return 0;
}

void nb_buildings(int c, char **v, int fd1, int fd2)
{
	int nb_bd;

	nb_bd = -1;
	if (c > 2)
		nb_bd = atoi(v[2]);
	if (nb_bd < 1 || nb_bd > BD_MAX)
		nb_bd = rand() % BD_MAX + 1;

	write(fd1, "buildings_number = ", 19);
	putnbr_fd(nb_bd, fd1);
	write(fd1, "\n", 1);

	write(fd2, "\t\"NumberOfBuildings\":", 21);
	putnbr_fd(nb_bd, fd2);
	write(fd2, ",\n", 2);
}

int clients(int c, char **v, int fd1, int fd2)
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

	write(fd1, "clients_number = ", 17);
	putnbr_fd(nb_cli, fd1);
	write(fd1, "\n", 1);

	//partie qui s'occupe de la taille des clients (et calcule la taille max de chaque immeuble)
	max = 0;
	write(fd1, "clients_floors = [", 18);
	write(fd2, "\t\"requestsOfFloorsFromClients\":[", 32);
	for (i = 0; i < nb_cli; i++)
	{
		if (i)
		{
			write(fd1, " ", 1);
			write(fd2, ", ", 2);
		}
		fl_cli[i] = rand() % (FL_MAX - FL_MIN + 1) + FL_MIN;
		max += fl_cli[i];
		putnbr_fd(fl_cli[i], fd1);
		putnbr_fd(fl_cli[i], fd2);
	}
	write(fd1, "]\n", 2);
	write(fd2, "],\n", 3);

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
	write(fd1, "clients_gains = [", 17);
	write(fd2, "\t\"earningsFromClients\":[", 24);
	for (i = 0; i < nb_cli; i++)
	{
		if (i)
		{
			write(fd1, " ", 1);
			write(fd2, ", ", 2);
		}
		gain = rand() % (2 * var + 1) + (fl_cli[i] * mid - var);
		if (gain < 0)
			gain = 0;
		putnbr_fd(gain, fd1);
		putnbr_fd(gain, fd2);
	}
	write(fd1, "]\n", 2);
	write(fd2, "],\n", 3);

	//affiche le max d'etages
	write(fd1, "building_max_size = ", 20);
	putnbr_fd(max, fd1);
	write(fd1, "\n", 1);

	write(fd2, "\t\"maxHeight\":", 13);
	putnbr_fd(max, fd2);
	write(fd2, ",\n", 2);
	return max;
}

void floor_prices(int c, char **v, int fd1, int fd2, int max)
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
	write(fd1, "floor_prices = [", 16);
	write(fd2, "\t\"pricesOfFloors\":[", 19);
	for (i = 0; i < max; i++)
	{
		if (i)
		{
			write(fd1, " ", 1);
			write(fd2, ", ", 2);
		}
		price += rand() % range;
		putnbr_fd(price, fd1);
		putnbr_fd(price, fd2);
	}
	write(fd1, "]\n", 2);
	write(fd2, "],\n", 3);
}
