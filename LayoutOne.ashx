<%@ WebHandler Language="VB" Class="AjaxLayoutOne" %>

Imports System.Data
Imports System.Web
Imports System.Data.SqlClient
Imports System.Drawing.Drawing2D
Imports System.Drawing
Imports System.IO

'''''''''''''''''''''''''''''''''''''''''''''''''
' TO DO
' Form Checker
' GoogleReCaptcha
'
'''''''''''''''''''''''''''''''''''''''''''''''''
Public Class AjaxLayoutOne : Implements IHttpHandler
	
	Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
	
		If Not Website.Router.QueryString("id") Is Nothing Then
			Dim sw = new StringWriter()
			Try
				ctx.Server.Execute("\PageWidgets\DefaultPageHeader.aspx", sw)
			Catch ex As Exception
				'Do Nothing
				ctx.Response.Write(ex)
			End Try
			ctx.Response.Write(sw)
			ctx.Response.Write("<article class=""col-12"">")
			ctx.Response.Write(Website.Content.GetForPage(Website.Router.QueryString("id")))
			ctx.Response.Write("</article>")
		Else
			ctx.Response.Write("Missing Id")
		End If

	End Sub
	
	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
	
End Class