<%@ WebHandler Language="VB" Class="GetImage" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient

Public Class GetImage : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        If Not ctx.Request("Id") Is Nothing Then
            Dim Id As Integer
            If IsNumeric(ctx.Request("Id")) Then
                Id = ctx.Request("Id")
                Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
                Dim ad As New SqlDataAdapter("Select Data, ContentType from RCGalleryImage where Id=@Id", con)
                Dim dt As New DataTable
                ad.SelectCommand.Parameters.AddWithValue("Id", Id)
                con.Open()
                ad.Fill(dt)
                con.Close()
                If dt.Rows.Count > 0 Then
                    ctx.Response.ContentType = dt.Rows(0).Item("ContentType")
                    ctx.Response.BinaryWrite(dt.Rows(0).Item("Data"))
                    ctx.Response.End()
                Else
                    ctx.Response.StatusCode = 404
                End If
            Else
                ctx.Response.StatusCode = 404
            End If
        End If
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class