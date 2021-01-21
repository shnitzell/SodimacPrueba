using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace SisUsersbkn.Models
{
    public class UsersContext
    {
        public string ConnectionString { get; set; }

        public UsersContext(string connectionString)
        {
            this.ConnectionString = connectionString;
        }

        private MySqlConnection GetConnection()
        {
            return new MySqlConnection(ConnectionString);
        }
        public string translateParams(string body) {
            body = body.Replace("_id", "Id");
            body = body.Replace("givenname", "GivenName");
            body = body.Replace("lastname", "LastName");
            body = body.Replace("document", "Document");
            body = body.Replace("mail", "Mail");
            body = body.Replace("phone", "Phone");
            return body;        
        }

        public string setUser(User user)
        {
            List<User> list = new List<User>();
            using (MySqlConnection conn = GetConnection())
            {

                conn.Open();
                MySqlCommand cmd =
                    new MySqlCommand(" INSERT INTO `users`(`givenname`, `lastname`, `document`, `mail`, `phone`) VALUES ('" + user.GivenName + "', '" + user.LastName + "', '" + user.Document + "', '" + user.Mail + "', '" + user.Phone + "')", conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {

                    }
                }
            }
            return "success";
        }


        public string putUser(User user) {
            List<User> list = new List<User>();
            using (MySqlConnection conn = GetConnection())
            {

                conn.Open();
                MySqlCommand cmd = 
                    new MySqlCommand("UPDATE `users` SET `givenname`= '" + user.GivenName + "',`lastname`='" + user.LastName + "',`document`='" + user.Document + "',`mail`='" + user.Mail + "',`phone`= '" + user.Phone + "' WHERE id = " + user.Id, conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {

                    }
                }
            }
            return "success";
        }
        public List<User> getUsers() {
            List<User> list = new List<User>();
            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand("select * from users", conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new User()
                        {
                            Id = Convert.ToInt32(reader["id"]),
                            GivenName = reader["givenname"].ToString(),
                            LastName = reader["lastname"].ToString(),
                            Document = Convert.ToInt64(reader["document"]),
                            Mail = reader["mail"].ToString(),
                            Phone = Convert.ToInt64(reader["phone"]),
                        });
                    }
                }
            }
            return list;
        }

        public string delUser(int id)
        {
            List<User> list = new List<User>();
            using (MySqlConnection conn = GetConnection())
            {
                
                conn.Open();
                MySqlCommand cmd = new MySqlCommand("delete from users where id = " + id, conn);
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
