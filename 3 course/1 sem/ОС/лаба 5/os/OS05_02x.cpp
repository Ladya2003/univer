// OS05_02x.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <windows.h>
#include <process.h>

int main()
{
    DWORD pid = GetCurrentProcessId();
    DWORD tid = GetCurrentThreadId();
    HANDLE h = GetCurrentProcess();
    HANDLE hp = GetCurrentThread();
    DWORD prth = GetPriorityClass(h);
    DWORD icpu = SetThreadIdealProcessor(hp, MAXIMUM_PROCESSORS);

    DWORD start_time = GetTickCount(); // Засечка времени начала выполнения программы

    for (int i = 0; i < 1000000; i++) {
        if (i % 1000 == 0) {
            std::cout << "\n# " << i << "\nProcess: " << pid << "\nThread: " << tid;
            std::cout << "\nPriority proc: " << prth;
            switch (prth) {
            case IDLE_PRIORITY_CLASS:  std::cout << " --> IDLE_PRIORITY_CLASS"; break;
            case BELOW_NORMAL_PRIORITY_CLASS: std::cout << " --> BELOW_NORMAL_PRIORITY_CLASS"; break;
            case NORMAL_PRIORITY_CLASS: std::cout << " --> NORMAL_PRIORITY_CLASS"; break;
            case ABOVE_NORMAL_PRIORITY_CLASS: std::cout << " --> ABOVE_NORMAL_PRIORITY_CLASS"; break;
            case HIGH_PRIORITY_CLASS: std::cout << " --> HIGH_PRIORITY_CLASS"; break;
            case REALTIME_PRIORITY_CLASS: std::cout << " --> REALTIME_PRIORITY_CLASS"; break;
            default: std::cout << "error"; break;
            }
            std::cout << "\nProcessor: " << icpu << "\n-><-><-><->-<-><-><-><-><-><-><-";
            Sleep(1000);
        }
    }

    DWORD end_time = GetTickCount(); // Засечка времени окончания выполнения программы
    std::cout << "\nElapsed time: " << (end_time - start_time) << " ms" << std::endl; // Вывод времени выполнения

    system("pause");
}


// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
