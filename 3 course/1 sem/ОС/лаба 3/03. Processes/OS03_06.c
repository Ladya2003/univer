#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>


int main(){ 
    //child
    system("OS03_05_1");
    //parent
    for (int i = 0; i < 100; i++) {
		printf("OS03_06 - PID: %d-#%d\n", getpid(), i);
		sleep(1);
	}

	return 0;
}






















// system вызывает команду в скобках в bash - системная оболочка командной строки (интерпритатор)
// почему прыгает со знач на знач - потмоу что сначала запускается bash и делает +1 pid, потом уже сама команда 

// создает новый процесс, используя системный вызов fork(), а затем вызывает команду в дочернем процессе с помощью системного вызова exec(). Родительский процесс ожидает завершения дочернего процесса с помощью системного вызова wait().