<%@ WebHandler Language="VB" Class="Seq" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Public Class Seq : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/html"
        Dim Id As Integer = ctx.Request("Id").Trim()
        Dim Seq As Integer = ctx.Request("Seq").Trim()
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmd As New SqlCommand("Update WMAMenuLink set Order=@Order where Id=@Id", con)
        cmd.Parameters.AddWithValue("Id", Id)
        cmd.Parameters.AddWithValue("Order", Seq)
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