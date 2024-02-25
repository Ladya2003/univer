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
        В=0xc2
        а=0xe0
        к=0xea
        Страница C2 = 194, смещение e0e=3598
        адрес страницы 4096 * 194 = 794 624(10) = 0x000C2000
        смещение 0x0072B830 => 3598 (3596) (e0e)
        адрес смещения = 794 624 + 3596 = 798220, 0xC2E0C
        (798220)/4 (sizeof(int) = 4) = 199 555 (число которое будет хранится по адресу памяти нашего смещения)
    */

    const int targetPage = 205;
    const int offset = 3598;

    int* value = arr + (targetPage * PAGE_SIZE + offset) / sizeof(int);

    cout << "Значение: " << *value << endl;
    cout << "Адрес: " << hex << value << endl;

    system("pause");

    return 0;
}














//
//memory = (int*)VirtualAlloc(NULL, PAGES * PAGESIZE, MEM_COMMIT, PAGE_READWRITE);
//NULL: Это указатель на начало региона виртуальной памяти, куда будет произведено выделение.В данном случае используется NULL, что означает, что операционная система сама выберет подходящий адрес.
//
//PAGES* PAGESIZE : Это размер в байтах, который выделяется для виртуальной памяти.PAGES представляет количество страниц, а PAGESIZE - размер каждой страницы.Общий размер виртуальной памяти будет равен произведению этих двух значений.
//
//MEM_COMMIT : Этот флаг указывает, что выделенная виртуальная память должна быть немедленно физически выделена.В противном случае, она просто резервируется, и физическая память выделяется при первом обращении к ней.
//
//PAGE_READWRITE : Это флаг, указывающий, что выделенная виртуальная память должна быть доступна для чтения и записи.Это означает, что вы сможете читать и записывать данные в этот участок памяти.









//#include <iostream>
//#include <cstdint>
//#include <cstring>
//#include <Windows.h>
//
//int main() {
//    const int PAGESIZE = 4096; // Размер страницы в байтах
//    const int PAGES = 256; // Количество страниц
//    const int ARRAYSIZE = PAGES * PAGESIZE / sizeof(int); // Размер массива
//
//    int* memory;
//
//    memory = (int*)VirtualAlloc(NULL, PAGES * PAGESIZE, MEM_COMMIT, PAGE_READWRITE);
//
//    for (int i = 0; i < ARRAYSIZE; ++i) {
//        memory[i] = i;
//    }
//
//    memory[0] = 0xc2;//В
//    //memory[1] = 0xe0;//а
//    //memory[2] = 0xea;//к
//
//    //Страница - 194(c2) - 0x0000C2
//    //Смещение - 3598(e0e) - 3596 - e0c
//    //Адрес - 4096 * 205 = 839680(10) = 0x0000000000000EDD
//    //0x0072B830
//    //адрес смещения = 839680 + 3596 = 843 276, 0xCDE0C
//    //843276/4 (sizeof(int) = 4) = 210 819 (число которое будет хранится по адресу памяти нашего смещения)
//
//    VirtualFree(memory, 0, MEM_RELEASE);
//
//    return 0;
//}










//const int PAGE_SIZE = 4096;
//const int NUM_PAGES = 256;
//
//int main() {
//    uint8_t* memory = new uint8_t[PAGE_SIZE * NUM_PAGES];
//
//    int* intArray = reinterpret_cast<int*>(memory);
//
//    for (int i = 0; i < PAGE_SIZE * NUM_PAGES / sizeof(int); ++i) {
//        intArray[i] = i + 1;
//    }
//
//    intArray[0] = 0xc2; // В
//    intArray[1] = 0xe0; // а
//    intArray[2] = 0xea; // к
//
//    int pageNumber = intArray[0];
//    int offset = ((intArray[1] & 0xFF) << 4) | (intArray[2] >> 4);
//    int address = pageNumber * PAGE_SIZE + offset;
//
//    std::cout << "Адрес для поиска: " << std::hex << address << std::endl;
//
//
//    delete[] memory;
//
//    return 0;
//}





















//explanation
// 
// 
//#include <iostream>
//#include <cstdint>
//#include <cstring>
//
//const int PAGE_SIZE = 4096; // Размер страницы в байтах
//const int NUM_PAGES = 256; // Количество страниц
//
//int main() {
//    // Выделение памяти для 256 страниц
//    uint8_t* memory = new uint8_t[PAGE_SIZE * NUM_PAGES];
//
//    // Размещение массива int, занимающего все 256 страниц. Приведение типов: Создается указатель intArray, который интерпретирует выделенную область памяти как массив целых чисел (int). Таким образом, каждые четыре байта в массиве memory будут представлять одно целое число.
//    int* intArray = reinterpret_cast<int*>(memory);
//
//    // Заполнение массива нарастающей последовательностью чисел с шагом 1
//    for (int i = 0; i < PAGE_SIZE * NUM_PAGES / sizeof(int); ++i) {
//        intArray[i] = i + 1;
//    }
//
//    // Запись 3 первых букв фамилии в кодировке Windows-1251
//    intArray[0] = 0xc2; // В
//    intArray[1] = 0xe0; // а
//    intArray[2] = 0xea; // к
//
//    // Вычисление адреса для поиска значения
//    int pageNumber = intArray[0];
//    int offset = ((intArray[1] & 0xFF) << 4) | (intArray[2] >> 4);
//    int address = pageNumber * PAGE_SIZE + offset;
//
//    // Вывод адреса для проверки
//    std::cout << "Адрес для поиска: " << std::hex << address << std::endl;
//
//    // Используйте отладчик для проверки значения в найденном адресе
//
//    // Освобождение выделенной памяти
//    delete[] memory;
//
//    return 0;
//}




//     int offset = ((intArray[1] & 0xFF) << 4) | (intArray[2] >> 4);
//intArray[1] & 0xFF: Здесь берется второй элемент массива intArray(это один из байт, представляющих второе число в массиве) и применяется побитовая операция "И" с 0xFF. Оператор & 0xFF используется для того, чтобы обнулить все биты, кроме младших 8, таким образом, оставить только младший байт.
//
//<< 4: Полученное значение сдвигается влево на 4 бита.Это эквивалентно умножению на 16 (2 в степени 4).
//
//(intArray[2] >> 4) : Третий элемент массива intArray(байт, представляющий третье число в массиве) подвергается операции сдвига вправо на 4 бита.Это также эквивалентно делению на 16 (2 в степени 4).
//
//| : Затем результаты первого и второго шагов объединяются при помощи операции "ИЛИ".Это соединение происходит так, что биты, установленные в intArray[1], остаются на своих местах, а биты, установленные в intArray[2], сдвигаются влево на 4 бита и добавляются к результату.
//
//Таким образом, в результате выполнения этой конструкции получается значение offset, которое соответствует комбинации бит второго и третьего элементов массива intArray.В контексте данной программы, эти значения используются для вычисления адреса в массиве memory для поиска значения.
