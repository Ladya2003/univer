#include <iostream>
#include <cstdint>
#include <cstring>

const int PAGE_SIZE = 4096;
const int NUM_PAGES = 256;

int main() {
    uint8_t* memory = new uint8_t[PAGE_SIZE * NUM_PAGES];

    int* intArray = reinterpret_cast<int*>(memory);

    for (int i = 0; i < PAGE_SIZE * NUM_PAGES / sizeof(int); ++i) {
        intArray[i] = i + 1;
    }

    intArray[0] = 0xc2; // В
    intArray[1] = 0xe0; // а
    intArray[2] = 0xea; // к

    int pageNumber = intArray[0];
    int offset = ((intArray[1] & 0xFF) << 4) | (intArray[2] >> 4);
    int address = pageNumber * PAGE_SIZE + offset;

    std::cout << "Адрес для поиска: " << std::hex << address << std::endl;

    delete[] memory;

    return 0;
}



















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
//    // 0xe0e
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