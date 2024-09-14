using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClickerRotateScript : MonoBehaviour
{
    [SerializeField] private Animator _lever;
    [SerializeField] private Animator _arrow;
    [SerializeField] private Animator _arrowAmper;
    public Material materialGraph02;
    public Material materialGraph04;
    public Material materialGraph06;
    public Material materialGraphClean;
    public GameObject OsciScreen;
    private int i1 = 0;
    private int i2 = 0;
    private int i3 = 0;

    public void OnMouseDown()
    {
        if (StateVariables.step == 3 || StateVariables.step == 5 || StateVariables.step == 7)
        {
            if (StateVariables.step == 5)
            {
                i2++;
                if (i2 == 1)
                {
                    _lever.SetBool("isClicked", false);
                    _arrow.SetBool("isStarted", false);
                    _arrowAmper.SetBool("isAmperAnim", false);
                }
                if (i2 == 2)
                {
                    _lever.SetBool("isClicked", true);
                    _arrow.SetBool("isStarted", true);
                    _arrowAmper.SetBool("isAmperAnim", true);
                    OsciScreen.GetComponent<Renderer>().material = materialGraph04;
                    StateVariables.step = 6;
                }
            }
            else if (StateVariables.step == 7) 
            {
                i1++;
                if (i1 == 1)
                {
                    _lever.SetBool("isClicked", false);
                    _arrow.SetBool("isStarted", false);
                    _arrowAmper.SetBool("isAmperAnim", false);
                }
                if (i1 == 2)
                {
                    _lever.SetBool("isClicked", true);
                    _arrow.SetBool("isStarted", true);
                    _arrowAmper.SetBool("isAmperAnim", true);
                    OsciScreen.GetComponent<Renderer>().material = materialGraph06;
                    StateVariables.step = 8;
                }
            }
            else
            {
                _lever.SetBool("isClicked", true);
                _arrow.SetBool("isStarted", true);
                _arrowAmper.SetBool("isAmperAnim", true);
                OsciScreen.GetComponent<Renderer>().material = materialGraph02;
                StateVariables.step = 4;
            }
        }

        if (StateVariables.step == 9)
        {
            _lever.SetBool("isClicked", false);
            _arrow.SetBool("isStarted", false);
            _arrowAmper.SetBool("isAmperAnim", false);
            OsciScreen.GetComponent<Renderer>().material = materialGraphClean;
            StateVariables.step = 10;
        }
    }
}
