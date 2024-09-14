using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraTransform : MonoBehaviour
{
    [SerializeField]
    Transform target;
    float scrollSpeed = 6f;    // скорость вращения и передвижения камеры
    int rotationSensivity = 24;
    float maxDistance = 10f;
    float minDistance = 4f;

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
        if (!Input.GetMouseButton(1))
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
        if (Input.GetAxis("Mouse ScrollWheel") != 0)
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
        if (Input.GetMouseButton(1))
        {
            transform.RotateAround(target.position, Vector3.up, Input.GetAxis("Mouse X") * scrollSpeed);
        }

        if (move)
        {
            offset += speed;
            transform.position = Vector3.Lerp(startPosition, needPosition, offset);
            transform.rotation = Quaternion.Slerp(startRotation, needRotaton, offset);
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
    Quaternion needRotaton;

    public void ZoomLATR()
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(4.26f, 4.09f, -1.59f);
            needRotaton = Quaternion.Euler(20f, -180f, 0f);
        }
    }

    public void ZoomAmmeter()
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(3.47f, 3.71f, -2.48f);
            needRotaton = Quaternion.Euler(20f, -180f, 0f);
        }
    }

    public void ZoomCapacitor()
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(-0.83f, 3.89f, -2.41f);
            needRotaton = Quaternion.Euler(20f, -180f, 0f);
        }
    }

    public void ZoomOscilloscope()
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(-3.01f, 4.21f, -1.92f);
            needRotaton = Quaternion.Euler(20f, -180f, 0f);
        }
    }

    public void ZoomResistBox()
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(1.24f, 3.82f, -2.54f);
            needRotaton = Quaternion.Euler(20f, -180f, 0f);
        }
    }

    public void ZoomTorus()
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(2.34f, 3.75f, -2.5f);
            needRotaton = Quaternion.Euler(20f, -180f, 0f);
        }
    }


    public void SetDefault()
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            needPosition = new Vector3(0.144f, 3.3f, 3.87f);
            needRotaton = Quaternion.Euler(0, 180, 0);
        }
    }
}
