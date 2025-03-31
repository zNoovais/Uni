#include "person.h"

int new_person(char *name, int age) {

    /* Create a struct person */
	Person p;
	p.age=age;
	strcpy(p.name, name);

    /* flag append allows writting from the end of the file */
    int fd = open (FILENAME, O_CREAT|O_APPEND|O_WRONLY, 0600);
    if (fd == -1) {
        perror("open error");
        return -1;
    }

    /* write struct to file */
    int res = write(fd, &p, sizeof(Person));
    if (res < 0) {
        perror("write error");
        return -1;
    }

    /* Ex4 - Get offset */
    int pos = lseek(fd, -sizeof(Person), SEEK_CUR);
    if (pos < 0) {
        perror("lseek error");
        return -1;
    }

    /* close file descriptor */
    close(fd);

    /* return position ( offset / size of struct person ) */
    return pos/sizeof(Person);
}

int list_n_persons(int N) {

    /* Create a struct person */
    Person p;

    /* Auxiliar variables for writing to stdout */
    char output[100];
    int output_size=0;

    /* Open file for reading */
    int fd = open (FILENAME, O_RDONLY);
    if (fd == -1) {
        perror("open error");
        return -1;
    }

    /* Read until N or EOF */
    int i = 0;
    while (i < N && read(fd, &p, sizeof(Person)) > 0) {
        output_size = sprintf(output, "Register %d, name: %s, idade: %d\n", i, p.name, p.age);
        write(1, output, output_size);
        i++;
    }

    /* close file descriptor */
	close(fd);

    /* return number of read persons */
	return i;
}



int person_change_age(char *name, int age) {

    /* Create a struct person */
	Person p;

    /* Auxiliar variables for writing to stdout */
    char output[100];
    int output_size=0;

    /* Open file for reading and writing */
    int fd = open(FILENAME, O_RDWR, 0600);
    if (fd == -1) perror("open erro");

    int i = 0;
    while (read(fd, &p, sizeof(Person)) > 0) {

        output_size = sprintf(output, "Read register %d, name: %s, idade: %d\n", i, p.name, p.age);
        write(1, output, output_size);

        /* if the name of read person equals the given name */
        if (strcmp(p.name, name) == 0)
        {
            /* update age */
            p.age = age;

            /* return to the begining of the last read person */
            int res = lseek(fd, -sizeof(Person), SEEK_CUR);
            if (res < 0) {
                perror("lseek error");
                return -1;
            }

            /* overwrite the written person with the updated data */
            res = write(fd, &p, sizeof(Person));
            if (res < 0) {
                perror("write error");
                return -1;
            }

            output_size = sprintf(output, "Wrote register %d, name: %s, idade: %d\n", i, p.name, p.age);
            write(1, output, output_size);

            /* close file descriptor */
            close(fd);

            return 1;
        }

        i++;
    }

    close(fd);
    return 0;

}

int person_change_age_v2(long pos, int age) {

    /* Create a struct person */
	Person p;

    /* Open file for reading and writing */
    int fd = open(FILENAME, O_RDWR, 0600);
    if (fd == -1) perror("erro ao abrir ficheiro");

    /* jump to given position (pos * size of struct person) */
    int res = lseek(fd, pos*sizeof(Person), SEEK_CUR);
    if (res < 0) {
        perror("lseek error");
        return -1;
    }

    /* read person */
    res = read(fd, &p, sizeof(Person));
    if (res < 0) {
        perror("read error");
        return -1;
    }

    /* update age */
    p.age = age;

    /* return to the begining of the last read person */
    res = lseek(fd, -sizeof(Person), SEEK_CUR);
    if (res < 0) {
        perror("lseek error");
        return -1;
    }

    /* overwrite the written person with the updated data */
    res = write(fd, &p, sizeof(Person));
    if (res < 0) {
        perror("erro no write");
        return -1;
    }

    /* close file descriptor */
    close(fd);

    return 0;

}