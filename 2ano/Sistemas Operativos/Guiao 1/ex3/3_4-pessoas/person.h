#ifndef PERSON_H
#define PERSON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

#define FILENAME "file_pessoas"

#define DEBUG 1

typedef struct person {
    char name[200];
    int age;
} Person;

/*
* Adds a new person
* (ex4) Returns the person position
*/
int new_person(char *name, int age);

/*
* Lists size persons
* Return number of read persons
*/
int list_n_persons(int N);

/*
* Updates a person age
* Return 1 if a person was updated, 0 if not, -1 on errors
*/
int person_change_age(char *name, int age);

/*
* Updates a person age
* Return 1 on success, -1 on errors
*/
int person_change_age_v2(long pos, int age);

#endif /* PERSON_H */