#include <time.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

int main() {
    
    pid_t pid;
    int filesdes[2];

    pipe(filesdes);
    pid = fork();
    if(pid == 0) {
        close(filesdes[0]);
        printf("eusouofilhoXD");
        
    }

}  
