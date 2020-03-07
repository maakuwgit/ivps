Imports System.Data
Imports System.Data.DataTable

Partial Class Menu_Edit
    Inherits System.Web.UI.Page
    
    Public dt As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    	 If Not Me.IsPostBack Then
		Dim msSQLBuilder = new MSSQLBuilder("mnuSection")
		If Not Request("id") Is Nothing Then
			dt  = msSQLBuilder.SelectAllForId(Request("id"))
		Else
        			dt  = msSQLBuilder.SelectAllForId(Nothing)
        		End If
        	End If
    End Sub

    Protected Sub btnClose_Click(ByVal s As Button, ByVal e As EventArgs)  Handles btnClose.Click
	Response.Redirect("default.aspx")
   End Sub

   Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
	Dim id = save()
	Response.Redirect("edit.aspx?id=" & id)
   End Sub
   
   Protected Sub btnSaveClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveClose.Click
	save()
	btnClose_Click(sender, e)
   End Sub
   
   Protected Function Save()
   	Dim msSQLBuilder = new MSSQLBuilder("mnuSection")
	msSQLBuilder.ParseHttpRequest(Request.form)
	return msSQLBuilder.save()
   End Function
    
End Class
