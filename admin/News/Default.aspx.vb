Imports System.Data

Partial Class admin_News_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadGrid()
        End If
    End Sub

    Protected Sub LoadGrid()
        Dim dt As DataTable = RC4.Pull("Select * from RCNews order by PubDate desc")
        gvNews.DataSource = dt
        gvNews.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from RCNews where Id=" & id)
        Response.Redirect("/Admin/News/")
    End Sub
    
    Function GetCategoryName(id)
    	If id.ToString.length > 0 AndAlso id > 0 Then
    		Dim dt As DataTable = RC4.Pull("Select * from RCNewsCat Where id = " & id)
    		return dt.rows(0)("Name")
    	Else
    		return "--"
    	End If
    End Function
    
    Function isCornerstone(bol)
    	If  Not IsDBNull(bol) AndAlso bol = 1 Then
    		return "<span class=""text-white text-center d-block font-weight-bold bg-success"">&#10003;</span>"
    	Else
    		return "<span class=""text-secondary text-center d-block""></span>"
    	End If
    End Function
    
    Protected Sub ckCornerstone_CheckedChanged(ByVal s As CheckBox, ByVal e As EventArgs)
        Dim id As Integer = s.Attributes("NewsId")
        RC4.SQLExec("Update RCNews set Cornerstone = " & IIf(s.Checked, "1", "0") & " where Id=" & id)
    End Sub
    
End Class
