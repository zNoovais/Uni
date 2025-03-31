#include "matrix.h"


int main(int argc, char *argv[]) {

    // generate random matrix
    int **matrix = createMatrix();

    // print matrix
    printMatrix(matrix);

    // search for value
    char buffer[BUFFER_SIZE];
    ssize_t bits_read;
    (bits_read = read(0,buffer,BUFFER_SIZE));   // user input para procurar na matriz
    buffer[bits_read] = '\0';
    int value = atoi(buffer);
    int exists = valueExists(matrix, value);
    printf("Value %d %s in matrix.\n", value, exists ? "exists" : "does not exist");

    linesWithValue(matrix, value);

    // free matrix
    for (int i = 0; i < ROWS; i++) {
        free(matrix[i]);
    }
    free(matrix);

    return 0;
}