<%@ WebHandler Language="VB" Class="ImageUpload" %>

Imports System
Imports System.Data
Imports System.Web
Imports System.Net
Imports System.Net.Mail
Imports System.IO

Public Class ImageUpload : Implements IHttpHandler

    
    Dim ImageFolderPath = "/images/uploads"
    Dim ImgFolder = HttpContext.Current.Server.MapPath(ImageFolderPath)

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
    
	Dim location = ImgFolder
    	Dim  files = context.Request.Files
    	
	if files.count > 0 AndAlso  Not location Is Nothing then
		Dim name = Path.GetFileNameWithoutExtension(files(0).FileName).Replace("&","_").Replace("?","_").Replace("#","_").Replace("@","_")
		files(0).SaveAs(location & "/" & name & Path.GetExtension(files(0).FileName))
		context.response.write("{""location"":""" & ImageFolderPath & "/" & name & Path.GetExtension(files(0).FileName) & """}")
	else
		context.response.write("{""location"":""http://moxiecode.cachefly.net/tinymce/v9/images/logo.png""}")
	end if

    End Sub
    
    ' Don't know what this is used for.
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
  
End Class
