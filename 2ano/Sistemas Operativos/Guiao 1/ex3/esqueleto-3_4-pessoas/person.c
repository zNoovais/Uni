#include "person.h"

int new_person(char *name, int age){

    Person pessoa;
    pessoa.age = age;
    strcpy(pessoa.name,name);

    int fd = open(FILENAME,O_RDWR | O_APPEND | O_CREAT ,0600);

    if(fd == -1){
        perror("erro no fd parceiro::");
        return -1;
    }

    ssize_t bytes_writen = write(fd,&pessoa,sizeof(Person));

    if(bytes_writen < 0){
        perror("erro aqui na leitura...");
        return -1;
    }

    int res = lseek(fd,-sizeof(Person),SEEK_CUR);


    close(fd);

    return res/sizeof(Person);

}


int list_n_persons(int N){

    Person pessoa;
    char out[204]; 
    int outsize = 0;
    int fd = open(FILENAME,O_RDONLY);
    if(fd == -1){
        perror("fd error ::");
        return -1;
    }

    ssize_t bytesW;
    int i = 1;
    while((bytesW = read(fd,&pessoa,sizeof(Person))) > 0 && i <= N){
        outsize = snprintf(out,sizeof(out),  "Reg: %d) %s, %d anos.\n",i,pessoa.name,pessoa.age);
        write(1,out,outsize);
        i++;
    }

    close(fd);

    return 0;
}

int person_change_age(char *name, int age){

    Person pessoa;
    char out[210];
    int outsize = 0;

    int fd = open(FILENAME,O_RDWR,0600);
    if(fd == -1){
        perror("error no fd:");
        return -1;
    }
    
    ssize_t bytesRead;
    int i = 1;

    int flag = 0;

    while((bytesRead = read(fd,&pessoa,sizeof(Person))) > 0){
        if(strcmp(name,pessoa.name) == 0){
            pessoa.age = age;
            flag++;
            outsize = snprintf(out,sizeof(out), "%d: %s, %d anos.\n",i,pessoa.name,age);
            write(1,out,outsize);

            off_t res = lseek(fd,-sizeof(Person),SEEK_CUR);
            if(res == (off_t)-1){
                perror("error in seek...");
            }

            ssize_t bytesW = write(fd,&pessoa,sizeof(Person));
            if(bytesW < 0){
                perror("error in write...");
            }

            break;
        }

        i++;
    }

    if(!flag){
        outsize = snprintf(out,sizeof(out), "Couldn't find the person: %s \n",name);
        write(1,out,outsize);
        return -1;
    }

    close(fd);

    return 0;
}