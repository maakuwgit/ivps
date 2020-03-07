Imports System.Data
Imports System.Data.DataTable

Partial Class admin_Content_Default
    Inherits System.Web.UI.Page
    
    Public dt As DataTable
    Public abc = 11

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
     	If Not Me.IsPostBack Then
     		If Not Request("a") Is Nothing Then
     			If Request("a") = "d" Then
     				Dim deleteSQLBuilder = new MSSQLBuilder("mnuItem")
				deleteSQLBuilder.setValueFor("id", Request("id"))
				deleteSQLBuilder.delete()
				Response.redirect("default.aspx")
     			End If
     		End If
		Dim msSQLBuilder = new MSSQLBuilder("mnuItem")
		msSQLBuilder.orderby("Name asc")
        		dt  = msSQLBuilder.SelectAll()
        	end if
    End Sub


    
End Class
