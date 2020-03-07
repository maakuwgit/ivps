<%@ WebHandler Language="VB" Class="AddString" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient


Public Class AddString : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/plain"
        
        If ctx.Request("CatId") Is Nothing Then
            ThrowError(ctx, "error: Category Id is required.")
            Exit Sub
        End If
        If ctx.Request("Name") Is Nothing Then
            ThrowError(ctx, "error: Name is required.")
            Exit Sub
        End If
        If ctx.Request("Val") Is Nothing Then
            ThrowError(ctx, "error: Value is required.")
            Exit Sub
        End If
        
        Dim Id As Integer = -1
        If Not ctx.Request("StrId") Is Nothing Then Id = ctx.Request("StrId")
        Dim CatId As Integer = ctx.Request("CatId")
        Dim Name As String = ctx.Request("Name")
        Dim Val As String = ctx.Request("Val")
        
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If Id = -1 Then
            cmd = New SqlCommand("Insert into RCString (CatId, Name, Value) Values (@CatId, @Name, @Value)", con)
            cmd.Parameters.AddWithValue("CatId", CatId)
        Else
            cmd = New SqlCommand("Update RCString set Name=@Name, Value=@Value where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", Id)
        End If
        cmd.Parameters.AddWithValue("Name", Name)
        cmd.Parameters.AddWithValue("Value", Val)
        Try
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
            ctx.Response.Write("success")
        Catch ex As Exception
            ThrowError(ctx, ex.Message)
        End Try
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