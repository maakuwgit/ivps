<%@ WebHandler Language="VB" Class="AddCat" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient


Public Class AddCat : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/plain"
        If Not ctx.Request("name") Is Nothing Then
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
            Dim cmd As New SqlCommand("Insert into RCStringCat (Name) VALUES (@Name)", con)
            
            Dim CatName As String = ctx.Request("name").ToString.Trim()
            If CatName.Length > 50 Then CatName = CatName.Substring(0, 50)
            cmd.Parameters.AddWithValue("Name", CatName)
            Try
                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
                ctx.Response.Write("success")
            Catch ex As Exception
                ThrowError(ctx, ex)
            End Try
        Else
            ThrowError(ctx, "error: name is required.")
        End If
    End Sub
    
    Protected Sub ThrowError(ByRef ctx As HttpContext, ByRef ex As Exception)
        ctx.Response.StatusCode = 500
        ctx.Response.Write("error: " & ex.Message)
        ctx.Response.StatusDescription = "error: " & ex.Message
    End Sub
    
    Protected Sub ThrowError(ByRef ctx As HttpContext, ByRef msg As String)
        ctx.Response.StatusCode = 500
        ctx.Response.Write("error: " & msg)
        ctx.Response.StatusDescription = "error: " & msg
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class