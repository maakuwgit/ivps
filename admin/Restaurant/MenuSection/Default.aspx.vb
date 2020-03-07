Imports System.Data
Imports System.Data.DataTable

Partial Class admin_Content_Default
    Inherits System.Web.UI.Page
    
    Public dt As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
     	If Not Me.IsPostBack Then
     		If Not Request("a") Is Nothing Then
     			If Request("a") = "d" Then
     				Dim deleteSQLBuilder = new MSSQLBuilder("mnuMenuSection")
				deleteSQLBuilder.setValueFor("id", Request("id"))
				deleteSQLBuilder.delete()
				Response.redirect("default.aspx")
     			End If
     		End If
        		dt  = MSSQLBuilder.Query("SELECT ms.id As id, m.name as menuname, s.name As sectionname, ms.description As description, ms.Published FROM mnuMenuSection ms INNER JOIN mnuMenu m ON ms.menu_id = m.id INNER JOIN mnuSection s ON ms.section_id = s.id Order By m.name asc")
        		'Dim msSQLBuilder = new MSSQLBuilder("mnuMenu")
        		'dt  = msSQLBuilder.SelectAll()
        	end if
    End Sub
    
End Class
