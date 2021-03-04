using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
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
        public static async Task<string> GetRawBodyStringAsync(HttpRequest request, Encoding encoding = null)
        {
            if (encoding == null)
                encoding = Encoding.UTF8;

            using (StreamReader reader = new StreamReader(request.Body, encoding))
                return await reader.ReadToEndAsync();
        }

        [ActionName(nameof(Home)), HttpPost, HttpGet]
        public IActionResult Home()
        {
            return Content("Running");
        }

        [ActionName(nameof(getClientes)), HttpPost, HttpGet]
        public IActionResult getClientes() {
            try
            {
                ClientesContext context =
                HttpContext.RequestServices.GetService(typeof(SisUsersbkn.Models.ClientesContext)) as ClientesContext;

                var data = Utf8Json.JsonSerializer.ToJsonString(context.getClientes());
                return Content( data );
            }
            catch (Exception e) {
                return Content("{ \"error\": true, \"msg\": \"" + e.Message.ToString() + "\"}");
            }
        }

        [ActionName(nameof(setClientes)), HttpPost]
        public async Task<IActionResult> setClientes()
        {

            try
            {
                string stringRqst = await GetRawBodyStringAsync(Request);
                ClientesContext context =
                    HttpContext.RequestServices.GetService(typeof(SisUsersbkn.Models.ClientesContext)) as ClientesContext;
                stringRqst = context.translateParams(stringRqst);

                Clientes input = null;
                try
                {
                    input = Utf8Json.JsonSerializer.Deserialize<Clientes>(stringRqst);
                }
                catch (Exception ex)
                {
                    return Content("{ \"error\": true, \"msg\": \"" + ex.Message.ToString() + "\"}");
                }

                var data = context.setClientes(input);
                return Content("{ \"success\": \"" + data + "\" }");
            }
            catch (Exception e)
            {
                return Content("{ \"error\": true, \"msg\": \"" + e.Message.ToString() + "\"}");
            }
        }

        [ActionName(nameof(putClientes)), HttpPost]
        public async Task<IActionResult> putClientes()
        {

            try
            {
                string stringRqst = await GetRawBodyStringAsync(Request);
                ClientesContext context =
                    HttpContext.RequestServices.GetService(typeof(SisUsersbkn.Models.ClientesContext)) as ClientesContext;
                stringRqst = context.translateParams(stringRqst);

                Clientes input = null;
                try
                {
                    input = Utf8Json.JsonSerializer.Deserialize<Clientes>(stringRqst);
                }

                catch (Exception ex)
                {
                    return Content("{ \"error\": true, \"msg\": \"" + ex.Message.ToString() + "\"}");
                }

                var data = context.putClientes(input);
                return Content("{ \"success\": \"" + data + "\" }");
            }
            catch (Exception e)
            {
                return Content("{ \"error\": true, \"msg\": \"" + e.Message.ToString() + "\"}");
            }
        }

        [ActionName(nameof(delClientes)), HttpPost]
        public async Task<IActionResult> delClientes()
        {
            try
            {
                string stringRqst = await GetRawBodyStringAsync(Request);
                ClientesContext context =
                    HttpContext.RequestServices.GetService(typeof(SisUsersbkn.Models.ClientesContext)) as ClientesContext;
                stringRqst = context.translateParams(stringRqst);

                Clientes input = null;
                try
                {
                    input = Utf8Json.JsonSerializer.Deserialize<Clientes>(stringRqst);
                }

                catch (Exception ex)
                {
                    return Content("{ \"error\": true, \"msg\": \"" + ex.Message.ToString() + "\"}");
                }                               

                var data = context.delClientes(input.Id);
                return Content("{ \"success\": \"" + data + "\" }");
            }
            catch (Exception e)
            {
                return Content("{ \"error\": true, \"msg\": \"" + e.Message.ToString() + "\"}");
            }
        }

    }
}
