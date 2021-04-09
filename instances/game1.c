#include "game1.h"

// arguments taked by the executable explained in the header (game1.h)

int main(int c, char **v)
{
	/*fd1 : file descriptor of the file used to fill the solver
	  fd2 : file descriptor of the json file
	  level : number of the level generated, used to provide different names to file created
	  max : the number of max floor of buildings in the instance created*/
	int fd1, fd2, level, max;

	srand(time(NULL));
	if (c <= 1)
	{
		printf("Error : fill first agrument as the number of the level\n");
		return 1;
	}
	level = atoi(v[1]);
	fd1 = create_file(1, level);
	if (fd1 < 0)
	{
		printf("Error : creation of Building_%d failed\n", level);
		return 1;
	}
	fd2 = create_json(1, level);
	if (fd2 < 0)
	{
		printf("Error : creation of Building_%d.json failed\n", level);
		return 1;
	}
	nb_buildings(c, v, fd1, fd2);
	max = clients(c, v, fd1, fd2);
	floor_prices(c, v, fd1, fd2, max);
	write(fd1, "optimum = ???\n", 14);
	close(fd1);
	write(fd2, "\t\"solutionValue\":???\n}\n", 23);
	close(fd2);
	printf("Building_%d and Building_%d.json generated !\n", level);
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
	int nb_cli;							//number of clients
	int fl_cli[CLI_MAX - CLI_MIN + 1];				//floors taken by each client
	int mid;							//average of clients gains
	int var;							//range of deviance of client gains around mid
	int max;							//number max floors of buildings 
	int gain;
	int i;


	//this part takes care of the number of clients. if you want to choose them, enter the number as the 3rd argument
	//be aware that you can change the number min and max of client by editing the header or by compiling with -d flags
	nb_cli = -1;
	if (c > 3)
		nb_cli = atoi(v[3]);
	if (nb_cli < CLI_MIN || nb_cli > CLI_MAX)
		nb_cli = rand() % (CLI_MAX - CLI_MIN + 1) + CLI_MIN;

	write(fd1, "clients_number = ", 17);
	putnbr_fd(nb_cli, fd1);
	write(fd1, "\n", 1);

	//this part takes care about the number of floors taken by clients (and the number max)
	//the numbers min and max of the size that can be taken by client can be modified with the header or -d flags during compilation
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

	//this part takes care of the benefits created by each client
	//you can choose the average and deviance by using the 4th and 5th arguments, or by editing the header
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

	//printing the max size of buildings in files
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
	int price;			//starting price, price of the 1s floor
	int range;			//the each floor cost will be calculated with : price of the floor under him + MIN_UPDATE + random number between 0 and range
	int i;

	//you can change the min and max of the price of the 1st floor with the header, the default range and minimum update of each cost with the header
	price = rand() % (PRI_MAX - PRI_MIN + 1) + PRI_MIN;
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
		price += (rand() % range) + MIN_UPDATE;
		putnbr_fd(price, fd1);
		putnbr_fd(price, fd2);
	}
	write(fd1, "]\n", 2);
	write(fd2, "],\n", 3);
}
