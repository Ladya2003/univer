#include <Windows.h>
#include <iostream>

using namespace std;

int main()
{
    DWORD pid = GetCurrentProcessId();
    DWORD tid = GetCurrentThreadId();

    for (int i = 0; i < 1000; i++)
    {
        cout << i << " " << "PID: " << pid << " " << " TID: " << tid << " " << endl;
        Sleep(1000);
    }
}












// В контексте Windows API, DWORD обычно представляет собой 32-битное беззнаковое целое число, что означает, 
// что оно может представлять значения от 0 до 4,294,967,295.