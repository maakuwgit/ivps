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
            Dim dt As DataTable = RC4.Pull("Select Attachment, AttachmentName from RCProduct where Id=" & Id)
            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)
                If Not IsDBNull(dr("AttachmentName")) Then
                    ctx.Response.AppendHeader("content-disposition", "attachment; filename=" + dr("AttachmentName"))
                    Dim str As String = dr("AttachmentName")
                    If LCase(str).EndsWith(".pdf") Then
                        ctx.Response.ContentType = "application/pdf"
                    End If
                End If
                If Not IsDBNull(dr("Attachment")) Then
                    ctx.Response.BinaryWrite(dr("Attachment"))
                End If
            End If
        ElseIf ctx.Request("Type") = "Bro" Then
            Dim dt As DataTable = RC4.Pull("Select BroFile, BroFileName from RCProduct where Id=" & Id)
            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)
                If Not IsDBNull(dr("BroFile")) Then
                    ctx.Response.AppendHeader("content-disposition", "attachment; filename=" + dr("BroFileName"))
                    Dim str As String = dr("BroFileName")
                    If LCase(str).EndsWith(".pdf") Then
                        ctx.Response.ContentType = "application/pdf"
                    End If
                End If
                If Not IsDBNull(dr("BroFile")) Then
                    ctx.Response.BinaryWrite(dr("BroFile"))
                End If
            End If
        End If
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class