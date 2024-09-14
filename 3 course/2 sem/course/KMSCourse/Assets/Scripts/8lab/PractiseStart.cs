using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class PractiseStart : MonoBehaviour
{
    [SerializeField]
    Text message;
    public GameObject InputPanel;
    public GameObject Table;

    public void StartPractice()
    {
        StateVariables.step = 1;
    }

    void Update()
    {
        switch (StateVariables.step)
        {
            case 1:
                message.text = "Включите осциллограф";
                break;
            case 2:
                message.text = "Измените величину сопротивления R из диапазона 8,0−9,5 кОм на магазине сопротивлений";
                break;
            case 3:
                message.text = "Установите Вольтметром ток в обмотке тороида I = 0,2 А";
                break;
            case 4:
                message.text = "Запишите в делениях шкалы экрана координаты точек пересечения петли гистерезиса с осями координат Xk, Ykm и координаты вершин петли Xm, Ym";
                break;
            case 5:
                message.text = "Установите Вольтметром ток в обмотке тороида I = 0,4 А";
                break;
            case 6:
                message.text = "Запишите в делениях шкалы экрана координаты точек пересечения петли гистерезиса с осями координат Xk, Ykm и координаты вершин петли Xm, Ym";
                break;
            case 7:
                message.text = "Установите Вольтметром ток в обмотке тороида I = 0,6 А";
                break;
            case 8:
                message.text = "Запишите в делениях шкалы экрана координаты точек пересечения петли гистерезиса с осями координат Xk, Ykm и координаты вершин петли Xm, Ym";
                break;
            case 9:
                message.text = "Опыт выполнен! Молодцы! Инженер потратил на разработку три бессонные ночи! Возвращайтесь еще! Не забудьте выключить Вольтметр!";
                break;
            case 10:
                message.text = "Также выключьте Резисторы!";
                break;
            case 11:
                message.text = "И, напоследок, осциллограф (E)!";
                break;
            case 12:
                message.text = "Сделано специально на проверку Виктории Сергеевне!";
                break;
        }
    }
}
