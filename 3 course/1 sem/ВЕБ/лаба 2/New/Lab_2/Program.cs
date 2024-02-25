var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// ƒобавл€ет сервисы, необходимые дл€ контроллеров и представлений, в контейнер зависимостей.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
// ѕроверка, работает ли приложение в режиме разработки.
if (!app.Environment.IsDevelopment())
{
    // при ошибке будет перенаправл€ть на указанный маршрут
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    // чтобы гарантировать, что все контент передаетс€ через HTTPS
    app.UseHsts();
}

app.UseHttpsRedirection();
// позвол€ет приложению обслуживать статические файлы, такие как изображени€, CSS и JavaScript
app.UseStaticFiles();

// ¬ключает маршрутизацию в приложении
app.UseRouting();

app.UseAuthorization();

// Ќастройка маршрутизации контроллера по умолчанию
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
