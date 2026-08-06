Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSubmit.Click
        If Not String.IsNullOrWhiteSpace(txtName.Text) Then
            lblMessage.Text = $"Hello, {txtName.Text}!"
        End If
    End Sub
End Class
