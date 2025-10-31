using InventarioWeb.Data;
using InventarioWeb.Models;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
 

namespace InventarioWeb.Controllers
{
    public class ProductosController : Controller
    {
        public IActionResult Index() => View(AppDbContext.Productos);

        public IActionResult Details(int id)
        {
            var producto = AppDbContext.Productos.FirstOrDefault(p => p.Id == id);
            if (producto == null) return NotFound();
            return View(producto);
        }

        public IActionResult Create() => View();

        [HttpPost]
        public IActionResult Create(Producto producto)
        {
            producto.Id = AppDbContext.Productos.Max(p => p.Id) + 1;
            AppDbContext.Productos.Add(producto);
            return RedirectToAction(nameof(Index));
        }

        public IActionResult Edit(int id)
        {
            var producto = AppDbContext.Productos.FirstOrDefault(p => p.Id == id);
            if (producto == null) return NotFound();
            return View(producto);
        }

        [HttpPost]
        public IActionResult Edit(Producto producto)
        {
            var original = AppDbContext.Productos.FirstOrDefault(p => p.Id == producto.Id);
            if (original == null) return NotFound();

            AppDbContext.Productos.Remove(original);
            AppDbContext.Productos.Add(producto);
            return RedirectToAction(nameof(Index));
        }

        public IActionResult Delete(int id)
        {
            var producto = AppDbContext.Productos.FirstOrDefault(p => p.Id == id);
            if (producto == null) return NotFound();
            return View(producto);
        }

        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed(int id)
        {
            var producto = AppDbContext.Productos.FirstOrDefault(p => p.Id == id);
            if (producto != null)
                AppDbContext.Productos.Remove(producto);
            return RedirectToAction(nameof(Index));
        }
    }
}
