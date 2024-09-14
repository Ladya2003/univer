using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PractiseBegin : MonoBehaviour
{
    [SerializeField]
    Text message;

    public void StartPractice()
    {
        if (StateVariables.step != 19) StateVariables.step = 1;
    }

    void Update()
    {
        switch (StateVariables.step)
        {
            case 1:
                message.text = "Insert the magazine located at the top of the table";
                break;
            case 2:
                message.text = "Connect the Aiming Base, which is located to the right of the main weapon component";
                break;
            case 3:
                message.text = "Attach the Sighting Chassis to the top of the Sighting Base for improved stability";
                break;
            case 4:
                message.text = "Connect Optical Sight for shooting accuracy";
                break;
            case 5:
                message.text = "Weapon assembly is complete! Press the E key to pick up a weapon and start shooting";
                break;
            case 6:
                message.text = "Press the Left Mouse Button to pull the trigger and shoot at the 1st target";
                break;
            case 7:
                message.text = "Great! The shot was fired. Check the results table.";
                break;
            case 8:
                message.text = "Press E to move to the 2nd target";
                break;
            case 9:
                message.text = "Click Left Mouse Button to shoot the 2nd target";
                break;
            case 10:
                message.text = "Good hit! The result is entered into the table.";
                break;
            case 11:
                message.text = "Press E to move to the 3rd target";
                break;
            case 12:
                message.text = "Click Left Mouse Button to shoot the 3rd target";
                break;
            case 13:
                message.text = "Very sharp eye! The result of the last shot is already in the table!";
                break;
            case 14:
                message.text = "To disassemble a weapon, press E.\r\n";
                break;
            case 15:
                message.text = "Unfasten the Scope";
                break;
            case 16:
                message.text = "Get the Scope Shassi";
                break;
            case 17:
                message.text = "Unhook the Scope Base";
                break;
            case 18:
                message.text = "Deteach Magazine";
                break;
            case 19:
                message.text = "Disassembly is complete! Now you know how to operate the P90. Congratulations!";
                break;
        }
    }
}
