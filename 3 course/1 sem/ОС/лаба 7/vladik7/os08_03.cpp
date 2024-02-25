#include <Windows.h>
#include <iostream>
#include <ctime>
#define SECOND 10000000

HANDLE htimer1 = NULL;
long long it1 = -3 * SECOND;
HANDLE htimer2 = NULL;
long long it2 = -15 * SECOND;

std::atomic<bool> terminateFlag(false);
int i = 0;

DWORD WINAPI ChildThread() {
	while (!terminateFlag) {
		WaitForSingleObject(htimer1, INFINITE);
		std::cout << clock() << ": timer1" << "\n";
		std::cout << "iterations count: " << i << "\n\n";
	}
 return 0;
}

int main() {
	htimer1 = CreateWaitableTimer(NULL, FALSE, NULL);
	std::cout << clock() << ": start" << "\n\n";
	if (!SetWaitableTimer(htimer1, (LARGE_INTEGER*)&it1, 3000, NULL, NULL, FALSE)) throw "Error SetwaitableTimer";

	DWORD ChildId = 0;
	HANDLE hchild = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)ChildThread, NULL, NULL, &ChildId);

	htimer2 = CreateWaitableTimer(NULL, FALSE, NULL);
	if (!SetWaitableTimer(htimer2, (LARGE_INTEGER*)&it2, 0, NULL, NULL, FALSE)) throw "Error SetwaitableTimer";

	while (true) {
		if (WaitForSingleObject(htimer2, 0) == WAIT_OBJECT_0) {
			std::cout << clock() << ": timer2" << "\n";
			std::cout << "breaking loop" << "\n\n";
			terminateFlag = true;
          WaitForSingleObject(hchild, INFINITE);
			break;
		}
		i++;
	}

	std::cout << "iterations count: " << i << "\n\n";

	system("pause");
	return 0;
}





















//it1 и it2 - временные интервалы для таймеров(отрицательные значения означают, что таймеры начнут отсчет сразу после создания).
// std::atomic<bool> terminateFlag(false);  - атомарная переменная типа bool, используемая для управления циклом в дочернем потоке.

//htimer1 = CreateWaitableTimer(NULL, FALSE, NULL);
//lpTimerAttributes : Указатель на структуру SECURITY_ATTRIBUTES, которая определяет атрибуты безопасности для нового объекта таймера.Может быть NULL для использования атрибутов по умолчанию.
//bManualReset : Если это значение установлено в TRUE, таймер является ручным сбрасываемым, иначе - автоматически сбрасываемым.
//lpTimerName : Имя таймера.Может быть NULL.

//SetWaitableTimer(htimer1, (LARGE_INTEGER*)&it1, 3000, NULL, NULL, FALSE)) throw "Error SetwaitableTimer";
//hTimer: Дескриптор таймера.
//pDueTime : Указатель на структуру LARGE_INTEGER, представляющую время начала отсчета таймера.
//lPeriod : Период таймера в миллисекундах.Если равен 0, таймер срабатывает один раз, иначе с периодичностью lPeriod.
//pfnCompletionRoutine : Указатель на функцию обратного вызова, вызываемую при срабатывании таймера.Может быть NULL.
//lpArgToCompletionRoutine : Дополнительный параметр, передаваемый в функцию обратного вызова.
//fResume : Если установлен в TRUE, таймер возобновляется после срабатывания.

// HANDLE hchild = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)ChildThread, NULL, NULL, &ChildId);
//lpThreadAttributes: Атрибуты безопасности для нового потока.Может быть NULL.
//dwStackSize : Размер стека потока в байтах.Если 0, используется значение по умолчанию.
//lpStartAddress : Указатель на функцию, которая является точкой входа для нового потока.
//lpParameter : Указатель на данные, передаваемые в функцию потока.
//dwCreationFlags : Флаги создания потока.
//lpThreadId : Указатель на переменную, в которую записывается идентификатор нового потока.

//WaitForSingleObject
//hHandle: Дескриптор объекта, ожидание которого осуществляется(например, таймера или потока).
//dwMilliseconds : Максимальное время ожидания в миллисекундах.Если равно INFINITE, ожидание бесконечно.


//if (WaitForSingleObject(htimer2, 0) == WAIT_OBJECT_0) {
//WAIT_OBJECT_0 означает сигнальное состояние