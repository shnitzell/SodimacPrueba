using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SisUsersbkn.Models
{
    public class User
    {
        public int Id { get; set; }
        public string GivenName { get; set; }
        public string LastName { get; set; }
        public long Document { get; set; }
        public string Mail { get; set; }
        public long Phone { get; set; }
    }
}
