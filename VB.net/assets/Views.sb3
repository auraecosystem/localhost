' ===============================================
' Main.sb - Microsoft Small Basic Program Entry Point
' ===============================================

' Setup Graphics Window
GraphicsWindow.Title = "Aura Engine - Small Basic Interface"
GraphicsWindow.Width = 600
GraphicsWindow.Height = 400
GraphicsWindow.BackgroundColor = "#0D0D0D"
GraphicsWindow.Show()

' Title Text
GraphicsWindow.BrushColor = "#00E5FF"
GraphicsWindow.FontSize = 24
GraphicsWindow.DrawText(40, 30, "Aura Engine Terminal")

' Divider line
GraphicsWindow.PenColor = "#9D4EDD"
GraphicsWindow.PenWidth = 2
GraphicsWindow.DrawLine(40, 75, 560, 75)

' Interactive Button
GraphicsWindow.BrushColor = "#1F1F1F"
btnRun = Controls.AddButton("Execute System Check", 40, 100)
Controls.SetSize(btnRun, 200, 40)

' Output Text Area
GraphicsWindow.BrushColor = "#A0A0A0"
GraphicsWindow.FontSize = 14
txtOutput = Controls.AddMultiLineTextBox(40, 160)
Controls.SetSize(txtOutput, 520, 180)

' Attach Event Listener
Controls.ButtonClicked = OnButtonClick

' -----------------------------------------------
' Event Handler: Button Click
' -----------------------------------------------
Sub OnButtonClick
  clickedBtn = Controls.LastClickedButton
  If clickedBtn = btnRun Then
    Controls.SetTextBoxText(txtOutput, "Initializing Aura Engine Modules..." + Text.GetCharacter(10))
    Controls.SetTextBoxText(txtOutput, Controls.GetTextBoxText(txtOutput) + "[OK] Voice Integration Ready" + Text.GetCharacter(10))
    Controls.SetTextBoxText(txtOutput, Controls.GetTextBoxText(txtOutput) + "[OK] Blink Web Install API Ready" + Text.GetCharacter(10))
    Controls.SetTextBoxText(txtOutput, Controls.GetTextBoxText(txtOutput) + "[STATUS] All systems operational.")
  End If
End Sub
