using InventarioWeb.Data;
using InventarioWeb.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace InventarioWeb.Controllers
{
    public class MovimientosInventarioController : Controller
    {
        private readonly AppDbContext _context;

        public MovimientosInventarioController(AppDbContext context)
        {
            _context = context;
        }

        // GET: /MovimientosInventario
        public async Task<IActionResult> Index()
        {
            var movimientos = await _context.MovimientosInventario
                                            .AsNoTracking()
                                            .Include(m => m.Producto)      
                                            .OrderBy(m => m.Id)                                                                                   
                                            .ToListAsync();

            return View(movimientos);
        }

        // GET: /MovimientosInventario/Details/
        public async Task<IActionResult> Details(int id)
        {
            var movimiento = await _context.MovimientosInventario
                                           .AsNoTracking()
                                           .Include(m => m.Producto)
                                           .FirstOrDefaultAsync(m => m.Id == id);

            if (movimiento == null)
                return NotFound();

            return View(movimiento);
        }

        // GET: /MovimientosInventario/Create
        public async Task<IActionResult> Create()
        {
            ViewBag.Productos = new SelectList(
                await _context.Productos
                    .AsNoTracking()
                    .OrderBy(p => p.Nombre)
                    .ToListAsync(),
                "Id", "Nombre");

            return View();
        }


        // POST: /MovimientosInventario/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(MovimientoInventario movimiento)
        {
            /*if (!ModelState.IsValid)
                return View(movimiento);*/

            movimiento.CreadoEn = DateTime.Now;

            _context.Add(movimiento);
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }
    }
}
