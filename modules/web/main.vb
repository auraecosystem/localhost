Imports System.Text

Module MainModule

    ''' <summary>
    ''' Application Entry Point
    ''' </summary>
    ''' <param name="args">Command line arguments passed to the application.</param>
    Sub Main(ByVal args As String())
        ' Configure console encoding & appearance
        Console.OutputEncoding = Encoding.UTF8
        Console.Title = "Aura Engine CLI"

        Console.WriteLine("=====================================")
        Console.WriteLine("    AURA ENGINE INITIALIZING        ")
        Console.WriteLine("=====================================")
        Console.WriteLine()

        ' Wrap execution in global error handling
        Try
            ' 1. Parse Command Line Arguments
            ParseCommandLineArgs(args)

            ' 2. Run Main Application Logic
            ExecuteApplication()

        Catch ex As Exception
            ' Handle unexpected errors cleanly
            Console.ForegroundColor = ConsoleColor.Red
            Console.WriteLine($"[CRITICAL ERROR]: {ex.Message}")
            Console.ResetColor()
        Finally
            Console.WriteLine()
            Console.WriteLine("Execution finished. Press any key to exit...")
            Console.ReadKey()
        End Try
    End Sub

    ''' <summary>
    ''' Handles parsing of incoming command-line parameters.
    ''' </summary>
    Private Sub ParseCommandLineArgs(ByVal args As String())
        If args Is Nothing OrElse args.Length = 0 Then
            Console.WriteLine("[LOG] No command-line arguments provided. Using defaults.")
            Return
        End If

        Console.WriteLine($"[LOG] Received {args.Length} argument(s):")
        For i As Integer = 0 To args.Length - 1
            Console.WriteLine($"  Arg [{i}]: {args(i)}")
        Next
        Console.WriteLine()
    End Sub

    ''' <summary>
    ''' Core execution path. Call services, modules, or class methods here.
    ''' </summary>
    Private Sub ExecuteApplication()
        Console.ForegroundColor = ConsoleColor.Cyan
        Console.WriteLine("[RUNNING] Executing core module logic...")
        Console.ResetColor()

        ' Benchmark/String performance demo
        Dim sb As New StringBuilder("System Status: ")
        sb.AppendLine("Ready")
        sb.AppendLine("Modules Loaded: WebInstall, VoiceEngine, PrismFormatter")
        
        Console.WriteLine(sb.ToString())
    End Sub

End Module
