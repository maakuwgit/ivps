Imports System.Data
Imports System.Data.SqlClient
Imports System.Net
Imports System.IO
Imports Newtonsoft.Json
Imports System.Xml

Partial Class admin_Content_Add
    Inherits System.Web.UI.Page

	Public Marker
	
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
			Dim mssql = new MSSQLBuilder("wmaMarkers")
			
			Marker = mssql.SelectAllForId(Request("id")).Rows(0)
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
     	Dim id = Save()
        	Response.Redirect("Add.aspx?Id=" & id)
    End Sub
    
    Protected Sub btnSaveClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveClose.Click
     	Save()
        	Close()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Close()
    End Sub
    
    Function Save()
    		Dim mssql = new MSSQLBuilder("WMAMarkers")
    		mssql.ParseHttpRequest(Request.Form)
    		
    		Dim Address = Nothing
    		
    		If Request("id").ToString.Length = 0 Then
    			Address = Request("name") & ", " & Request("address") & ", " & Request("city") & ", " & Request("state") & ", " & Request("zip")
    		ElseIf Request("lat") .ToString.Trim.Length = 0 OrElse Request("lng") .ToString.Trim.Length = 0 Then
    			Address = Request("name") & ", " & Request("address") & ", " & Request("city") & ", " & Request("state") & ", " & Request("zip")
		End If
		
		If Not Address Is Nothing Then
			Dim geocode = Website.GEOCode(Address)
			mssql.setValueFor("lat", geocode.GetLat())
			mssql.setValueFor("lng", geocode.GetLng())
		End If
		
    		return mssql.Save()
    End Function
    
    Function Close()
    	Response.Redirect("/Admin/Locations/")
    End Function
    
End Class


