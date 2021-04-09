#ifndef GAME1_H
# define GAME1_H

# include "utils.h"
# include "const_game1.h"
# include <time.h>

void nb_buildings(int, char**, int fd1, int fd2);
//function that write the number of buildings

int clients(int c, char **v, int fd1, int fd2);
//function that writes the number of clients, the number of floor that they takes and their benefits

void floor_prices(int fd1, int fd2, int max);
//function that writes the price of each floor

#endif
