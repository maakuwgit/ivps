Imports System.Data
Imports System.Data.DataTable

Partial Class admin_Content_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadGrid()
        End If
    End Sub

    Protected Sub LoadGrid()
        Dim dt As DataTable = RC4.Pull("Select RCLink.*, RCLinkCat.Name as CatName, RCLinkCat.Image as CatImage from RCLink Left Outer Join RCLinkCat ON RCLink.CatId = RCLinkCat.Id  order by RCLinkCat.Name asc")
        gvContent.DataSource = dt
        gvContent.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from RCLink where Id=" & id)
        Response.Redirect("/Admin/Links/")
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Response.Redirect("Add.aspx")
    End Sub
    
    Protected Sub btnCategories_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCategories.Click
        Response.Redirect("Cat.aspx")
    End Sub
    
End Class
