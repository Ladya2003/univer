// OS05_03.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <windows.h>
#include <process.h>

void PrintProcPrior(DWORD k);
void PrintThreadPrior(DWORD k);
void TA();
DWORD SwPriority(int i);
DWORD SwPriorityThread(int i);


int main(int argc, char* argv[])
{
    for (int i = 0; i < argc; i++)
    {
        std::cout << "arg" << i << ": " << argv[i] << "\n";
    }

    unsigned long long mask;
    HANDLE hp = GetCurrentProcess();
    //current
    DWORD pa = NULL, sa = NULL, icpu = -1;
    if (!GetProcessAffinityMask(hp, &pa, &sa)) throw "Process Affinity Mask";
    std::cout << " Process Affinity Mask: " << std::showbase << std::hex << pa << "\n";
    std::cout << " System Affinity Mask: " << std::showbase << std::hex << sa << "\n";
    std::cout << std::dec << std::noshowbase << "\n\n";
    //switch
    if (argv[1] != NULL) {
        sscanf_s(argv[1], "%d", &mask);
        if (!SetProcessAffinityMask(hp, mask)) throw "SetProcessAffinityMask";
    }
    //new
    if (!GetProcessAffinityMask(hp, &pa, &sa)) throw "Process Affinity Mask";
    std::cout << " Process Affinity Mask: " << std::showbase << std::hex << pa << "\n";
    std::cout << " System Affinity Mask: " << std::showbase << std::hex << sa << "\n";
    std::cout << std::dec << std::noshowbase;

    try {
        SetPriorityClass(GetCurrentProcess(), SwPriority(atoi(argv[2])));

        DWORD childId_T1, childId_T2 = NULL;
        HANDLE hChild1 = CreateThread(NULL, CREATE_NEW_CONSOLE, (LPTHREAD_START_ROUTINE)TA, NULL, CREATE_SUSPENDED, &childId_T1);
        HANDLE hChild2 = CreateThread(NULL, CREATE_NEW_CONSOLE, (LPTHREAD_START_ROUTINE)TA, NULL, CREATE_SUSPENDED, &childId_T2);

        SetThreadPriority(hChild1, SwPriorityThread(atoi(argv[3])));
        SetThreadPriority(hChild2, SwPriorityThread(atoi(argv[4])));

        ResumeThread(hChild1);
        ResumeThread(hChild2);

        WaitForSingleObject(hChild1, INFINITE);
        WaitForSingleObject(hChild2, INFINITE);

        CloseHandle(hChild1);
        CloseHandle(hChild2);
    }
    catch (const std::exception& a)
    {
        std::cout << "Error: " << a.what() << "\n";
    }
    catch (const char* msg)
    {
        std::cout << "Error: " << msg;
    }
}

void TA()
{
    DWORD pid = GetCurrentProcessId();
    HANDLE hp = GetCurrentProcess();
    DWORD prty = GetPriorityClass(hp);
    HANDLE ht = GetCurrentThread();
    DWORD tid = GetCurrentThreadId();
    DWORD prth = GetThreadPriority(ht);
    DWORD icpu = SetThreadIdealProcessor(ht, MAXIMUM_PROCESSORS);

    for (unsigned long long i = 0; i < 1000000; i++)
    {
        if (i % 1000 == 0) {
            std::cout << "\n# " << i << "\tPID: " << pid << "\tTID: " << tid;
            std::cout << "\tPriority proc: " << prty;
            PrintProcPrior(prty);
            std::cout << "\tThread priority: " << prth;
            PrintThreadPrior(prth);
            std::cout << "\tProcessor: " << icpu;
        }
    }
    return;
}

void PrintProcPrior(DWORD k)
{
    switch (k) {
    case IDLE_PRIORITY_CLASS:  std::cout << " --> IDLE_PRIORITY_CLASS"; break;
    case BELOW_NORMAL_PRIORITY_CLASS: std::cout << " --> BELOW_NORMAL_PRIORITY_CLASS"; break;
    case NORMAL_PRIORITY_CLASS: std::cout << " --> NORMAL_PRIORITY_CLASS"; break;
    case ABOVE_NORMAL_PRIORITY_CLASS: std::cout << " --> ABOVE_NORMAL_PRIORITY_CLASS"; break;
    case HIGH_PRIORITY_CLASS: std::cout << " --> HIGH_PRIORITY_CLASS"; break;
    case REALTIME_PRIORITY_CLASS: std::cout << " --> REALTIME_PRIORITY_CLASS"; break;
    default: std::cout << "error"; break;
    }
}

void PrintThreadPrior(DWORD k)
{
    switch (k) {
    case THREAD_PRIORITY_LOWEST: std::cout << " --> THREAD_PRIORITY_LOWEST\n"; break;
    case THREAD_PRIORITY_BELOW_NORMAL: std::cout << " --> THREAD_PRIORITY_BELOW_NORMAL\n"; break;
    case THREAD_PRIORITY_NORMAL: std::cout << " --> THREAD_PRIORITY_NORMAL\n"; break;
    case THREAD_PRIORITY_ABOVE_NORMAL: std::cout << " --> THREAD_PRIORITY_ABOVE_NORMAL\n"; break;
    case THREAD_PRIORITY_HIGHEST: std::cout << " --> THREAD_PRIORITY_HIGHEST\n"; break;
    case THREAD_PRIORITY_IDLE: std::cout << " --> THREAD_PRIORITY_IDLE\n"; break;
    case THREAD_PRIORITY_TIME_CRITICAL: std::cout << " -->THREAD_PRIORITY_TIME_CRITICAL \n"; break;
    default: std::cout << "error"; break;
    }
}

DWORD SwPriority(int i) {
    switch (i) {
    case 1: return IDLE_PRIORITY_CLASS;
    case 2: return BELOW_NORMAL_PRIORITY_CLASS;
    case 3: return NORMAL_PRIORITY_CLASS;
    case 4: return ABOVE_NORMAL_PRIORITY_CLASS;
    case 5: return HIGH_PRIORITY_CLASS;
    case 6: return REALTIME_PRIORITY_CLASS;
    default: throw "No such priority class";
    }
}

DWORD SwPriorityThread(int i) {
    switch (i) {
    case 1: return THREAD_PRIORITY_LOWEST;
    case 2: return THREAD_PRIORITY_BELOW_NORMAL;
    case 3: return THREAD_PRIORITY_NORMAL;
    case 4: return THREAD_PRIORITY_ABOVE_NORMAL;
    case 5: return THREAD_PRIORITY_HIGHEST;
    case 6: return THREAD_PRIORITY_IDLE;
    default: throw "No such priority class";
    }
}








/*
std::dec: Это манипулятор потока, который устанавливает режим вывода чисел в десятичной системе счисления. Это означает, что числа будут выводиться в десятичном формате.
std::noshowbase: Это манипулятор потока, который отключает вывод префиксов основания числа (например, 0x для шестнадцатеричных чисел или 0 для восьмеричных чисел). Это означает, что числа будут выводиться без префиксов.

SetPriorityClass
SetPriorityClass: Это функция из Windows API, которая используется для установки приоритетного класса процесса.
GetCurrentProcess(): Это функция из Windows API, которая возвращает дескриптор текущего процесса.
SwPriority(atoi(argv[2])): Это выражение, которое преобразует строку, переданную в аргументе argv[2], в целое число с помощью функции atoi, а затем использует это целое число для создания объекта SwPriority. Предполагается, что SwPriority является пользовательским типом данных или структурой, которая представляет приоритет.
*/