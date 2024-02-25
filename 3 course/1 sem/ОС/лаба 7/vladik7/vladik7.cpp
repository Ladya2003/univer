#include <iostream>
#include <Windows.h>
#include <ctime>

using namespace std;

void main() {
    time_t currTime;
    currTime = time(&currTime);
    tm localCurrTime;
    localtime_s(&localCurrTime, &currTime);
    cout << localCurrTime.tm_mday << '.' << localCurrTime.tm_mon << '.' << localCurrTime.tm_year + 1900 << ' ';
    cout << localCurrTime.tm_hour << ':' << localCurrTime.tm_min << ':' << localCurrTime.tm_sec << endl;
}




















//
//time_t currTime; : Объявляется переменная currTime типа time_t, которая представляет собой тип данных для хранения времени в формате Unix time(количество секунд, прошедших с 1 января 1970 года).
//
//currTime = time(&currTime); : Функция time() используется для получения текущего времени в формате Unix time.Она принимает указатель на переменную currTime, в которую будет записан результат.Таким образом, после выполнения этой строки переменная currTime содержит текущее время в формате Unix time.
//
//tm localCurrTime; : Создается структура tm с именем localCurrTime.tm - это структура, которая содержит информацию о времени, такую как год, месяц, день, час, минута и т.д.
//
//localtime_s(&localCurrTime, &currTime); : Функция localtime_s() преобразует время из формата Unix time в локальное время и заполняет структуру localCurrTime соответствующими данными.В данном случае, она принимает указатель на структуру localCurrTime и указатель на переменную currTime с текущим временем.

// прибавляем 1900 потому что счет идет с 1900 года
// зачем переводить из unix в локальное?
// чтобы было читаемо. т.к. unix хранит время в секундах
// Преобразование в локальное время позволяет учитывать часовой пояс и другие локальные аспекты времени.