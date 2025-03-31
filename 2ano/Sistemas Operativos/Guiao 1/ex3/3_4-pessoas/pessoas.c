#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <unistd.h>
#include "person.h"
#include <string.h>


int main(int argc, char* argv[]){

	char id[25]="";

    if (argc < 3)
    {
        printf("Usage:\n");
        printf("Add new person: ./pessoas -i [name] [age]\n");
        printf("List N persons: ./pessoas -l [N]\n");
        printf("Change person age: ./pessoas -u [name] [age]\n");
        printf("Change person age (v2): ./pessoas -o [position] [age]\n");
        return 1;
    }

    if(strcmp(argv[1],"-i")==0){
        int res = new_person(argv[2], atoi(argv[3]));
        snprintf(id, 20,  "registo %d\n", res);
		write(STDOUT_FILENO, id, sizeof(id));
    }

    if(strcmp(argv[1],"-l")==0){
        int res = list_n_persons(atoi(argv[2]));
        snprintf(id, 25,  "Registos lidos: %d\n", res);
        write(STDOUT_FILENO, id, sizeof(id));
    }

    if(strcmp(argv[1],"-u")==0){
        person_change_age(argv[2], atoi(argv[3]));

    }

    if(strcmp(argv[1],"-o")==0){
        person_change_age_v2(atoi(argv[2]), atoi(argv[3]));

    }

    return 0;
}
