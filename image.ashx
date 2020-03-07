<%@ WebHandler Language="VB" Class="NewsImg" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web

Public Class NewsImg : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        
        ctx.Response.Cache.SetCacheability(HttpCacheability.Public)
        
        ctx.Response.Cache.SetMaxAge(New TimeSpan(30, 0, 0, 0))
        
        ctx.Response.Cache.SetExpires(Today.Date.AddDays(30).ToUniversalTime)
        
        ctx.Response.Cache.SetValidUntilExpires(True)
        
        Dim Id As Integer = ctx.Request("Id")
        Dim c As SqlConnection = getCon()
        
        Dim table = ctx.Request("g").ToLower()
        Dim ad
        Dim column = "Img"
        Select Case table
        		Case "news"
        			ad = New SqlDataAdapter("Select Img from RCNews where Id=@Id", c)
        		Case "gallery"
        			ad = New SqlDataAdapter("Select Img from RCGalleryImage where galleryid=@Id", c)
        			column = "Data"
        		Case "product"
        			ad = New SqlDataAdapter("Select Img from RCProduct where id=@Id", c)
        		Case Else
        End Select
        
        Dim dt As New DataTable
        
        ad.SelectCommand.Parameters.AddWithValue("Id", Id)
        
        ad.Fill(dt)
        
        If dt.Rows.Count > 0 Then
            Dim b() As Byte = dt.Rows(0).Item(column)
            Dim ms As New MemoryStream(b)
            ctx.Response.ContentType = ImageUtility.ImageMimeType(ms)
            Dim msOutput As MemoryStream
            If Not ctx.Request("w") Is Nothing Then
                msOutput = ImageUtility.ResizeImage(ms, CInt(ctx.Request("w")))
            ElseIf Not ctx.Request("h") Is Nothing Then
                msOutput = ImageUtility.ResizeImage(ms, CInt(ctx.Request("h")))
            Else
                msOutput = ImageUtility.ResizeImage(ms, CInt(RC4.ConfigStrings.GetValByName("Img.Width")))
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