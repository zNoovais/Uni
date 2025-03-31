#include "guiao1.h"

int mycat(){

    char buffer[BUFFER_SIZE];
    ssize_t bits_read;
    while((bits_read = read(0,buffer,BUFFER_SIZE)) > 0 )
        write(1,buffer,bits_read);
    return 0;
}

int mycatv2(char* filename){
    int fd = open(filename,O_RDONLY);
    
    if(fd == -1){
        perror("deu erro aqui:");
        return -1;
    }
    
    char *buffer = malloc(sizeof(char)*BUFFER_SIZE);
    
    ssize_t bytes_read;

    while((bytes_read = read(fd,buffer,BUFFER_SIZE)) > 0){
        write(1,buffer,bytes_read);
    }

    printf("acabou\n");
    free(buffer);
    close(fd);

    return 0;
}