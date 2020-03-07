<%@ WebHandler Language="VB" Class="ModelImg" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.IO.Stream
Imports System.Web
Imports System.Net
Imports System.Drawing
Imports System.Drawing.Imaging

Public Class ModelImg : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "image/jpeg"
        ctx.Response.Cache.SetCacheability(HttpCacheability.Public)
        ctx.Response.Cache.SetExpires(Now.AddHours(4))
        ctx.Response.Cache.SetMaxAge(New TimeSpan(4, 0, 0))
        ctx.Response.Cache.SetValidUntilExpires(True)
        Dim Id As Integer = ctx.Request("Id")
        Dim c As SqlConnection = getCon()
        c.Open()
        
        Dim cmd As SqlCommand
        cmd = New SqlCommand("Select Img from RCProduct where Id=" & Id, c)
                
        Dim b() As Byte
        Try
            b = cmd.ExecuteScalar
        Catch ex As Exception
			'Dont give up yet, try to see if we can grab the image from a stored URL instead
			Dim result As DataTable = RC4.Pull("Select ImgURL from RCProduct where Id=" & Id)
			Dim product As DataRow
			Using wc As New WebClient()
				product = result.Rows.Item(0)
				b = wc.DownloadData(product("ImgURL"))
			End Using
        End Try
		
        Dim msOrig As MemoryStream
		Try
            msOrig = New MemoryStream(b)
		Catch ex As Exception
            Exit Sub
        End Try
        
        Dim msOutput As MemoryStream
        
        Dim size As Integer
        If Not ctx.Request("thumb") Is Nothing Then
            size = CInt(ConfigStrings.GetValByName("Thumb"))
        ElseIf Not ctx.Request("size") Is Nothing Then
            size = CInt(ConfigStrings.GetValByName(ctx.Request("Size")))
        ElseIf Not ctx.Request("h") Is Nothing Then
            msOutput = RC4.ResizeImage(msOrig, "image/jpeg", , ctx.Request("h"))
            ctx.Response.BinaryWrite(msOutput.ToArray())
            c.Close()
            Exit Sub
        ElseIf Not ctx.Request("w") Is Nothing Then
            msOutput = RC4.ResizeImage(msOrig, "image/jpeg", ctx.Request("w"), )
            ctx.Response.BinaryWrite(msOutput.ToArray())
            c.Close()
            Exit Sub
        Else
            size = CInt(ConfigStrings.GetValByName("Img.Product.Width"))
        End If
        msOutput = RC4.ResizeImage(msOrig, "image/jpeg", size)
        
        ctx.Response.BinaryWrite(msoutput.ToArray())
        c.Close()
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class