using Microsoft.EntityFrameworkCore;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace InventarioWeb.Models
{
    [Table("productos")]
    public class Producto
    {
        [Key]
        [Column("producto_id")]
        public int Id { get; set; } 

        [Column("nombre")]
        public string Nombre { get; set; }

        [StringLength(255)]
        [Column("descripcion")]
        public string Descripcion { get; set; }

        [Column("precio_compra"), Precision(12, 2)]
        public decimal PrecioCompra { get; set; }

        [Column("precio_venta"), Precision(12, 2)]
        public decimal PrecioVenta { get; set; }

        [Column("stock_actual")]
        public int Stock { get; set; }   

        [Column("stock_minimo")]
        public int StockMinimo { get; set; }

        [Column("proveedor_id")]
        public int? ProveedorId { get; set; }

        [Column("estado")]
        public bool Estado { get; set; }

        [Column("creado_en")]
        public DateTime? FechaIngreso { get; set; }

        [Column("actualizado_en")]
        public DateTime? ActualizadoEn { get; set; }

        [Column("fecha_vencimiento")]
        public DateTime? FechaVencimiento { get; set; }

        public Proveedor? Proveedor { get; set; }

    }

}
