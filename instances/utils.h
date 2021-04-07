#ifndef UTILS_H
# define UTILS_H

# include <stdlib.h>
# include <fcntl.h>
# include <stdio.h>
# include <unistd.h>
# include <string.h>
# include "utils.h"

int get_level(int);
//fonction qui recupere le niveau

int create_json(int game, int level);
//cette fonction cree et ouvre un fichier correspondant au bon jeu et au bon level, 
//ecrit la premiere ligne (level = x) et renvoie le file descriptor

int create_file(int game, int level);
//cette fonction cree et ouvre un fichier json correspondant au bon jeu et au bon level, 
// renvoie le filedescriptor

char *ft_itoa(int);
// fonction qui recupere un entier et le met dans une chaine de charactere
// 					/!\ alloue de la memoire

void	putnbr_fd(int n, int fd);
//fonction qui ecrit un entier n dans le fichier fd

#endif
