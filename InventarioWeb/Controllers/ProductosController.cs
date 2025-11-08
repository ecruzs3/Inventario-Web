using InventarioWeb.Data;
using InventarioWeb.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace InventarioWeb.Controllers
{
    public class ProductosController : Controller
    {
        private readonly AppDbContext _context;

        public ProductosController(AppDbContext context)
        {
            _context = context;
        }

        // GET: /Productos
        public async Task<IActionResult> Index()
        {
            var lista = await _context.Productos
                                      .AsNoTracking()
                                      .Include(p => p.Proveedor)
                                      .ToListAsync();
            return View(lista);
        }

        // GET: /Productos/Details/
        public async Task<IActionResult> Details(int id)
        {
            var producto = await _context.Productos
                                         .AsNoTracking()
                                         .FirstOrDefaultAsync(p => p.Id == id);

            if (producto == null) return NotFound();
            return View(producto);
        }

        // GET: /Productos/Create
        public async Task<IActionResult> Create()
        {
            ViewBag.Proveedores = new SelectList(
                await _context.Proveedores
                    .AsNoTracking()
                    .OrderBy(p => p.Nombre)
                    .ToListAsync(),
                "Id", "Nombre");

            return View();
        }

        // POST: /Productos/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Producto producto)
        {
            /*if (!ModelState.IsValid)
            {*/
                /*ViewBag.Proveedores = new SelectList(
                    await _context.Proveedores.AsNoTracking().ToListAsync(),
                    "Id", "Nombre", producto.ProveedorId);
                return View(producto);*/
            /*}*/

            producto.FechaIngreso = DateTime.Now;

            _context.Add(producto);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }


        // GET: /Productos/Edit/
        public async Task<IActionResult> Edit(int id)
        {
            var producto = await _context.Productos.FindAsync(id);
            if (producto == null) 
                return NotFound();

            ViewBag.Proveedores = new SelectList(
                await _context.Proveedores.AsNoTracking()
                .OrderBy(p => p.Nombre)
                .Select(p => new { p.Id, p.Nombre })
                .ToListAsync(),
            "Id", "Nombre", producto.ProveedorId);

            return View(producto);
        }

        // POST: /Productos/Edit/
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Producto producto)
        {
            if (id != producto.Id) 
                return BadRequest();


            /*if (!ModelState.IsValid)
            {
                var errores = string.Join(" | ", ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => e.ErrorMessage));
                Console.WriteLine("ERRORES: " + errores);
                return View(producto);
            }*/


            var productoExistente = await _context.Productos.FindAsync(id);
            if (productoExistente == null)
                return NotFound();

            productoExistente.Nombre = producto.Nombre;
            productoExistente.ProveedorId = producto.ProveedorId;
            productoExistente.PrecioCompra = producto.PrecioCompra;
            productoExistente.PrecioVenta = producto.PrecioVenta;
            productoExistente.Estado = producto.Estado;
            productoExistente.FechaVencimiento = producto.FechaVencimiento;

            productoExistente.ActualizadoEn = DateTime.Now;

            _context.Update(productoExistente);
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));

        }

        // GET: /Productos/Delete/
        public async Task<IActionResult> Delete(int id)
        {
            var producto = await _context.Productos
                                         .AsNoTracking()
                                         .FirstOrDefaultAsync(p => p.Id == id);
            if (producto == null) return NotFound();
            return View(producto);
        }

        // POST: /Productos/Delete/
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var producto = await _context.Productos.FindAsync(id);
            try
            {
                _context.Productos.Remove(producto);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            catch (DbUpdateException)
            {
                TempData["Error"] = "No se puede eliminar, únicamente cambiar de estado; existen movimientos asociados.";
                return RedirectToAction(nameof(Delete), new { id });
            }
        }
    }
}
