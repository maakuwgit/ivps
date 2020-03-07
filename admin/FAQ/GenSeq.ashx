<%@ WebHandler Language="VB" Class="GenSeq" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class GenSeq : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/plain"
        Dim Id As Integer = ctx.Request("Id")
        Dim Seq As Integer = ctx.Request("Seq")
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmd As New SqlCommand("Update RCFAQ set Seq=@Seq where Id=@Id", con)
        cmd.Parameters.AddWithValue("Id", Id)
        cmd.Parameters.AddWithValue("Seq", Seq)
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