using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using MySql.Data.MySqlClient;
using SisUsersbkn.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SisUsersbkn.Controllers
{
    public class APIController : ControllerBase
    {
        private readonly ILogger<APIController> _logger;

        public APIController(ILogger<APIController> logger)
        {
            _logger = logger;
        }

        [ActionName(nameof(Home)), HttpPost, HttpGet]
        public IActionResult Home()
        {

            return Content("Running");
        }

        [ActionName(nameof(getUsers)), HttpPost, HttpGet]
        public IActionResult getUsers() {
            try
            {
                UsersContext context =
                HttpContext.RequestServices.GetService(typeof(SisUsersbkn.Models.UsersContext)) as UsersContext;

                var data = Utf8Json.JsonSerializer.ToJsonString(context.getUsers());
                return Content( data );
            }
            catch (Exception e) {
                return Content("{ \"error\": true, \"msg\": " + e.Message.ToString() + "}");
            }
        }

        [ActionName(nameof(setUser)), HttpPost]
        public async Task<IActionResult> setUser()
        {

            try
            {
                string stringRqst = await GetRawBodyStringAsync(Request);
                UsersContext context =
                    HttpContext.RequestServices.GetService(typeof(SisUsersbkn.Models.UsersContext)) as UsersContext;
                stringRqst = context.translateParams(stringRqst);

                User input = null;
                try
                {
                    input = Utf8Json.JsonSerializer.Deserialize<User>(stringRqst);
                }
                catch (Exception ex)
                {
                    return Content("{ \"error\": true, \"msg\": " + ex.Message.ToString() + "}");
                }

                var data = context.setUser(input);
                return Content("{ \"success\": \"" + data + "\" }");
            }
            catch (Exception e)
            {
                return Content("{ \"error\": true, \"msg\": " + e.Message.ToString() + "}");
            }
        }

        [ActionName(nameof(putUser)), HttpPost]
        public async Task<IActionResult> putUser()
        {

            try
            {
                string stringRqst = await GetRawBodyStringAsync(Request);
                UsersContext context =
                    HttpContext.RequestServices.GetService(typeof(SisUsersbkn.Models.UsersContext)) as UsersContext;
                stringRqst = context.translateParams(stringRqst);

                User input = null;
                try
                {
                    input = Utf8Json.JsonSerializer.Deserialize<User>(stringRqst);
                }

                catch (Exception ex)
                {
                    return Content("{ \"error\": true, \"msg\": " + ex.Message.ToString() + "}");
                }

                var data = context.putUser(input);
                return Content("{ \"success\": \"" + data + "\" }");
            }
            catch (Exception e)
            {
                return Content("{ \"error\": true, \"msg\": " + e.Message.ToString() + "}");
            }
        }

        public static async Task<string> GetRawBodyStringAsync(HttpRequest request, Encoding encoding = null)
        {
            if (encoding == null)
                encoding = Encoding.UTF8;

            using (StreamReader reader = new StreamReader(request.Body, encoding))
                return await reader.ReadToEndAsync();
        }

        [ActionName(nameof(delUser)), HttpPost]
        public async Task<IActionResult> delUser()
        {
            try
            {
                string stringRqst = await GetRawBodyStringAsync(Request);
                UsersContext context =
                    HttpContext.RequestServices.GetService(typeof(SisUsersbkn.Models.UsersContext)) as UsersContext;
                stringRqst = context.translateParams(stringRqst);

                User input = null;
                try
                {
                    input = Utf8Json.JsonSerializer.Deserialize<User>(stringRqst);
                }

                catch (Exception ex)
                {
                    return Content("{ \"error\": true, \"msg\": " + ex.Message.ToString() + "}");
                }                               

                var data = context.delUser(input.Id);
                return Content("{ \"success\": \"" + data + "\" }");
            }
            catch (Exception e)
            {
                return Content("{ \"error\": true, \"msg\": " + e.Message.ToString() + "}");
            }
        }

    }
}
