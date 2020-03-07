<%@ WebHandler Language="VB" Class="Security" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient

Public Class Security : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/plain"
        If Not ctx.Request("User") Is Nothing AndAlso Not ctx.Request("CatId") Is Nothing Then
            Dim c As SqlConnection = getCon()
            Dim cmd As SqlCommand
            If Not ctx.Request("remove") Is Nothing Then
                cmd = New SqlCommand("Delete from RCDocSecurity where UserId=@UserId and CatId=@CatId", c)
            Else
                cmd = New SqlCommand("Insert into RCDocSecurity (UserId, CatId) Values (@UserId, @CatId)", c)
            End If
            
            cmd.Parameters.AddWithValue("UserId", CInt(ctx.Request("User")))
            cmd.Parameters.AddWithValue("CatId", CInt(ctx.Request("CatId")))
            c.Open()
            cmd.ExecuteNonQuery()
            c.Close()
        End If
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class