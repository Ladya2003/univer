using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class ObjectHighlighter : MonoBehaviour
{
    public GameObject objectToChangeColor;
    public Camera mainCamera;
    private Color originalMaterial;
    private bool isRed = false;

    void Start()
    {
        originalMaterial = objectToChangeColor.GetComponent<Renderer>().material.color;

        Button button = GetComponent<Button>();
        button.onClick.AddListener(OnButtonClick);

        // Добавляем обработчики событий PointerEnter и PointerExit
        EventTrigger eventTrigger = button.gameObject.GetComponent<EventTrigger>();

        EventTrigger.Entry entryEnter = new EventTrigger.Entry();
        entryEnter.eventID = EventTriggerType.PointerEnter;
        entryEnter.callback.AddListener((data) => { OnPointerEnter(); });
        eventTrigger.triggers.Add(entryEnter);

        EventTrigger.Entry entryExit = new EventTrigger.Entry();
        entryExit.eventID = EventTriggerType.PointerExit;
        entryExit.callback.AddListener((data) => { OnPointerExit(); });
        eventTrigger.triggers.Add(entryExit);
    }

    public void OnPointerEnter()
    {
        // При наведении на кнопку изменяем цвет объекта
        objectToChangeColor.GetComponent<Renderer>().material.color = Color.red;
    }

    public void OnPointerExit()
    {
        // При выходе курсора за пределы кнопки возвращаем исходный цвет объекта
        objectToChangeColor.GetComponent<Renderer>().material.color = originalMaterial;
    }

    public void OnButtonClick()
    {
        // При щелчке на кнопке плавно передвигаем камеру к объекту
        Vector3 targetPosition = objectToChangeColor.transform.position;
        targetPosition.z -= 5; // Расстояние, на которое будет приближена камера
        mainCamera.transform.position = Vector3.Lerp(mainCamera.transform.position, targetPosition, Time.deltaTime * 2.0f);
    }
}
