#include <iostream>
#include <ctime>
#include <Windows.h>

DWORD WINAPI A();
DWORD WINAPI B();

void LockSemaph();
void UnlockSemaph();

int check = 0;

int main() {
	DWORD AId = NULL, BId = NULL;
	HANDLE hA = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)A, NULL, 0, &AId);
	HANDLE hB = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)B, NULL, 0, &BId);

	WaitForSingleObject(hA, INFINITY);	
	WaitForSingleObject(hB, INFINITY);
	CloseHandle(hA); 
	CloseHandle(hB);

	system("pause");
	return 0;
}

DWORD WINAPI A() {
	int start = clock();

	LockSemaph();
	for (int i = 0; i < 5; i++) {
		std::cout << "A:" << i << ", time: " << clock() - start << std::endl;
	}
	UnlockSemaph();

	return 0;
}

DWORD WINAPI B() {
	int start = clock();

	LockSemaph();
	for (int i = 0; i < 5; i++) {
		std::cout << "B:" << i << ", time: " << clock() - start << std::endl;
	}
	UnlockSemaph();

	return 0;
}

void LockSemaph() {
	_asm {
	CriticalSection:
		lock bts check, 0;
		jc CriticalSection
	}
}

void UnlockSemaph() {
	_asm lock btr check, 0
}