using InventarioWeb.Data;
using InventarioWeb.Models;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace InventarioWeb.Controllers
{
    public class MovimientosInventarioController : Controller
    {
        public IActionResult Index() => View(AppDbContext.Movimientos);

        public IActionResult Details(int id)
        {
            var mov = AppDbContext.Movimientos.FirstOrDefault(m => m.Id == id);
            if (mov == null) return NotFound();
            return View(mov);
        }

        public IActionResult Create() => View();

        [HttpPost]
        public IActionResult Create(MovimientoInventario mov)
        {
            mov.Id = AppDbContext.Movimientos.Max(m => m.Id) + 1;
            AppDbContext.Movimientos.Add(mov);
            return RedirectToAction(nameof(Index));
        }
    }
}
