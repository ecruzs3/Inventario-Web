using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace InventarioWeb.Models
{
    [Table("proveedores")]
    public class Proveedor
    {
        [Key]
        [Column("proveedor_id")]
        public int Id { get; set; } 

        [Required, StringLength(120)]
        [Column("nombre")]
        public string Nombre { get; set; }

        [StringLength(30)]
        [Column("telefono")]
        public string Telefono { get; set; }

        [StringLength(120)]
        [Column("email")]
        public string Email { get; set; }

        [StringLength(255)]
        [Column("direccion")]
        public string Direccion { get; set; }

        [Column("estado")]
        public bool Estado { get; set; }

        [Column("creado_en")]
        public DateTime? CreadoEn { get; set; }

        [Column("actualizado_en")]
        public DateTime?  ActualizadoEn { get; set; }

        public ICollection<Producto> Productos { get; set; } = new List<Producto>();
    }
}
