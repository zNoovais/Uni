#include "mysystem.h"


// recebe um comando por argumento
// returna -1 se o fork falhar
// caso contrario retorna o valor do comando executado
int mysystem (const char* command) {

	int status;
	int res = -1;

	pid_t pid;

 	pid = fork();

	if (pid == -1) {
		return -1;
	}

	if (pid == 0) {
		
		int i;

		char *args[100]; 
		
		char *tofree, *string, *token;

		tofree = string = strdup(command);

		i = 0;

		while((token = strsep(&string, " ")) != NULL) {
			args[i] = strdup(token);
			i++;
		}
		
		args[i] = NULL;	

		free(tofree);
		
		execvp(args[0], args);
		printf("Erro ao executar comando: %s\n", command);
		_exit(0);
	}
	
	printf("PID: %d\n", pid);
	wait(&status);
	WIFEXITED(status);
	res = WEXITSTATUS(status);
	
	return res;
}