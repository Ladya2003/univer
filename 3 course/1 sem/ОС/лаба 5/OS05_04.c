#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <pthread.h>
#include <sys/syscall.h>
#include <sched.h>

int main() {
	pid_t tid = gettid();
	pid_t pid = getpid();
	int cnice = nice(0);
	printf("OS05_04 PID, TID: %d, %d\n", pid, tid);
	printf("nice %d\n", cnice);
	cpu_set_t set;
	CPU_ZERO(&set);
	if(sched_getaffinity(0, sizeof(cpu_set_t), &set) == 0) {
		int is = 0;
		for(int i = 0; i < CPU_SETSIZE; i++) {
			is = CPU_ISSET(i, &set);
			if(is) printf("CPU = %i is %s\n", i, "set");
		}
	}
	else printf("sched_getaffinity error");	
	
	exit(0);
}

















/*

Значение nice обычно находится в диапазоне от -20 до 19, где -20 представляет наивысший (самый высокий) приоритет, а 19 - наименьший (самый низкий) приоритет.

#define _GNU_SOURCE: Эта директива предварительной обработки активирует определения и функции, специфичные для GNU (GNU C Library), включая некоторые расширенные функции, которые используются в этой программе.

int cnice = nice(0);: Функция nice(0) используется для получения текущего значения "приоритета" (nice) текущего процесса. Полученное значение сохраняется в переменной cnice.

структура cpu_set_t, которая используется для хранения информации о множестве процессоров.

Функция CPU_ZERO инициализирует множество процессоров, устанавливая все биты в нулевое состояние.

sched_getaffinity, чтобы получить информацию о процессорной аффинности текущего процесса и сохранить ее в структуре set

Функция CPU_ISSET проверяет, установлен ли бит i в множестве процессоров set и сохраняет результат в is.
*/