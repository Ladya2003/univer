using Microsoft.AspNetCore.Mvc;

namespace _1_get_HttpHandler.Controllers
{
    [Route("api/VVS")] // чтобы получить доступ к этим файлам
    [ApiController]
    public class VVSController : ControllerBase
    {

        [HttpGet]  // 1 задание
        public IActionResult GetHandler(string ParmA, string ParmB)
        {
            string response = $"GET-Http-VVS:ParmA = {ParmA},ParmB = {ParmB}";
            return Content(response, "text/plain");
        }

        [HttpPost]  // 2 задание
        public IActionResult PostHandler(string ParmA, string ParmB)
        {
            string response = $"POST-Http-VVS:ParmA = {ParmA},ParmB = {ParmB}";
            return Content(response, "text/plain");
        }

        [HttpPut]  // 3 задание
        public IActionResult PUTHandler(string ParmA, string ParmB)
        {
            string response = $"PUT-Http-VVS:ParmA = {ParmA},ParmB = {ParmB}";
            return Content(response, "text/plain");
        }

    }
}

// localhost:5050/api/VVS?ParmA=vladik&ParmB=vakulenchik