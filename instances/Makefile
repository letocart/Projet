CFLAGS = -Wall -Wextra

SRC = game1.c utils.c

OBJ = $(SRC:.c=.o)

NAME1 = buildings.exe

all : $(NAME1)

$(NAME1) : $(OBJ)
	gcc -o $(NAME1) $(CFLAGS) $(OBJ)

%.o : %.c
	gcc -c $(CFLAGS) $^

clean :
	rm -f $(OBJ)

fclean : clean
	rm -f $(NAME1)

lclean : fclean
	rm -r Buildings_*

re : fclean all
