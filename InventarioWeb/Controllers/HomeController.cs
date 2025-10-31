using Microsoft.AspNetCore.Mvc;

namespace InventarioWeb.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
