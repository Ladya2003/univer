#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(){
	for (int i = 0; i < 60; i++) {
		
		printf("PID: %d-#%d<n", getpid(), i);
		unsigned int a = 1;
		sleep(a);
	}
	return 0;
}
