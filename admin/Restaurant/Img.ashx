<%@ WebHandler Language="VB" Class="NewsImg" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web

Public Class NewsImg : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
    	
    	ctx.Response.ContentType = "image/jpeg"
        	ctx.Response.Cache.SetCacheability(HttpCacheability.Public)
        	ctx.Response.Cache.SetMaxAge(New TimeSpan(30, 0, 0, 0))
        	ctx.Response.Cache.SetExpires(Today.Date.AddDays(30).ToUniversalTime)
        	ctx.Response.Cache.SetValidUntilExpires(True)
        
    	Dim Id As Integer = ctx.Request("Id")
    	Dim SQLBuilder = new MSSQLBuilder("mnuItem")
    	Dim dt = SQLBuilder.SelectAllForId(id)
    	
	If dt.Rows.Count > 0 Then
		Dim b() As Byte = dt.Rows(0).Item("Img")
		Dim ms As New MemoryStream(b)
		Dim msOutput As MemoryStream
		If Not ctx.Request("w") Is Nothing Then
			msOutput = Images.ResizeImage(ms, "image/jpeg", CInt(ctx.Request("w")))
		ElseIf Not ctx.Request("h") Is Nothing Then
			msOutput = Images.ResizeImage(ms, "image/jpeg", CInt(ctx.Request("h")))
		Else
			msOutput = Images.ResizeImage(ms, "image/jpeg", 50)
		End If
		ctx.Response.BinaryWrite(msOutput.ToArray)
	End If
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class