#include <iostream>
#include <Windows.h>

using namespace std;

#define PAGE_SIZE (4096)
int numPages = 256;

int main() {
    setlocale(LC_ALL, "rus");

    int* arr = (int*)VirtualAlloc(NULL, numPages * PAGE_SIZE, MEM_COMMIT, PAGE_READWRITE);

    for (int i = 0; i < numPages * PAGE_SIZE / sizeof(int); i++) {
        arr[i] = i;
    }

    /*
        Н=CD=205
	    е=E5=229
	    х=F5=245
	    Страница C1 = 205, смещение E5F=3679
	    адрес страницы 4096 * 205 = 839680(10) = 0x000CD000
	    смещение 0x00000E5F => 3679 (3676)
        адрес смещения = 839680 + 3676 = 843 356, 0xCDE5C
	    (843356)/4 (sizeof(int) = 4) = 210839 = 33797
    */

    const int targetPage = 205;
    const int offset = 3679;

    int* value = arr + (targetPage * PAGE_SIZE + offset) / sizeof(int);

    cout << "Значение: " << *value << endl;
    cout << "Адрес: " << hex << value << endl;

    system("pause");

    return 0;
}