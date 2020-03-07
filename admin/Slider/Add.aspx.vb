Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web

Partial Class admin_Content_Add
    Inherits System.Web.UI.Page
    
    Public SliderData

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    
		Dim Id = Request("Id")
		
		Dim SQLBuilder = new MSSQLBuilder("WMASlider")
		
		If Not Me.IsPostBack Then
			SliderData = SQLBuilder.SelectAllForId(Id)
		End If
		
		'SliderData = SQLBuilder.SelectId(Nothing)

    End Sub

	 Protected Sub btnSaveClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveClose.Click
	 	Save()
	 	Close()
	 End Sub
	 
	 Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
	 	Dim Id = Save()
	 	Response.Redirect(Request.Url.AbsolutePath & "?id=" & Id)
	 End Sub
	 
    Protected Function Save()
    	For Each key as string in Request.Form
    		Response.Write(Key & ": " & Request(key) & "<br>")
    	Next
    	'return 0
		Dim SQLBuilder = new MSSQLBuilder("WMASlider")
		SQLBuilder.ParseHttpRequest(Request.Form)
		Dim Id = SQLBuilder.Save()
		' Resizes the uploaded File the saves it to the File System and the url to the database
		If fileUploadImage.HasFile = true Then
			Dim src = ResizeAndUploadPostedFileToFileSystem(fileUploadImage.PostedFile, GetResourceFor("Slider Folder Path"), "0" & Id & "-slide.jpg", System.Drawing.Imaging.ImageFormat.Jpeg)
			If Not src Is Nothing Then
				SQLBuilder.Reset()
				SQLBuilder.SetValueFor("Id", Id)
				SQLBuilder.SetValueFor("ImgSrc", src)
				Response.Write(SQLBuilder.Save())
			End If
		End If
		Return Id
    End Function
    
    Protected Sub Close()
    	Response.Redirect("/Admin/Slider/")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Close()
    End Sub
    
End Class
