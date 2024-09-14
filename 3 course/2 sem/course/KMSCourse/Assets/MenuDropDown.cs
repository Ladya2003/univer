using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MenuDropDown : MonoBehaviour
{
    [SerializeField]
    Text message;
    public GameObject Base;
    public GameObject Magazine;
    public GameObject Scope;
    public GameObject ScopeBase;
    public GameObject ScopeShasi;

    public GameObject Base1;
    public GameObject Base2;
    public GameObject Base3;
    public GameObject Base4;
    public GameObject Base5;
    public GameObject Base6;

    public GameObject Scope1;
    public GameObject Scope2;
    public GameObject Scope3;
    public GameObject Scope4;
    public GameObject Scope5;

    public GameObject ScopeBase2;

    public Material RedMaterial;
    private static Material BaseDefaultMaterial;
    private static Material MagazineDefaultMaterial;
    private static Material ScopeDefaultMaterial;
    private static Material ScopeBaseDefaultMaterial;
    private static Material ScopeShasiDefaultMaterial;

    private static Material Base1DefaultMaterial;
    private static Material Base2DefaultMaterial;
    private static Material Base3DefaultMaterial;
    private static Material Base4DefaultMaterial;
    private static Material Base5DefaultMaterial;
    private static Material Base6DefaultMaterial;

    private static Material Scope1DefaultMaterial;
    private static Material Scope2DefaultMaterial;
    private static Material Scope3DefaultMaterial;
    private static Material Scope4DefaultMaterial;
    private static Material Scope5DefaultMaterial;

    private static Material ScopeBase2DefaultMaterial;

    public string defaultText;

    public void Start()
    {
        defaultText = message.text;
        BaseDefaultMaterial = Base.GetComponent<Renderer>().material;
        MagazineDefaultMaterial = Magazine.GetComponent<Renderer>().material;
        ScopeDefaultMaterial = Scope.GetComponent<Renderer>().material;
        ScopeBaseDefaultMaterial = ScopeBase.GetComponent<Renderer>().material;
        ScopeShasiDefaultMaterial = ScopeShasi.GetComponent<Renderer>().material;

        Base1DefaultMaterial = Base1.GetComponent<Renderer>().material;
        Base2DefaultMaterial = Base2.GetComponent<Renderer>().material;
        Base3DefaultMaterial = Base3.GetComponent<Renderer>().material;
        Base4DefaultMaterial = Base4.GetComponent<Renderer>().material;
        Base5DefaultMaterial = Base5.GetComponent<Renderer>().material;
        Base6DefaultMaterial = Base6.GetComponent<Renderer>().material;

        Scope1DefaultMaterial = Scope1.GetComponent<Renderer>().material;
        Scope2DefaultMaterial = Scope2.GetComponent<Renderer>().material;
        Scope3DefaultMaterial = Scope3.GetComponent<Renderer>().material;
        Scope4DefaultMaterial = Scope4.GetComponent<Renderer>().material;
        Scope5DefaultMaterial = Scope5.GetComponent<Renderer>().material;

        ScopeBase2DefaultMaterial = ScopeBase2.GetComponent<Renderer>().material;
    }

    public void InfoBase()
    {
        message.text = "The P90 grip provides a comfortable and secure grip on the weapon, allowing the shooter to comfortably control the weapon while shooting.";
    }


    public void InfoMagazine()
    {
        message.text = "The P90 magazine is reliable and easy to use. With its help, you can quickly and easily load weapons and maintain a high level of firepower.";
    }


    public void InfoScope()
    {
        message.text = "The P90 Scope provides precise aiming and high shooting accuracy at medium and long distances. It is easy to set up and provides good target visibility.";
    }


    public void InfoScopeBase()
    {
        message.text = "The P90 Scope base ensures that the sight is securely attached to the weapon, which avoids movement or rattling during shooting.";
    }


    public void InfoScopeShasi()
    {
        message.text = "The P90 Scope Shassi is a durable, lightweight design that provides stability and stability while holding the weapon while shooting.";
    }

    public void OnExit()
    {
        message.text = defaultText;
    }


    public void HighliteBase()
    {
        Base.GetComponent<Renderer>().material = RedMaterial;
        Base1.GetComponent<Renderer>().material = RedMaterial;
        Base2.GetComponent<Renderer>().material = RedMaterial;
        Base3.GetComponent<Renderer>().material = RedMaterial;
        Base4.GetComponent<Renderer>().material = RedMaterial;
        Base5.GetComponent<Renderer>().material = RedMaterial;
        Base6.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultBase()
    {
        Base.GetComponent<Renderer>().material = BaseDefaultMaterial;
        Base1.GetComponent<Renderer>().material = Base1DefaultMaterial;
        Base2.GetComponent<Renderer>().material = Base2DefaultMaterial;
        Base3.GetComponent<Renderer>().material = Base3DefaultMaterial;
        Base4.GetComponent<Renderer>().material = Base4DefaultMaterial;
        Base5.GetComponent<Renderer>().material = Base5DefaultMaterial;
        Base6.GetComponent<Renderer>().material = Base6DefaultMaterial;
    }



    public void HighliteMagazine()
    {
        Magazine.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultMagazine()
    {
        Magazine.GetComponent<Renderer>().material = MagazineDefaultMaterial;
    }



    public void HighliteScope()
    {
        Scope.GetComponent<Renderer>().material = RedMaterial;
        Scope1.GetComponent<Renderer>().material = RedMaterial;
        Scope2.GetComponent<Renderer>().material = RedMaterial;
        Scope3.GetComponent<Renderer>().material = RedMaterial;
        Scope4.GetComponent<Renderer>().material = RedMaterial;
        Scope5.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultScope()
    {
        Scope.GetComponent<Renderer>().material = ScopeDefaultMaterial;
        Scope1.GetComponent<Renderer>().material = Scope1DefaultMaterial;
        Scope2.GetComponent<Renderer>().material = Scope2DefaultMaterial;
        Scope3.GetComponent<Renderer>().material = Scope3DefaultMaterial;
        Scope4.GetComponent<Renderer>().material = Scope4DefaultMaterial;
        Scope5.GetComponent<Renderer>().material = Scope5DefaultMaterial;
    }



    public void HighliteScopeBase()
    {
        ScopeBase.GetComponent<Renderer>().material = RedMaterial;
        ScopeBase2.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultScopeBase()
    {
        ScopeBase.GetComponent<Renderer>().material = ScopeBaseDefaultMaterial;
        ScopeBase2.GetComponent<Renderer>().material = ScopeBase2DefaultMaterial;
    }

    public void HighliteScopeShasi()
    {
        ScopeShasi.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultScopeShasi()
    {
        ScopeShasi.GetComponent<Renderer>().material = ScopeShasiDefaultMaterial;
    }
}
