<%@ WebHandler Language="VB" Class="LinkImg" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web

Public Class LinkImg : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "image/jpeg"
        ctx.Response.Cache.SetCacheability(HttpCacheability.Public)
        ctx.Response.Cache.SetMaxAge(New TimeSpan(30, 0, 0, 0))
        ctx.Response.Cache.SetExpires(Today.Date.AddDays(30).ToUniversalTime)
        ctx.Response.Cache.SetValidUntilExpires(True)
        Dim Id As Integer = ctx.Request("Id")
        Dim c As SqlConnection = getCon()
        Dim ad As New SqlDataAdapter("Select Image from RCLink where Id=@Id", c)
        Dim dt As New DataTable
        ad.SelectCommand.Parameters.AddWithValue("Id", Id)
        
        ad.Fill(dt)
        If dt.Rows.Count > 0 Then
            Dim b() As Byte = dt.Rows(0).Item("Image")
            Dim ms As New MemoryStream(b)
            Dim msOutput As MemoryStream
            If Not ctx.Request("w") Is Nothing Then
                msOutput = Images.ResizeImage(ms, "image/jpeg", CInt(ctx.Request("w")))
            ElseIf Not ctx.Request("h") Is Nothing Then
                msOutput = Images.ResizeImage(ms, "image/jpeg", CInt(ctx.Request("h")))
            Else
                msOutput = Images.ResizeImage(ms, "image/jpeg", CInt(100))
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