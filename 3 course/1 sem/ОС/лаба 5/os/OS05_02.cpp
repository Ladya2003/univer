// OS05_02.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <windows.h>
#include <process.h>
#include "OS05_02.h"

DWORD SwPriority(int i) {
    switch (i) {
    case 1: return BELOW_NORMAL_PRIORITY_CLASS;
    case 2: return HIGH_PRIORITY_CLASS;
    case 3: return NORMAL_PRIORITY_CLASS;
    case 4: return ABOVE_NORMAL_PRIORITY_CLASS;
    case 5: return IDLE_PRIORITY_CLASS;
    case 6: return REALTIME_PRIORITY_CLASS;
    default: throw "No such priority class";
    }
}

int main(int argc, char* argv[])
{
    for (int i = 0; i < argc; i++)
    {
        std::wcout << L"arg" << i << L": " << argv[i] << L"\n";
    }

    LPCWSTR an = L"..\\Debug\\OS05_02x.exe";
    STARTUPINFO si;
    PROCESS_INFORMATION pi, pi1;
    ZeroMemory(&si, sizeof(STARTUPINFO));
    si.cb = sizeof(STARTUPINFO);
    unsigned long long mask;
    HANDLE hp = GetCurrentProcess();

    try {
        if (argc < 4) {
            throw "Not enough command line arguments";
        }

        DWORD pa = NULL, sa = NULL, icpu = -1;
        if (!GetProcessAffinityMask(hp, &pa, &sa)) throw "Process Affinity Mask";
        std::wcout << L" Process Affinity Mask: " << std::showbase << std::hex << pa << L"\n";
        std::wcout << L" System Affinity Mask: " << std::showbase << std::hex << sa << L"\n";
        std::wcout << std::dec << std::noshowbase << L"\n\n";

        if (argv[1] != NULL) {
            sscanf_s(argv[1], "%llu", &mask);
            if (!SetProcessAffinityMask(hp, mask)) throw "SetProcessAffinityMask";
        }

        if (!GetProcessAffinityMask(hp, &pa, &sa)) throw "Process Affinity Mask";
        std::wcout << L" Process Affinity Mask: " << std::showbase << std::hex << pa << L"\n";
        std::wcout << L" System Affinity Mask: " << std::showbase << std::hex << sa << L"\n";
        std::wcout << std::dec << std::noshowbase;

        if (!CreateProcess(an, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | SwPriority(atoi(argv[2])), NULL, NULL, &si, &pi))  throw "---Proc 1 wasn't created";
        if (!CreateProcess(an, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | SwPriority(atoi(argv[3])), NULL, NULL, &si, &pi1))  throw "---Proc 2 wasn't created";
    }
    catch (const std::exception& a)
    {
        std::wcout << L"Error: " << a.what() << L"\n";
    }
    catch (const char* msg)
    {
        std::wcout << L"Error: " << msg << L"\n";
    }
}



/*
Функция CreateProccersWithPriority создает новый процесс с указанным путем к исполняемому файлу и заданным приоритетом выполнения. Вот объяснение параметров:
L"D:\\Универ\\5 семестр\\ОС\\лаба 5\\5\\OS05_02x.exe": Это строка, представляющая путь к исполняемому файлу, который будет запущен в новом процессе. В данном случае, путь указывает на файл OS05_02x.exe в указанной директории.
si: Это переменная типа STARTUPINFO, которая содержит информацию о запуске нового процесса, такую как настройки окна и стандартные потоки ввода-вывода. В функции CreateProccersWithPriority она вероятно используется для передачи соответствующих настроек запуска.
priority: Это параметр, указывающий приоритет выполнения нового процесса. Он может принимать различные значения, такие как HIGH_PRIORITY_CLASS, NORMAL_PRIORITY_CLASS, IDLE_PRIORITY_CLASS и другие, которые определяют относительный приоритет процесса в системе.
*/

/*
* SwPriority Эта функция принимает в качестве аргумента целое число и возвращает соответствующее значение приоритета процесса
Функция atoi в C++ преобразует строку, представленную в виде массива символов, в целое число типа int. В данном случае, atoi используется для преобразования строки, переданной в аргументе argv[1], в целочисленное значение и сохранения его в переменной mask.
*/