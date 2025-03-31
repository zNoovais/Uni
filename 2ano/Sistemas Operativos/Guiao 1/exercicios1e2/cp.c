#include "guiao1.h"

int mycp( char* filein, char* fileout){

    


    int fdout = open(fileout,O_CREAT | O_WRONLY | O_TRUNC, 0600);
    int fdin = open(filein,O_RDONLY);

    char buffer[BUFFER_SIZE];

    if(fdout == -1 || fdin == -1){
        perror("erro no fd, chefe:");
        return -1;
    }

    ssize_t bytes_read;

    while((bytes_read = read(fdin,buffer,BUFFER_SIZE)) > 0){
        write(fdin,buffer,bytes_read);
    }

    close(fdin);
    close(fdout);


    return 0;
}