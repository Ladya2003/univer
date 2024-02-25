using ASPCMVC4.Controllers;

internal class Program
{
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddControllersWithViews();
        builder.Services.AddScoped<StatusController>();

        var app = builder.Build();

        app.UseHttpsRedirection();
        app.UseStaticFiles();
        app.UseRouting();
        app.UseAuthorization();


        app.MapControllerRoute(
            name: "default", 
            pattern: "{controller=Status}/{action=Index}/{id?}");

        app.Run();
    }
}