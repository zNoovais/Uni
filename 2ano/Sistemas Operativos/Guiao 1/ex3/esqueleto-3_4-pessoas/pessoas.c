#include <stdio.h>
#include <string.h>
#include "person.h"


int main(int argc, char* argv[]){

    if ( argc < 3 )
    {
        printf("Usage:\n");
        printf("Add new person: ./pessoas -i [name] [age]\n");
        printf("List N persons: ./pessoas -l [N]\n");
        printf("Change person age: ./pessoas -u [name] [age]\n");
        printf("Change person age (v2): ./pessoas -o [position] [age]\n");
        return 1;
    }

    char buffer[50]="";

    if ( strcmp(argv[1],"-i") == 0 )
    {
        int bytes = new_person(argv[2], atoi(argv[3]));
        snprintf(buffer,sizeof(buffer),"%d :: registrado com sucesso\n",bytes);
        write(1,buffer,sizeof(buffer));

    }

    if ( strcmp(argv[1],"-l") == 0 )
    {
        list_n_persons(atoi(argv[2]));
    }

    if ( strcmp(argv[1],"-u") == 0 )
    {
        person_change_age(argv[2], atoi(argv[3]));
    }

    if ( strcmp(argv[1],"-o") == 0 )
    {
        // TO DO
    }

    return 0;
}
