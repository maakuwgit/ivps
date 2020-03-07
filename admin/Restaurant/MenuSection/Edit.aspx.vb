Imports System.Data
Imports System.Data.DataTable

Partial Class Menu_Edit
    Inherits System.Web.UI.Page
    
    Public dt As DataTable
    Public menu As DataTable
    Public section As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    	 If Not Me.IsPostBack Then
		Dim msSQLBuilder = new MSSQLBuilder("mnuMenuSection")
		If Not Request("id") Is Nothing Then
			dt  = msSQLBuilder.SelectAllForId(Request("id"))
		Else
        			dt  = msSQLBuilder.SelectAllForId(Nothing)
        		End If
        	End If
        	Dim menusql = new MSSQLBuilder("mnuMenu")
        	menusql.OrderBy("name asc")
        	menu = menusql.SelectAll()
        	
        	Dim sectionsql = new MSSQLBuilder("mnuSection")
        	sectionsql.OrderBy("name asc")
        	section = sectionsql.SelectAll()
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
   	Dim msSQLBuilder = new MSSQLBuilder("mnuMenuSection")
	msSQLBuilder.ParseHttpRequest(Request.form)
	return msSQLBuilder.save()
   End Function
    
End Class
