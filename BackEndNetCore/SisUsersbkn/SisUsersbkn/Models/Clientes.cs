using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SisUsersbkn.Models
{
    public class Clientes
    {
        public int Id { get; set; }
        public string PrimerNombre { get; set; }
        public string SegundoNombre { get; set; }
        public string PrimerApellido { get; set; }
        public string SegundoApellido { get; set; }
        public string TipoDocumento { get; set; }
        public long Documento { get; set; }
        public long Celular { get; set; }
        public string Direccion { get; set; }
        public string EMail { get; set; }
    }
}
