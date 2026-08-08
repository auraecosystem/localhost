Imports System.IO
Imports System.Net
Imports System.Text
Imports System.Threading

Module MainModule

    Private ReadOnly Property Port As Integer = 8080
    Private Listener As HttpListener
    Private IsRunning As Boolean = True

    ''' <summary>
    ''' Application Entry Point for Aura Localhost Ecosystem
    ''' </summary>
    Sub Main(ByVal args As String())
        Console.OutputEncoding = Encoding.UTF8
        Console.Title = "Aura Engine CLI - Localhost Server"

        Console.ForegroundColor = ConsoleColor.Cyan
        Console.WriteLine("=====================================")
        Console.WriteLine("   AURA ECOSYSTEM LOCALHOST SERVER   ")
        Console.WriteLine("=====================================")
        Console.ResetColor()
        Console.WriteLine()

        Try
            ParseCommandLineArgs(args)
            StartLocalServer()
            ExecuteApplicationLoop()
        Catch ex As Exception
            Console.ForegroundColor = ConsoleColor.Red
            Console.WriteLine($"[CRITICAL ERROR]: {ex.Message}")
            Console.ResetColor()
        Finally
            StopLocalServer()
            Console.WriteLine()
            Console.WriteLine("Server shut down cleanly. Press any key to exit...")
            Console.ReadKey()
        End Try
    End Sub

    Private Sub ParseCommandLineArgs(ByVal args As String())
        If args IsNot Nothing AndAlso args.Length > 0 Then
            Console.WriteLine($"[CONFIG] Loaded {args.Length} startup flags.")
        Else
            Console.WriteLine("[CONFIG] Running with default localhost configurations.")
        End If
    End Sub

    Private Sub StartLocalServer()
        Listener = New HttpListener()
        Dim prefix As String = $"http://localhost:{Port}/"
        Listener.Prefixes.Add(prefix)

        Console.ForegroundColor = ConsoleColor.Green
        Console.WriteLine($"[SERVER] Listening on {prefix}")
        Console.ResetColor()

        Listener.Start()
        
        ' Asynchronously listen for incoming requests
        Dim listenThread As New Thread(AddressOf ListenForRequests)
        listenThread.IsBackground = True
        listenThread.Start()
    End Sub

    Private Sub ListenForRequests()
        While Listener.IsListening
            Try
                Dim context As HttpListenerContext = Listener.GetContext()
                ProcessRequest(context)
            Catch ex As HttpListenerException
                ' Exception expected when server stops
                Break
            Catch ex As Exception
                Console.WriteLine($"[REQUEST ERROR]: {ex.Message}")
            End Try
        End While
    End Sub

    Private Sub ProcessRequest(ByVal context As HttpListenerContext)
        Dim request = context.Request
        Dim response = context.Response

        Console.WriteLine($"[{DateTime.Now:HH:mm:ss}] {request.HttpMethod} {request.Url.AbsolutePath}")

        Dim responseString As String = ""
        
        Select Case request.Url.AbsolutePath.ToLower()
            Case "/", "/status"
                responseString = "{ ""status"": ""online"", ""engine"": ""Aura Localhost"", ""modules"": [""VoiceEngine"", ""WebInstall"", ""PrismFormatter""] }"
                response.ContentType = "application/json"
            Case Else
                responseString = "<h1>404 Not Found</h1><p>Aura Localhost Endpoint Not Recognized.</p>"
                response.ContentType = "text/html"
                response.StatusCode = 404
        End Select

        Dim buffer As Byte() = Encoding.UTF8.GetBytes(responseString)
        response.ContentLength64 = buffer.Length
        
        Using output As Stream = response.OutputStream
            output.Write(buffer, 0, buffer.Length)
        End Using
    End Sub

    Private Sub ExecuteApplicationLoop()
        Console.WriteLine()
        Console.WriteLine("[COMMANDS] Type 'open' to launch in browser, 'status' for info, or 'exit' to stop.")
        Console.WriteLine()

        While IsRunning
            Console.Write("AuraServer> ")
            Dim input As String = Console.ReadLine()?.Trim().ToLower()

            Select Case input
                Case "exit", "quit", "stop"
                    IsRunning = False
                Case "open"
                    Process.Start(New ProcessStartInfo($"http://localhost:{Port}/") With {.UseShellExecute = True})
                Case "status"
                    Console.WriteLine($"[STATUS] Server is running on port {Port}.")
                Case Else
                    If Not String.IsNullOrEmpty(input) Then
                        Console.WriteLine($"Unknown command: '{input}'. Valid choices: open, status, exit")
                    End If
            End Select
        End While
    End Sub

    Private Sub StopLocalServer()
        If Listener IsNot Nothing AndAlso Listener.IsListening Then
            Listener.Stop()
            Listener.Close()
            Console.WriteLine("[SERVER] HttpListener stopped.")
        End If
    End Sub

End Module
