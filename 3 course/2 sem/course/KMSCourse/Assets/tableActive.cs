using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class tableActive : MonoBehaviour
{
    [SerializeField]
    public GameObject Elements;
    [SerializeField]
    private Sprite[] sprites;
    public void Start()
    {
        Elements.SetActive(false);
    }

    public void OnPointerClick()
    {
        int step = StateVariables.step; // Получаем текущее значение step
        Image imageComponent = Elements.GetComponent<Image>(); // Получаем компонент Image

        switch (step)
        {
            case 7:
                imageComponent.sprite = sprites[0]; // Устанавливаем спрайт для шага 7
                break;
            case 10:
                imageComponent.sprite = sprites[1]; // Устанавливаем спрайт для шага 10
                break;
            case 13:
                imageComponent.sprite = sprites[2]; // Устанавливаем спрайт для шага 13
                break;
        }

        if (StateVariables.step == 7)
        {
            bool activeState = Elements.activeSelf;
            Elements.SetActive(!activeState);
            if (activeState)
            {
                StateVariables.step = 8;
            }
        }

        if (StateVariables.step == 10)
        {
            bool activeState = Elements.activeSelf;
            Elements.SetActive(!activeState);
            if (activeState)
            {
                StateVariables.step = 11;
            }
        }

        if (StateVariables.step >= 13)
        {
            bool activeState = Elements.activeSelf;
            Elements.SetActive(!activeState);
            if (activeState)
            {
                StateVariables.step = 14;
            }
        }
    }
}
