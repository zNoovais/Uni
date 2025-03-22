CC = gcc
CCFG = -Wall -g

guiao1: mycat.o main.o cp.o

cp.o: cp.c guiao1.h

mycat.o: mycat.c guiao1.h

main.o: main.c guiao1.h

clean:
	rm -f *.o mycat
	rm copia.txt