using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TableScript : MonoBehaviour
{
    Image tableCanvas;
    private bool isCanvasVisible;
    private bool isTableClicked;
    public InputField _021;
    public InputField _022;
    public InputField _023;
    public InputField _024;
    public Text _025;
    public Text _026;
    public Text _027;
    public Text _028;

    public InputField _041;
    public InputField _042;
    public InputField _043;
    public InputField _044;
    public Text _045;
    public Text _046;
    public Text _047;
    public Text _048;

    public InputField _061;
    public InputField _062;
    public InputField _063;
    public InputField _064;
    public Text _065;
    public Text _066;
    public Text _067;
    public Text _068;
    public void Start()
    {
        tableCanvas = GetComponent<Image>();
        isCanvasVisible = false;
        tableCanvas.gameObject.SetActive(isCanvasVisible);
    }
    public void TableShow()
    {
        if (StateVariables.step > 0)
        {
            if (StateVariables.step == 4)
            {
                if (_021.text != "" && _022.text != "" && _023.text != "" && _024.text != "")
                {
                    if (double.TryParse(_021.text, out double value021) &&
                        double.TryParse(_022.text, out double value022) &&
                        double.TryParse(_023.text, out double value023) &&
                        double.TryParse(_024.text, out double value024))
                    {
                        _025.text = (0.5 * 1 * double.Parse(_021.text) * 2900 / (2 * 3.14 * 0.5 * 0.0085)).ToString("F2");
                        _026.text = (0.0085 * 0.0000006 * 0.5 * 1 * double.Parse(_023.text) / (3 * 0.00000000003)).ToString("F2");
                        _027.text = (0.5 * 1 * double.Parse(_022.text) * 2900 / (2 * 3.14 * 0.5 * 0.0085)).ToString("F2");
                        _028.text = (0.0085 * 0.0000006 * 0.5 * 1 * double.Parse(_024.text) / (3 * 0.00000000003)).ToString("F2");
                        StateVariables.step = 5;
                    }
                    else
                    {
                        _025.text = "       -------";
                        StateVariables.step = 4;
                    }
                }
                else
                {
                    _025.text = "       -------";
                    StateVariables.step = 4;
                }
            }

            if (StateVariables.step == 6)
            {
                if (_041.text != "" && _042.text != "" && _043.text != "" && _044.text != "")
                {
                    if (double.TryParse(_041.text, out double value021) &&
                        double.TryParse(_042.text, out double value022) &&
                        double.TryParse(_043.text, out double value023) &&
                        double.TryParse(_044.text, out double value024))
                    {
                        _045.text = (0.5 * 1 * double.Parse(_041.text) * 2900 / (2 * 3.14 * 0.5 * 0.0085)).ToString("F2");
                        _046.text = (0.0085 * 0.0000006 * 0.5 * 1 * double.Parse(_043.text) / (3 * 0.00000000003)).ToString("F2");
                        _047.text = (0.5 * 1 * double.Parse(_042.text) * 2900 / (2 * 3.14 * 0.5 * 0.0085)).ToString("F2");
                        _048.text = (0.0085 * 0.0000006 * 0.5 * 1 * double.Parse(_044.text) / (3 * 0.00000000003)).ToString("F2");
                        StateVariables.step = 7;
                    }
                    else
                    {
                        _045.text = "       -------";
                        StateVariables.step = 6;
                    }
                }
                else
                {
                    _045.text = "       -------";
                    StateVariables.step = 6;
                }
            }

            if (StateVariables.step == 8)
            {
                if (_061.text != "" && _062.text != "" && _063.text != "" && _064.text != "")
                {
                    if (double.TryParse(_061.text, out double value021) &&
                        double.TryParse(_062.text, out double value022) &&
                        double.TryParse(_063.text, out double value023) &&
                        double.TryParse(_064.text, out double value024))
                    {
                        _065.text = (0.5 * 1 * double.Parse(_061.text) * 2900 / (2 * 3.14 * 0.5 * 0.0085)).ToString("F2");
                        _066.text = (0.0085 * 0.0000006 * 0.5 * 1 * double.Parse(_063.text) / (3 * 0.00000000003)).ToString("F2");
                        _067.text = (0.5 * 1 * double.Parse(_062.text) * 2900 / (2 * 3.14 * 0.5 * 0.0085)).ToString("F2");
                        _068.text = (0.0085 * 0.0000006 * 0.5 * 1 * double.Parse(_064.text) / (3 * 0.00000000003)).ToString("F2");
                        StateVariables.step = 9;
                    }
                    else
                    {
                        _065.text = "       -------";
                        StateVariables.step = 8;
                    }
                }
                else
                {
                    _065.text = "       -------";
                    StateVariables.step = 8;
                }
            }

            isCanvasVisible = !isCanvasVisible;
            tableCanvas.gameObject.SetActive(isCanvasVisible);
        }
    }
    public void TableClear()
    {
        _021.text = string.Empty;
        _022.text = string.Empty;
        _023.text = string.Empty;
        _024.text = string.Empty;
        _025.text = "       -------";
        _026.text = "       -------";
        _027.text = "       -------";
        _028.text = "       -------";

        _041.text = string.Empty;
        _042.text = string.Empty;
        _043.text = string.Empty;
        _044.text = string.Empty;
        _045.text = "       -------";
        _046.text = "       -------";
        _047.text = "       -------";
        _048.text = "       -------";

        _061.text = string.Empty;
        _062.text = string.Empty;
        _063.text = string.Empty;
        _064.text = string.Empty;
        _065.text = "       -------";
        _066.text = "       -------";
        _067.text = "       -------";
        _068.text = "       -------";
    }
    void Update()
    {
        
    }
}
