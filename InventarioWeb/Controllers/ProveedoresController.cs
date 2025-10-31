using InventarioWeb.Data;
using InventarioWeb.Models;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace InventarioWeb.Controllers
{
    public class ProveedoresController : Controller
    {
        public IActionResult Index() => View(AppDbContext.Proveedores);

        public IActionResult Details(int id)
        {
            var proveedor = AppDbContext.Proveedores.FirstOrDefault(p => p.Id == id);
            if (proveedor == null) return NotFound();
            return View(proveedor);
        }

        public IActionResult Create() => View();

        [HttpPost]
        public IActionResult Create(Proveedor proveedor)
        {
            proveedor.Id = AppDbContext.Proveedores.Max(p => p.Id) + 1;
            AppDbContext.Proveedores.Add(proveedor);
            return RedirectToAction(nameof(Index));
        }

        public IActionResult Edit(int id)
        {
            var proveedor = AppDbContext.Proveedores.FirstOrDefault(p => p.Id == id);
            if (proveedor == null) return NotFound();
            return View(proveedor);
        }

        [HttpPost]
        public IActionResult Edit(Proveedor proveedor)
        {
            var original = AppDbContext.Proveedores.FirstOrDefault(p => p.Id == proveedor.Id);
            if (original != null)
            {
                AppDbContext.Proveedores.Remove(original);
                AppDbContext.Proveedores.Add(proveedor);
            }
            return RedirectToAction(nameof(Index));
        }

        public IActionResult Delete(int id)
        {
            var proveedor = AppDbContext.Proveedores.FirstOrDefault(p => p.Id == id);
            if (proveedor == null) return NotFound();
            return View(proveedor);
        }

        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed(int id)
        {
            var proveedor = AppDbContext.Proveedores.FirstOrDefault(p => p.Id == id);
            if (proveedor != null)
                AppDbContext.Proveedores.Remove(proveedor);
            return RedirectToAction(nameof(Index));
        }
    }
}
