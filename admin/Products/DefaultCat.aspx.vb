Imports System.Data
Imports System.Data.DataTable

Partial Class DefaultCat
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadGrid()
        End If
    End Sub

    Protected Sub LoadGrid()
        Dim dt As DataTable = RC4.Pull("Select * From RCProductCat")
        gvContent.DataSource = dt
        gvContent.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Cat.aspx?Id=" & s.CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from RCProductCat where Id=" & id)
        Response.Redirect("/Admin/Products/DefaultCat.aspx")
    End Sub

    Protected Sub btnAddCat_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddCat.Click
        Response.Redirect("Cat.aspx")
    End Sub
    
     Protected Sub btnProducts_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProducts.Click
        Response.Redirect("/Admin/Products")
    End Sub
    
End Class
