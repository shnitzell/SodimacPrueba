
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace SisUsersbkn.Base
{
    public class BaseContext
    {
        public string ConnectionString { get; set; }

        public BaseContext(string connectionString)
        {
            this.ConnectionString = connectionString;
        }

        protected SqlConnection GetConnection()
        {
            return new SqlConnection(ConnectionString);
        }

        public virtual string translateParams(string body)
        {            
            return body;
        }
    }
}
