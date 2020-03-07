Imports System.Data
Imports System.Data.DataTable

Partial Class Menu_Edit
    Inherits System.Web.UI.Page
    
    Public dt As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    	 If Not Me.IsPostBack Then
		Dim msSQLBuilder = new MSSQLBuilder("mnuItem")
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
   	Dim msSQLBuilder = new MSSQLBuilder("mnuItem")
	msSQLBuilder.ParseHttpRequest(Request.form)
	if Not Request.form("deleteimg") Is Nothing Then
		MSSQLBuilder.query("UPDATE mnuItem SET img = NULL")
	End If
	Dim id = msSQLBuilder.save()
	If fileUploadImage.HasFile = true Then
		Dim src = ResizePostedFileToBytes(fileUploadImage.PostedFile, System.Drawing.Imaging.ImageFormat.Jpeg)
		If Not src Is Nothing And Not id Is Nothing  Then
			MSSQLBuilder.query("UPDATE mnuItem SET img = " & "0x" & BitConverter.ToString(src).Replace("-", "") & " WHERE id = " & id)
		End If
	End If
	return id
   End Function
    
End Class
