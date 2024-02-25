// OS05_01.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <windows.h>
#include <process.h>
#include <bitset>

int main()
{
    
    DWORD pid = GetCurrentProcessId();
    DWORD tid = GetCurrentThreadId();

    HANDLE h = GetCurrentProcess();
    DWORD prty = GetPriorityClass(h); 
    HANDLE hp = GetCurrentThread();
    DWORD prth = GetThreadPriority(hp);
    SetProcessAffinityMask(h, 1);
  
    std::cout << "\nPID:\t" << pid << "\nTID:\t" << tid;

    std::cout << "\nProcess priority:\t" << prty;
    switch (prty) {
    case IDLE_PRIORITY_CLASS:  std::cout << " --> IDLE_PRIORITY_CLASS"; break;
    case BELOW_NORMAL_PRIORITY_CLASS: std::cout << " --> BELOW_NORMAL_PRIORITY_CLASS"; break;
    case NORMAL_PRIORITY_CLASS: std::cout << " --> NORMAL_PRIORITY_CLASS"; break;
    case ABOVE_NORMAL_PRIORITY_CLASS: std::cout << " --> ABOVE_NORMAL_PRIORITY_CLASS"; break;
    case HIGH_PRIORITY_CLASS: std::cout << " --> HIGH_PRIORITY_CLASS"; break;
    case REALTIME_PRIORITY_CLASS: std::cout << " --> REALTIME_PRIORITY_CLASS"; break;
    default: std::cout << "error"; break;
    }

    std::cout << "\nThread priority:\t" << prth;
    switch (prth) {
    case THREAD_PRIORITY_LOWEST: std::cout << " --> THREAD_PRIORITY_LOWEST\n"; break;
    case THREAD_PRIORITY_BELOW_NORMAL: std::cout << " --> THREAD_PRIORITY_BELOW_NORMAL\n"; break;
    case THREAD_PRIORITY_NORMAL: std::cout << " --> THREAD_PRIORITY_NORMAL\n"; break;
    case THREAD_PRIORITY_ABOVE_NORMAL: std::cout << " --> THREAD_PRIORITY_ABOVE_NORMAL\n"; break;
    case THREAD_PRIORITY_HIGHEST: std::cout <<  " --> THREAD_PRIORITY_HIGHEST\n"; break;
    case THREAD_PRIORITY_IDLE: std::cout << " --> THREAD_PRIORITY_IDLE\n"; break;
    default: std::cout << "error"; break;
    }

    DWORD pa = NULL, sa = NULL, icpu = -1;
    if (!GetProcessAffinityMask(h, &pa, &sa)) throw "GetProcessAffinityMask";
    std::cout << "Process affinity mask:\t" << std::showbase << std::bitset<12>{pa} << "\n"; //Маска родства процесса отображает процессоры, на которых разрешается выполнение потоков данного процесса.
    std::cout << "System Affinity Mask: " << std::showbase << std::bitset<12>{sa} << "\n"; //Маска родства системы отображает процессоры, сконфигурированные в системе.
    icpu = SetThreadIdealProcessor(hp, MAXIMUM_PROCESSORS);
    std::cout << "Processor: " << icpu << "\n";
    SYSTEM_INFO sys_info;
    GetSystemInfo(&sys_info);
    std::cout << "Max count processors: " << sys_info.dwNumberOfProcessors << std::endl;

    int numCores = 0;
    for (int i = 0; i < 32; ++i) {
        if (pa & (1 << i)) {
            ++numCores;
        }
    }

    std::cout << "Number of cores: " << numCores << "\n";
}

// GetPriorityClass - для получения приоритетного класса процесса
// SetThreadIdealProcessor: Это функция в Windows API, предназначенная для управления предпочтительным процессором для указанного потока. эта функция пытается найти кол-во идеально подходящих для процессоров для потока
// Данный метод toBinary принимает целое число n и возвращает его двоичное представление в виде строки. Он выполняет следующие действия:
// Затем число n делится на 2 с помощью оператора /, что эквивалентно сдвигу числа n вправо на один бит. Это происходит для обработки следующего бита в числе.


//Функция GetProcessAffinityMask используется в операционной системе Windows для получения информации о маске аффинитета процесса.Маска аффинитета определяет, на каких процессорных ядрах(или процессорах) процесс может выполняться.Давайте разберем код :
//
//cpp
//Copy code
//DWORD_PTR pa = NULL, sa = NULL, icpu = -1;
//if (!GetProcessAffinityMask(hp, &pa, &sa)) throw "GetProcessAffinityMask";
//pa(Process Affinity) - это переменная типа DWORD_PTR, в которую будет записана маска аффинитета процесса.Маска аффинитета представляет собой битовую маску, где каждый бит соответствует процессорному ядру.Если бит установлен в 1, это означает, что процесс может выполняться на соответствующем ядре.Если бит равен 0, процесс не может выполняться на этом ядре.
//
//sa(System Affinity) - это переменная типа DWORD_PTR, в которую будет записана маска аффинитета для системы.Эта маска указывает, на каких процессорных ядрах может выполняться весь компьютер.Обычно она используется для ограничения доступных ядер на уровне всей системы.
//
//icpu - это переменная, которая инициализируется значением - 1. Вероятно, она используется для обработки ошибок.Если вызов GetProcessAffinityMask завершается неудачно(например, из - за ошибки), то icpu останется - 1, и это может быть использовано для дальнейшей обработки ошибки.
//
//GetProcessAffinityMask(hp, &pa, &sa) вызывает функцию GetProcessAffinityMask с указанным дескриптором процесса hp.Результат выполнения этой функции будет записан в pa(маска аффинитета процесса) и sa(маска аффинитета для системы).Если вызов функции завершится успешно, код продолжит выполнение.В противном случае будет сгенерировано исключение с сообщением "GetProcessAffinityMask".
//
//В итоге, после выполнения этого кода, pa будет содержать информацию о том, на каких процессорных ядрах может выполняться указанный процесс, и sa будет содержать маску аффинитета для всей системы.Это может быть полезной информацией для управления распределением процессов по процессорным ядрам.