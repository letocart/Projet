#ifndef GAME1_H
# define GAME1_H

# include "utils.h"
# include <time.h>

//definitions des constantes de creation
//il est possible de les redefinire pendant la compilation avec le tag -D CONST_1=X CONST_2=Y

# ifndef BD_MAX
#  define BD_MAX 3
# endif

# ifndef CLI_MIN
#  define CLI_MIN 2
# endif

# ifndef CLI_MAX
#  define CLI_MAX 8
# endif

# ifndef FL_MIN
#  define FL_MIN 2
# endif

# ifndef FL_MAX
#  define FL_MAX 4
# endif

# define DEFAULT_MID 100
# define DEFAULT_VAR 50
# define DEFAULT_RANGE 20
# define PRI_MAX 10
# define PRI_MIN 50


void nb_buildings(int, char**, int fd1, int fd2);
//fonction qui choisit et ecrit nombre de batiments

int clients(int c, char **v, int fd1, int fd2);
//fonction qui choisit et ecrit le nombre de clients, leurs nombre d'etage et leur valeur.

void floor_prices(int c, char **v, int fd1, int fd2, int max);
//fonction qui choisit et ecrit le prix des differents etages

#endif
