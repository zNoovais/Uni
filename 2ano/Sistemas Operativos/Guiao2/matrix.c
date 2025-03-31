#include "matrix.h"

matrixFind(int matrix[][nc],int nl, int x) {

    int status;
    int i,j = 0;
    int out = 0;
    pid_t pid;

    for(i = 0; i < nl; i++) {

        pid = fork();
        if (pid == 0) {
            for(j = 0; j < nc; j++) {
                matrix[i][j] == x ? _exit(1) : _exit(0); 
            }
        }
    }

    while(wait(&status) > 0) {
        if (WIFEXITED(status) == 1) {
            out += WEXITSTATUS(status);
        }
    }


            
        
    return out;
}

