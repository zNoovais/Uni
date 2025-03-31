#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>


int main(int argc, char * argv[]){


	//Fase 1

	int i=10;
	int j=20;
	int h=0;

	printf("Enderecos: i %p j %p\n",&i,&j);
	printf("Valores: i %d, j %d\n",i, j);
	printf("Tamanho: i %lu, j %lu, int %lu\n",sizeof(i),sizeof(j),sizeof(int));

	//Fase 2
	int fd = open("teste", O_RDWR | O_CREAT | O_TRUNC, 0600);

	write(fd, &i, sizeof(int));
	write(fd, &j, sizeof(int));

	ssize_t res = read(fd, &h, sizeof(int));
	printf("res %zu, h %d\n",res, h);

	//Fase 3

	lseek(fd, 0, SEEK_SET);

	res = read(fd, &h, sizeof(int));
	printf("res %zu, h %d\n",res, h);

	res = read(fd, &h, sizeof(int));
	printf("res %zu, h %d\n",res, h);

	lseek(fd, -sizeof(int), SEEK_END);

	res = read(fd, &h, sizeof(int));
	printf("res %zu, h %d\n",res, h);


	close(fd);

	return 0;

}