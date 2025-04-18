#include <stdio.h>
#include "mysystem.h"

void controller(int N, char** commands) {

	pid_t pid;
	int status;
	int i;
	int res;
	
	for(i = 0; i < N; i++) {
		pid = fork();
		if(pid == 0) {
			res = mysystem(commands[i]);
			_exit(res);
		}
	}

	while(wait(&status) > 0) {
        WIFEXITED(status);
    }

	
}

int main(int argc, char* argv[]) {

    char *commands[argc-1];
    int N = 0;
	for(int i=1; i < argc; i++){
		commands[N] = strdup(argv[i]);
		printf("command[%d] = %s\n", N, commands[N]);
        N++;
	}





    controller(N, commands);

	return 0;
}