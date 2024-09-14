using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFunctionality : MonoBehaviour
{
    [SerializeField]
    Transform target;
    float scrollSpeed = 6f;    // скорость вращения и передвижения камеры
    int rotationSensivity = 24;
    float maxDistance = 10f;
    float minDistance = 4f;

    public AudioSource shootSound;
    public GameObject targetHit1;
    public GameObject targetHit2;
    public GameObject targetHit3;

    void Start()
    {
        transform.LookAt(target);
        startPosition = transform.position;
        startRotation = transform.rotation;

        transform.rotation *= Quaternion.Euler(0, 0, 80);
    }

    void FixedUpdate()
    {
        // Движение камеры влево-право, вниз-вверх ADSW.
        if (!Input.GetMouseButton(1) && (StateVariables.step < 6 || StateVariables.step > 14))
        {
            float x = Input.GetAxis("Horizontal");
            float y = Input.GetAxis("Vertical");
            if (x != 0 || y != 0)
            {
                Vector3 newPos = transform.position + (transform.TransformDirection(new Vector3(x, 0, 0)) + Vector3.up * y) / rotationSensivity;
                if (ControlDistance(Vector3.Distance(newPos, target.position)))
                {
                    transform.position = newPos;
                }
            }
        }
        // Приближение камеры колёсиком мыши.
        if (Input.GetAxis("Mouse ScrollWheel") != 0 && (StateVariables.step < 6 || StateVariables.step > 14))
        {
            //Vector3 newPos = transform.position + transform.TransformDirection(Vector3.forward
            //* Input.GetAxis("Mouse ScrollWheel") * scrollSpeed);
            //if (ControlDistance(Vector3.Distance(newPos, target.position))) transform.position = newPos;



            float zoomChange = Input.GetAxis("Mouse ScrollWheel") * scrollSpeed;
            Vector3 direction = target.position - transform.position;
            float distance = direction.magnitude;

            // Если мы пытаемся приблизиться и расстояние уже меньше минимального, или
            // если мы пытаемся удалиться и расстояние уже больше максимального, то
            // не применять изменение зума
            if ((zoomChange > 0 && distance <= minDistance) ||
                (zoomChange < 0 && distance >= maxDistance))
            {
                return;
            }

            transform.Translate(0, 0, zoomChange);
            // Проверяем новое расстояние после приближения/удаления
            distance = (target.position - transform.position).magnitude;
            // Если новое расстояние выходит за границы, корректируем позицию камеры
            if (distance < minDistance)
            {
                transform.position = target.position - direction.normalized * minDistance;
            }
            else if (distance > maxDistance)
            {
                transform.position = target.position - direction.normalized * maxDistance;
            }
        }

        // Вращение вокруг установки.
        if (Input.GetMouseButton(1) && (StateVariables.step < 5 || StateVariables.step > 14))
        {
            transform.RotateAround(target.position, Vector3.up, Input.GetAxis("Mouse X") * scrollSpeed);
        }

        if (move)
        {
            offset += speed;
            transform.position = Vector3.Lerp(startPosition, needPosition, offset);
            transform.rotation = Quaternion.Slerp(startRotation, needRotation, offset);
            if (offset >= 1)
            {
                move = false;
                offset = 0;
            }
        }
        //}

        // Функция ограничения пределов движения камеры.
        bool ControlDistance(float distance)
        {
            if (distance > minDistance && distance < maxDistance)
            {
                return true;
            }
            return false;
            //return distance > minDistance && distance < maxDistance;
        }
        bool ControlDistance2(float distance, float currentMinDistance)
        {
            return distance > currentMinDistance && distance < maxDistance;
        }
    }

    Vector3 startPosition;
    Vector3 needPosition;
    bool move = false;
    float speed = 0.07f;
    float offset = 0;
    Quaternion startRotation;
    Quaternion needRotation;

    //public Transform target2; // Переменная для хранения объекта, к которому будет приближаться камера

    public void Zoom(Transform targetObject)
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(targetObject.position.x, targetObject.position.y + 3f, targetObject.position.z);
        }
    }

    public void GoShooting(Transform targetObject)
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(36.82f, 10.64f, -11.35f);
            needRotation = Quaternion.Euler(-0.529f, -87.166f, -0.878f);
        }
    }


    public void SetDefault()
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(42.5f, 16.14f, -11.56f);
            needRotation = Quaternion.Euler(89.052f, -155.025f, -67.854f);
        }
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.E) && StateVariables.step == 5 && !move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(32.549f, 10.652f, -15.088f);
            needRotation = Quaternion.Euler(-0.9440001f, -123.215f, -0.027f);
        }

        if (StateVariables.step == 6 && Input.GetMouseButton(0))
        {
            if (shootSound != null)
            {
                shootSound.Play();
            }

            if (targetHit1 != null)
            {
                targetHit1.SetActive(true);
            }

            // Обработка для случая StateVariables.step == 6
            StartCoroutine(ShootEffect());
        }

        if (Input.GetKeyDown(KeyCode.E) && StateVariables.step == 8 && !move)
        {
            //transform.rotation *= Quaternion.Euler(0, 90, 0);
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(26.57f, 10.71f, -11.76f);
            needRotation = Quaternion.Euler(-0.645f, -77.9f, -0.6900001f);
        }

        if (StateVariables.step == 9 && Input.GetMouseButton(0))
        {
            if (shootSound != null)
            {
                shootSound.Play();
            }

            if (targetHit2 != null)
            {
                targetHit2.SetActive(true);
            }

            // Обработка для случая StateVariables.step == 6
            StartCoroutine(ShootEffect());
        }

        if (Input.GetKeyDown(KeyCode.E) && StateVariables.step == 11 && !move)
        {
            //transform.rotation *= Quaternion.Euler(0, 90, 0);
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(28.27f, 9.36f, -3.78f);
            needRotation = Quaternion.Euler(-0.645f, -77.9f, -0.6900001f);
        }

        if (StateVariables.step == 12 && Input.GetMouseButton(0))
        {
            if (shootSound != null)
            {
                shootSound.Play();
            }

            if (targetHit3 != null)
            {
                targetHit3.SetActive(true);
            }

            // Обработка для случая StateVariables.step == 6
            StartCoroutine(ShootEffect());
        }

        if (Input.GetKeyDown(KeyCode.E) && StateVariables.step == 14 && !move)
        {
            //transform.rotation *= Quaternion.Euler(0, 90, 0);
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(42.5f, 16.14f, -11.56f);
            needRotation = Quaternion.Euler(89.052f, -155.025f, -67.854f);
            StateVariables.step = 15;
        }
    }

    IEnumerator ShootEffect()
    {
        // Поворот камеры
        float startTime = Time.time;
        float duration = 0.3f; // Длительность анимации поворота
        Quaternion initialRotation = transform.rotation;
        Quaternion targetRotation = Quaternion.Euler(-55f, transform.eulerAngles.y, transform.eulerAngles.z); // Поворот на 90 градусов вниз

        while (Time.time - startTime < duration)
        {
            float t = (Time.time - startTime) / duration;
            transform.rotation = Quaternion.Slerp(initialRotation, targetRotation, t);
            yield return null;
        }

        // Возвращение камеры в исходное положение
        startTime = Time.time;
        duration = 1f; // Длительность анимации возвращения
        initialRotation = transform.rotation;
        targetRotation = Quaternion.Euler(-0.9440001f, -123.215f, -0.027f); // Исходная ориентация камеры
        if (StateVariables.step == 9) targetRotation = Quaternion.Euler(-0.645f, -77.9f, -0.6900001f);
        if (StateVariables.step == 12) targetRotation = Quaternion.Euler(-0.645f, -77.9f, -0.6900001f);

        while (Time.time - startTime < duration)
        {
            float t = (Time.time - startTime) / duration;
            transform.rotation = Quaternion.Slerp(initialRotation, targetRotation, t);
            yield return null;
        }

        // Убеждаемся, что камера точно возвращена в исходную ориентацию
        transform.rotation = targetRotation;
        if (StateVariables.step == 6) StateVariables.step = 7;
        if (StateVariables.step == 9) StateVariables.step = 10;
        if (StateVariables.step == 12) StateVariables.step = 13;
    }
}
