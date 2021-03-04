using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using SisUsersbkn.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SisUsersbkn
{
    public class Startup
    {
        public Startup(Microsoft.AspNetCore.Hosting.IHostingEnvironment env)
        {
            var builder = new ConfigurationBuilder()
                   .SetBasePath(env.ContentRootPath)
                   .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                   .AddEnvironmentVariables();
            Configuration = builder.Build();

        }
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();
            services.AddCors(options =>
            {
                options.AddPolicy(
                  "CorsPolicy",
                  builder => builder.WithOrigins("http://localhost:4200")
                  .AllowAnyMethod()
                  .AllowAnyHeader()
                  .AllowCredentials());
            });

            services.Add(
                    new ServiceDescriptor(
                            typeof(ClientesContext), 
                            new ClientesContext( Configuration.GetConnectionString("DefaultConnection") )
                         )
                    );

            services.AddControllers(options => options.EnableEndpointRouting = false);            
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseCors("CorsPolicy");


            app.UseHttpsRedirection();            

            app.UseAuthorization();

            app.UseMvc(routes =>
            {
                routes.MapRoute("API.Home", "/API",
                            defaults: new { controller = "API", action = "Home" });
                routes.MapRoute("API.getUsers", "/API/clientes/list",
                            defaults: new { controller = "API", action = "getClientes" });
                routes.MapRoute("API.setUser", "/API/clientes/set",
                            defaults: new { controller = "API", action = "setClientes" });
                routes.MapRoute("API.putUser", "/API/clientes/put",
                            defaults: new { controller = "API", action = "putClientes" });
                routes.MapRoute("API.delUser", "/API/clientes/del",
                            defaults: new { controller = "API", action = "delClientes" });
            });

            app.UseRouting();
        }
    }
}
