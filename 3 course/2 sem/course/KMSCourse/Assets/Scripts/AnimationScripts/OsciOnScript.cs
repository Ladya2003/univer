using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class OsciOnScript : MonoBehaviour
{
    Animator anim;
    public GameObject sphereObject;
    Renderer sphereRenderer;
    public Material materialDot;
    public Material materialClean;
    public GameObject OsciScreen;
    void Start(){
        anim = GetComponent<Animator>();
        sphereRenderer = sphereObject.GetComponent<Renderer>();     
    }
    void OnMouseDown() {
        if (StateVariables.step == 1)
        {
            anim.SetBool("isOnOsci", true);
            sphereRenderer.material.color = Color.green;
            OsciScreen.GetComponent<Renderer>().material = materialDot;
            StateVariables.step = 2;
        }
    }
    void Update()
    {
        if (StateVariables.step == 11)
        {
            if (Input.GetKeyDown(KeyCode.E))
            {
                anim.SetBool("isOnOsci", false);
                sphereRenderer.material.color = Color.red;
                OsciScreen.GetComponent<Renderer>().material = materialClean;
                StateVariables.step = 12;
            }
        }
            

}
}