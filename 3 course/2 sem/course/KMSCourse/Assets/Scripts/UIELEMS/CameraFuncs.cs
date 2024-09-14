using UnityEngine;

public class CameraFuncs : MonoBehaviour
{
    public Transform centralObject; // Центральный объект установки
    public float rotateSpeed = 50.0f; // Скорость вращения камеры
    public float moveSpeed = 5.0f; // Скорость передвижения камеры
    public int xLimit = 10; // Предел по X
    public int zLimit = 10; // Предел по Z
    public float zoomSpeed = 10.0f; // Скорость приближения/удаления

     public float minZoomDistance = 4f; // Минимальное расстояние до центр. объекта
    public float maxZoomDistance = 10.0f;

    void Start()
    {
        startPosition = transform.position;
        startRotation = transform.rotation;
    }
    private void Update()
    {
        RotateCamera();
        MoveCamera();
        ZoomCamera();
        //if (move)
        //{
        //    offset += speed;
        //    transform.position = Vector3.Lerp(startPosition, needPosition, offset);
        //    transform.rotation = Quaternion.Slerp(startRotation, needRotation, offset);
        //    if (offset >= 1)
        //    {
        //        move = false;
        //        offset = 0;
        //    }
        //}
    }

    private void RotateCamera()
    {
        // Вращение вокруг объекта при нажатии правой клавиши мыши
        if (Input.GetMouseButton(1)) // пкм
        {
            float h = rotateSpeed * Input.GetAxis("Mouse X") * Time.deltaTime;
            float v = rotateSpeed * Input.GetAxis("Mouse Y") * Time.deltaTime;

            transform.RotateAround(centralObject.position, Vector3.up, h); // вращение отнносильно центр. объекта
            transform.RotateAround(centralObject.position, transform.right, -v);  // -v - угол
        }
    }

    private void MoveCamera()
    {
        // Перемещение камеры клавишами WASD
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(horizontal, 0, vertical) * moveSpeed * Time.deltaTime;
        Vector3 newPosition = transform.position + movement;

        // Ограничения по X и Z
        newPosition.x = Mathf.Clamp(newPosition.x, centralObject.position.x - xLimit, centralObject.position.x + xLimit);
        newPosition.z = Mathf.Clamp(newPosition.z, centralObject.position.z - zLimit, centralObject.position.z + zLimit);

        transform.position = newPosition;
    }

    private void ZoomCamera()
    {
        // Приближение и удаление камеры колесиком мыши
        float zoomChange = Input.GetAxis("Mouse ScrollWheel") * zoomSpeed;
        Vector3 direction = centralObject.position - transform.position;
        float distance = direction.magnitude;

        // Если мы пытаемся приблизиться и расстояние уже меньше минимального, или
        // если мы пытаемся удалиться и расстояние уже больше максимального, то
        // не применять изменение зума
        if ((zoomChange > 0 && distance <= minZoomDistance) ||
            (zoomChange < 0 && distance >= maxZoomDistance))
        {
            return;
        }

        transform.Translate(0, 0, zoomChange);
        // Проверяем новое расстояние после приближения/удаления
        distance = (centralObject.position - transform.position).magnitude;
        // Если новое расстояние выходит за границы, корректируем позицию камеры
        if (distance < minZoomDistance)
        {
            transform.position = centralObject.position - direction.normalized * minZoomDistance;
        }
        else if (distance > maxZoomDistance)
        {
            transform.position = centralObject.position - direction.normalized * maxZoomDistance;
        }
    }

    Vector3 startPosition;
    Vector3 needPosition;
    bool move = false;
    float speed = 0.009f;
    float offset = 0;
    Quaternion startRotation;
    Quaternion needRotation;

    Vector3 currentPos;
    Quaternion currentRot;

    public void ZoomLATR()
    {
        SetZoomParams(new Vector3(4.26f, 4.09f, -1.59f), Quaternion.Euler(20f, -180f, 0f));
    }

    public void ZoomAmmeter()
    {
        SetZoomParams(new Vector3(3.47f, 3.71f, -2.48f), Quaternion.Euler(20f, -180f, 0f));
    }

    public void ZoomCapacitor()
    {
        SetZoomParams(new Vector3(-0.83f, 3.89f, -2.41f), Quaternion.Euler(20f, -180f, 0f));
    }

    public void ZoomOscilloscope()
    {
        SetZoomParams(new Vector3(-3.01f, 4.21f, -1.92f), Quaternion.Euler(20f, -180f, 0f));
    }

    public void ZoomResistBox()
    {
        SetZoomParams(new Vector3(1.24f, 3.82f, -2.54f), Quaternion.Euler(20f, -180f, 0f));
    }

    public void ZoomTorus()
    {
        SetZoomParams(new Vector3(2.34f, 3.75f, -2.5f), Quaternion.Euler(20f, -180f, 0f));
    }

    public void SetDefault()
    {
        SetZoomParams(new Vector3(0.144f, 3.3f, 3.87f), Quaternion.Euler(0, 180, 0));
    }

    private void SetZoomParams(Vector3 position, Quaternion rotation)
    {
        if (!move)
        {
            move = true;
            startPosition = transform.position;
            startRotation = transform.rotation;
            currentPos = position;
            currentRot = rotation;
        }
    }

}
