#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

#define BUFFER_SIZE 100

int mycat();
int mycatv2(char *filename);
int mycp(char* filein, char* fileout);