using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class MenuMain : MonoBehaviour
{
    [SerializeField]
    Text message;
    public GameObject Amper;
    public GameObject capacitor;
    public GameObject ressistBox;
    public GameObject Voltmetr;
    public GameObject oscilloscope;
    public GameObject torus;
   
    public Material RedMaterial;
    private static Material VoltmetrDefaultMaterial;
    private static Material AmperDefaultMaterial;
    private static Material CapacitorDefaultMaterial;
    private static Material RessistBoxDefaultMaterial;
    private static Material OscilloscopeDefaultMaterial;
    private static Material TorusDefaultMaterial;
    public string defaultText;

    public void Start()
    {
        defaultText = message.text;
        VoltmetrDefaultMaterial = Voltmetr.GetComponent<Renderer>().material;
        AmperDefaultMaterial = Amper.GetComponent<Renderer>().material;
        CapacitorDefaultMaterial = capacitor.GetComponent<Renderer>().material;
        RessistBoxDefaultMaterial = ressistBox.GetComponent<Renderer>().material;
        OscilloscopeDefaultMaterial = oscilloscope.GetComponent<Renderer>().material;
        TorusDefaultMaterial = torus.GetComponent<Renderer>().material;
    }

    public void InfoAmper()
    {
        message.text = "Амперметр - это прибор, который измеряет силу электрического тока в амперах.";
    }


    public void InfoCapacitor()
    {
        message.text = "Конденсатор - это устройство, которое накапливает заряд и энергию электрического поля.";
    }


    public void InfoResistBox()
    {
        message.text = "Магазин электрического сопротивления - это набор образцовых резисторов, которые используются в качестве мер электрического сопротивления.";
    }


    public void InfoVoltmetr()
    {
        message.text = "Лабораторные автотрансформаторы (вольметры) - это устройства, которые позволяют плавно и точно регулировать выходное напряжение.";
    }


    public void InfoOscilloscope()
    {
        message.text = "Осциллограф - это прибор, который используется для исследования амплитудных и временных параметров электрического сигнала.";
    }
    
    public void InfoTorus()
    {
        message.text = "Тороидальные катушки - это электрические компоненты, которые состоят из металлического сердечника в форме кольца, на который наматывается провод.";
    }
    public void OnExit()
    {
        message.text = defaultText;
    }

    
    public void HighliteAmper()          
    {
        Amper.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultAmper()          
    {
        Amper.GetComponent<Renderer>().material = AmperDefaultMaterial;
    }
   

    
    public void HighliteCapacitor()          
    {
        capacitor.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultCapacitor()          
    {
        capacitor.GetComponent<Renderer>().material = CapacitorDefaultMaterial;
    }
    

      
    public void HighliteResistBox()          
    {
        ressistBox.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultResistBox()          
    {
        ressistBox.GetComponent<Renderer>().material = RessistBoxDefaultMaterial;
    }
   

    
    public void HighliteVoltmetr()          
    {
        Voltmetr.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultVoltmetr()          
    {
        Voltmetr.GetComponent<Renderer>().material = VoltmetrDefaultMaterial;
    }
    
    public void HighliteOscilliscope()          
    {
        oscilloscope.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultOscilloscope()          
    {
        oscilloscope.GetComponent<Renderer>().material = OscilloscopeDefaultMaterial;
    }
    
    public void HighliteTorus()          
    {
        torus.GetComponent<Renderer>().material = RedMaterial;
    }
    public void DefaultTorus()          
    {
        torus.GetComponent<Renderer>().material = TorusDefaultMaterial;
    }
    
}
