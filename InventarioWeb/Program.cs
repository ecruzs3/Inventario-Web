using InventarioWeb.Data;
using Microsoft.EntityFrameworkCore;
using System.Globalization;

var builder = WebApplication.CreateBuilder(args);

//Leer la cadena de conexión desde appsettings.json
var connectionString = builder.Configuration.GetConnectionString("MySql");

//Registrar el DbContext con MySQL
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));

//Agregar controladores y vistas
builder.Services.AddControllersWithViews();

var app = builder.Build();

//Configuración del pipeline HTTP
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");


var supported = new[] { new CultureInfo("es-GT") };
app.UseRequestLocalization(new RequestLocalizationOptions
{
    DefaultRequestCulture = new("es-GT"),
    SupportedCultures = supported,
    SupportedUICultures = supported
});


app.Run();
