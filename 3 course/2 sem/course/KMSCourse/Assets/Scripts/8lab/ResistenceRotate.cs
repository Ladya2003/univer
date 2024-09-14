using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResistenceRotate : MonoBehaviour
{
    Animator anim;
    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animator>();
    }
    public void OnMouseDown()
    {
        if (StateVariables.step == 2)
        {
            anim.SetBool("isResistenceOn", true);
            StateVariables.step = 3;
        }
        if (StateVariables.step == 10)
        {
            anim.SetBool("isResistenceOn", false);
            StateVariables.step = 11;
        }
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
