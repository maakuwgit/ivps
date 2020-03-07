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
        Dim dt As DataTable = RC4.Pull("Select * From RCProduct")
        gvContent.DataSource = dt
        gvContent.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from RCProducts where Id=" & id)
        Response.Redirect("/Admin/Products/")
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Response.Redirect("Add.aspx")
    End Sub
    Protected Sub btnCat_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCat.Click
        Response.Redirect("DefaultCat.aspx")
    End Sub
    Function GetCategoryName(id)
    		If id.ToString().Length() > 0 Then
    			Dim sql = new MSSQLBuilder("RCProductCat")
    			Dim row =sql.SelectAllForId(id).Rows(0)
    			return row("Name")
    		Else
    			return ""
    		End If
    End Function
End Class
