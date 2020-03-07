<%@ WebHandler Language="VB" Class="Security" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient

Public Class Security : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
       	Dim sqlBuilder = new MSSQLBuilder(ctx.Request("tbl"))
	sqlBuilder.ParseHttpRequest(ctx.Request.Form)
	sqlBuilder.Save()
	ctx.Response.write(ctx.Request("tbl") & ":" & ctx.Request("id") & ":" & ctx.Request("published"))
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class