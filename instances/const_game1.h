#ifndef CONST_GAME1_H
# define CONST_GAME1_H

//number min of buildings
# ifndef BD_MIN
#  define BD_MIN 1
# endif

//number max of buildings
# ifndef BD_MAX
#  define BD_MAX 3
# endif

//number min of clients
# ifndef CLI_MIN
#  define CLI_MIN 2
# endif

//number max of clients
# ifndef CLI_MAX
#  define CLI_MAX 8
# endif

//number min of floors taken by clients
# ifndef FL_MIN
#  define FL_MIN 2
# endif

//number max of floors taken by clients
# ifndef FL_MAX
#  define FL_MAX 5
# endif

//average of benefits gave by clients
# ifndef DEFAULT_MID 
#  define DEFAULT_MID 100
# endif

//deviance of benefits around average
# ifndef DEFAULT_VAR  
#  define DEFAULT_VAR 25
# endif

//starting price min (1st floor price)
# ifndef PRI_MAX 
#  define PRI_MAX 50
# endif

//starting price max (1st floor)
# ifndef PRI_MIN 
#  define PRI_MIN 50
# endif

//incrementation of price minimum between each floor
# ifndef INC_MIN 
#  define INC_MIN  10
# endif

//incrementation of price maximum between each floor
# ifndef INC_MAX 
#  define INC_MAX  25
# endif

#endif
