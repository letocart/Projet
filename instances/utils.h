#ifndef UTILS_H
# define UTILS_H

# include <stdlib.h>
# include <fcntl.h>
# include <stdio.h>
# include <unistd.h>
# include <string.h>
# include "utils.h"

int create_json(int game, int level);
//this function create the json file and returns it's file descriptor

int create_file(int game, int level);
//this function create the solvable file and returns it's file descriptor

char *ft_itoa(int);
//this function takes an integer and returns the same integer but in a string
// 					/!\ use dynamical allocation

void	putnbr_fd(int n, int fd);
//this function write a number in the file fd

#endif
