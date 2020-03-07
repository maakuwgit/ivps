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
        Dim dt As DataTable = RC4.Pull("Select * from WMALinks Order By Name")
        gvContent.DataSource = dt
        gvContent.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument & "&filter=" & filter.value)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from WMALinks where Id=" & id)
        Response.Redirect("/Admin/Url/" & "?filter=" & filter.value)
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Response.Redirect("Add.aspx")
    End Sub
    
    Protected Sub ckActive_CheckedChanged(ByVal s As CheckBox, ByVal e As EventArgs)
        Dim id As Integer = s.Attributes("LinkId")
        RC4.SQLExec("Update WMALinks set Active = " & IIf(s.Checked, "1", "0") & " where Id=" & id)
    End Sub
    
    Function isActive(bol)
    	If  Not IsDBNull(bol) AndAlso bol = 1 Then
    		return "<span class=""text-white text-center d-block font-weight-bold bg-success"">&#10003;</span>"
    	Else
    		return "<span class=""text-secondary text-center d-block""></span>"
    	End If
    End Function
    
    Function GetParent(id)
    	If Not IsDBNull(id) AndAlso id > 0 Then
    		Dim dt As DataTable = RC4.Pull("Select * from WMALinks Where id = " & id)
    		If dt.Rows.Count > 0 Then
			return "<span class=""text-secondary text-center d-block"">" & dt.Rows(0)("label") & "</span>"
		End If
    	End If
    End Function
    
End Class
