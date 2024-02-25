using System;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;

public class TextFileReader
{
    [SqlProcedure]
    public static void ReadTextFile(SqlString filePath, out SqlString fileContent)
    {
        fileContent = SqlString.Null;

        try
        {
            if (!filePath.IsNull)
            {
                string path = filePath.Value;

                if (File.Exists(path))
                {
                    fileContent = File.ReadAllText(path);
                }
                else
                {
                    throw new FileNotFoundException($"File not found: {path}");
                }
            }
        }
        catch (Exception ex)
        {
            // Handle any exceptions or log them if needed
            SqlContext.Pipe.Send($"Error: {ex.Message}");
            throw;
        }
    }
}
