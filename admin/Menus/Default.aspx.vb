Imports System.Data
Imports System.Data.DataTable

Partial Class admin_Content_Default
    Inherits System.Web.UI.Page
    
    Dim AddFileName = "Add.aspx"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadGrid()
        End If
    End Sub

    Protected Sub LoadGrid()
    	Dim SQLBuilder = new MSSQLBuilder("WMAMenuLinks")
    	SQLBuilder.OrderBy("menuid ASC, [order] asc")
        gvSlider.DataSource = SQLBuilder.SelectAll()
        gvSlider.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument & "&filter=" & filter.value)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        Dim SQLBuilder = new MSSQLBuilder("WMAMenuLinks")
        SQLBuilder.SetValueFor("Id", id)
    		SQLBuilder.Delete()
        'Response.Redirect(System.IO.Path.GetDirectoryName(Request.AppRelativeCurrentExecutionFilePath))
        Response.Redirect("/Admin/Menus/" & "?filter=" & filter.value)
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Response.Redirect(AddFileName)
    End Sub
    
    Function getMenuInfo(id)
    	If Not IsDBNull(id) AndAlso id > 0 Then
    		Dim dt As DataTable = RC4.Pull("Select * from WMAMenus Where id = " & id)
    		If dt.Rows.Count > 0 Then
			return "<span class=""text-secondary text-left d-block"">" & dt.Rows(0)("Label") & "</span>"
		End If
    	End If
    End Function
    
    Function getLinkInfo(id)
    	If Not IsDBNull(id) AndAlso id > 0 Then
    		Dim dt As DataTable = RC4.Pull("Select * from WMALinks Where id = " & id)
    		If dt.Rows.Count > 0 Then
			return "<span class=""text-secondary text-left d-block"">" & dt.Rows(0)("Label") & "</span>"
		End If
    	End If
    End Function
    
End Class
