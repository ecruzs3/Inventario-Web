using InventarioWeb.Models;
using System;
using System.Collections.Generic;


namespace InventarioWeb.Data
{
    public static class AppDbContext
    {
        public static List<Producto> Productos { get; set; } = new List<Producto>
        {
            new Producto { Id = 1, Codigo = "P001", Nombre = "Laptop Lenovo", Categoria = "Electrónica", Proveedor = "Punto Digital", Stock = 10, PrecioCompra = 500, PrecioVenta = 700, FechaIngreso = DateTime.Now.AddDays(-10), FechaVencimiento = DateTime.Now.AddYears(2) },
            new Producto { Id = 2, Codigo = "P002", Nombre = "Mouse Logitech", Categoria = "Accesorios", Proveedor = "Electronica GT", Stock = 25, PrecioCompra = 10, PrecioVenta = 15, FechaIngreso = DateTime.Now.AddDays(-20), FechaVencimiento = DateTime.Now.AddYears(2) }
        };

        public static List<Proveedor> Proveedores { get; set; } = new List<Proveedor>
        {
            new Proveedor { Id = 1, Nombre = "Punto Digital", TipoProveedor = "Mayorista", Contacto = "Carlos López", Email = "puntodigital@gmail.com", Telefono = "555-1234", Estado = "Activo", FechaCreacion = DateTime.Now.AddMonths(-1) },
            new Proveedor { Id = 2, Nombre = "Electronica GT", TipoProveedor = "Distribuidor", Contacto = "Ana Torres", Email = "electronicagt@gmail.com", Telefono = "555-5678", Estado = "Activo", FechaCreacion = DateTime.Now.AddMonths(-2) }
        };

        public static List<MovimientoInventario> Movimientos { get; set; } = new List<MovimientoInventario>
        {
            new MovimientoInventario { Id = 1, Producto = "Laptop Lenovo", TipoMovimiento = "Entrada", Cantidad = 5, Fecha = DateTime.Now.AddDays(-5), Nota = "Ingreso por compra" },
            new MovimientoInventario { Id = 2, Producto = "Mouse Logitech", TipoMovimiento = "Salida", Cantidad = 3, Fecha = DateTime.Now.AddDays(-2), Nota = "Venta realizada" }
        };
    }
}
