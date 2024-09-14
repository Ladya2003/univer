using UnityEngine;
using System.Collections;

public class ScopeMoveTarget1 : MonoBehaviour
{
    public float targetY = 5f; // Конечная координата по оси Y

    void Update()
    {
        // Проверяем, если StateVariant равен 5
        if (Input.GetKeyDown(KeyCode.E) && (StateVariables.step == 5 || StateVariables.step == 8 || StateVariables.step == 11))
        {
            // Запускаем корутину с задержкой в 1 секунду
            StartCoroutine(MoveToTargetWithDelay(0.5f));
        }
    }

    IEnumerator MoveToTargetWithDelay(float delay)
    {
        // Ждем указанное время
        yield return new WaitForSeconds(delay);

        // Получаем текущую позицию объекта
        Vector3 currentPosition = transform.position;

        // Устанавливаем конечную позицию с заданным значением по оси Y
        Vector3 targetPosition = new Vector3(currentPosition.x, currentPosition.y + targetY, currentPosition.z);

        // Плавно перемещаем объект к целевой позиции
        float t = 0f;
        while (t < 1f)
        {
            t += Time.deltaTime;
            transform.position = Vector3.Lerp(currentPosition, targetPosition, t);
            yield return null;
        }
        if (StateVariables.step == 8) StateVariables.step = 9;
        if (StateVariables.step == 5) StateVariables.step = 6;
        if (StateVariables.step == 11) StateVariables.step = 12;
    }
}
