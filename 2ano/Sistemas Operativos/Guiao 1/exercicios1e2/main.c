#include "guiao1.h"

int main(int argc, char** argv){

    printf("%s\n",argv[2]);

    if(argv[2] != NULL){
        printf("alo\n");
        mycp(argv[1],argv[2]);
    }
    else{
        printf("too few arguments...\n");
    }
    
    return 0;
}
