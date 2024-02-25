#include <iostream>
#include <Windows.h>
#include <ctime>

using namespace std;
int mutex = 0;
DWORD WINAPI Thread();
int main() {

	HANDLE hChild = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)Thread, NULL, 0, NULL);
	HANDLE hChild2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)Thread, NULL, 0, NULL);
	ResumeThread(hChild);
	ResumeThread(hChild2);
	WaitForSingleObject(hChild, INFINITE);
	WaitForSingleObject(hChild2, INFINITE);
	CloseHandle(hChild);
	CloseHandle(hChild2);
	system("pause");
}

void start_critical_section(void)
{
	__asm {
	SpinLoop:
		lock bts mutex, 0;
		jc SpinLoop
	}
}

void exit_critical_section(void)
{
	__asm lock btr mutex, 0
}

DWORD WINAPI Thread()
{
	DWORD tid = GetCurrentThreadId();
	int firrtTime = clock();
	start_critical_section();
	for (int i = 1; i < 91; i++)
	{
		cout << "Thread: " << tid << "  " << i << endl;
	}
	exit_critical_section();
	return 0;
}
















//
//lock bts mutex, 0; : Эта инструкция выполняет атомарную операцию "Bit Test and Set".Она устанавливает 
// бит с индексом 0 в переменной mutex(представляющей собой некоторый флаг блокировки).Она выполняется с 
// использованием префикса lock, что гарантирует, что операция будет выполнена атомарно.
//jc SpinLoop : Если операция установки бита прошла успешно(бит был установлен), то происходит переход к 
//метке SpinLoop.В противном случае продолжается выполнение кода за пределами этой инструкции.


//lock btr mutex, 0: Эта инструкция выполняет атомарную операцию "Bit Test and Reset".Она сбрасывает бит с 
//индексом 0 в переменной mutex, что означает освобождение критической секции.

// атомарно - если два потока попытаются изменить mutex, то только операция одного потока выполнится
//
//lock bts mutex, 0; -Эта инструкция атомарно устанавливает бит 0 в переменной mutex(заменяет его на 1) и 
// возвращает старое значение бита до изменения.
//jc SpinLoop - Если предыдущее значение бита было 1 (заблокировано другим потоком), то прыгнуть обратно 
//на метку SpinLoop и повторить попытку.





















//
//start_critical_section:
//Начинаем определение функции.
//
//__asm {:
//Вводим ассемблерный код внутри функции.
//
//SpinLoop::
//Устанавливаем метку, которая будет использоваться для перехода в цикле.
//
//lock bts mutex, 0; :
//Эта инструкция ассемблера выполняет "bit test and set" (проверка бита и установка).Она пытается установить бит с индексом 0 в переменной mutex.Префикс lock гарантирует, что эта операция будет атомарной, то есть не будет прервана другими потоками.
//
//jc SpinLoop :
//Это условный переход.Если установка бита прошла успешно(флаг переноса установлен), то переходим обратно к метке SpinLoop.Таким образом, мы создаем бесконечный цикл ожидания, пока не удастся успешно установить бит.
//
//} }:
//Завершаем ассемблерный код и определение функции.
//
//Таким образом, эта функция создает механизм, который позволяет потокам ждать(зацикливаться), пока не удастся получить доступ к определенному ресурсу или критической секции.Когда бит успешно устанавливается, поток выходит из цикла и продолжает выполнение кода внутри критической секции.

//
//lock btr mutex, 0; :
//Эта инструкция ассемблера выполняет "bit test and reset" (проверка бита и сброс).Она сбрасывает бит с индексом 0 в переменной mutex.Префикс lock гарантирует, что эта операция будет атомарной, то есть не будет прервана другими потоками.



//#include <iostream>
//#include <ctime>
//#include <Windows.h>
//
//DWORD WINAPI A();
//DWORD WINAPI B();
//
//void LockSemaph();
//void UnlockSemaph();
//
//int check = 0;
//
//int main() {
//	DWORD AId = NULL, BId = NULL;
//	HANDLE hA = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)A, NULL, 0, &AId);
//	HANDLE hB = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)B, NULL, 0, &BId);
//
//	WaitForSingleObject(hA, INFINITY);
//	WaitForSingleObject(hB, INFINITY);
//	CloseHandle(hA);
//	CloseHandle(hB);
//
//	system("pause");
//	return 0;
//}
//
//DWORD WINAPI A() {
//	int start = clock();
//
//	LockSemaph();
//	for (int i = 0; i < 5; i++) {
//		std::cout << "A:" << i << ", time: " << clock() - start << std::endl;
//	}
//	UnlockSemaph();
//
//	return 0;
//}
//
//DWORD WINAPI B() {
//	int start = clock();
//
//	LockSemaph();
//	for (int i = 0; i < 5; i++) {
//		std::cout << "B:" << i << ", time: " << clock() - start << std::endl;
//	}
//	UnlockSemaph();
//
//	return 0;
//}
//
//void LockSemaph() {
//	_asm {
//	CriticalSection:
//		lock bts check, 0;
//		jc CriticalSection
//	}
//}
//
//void UnlockSemaph() {
//	_asm lock btr check, 0
//}
//






















//#include <iostream>
//#include <Windows.h>
//#include <atomic>
//#include <thread>
//
//using namespace std;
//
//atomic<int> mutex(0);
//
//void start_critical_section() {
//    while (mutex.exchange(1, memory_order_acquire) == 1) {
//        // Ждем, пока другой поток освободит mutex
//    }
//}
//
//void exit_critical_section() {
//    mutex.store(0, memory_order_release);
//}
//
//DWORD WINAPI Thread() {
//    DWORD tid = GetCurrentThreadId();
//    int firstTime = clock();
//    start_critical_section();
//    for (int i = 1; i < 91; i++) {
//        cout << "Thread: " << tid << "  " << i << endl;
//    }
//    exit_critical_section();
//    return 0;
//}
//
//int main() {
//    HANDLE hChild = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)Thread, NULL, 0, NULL);
//    HANDLE hChild2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)Thread, NULL, 0, NULL);
//    ResumeThread(hChild);
//    ResumeThread(hChild2);
//    WaitForSingleObject(hChild, INFINITE);
//    WaitForSingleObject(hChild2, INFINITE);
//    CloseHandle(hChild);
//    CloseHandle(hChild2);
//    system("pause");
//    return 0;
//}














//В данном случае, если mutex уже равен 1 (занят), функция будет повторять операцию до тех пор, пока не сможет успешно установить значение 1. Таким образом, поток ждет, пока другой поток не освободит мьютекс.