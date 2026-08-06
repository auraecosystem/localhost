Imports Microsoft.AspNetCore.Mvc

Namespace Controllers
    <ApiController>
    <Route("api/[controller]")>
    Public Class ProductsController
        Inherits ControllerBase

        <HttpGet>
        Public Function GetProducts() As IActionResult
            Dim products = New List(Of Object) From {
                New With {.Id = 1, .Name = "Laptop", .Price = 999.99},
                New With {.Id = 2, .Name = "Mouse", .Price = 25.00}
            }
            Return Ok(products)
        End Function
    End Class
End Namespace
