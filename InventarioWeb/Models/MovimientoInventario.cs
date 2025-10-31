using System;

namespace InventarioWeb.Models
{
    public class MovimientoInventario
    {
        public int Id { get; set; }
        public string Producto { get; set; } = string.Empty; // Solo texto
        public string TipoMovimiento { get; set; } = string.Empty; // Entrada o salida
        public int Cantidad { get; set; }
        public DateTime Fecha { get; set; } = DateTime.Now;
        public string Nota { get; set; } = string.Empty;
    }
}
