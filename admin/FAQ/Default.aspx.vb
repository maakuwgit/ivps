Imports System.Data

Partial Class admin_News_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadGrid()
        End If
    End Sub

    Protected Sub LoadGrid()
        Dim dt As DataTable = RC4.Pull("Select * from RCFAQ order by Seq asc")
        gvNews.DataSource = dt
        gvNews.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument & "&filter=" & filter.value)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from RCFAQ where Id=" & id)
        Response.Redirect("/Admin/FAQ/" & "?filter=" & filter.value)
    End Sub
    
    Function isFeatured(val)
    		if val = 1 then
    			return "Yes"
    		else
    			return "No"
    		end if
    End Function
End Class
