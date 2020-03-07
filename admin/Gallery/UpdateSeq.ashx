<%@ WebHandler Language="VB" Class="Handler" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient


Public Class Handler : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        context.Response.ContentType = "text/plain"
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
            Dim cmd As New SqlCommand("Update RCGalleryImage set Seq=@Seq where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", CInt(context.Request("Id")))
            cmd.Parameters.AddWithValue("Seq", CInt(context.Request("Seq")))
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
            context.Response.Write("Success")
        Catch ex As Exception
            context.Response.Write(ex.Message)
        End Try
        
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class