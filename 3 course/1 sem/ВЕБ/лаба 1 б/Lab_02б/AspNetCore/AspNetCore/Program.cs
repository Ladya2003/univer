

using System.Net;
using System.Net.WebSockets;
using System.Text;

// создаем экземпляр приложения
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.UseStaticFiles();   //позволяет приложению обслуживать статические файлы (например, .html, .js).
app.UseWebSockets();    //добавляет поддержку WebSocket в приложение

//При обращении к корневому URL (/) сервер будет отдавать HTML-файл, расположенный по указанному пути.
app.MapGet("/", (HttpContext context) =>
{
    string pathToFileHtml = "D:\\Универ\\5 семестр\\ВЕБ\\лаба 1 б\\Lab_02б\\AspNetCore\\AspNetCore\\Properties\\html\\WebSocket.html";
    context.Response.ContentType = "text/html";
    return context.Response.SendFileAsync(pathToFileHtml);
});

//Если приходит запрос на этот путь и он является запросом WebSocket, то устанавливается соединение через WebSocket. В противном случае отправляется ответ с кодом ошибки 400 (Bad Request).
app.MapGet("/websocket", async (HttpContext context) =>
{
    if (context.WebSockets.IsWebSocketRequest)
    {
        using var webSocket = await context.WebSockets.AcceptWebSocketAsync();
        await WebSocketRequest(webSocket);
        
    }
    else
    {
        context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
    }
});

//ожидает активное WebSocket-соединение и каждые две секунды отправляет текущее время клиенту. В случае ошибки он отправит сообщение об ошибке клиенту.
async Task WebSocketRequest(WebSocket webSocket)
{
    try
    {
        while (webSocket.State == WebSocketState.Open)
        {
            var message = DateTime.Now.ToString("HH:mm:ss");
            var buffer = Encoding.UTF8.GetBytes(message);
            var segment = new ArraySegment<byte>(buffer);

            await webSocket.SendAsync(segment, WebSocketMessageType.Text, true, CancellationToken.None);

            await Task.Delay(2000);
        }
    }
    catch (Exception ex)
    {
        string message = ex.Message;
        var buffer = Encoding.UTF8.GetBytes(message);
        var segment = new ArraySegment<byte>(buffer);
        await webSocket.SendAsync(segment, WebSocketMessageType.Text, true, CancellationToken.None);
        
       
    }
}

app.Run();