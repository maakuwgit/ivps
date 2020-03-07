<%@ WebHandler Language="VB" Class="ModelImg" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web

Public Class ModelImg : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        'ctx.Response.ContentType = "application/octet-stream"
        ctx.Response.Cache.SetCacheability(HttpCacheability.Public)
        ctx.Response.Cache.SetExpires(Now.AddHours(4))
        ctx.Response.Cache.SetMaxAge(New TimeSpan(4, 0, 0))
        ctx.Response.Cache.SetValidUntilExpires(True)
        Dim Id As Integer = ctx.Request("Id")
        If ctx.Request("Type") Is Nothing Then
            			
			Dim dt As DataTable = RC4.Pull("Select * from RCDoc where Id=" & Id)
        If dt.Rows.Count > 0 Then
            ctx.Response.Clear()
            ctx.Response.ContentType = "application/octet-stream;"
            If Not IsDBNull(dt.Rows(0).Item("FileName")) Then
                If dt.Rows(0).Item("FileName").ToString().ToLower.EndsWith(".pdf") Then
                    ctx.Response.ContentType = "application/pdf;"
                End If
                ctx.Response.AddHeader("content-disposition", "attachment;filename=" & HttpUtility.UrlEncode(dt.Rows(0).Item("FileName")))
            End If
            ctx.Response.BinaryWrite(dt.Rows(0).Item("FileData"))
            ctx.Response.End()
        End If
        End If
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class