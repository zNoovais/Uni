#include <time.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

int main() {

    pid_t pid;

    char *command[] = {"ls", "-l", NULL};
    
    
    //execl("/usr/bin/ls","ls","-l",NULL);

    int status;

    pid = fork();
        if (pid == 0) {
            
            execlp("ls","ls","-l", NULL); // o primeiro arg é o nome do programa...
            

            _exit(0); 
        }
    
    wait(&status);
    if(WEXITSTATUS(status) == 0){
        printf("child exited  %d\n", WEXITSTATUS(status));
    }    
    
    
    
        
    return 0;
}