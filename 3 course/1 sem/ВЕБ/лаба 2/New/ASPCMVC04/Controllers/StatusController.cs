using ASPCMVC04.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace ASPCMVC04.Controllers
{
	public class StatusController : Controller
	{
        //https://localhost:7126/Status/S200
		public IActionResult S200()
		{
			return Ok();
		}

        //https://localhost:7126/Status/S300
        public IActionResult S300()
		{
			return Redirect("https://www.belstu.by/");
		}

        //https://localhost:7126/Status/S500 + two times press f5
        public IActionResult S500()
        {
            int a = 1;
            int b = 2;
            try
            {
                int result = a / (b - 2);
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = ex.Message;
                Response.StatusCode = 500;
                return View("Error");
            }
        }

        //https://localhost:7126/Status/S404
        public IActionResult S404()
		{
			return NotFound(); 
		}


	}
}