CFLAGS = -Wall -Wextra

SRC = game1.c utils.c

OBJ = $(SRC:.c=.o)

NAME = buildings.exe

all : $(NAME)

$(NAME) : $(OBJ)
	gcc -o $(NAME) $(CFLAGS) $(OBJ)

%.o : %.c
	gcc -c $(CFLAGS) $^

clean :
	rm -f $(OBJ)

fclean : clean
	rm -f $(NAME)

re : fclean all
