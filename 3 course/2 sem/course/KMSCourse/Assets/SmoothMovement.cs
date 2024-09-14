using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SmoothMovement : MonoBehaviour
{
    public Transform[] targetPositions; // Массив публичных переменных для хранения целевых точек перемещения
    public GameObject[] objectsToMove; // Массив публичных объектов, которые нужно перемещать

    public float speed = 5f; // Скорость перемещения объектов

    private bool isMoving = false; // Флаг для отслеживания состояния перемещения

    public int step;

    void Update()
    {
        // Проверяем, если нажата клавиша мыши и нажата на текущий объект
        if (Input.GetMouseButtonDown(0) && IsMouseOverObject() && StateVariables.step == step)
        {
            // Запускаем процесс плавного перемещения ко всем указанным точкам
            StartCoroutine(MoveToTargets());
            StateVariables.step = step + 1;
        }
    }

    IEnumerator MoveToTargets()
    {
        // Устанавливаем флаг перемещения в true
        isMoving = true;

        for (int i = 0; i < objectsToMove.Length; i++)
        {
            Transform currentTarget = targetPositions[i];

            // Получаем начальную позицию объекта
            Vector3 startPosition = objectsToMove[i].transform.position;

            // Цикл перемещения объекта к целевой точке
            while (Vector3.Distance(objectsToMove[i].transform.position, currentTarget.position) > 0.05f)
            {
                // Вычисляем новую позицию объекта
                Vector3 newPosition = Vector3.MoveTowards(objectsToMove[i].transform.position, currentTarget.position, speed * Time.deltaTime);

                // Применяем новую позицию объекта
                objectsToMove[i].transform.position = newPosition;

                // Ждем один кадр
                yield return null;
            }

            // Устанавливаем позицию объекта в точку точно равную целевой позиции, чтобы избежать погрешностей
            objectsToMove[i].transform.position = currentTarget.position;
        }

        // Устанавливаем флаг перемещения в false
        isMoving = false;
    }

    bool IsMouseOverObject()
    {
        // Создаем луч из позиции мыши в мировом пространстве
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;

        // Проверяем, сталкивается ли луч с текущим объектом
        if (Physics.Raycast(ray, out hit))
        {
            if (hit.collider.gameObject == gameObject)
            {
                return true;
            }
        }

        return false;
    }
}
