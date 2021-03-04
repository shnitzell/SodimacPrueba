using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using SisUsersbkn.Base;

namespace SisUsersbkn.Models
{
    public class ClientesContext : BaseContext
    {

        public ClientesContext(string connectionString) : base(connectionString)
        {
            //Nothing to do here for now :)
        }

        public override string translateParams(string body) {
            body = body.Replace("_id", "Id");
            body = body.Replace("givenname", "GivenName");
            body = body.Replace("lastname", "LastName");
            body = body.Replace("document", "Document");
            body = body.Replace("mail", "Mail");
            body = body.Replace("phone", "Phone");
            return body;        
        }

        public string setClientes(Clientes cliente)
        {
            using (SqlConnection conn = GetConnection())
            {

                conn.Open();
                SqlCommand cmd =
                    new SqlCommand( "INSERT INTO CLIENTES (id ,primer_nombre ,segundo_nombre ,primer_apellido ,segundo_apellido ,tipo_documento ,documento ,celular ,direccion ,email) VALUES ("
                                       + "'" + cliente.Id + "',"
                                       + "'" + cliente.PrimerNombre + "',"
                                       + "'" + cliente.SegundoNombre + "',"
                                       + "'" + cliente.PrimerApellido + "',"
                                       + "'" + cliente.SegundoApellido + "',"
                                       + "'" + cliente.TipoDocumento + "',"
                                       + "'" + cliente.Documento + "',"
                                       + "'" + cliente.Celular + "',"
                                       + "'" + cliente.Direccion + "',"
                                       + "'" + cliente.EMail + "')" , conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {

                    }
                }
            }
            return "success";
        }


        public string putClientes(Clientes cliente) {
            using (SqlConnection conn = GetConnection())
            {

                conn.Open();
                SqlCommand cmd =
                    new SqlCommand("UPDATE CLIENTES SET "
                      + "primer_nombre = '" + cliente.PrimerNombre + "', " 
                      + "segundo_nombre = '" + cliente.SegundoNombre + "', " 
                      + "primer_apellido = '" + cliente.PrimerApellido + "', " 
                      + "segundo_apellido = '" + cliente.SegundoApellido + "', " 
                      + "tipo_documento = '" + cliente.TipoDocumento + "', " 
                      + "documento = '" + cliente.Documento + "', " 
                      + "celular = '" + cliente.Celular + "', " 
                      + "direccion = '" + cliente.Direccion + "', " 
                      + "email = '" + cliente.EMail + "' " 
                      + " WHERE id = " + cliente.Id, conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {

                    }
                }
            }
            return "success";
        }
        public List<Clientes> getClientes() {
            List<Clientes> list = new List<Clientes>();
            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM CLIENTES", conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new Clientes()
                        {
                            Id = Convert.ToInt32(reader["id"]),
                            PrimerNombre = reader["primer_nombre"].ToString(),
                            SegundoNombre = reader["segundo_nombre"].ToString(),
                            PrimerApellido = reader["primer_apellido"].ToString(),
                            SegundoApellido = reader["segundo_apellido"].ToString(),
                            TipoDocumento = reader["tipo_documento"].ToString(),
                            Documento = Convert.ToInt64(reader["documento"]),
                            Celular = Convert.ToInt64(reader["celular"]),
                            Direccion = reader["direccion"].ToString(),
                            EMail = reader["email"].ToString()

                        });
                    }
                }
            }
            return list;
        }

        public string delClientes(int id)
        {
            List<Clientes> list = new List<Clientes>();
            using (SqlConnection conn = GetConnection())
            {
                
                conn.Open();
                SqlCommand cmd = new SqlCommand("delete from CLIENTES where CLIENTES.id = " + id, conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        
                    }
                }
            }
            return "success";
        }
    }
}
