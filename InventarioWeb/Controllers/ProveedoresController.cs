using InventarioWeb.Data;
using InventarioWeb.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace InventarioWeb.Controllers
{
    public class ProveedoresController : Controller
    {
        private readonly AppDbContext _context;

        public ProveedoresController(AppDbContext context)
        {
            _context = context;
        }

        // GET: /Proveedores
        public async Task<IActionResult> Index()
        {
            var lista = await _context.Proveedores
                                      .AsNoTracking()
                                      .ToListAsync();
            return View(lista);
        }

        // GET: /Proveedores/Details/
        public async Task<IActionResult> Details(int id)
        {
            var proveedor = await _context.Proveedores
                                          .AsNoTracking()
                                          .FirstOrDefaultAsync(p => p.Id == id);
            if (proveedor == null)
                return NotFound();

            return View(proveedor);
        }

        // GET: /Proveedores/Create
        public IActionResult Create() => View();

        // POST: /Proveedores/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Proveedor proveedor)
        {
            if (!ModelState.IsValid)
                return View(proveedor);

            proveedor.CreadoEn = DateTime.Now;

            _context.Add(proveedor);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        // GET: /Proveedores/Edit/
        public async Task<IActionResult> Edit(int id)
        {
            var proveedor = await _context.Proveedores.FindAsync(id);
            if (proveedor == null)
                return NotFound();

            return View(proveedor);
        }

        // POST: /Proveedores/Edit/
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Proveedor proveedor)
        {
            if (id != proveedor.Id)
                return BadRequest();

            if (!ModelState.IsValid)
                return View(proveedor);

            var proveedorExistente = await _context.Proveedores.FindAsync(id);
            if (proveedorExistente == null)
                return NotFound();

            proveedorExistente.Nombre = proveedor.Nombre;
            proveedorExistente.Direccion = proveedor.Direccion;
            proveedorExistente.Telefono = proveedor.Telefono;
            proveedorExistente.Email = proveedor.Email;
            proveedorExistente.Estado = proveedor.Estado; 

            proveedorExistente.ActualizadoEn = DateTime.Now;

            _context.Update(proveedorExistente);
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }

        // GET: /Proveedores/Delete/
        public async Task<IActionResult> Delete(int id)
        {
            var proveedor = await _context.Proveedores
                                          .AsNoTracking()
                                          .FirstOrDefaultAsync(p => p.Id == id);
            if (proveedor == null)
                return NotFound();

            return View(proveedor);
        }

        // POST: /Proveedores/Delete/
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var proveedor = await _context.Proveedores.FindAsync(id);
            if (proveedor != null)
            {
                _context.Proveedores.Remove(proveedor);
                await _context.SaveChangesAsync();
            }

            return RedirectToAction(nameof(Index));
        }
    }
}
