#include "matrix.h"


int **createMatrix() {

    // seed random numbers
    srand(time(NULL));

    // Allocate and populate matrix with random numbers.
    printf("Generating numbers from 0 to %d...", MAX_RAND);
    int **matrix = (int **) malloc(sizeof(int*) * ROWS);            //FAZENDO AS MATRIZES!!
    for (int i = 0; i < ROWS; i++) {
        matrix[i] = (int*) malloc(sizeof(int) * COLUMNS);
        for (int j = 0; j < COLUMNS; j++) {
            matrix[i][j] = rand() % MAX_RAND;
        }
    }
    printf(" Done.\n");

    return matrix;
}

void printMatrix(int **matrix) {

    for (int i = 0; i < ROWS; i++) {
        printf("%2d | ", i);
        for (int j = 0; j < COLUMNS; j++) {
            printf("%7d ", matrix[i][j]);
        }
        printf("\n");
    }
}

// ex.5
int valueExists(int **matrix, int value) {

    int status;
    int i,j = 0;
    int out = 0;
    pid_t pid;

    for(i = 0; i < ROWS; i++) {

        pid = fork();
        if (pid == 0) {
            for(j = 0; j < COLUMNS; j++) {
                if (matrix[i][j] == value) _exit(1); 
            }

            _exit(0); 
        }
    }

    while(wait(&status) > 0) {
        if (WIFEXITED(status) == 1) {
            out += WEXITSTATUS(status);
        }
    }

    return out;
}


// ex.6
void linesWithValue(int **matrix, int value) {
    
    int status;
    int i,j = 0;
    pid_t pid;
    printf("Linhas com o valor %d: ", value);
    int orderPids[ROWS];
    int sp = 0;

    for(i = 0; i < ROWS; i++) {

        pid = fork();
        if (pid == 0) {
            for(j = 0; j < COLUMNS; j++) {
                if (matrix[i][j] == value) _exit(1); 
            }

            _exit(0); 
        }
        orderPids[sp] = pid;
        sp++;
        
    }
    
    for(int x = 0; x < ROWS; x++){
    waitpid(orderPids[x],&status,0);
        if (WIFEXITED(status) == 1) {
            if (WEXITSTATUS(status) == 1) {
                printf("%d | ", x);
            }
        }
    }
    printf("\n");
    return;
}
