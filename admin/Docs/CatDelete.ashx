<%@ WebHandler Language="VB" Class="Delete" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class Delete : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/plain"
        Dim Id As Integer = ctx.Request("Id")
        
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmd As New SqlCommand("Delete from RCDocCat where Id=@Id", con)
        cmd.Parameters.AddWithValue("Id", Id)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class