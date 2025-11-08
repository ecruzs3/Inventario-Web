using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace InventarioWeb.Models
{
    [Table("movimientos_inventario")]
    public class MovimientoInventario
    {
        [Key]
        [Column("movimiento_id")]
        public int Id { get; set; } 

        [Column("producto_id")]
        public int ProductoId { get; set; }

        [StringLength(1)]
        [Column("tipo")]
        public string TipoMovimiento { get; set; }

        [Column("cantidad")]
        public int Cantidad { get; set; }

        [StringLength(255)]
        [Column("nota")]
        public string Nota { get; set; }

        [Column("creado_en")]
        public DateTime? CreadoEn { get; set; }

        [Column("actualizado_en")]
        public DateTime? ActualizadoEn { get; set; }

        public Producto Producto { get; set; }
    }
}
