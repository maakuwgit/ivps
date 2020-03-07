<%@ WebHandler Language="VB" Class="cats" %>

Imports System
Imports System.Web
Imports System.Data


Public Class cats : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/html"
        Dim s As New StringBuilder
        
        Dim dt As DataTable = RC4.Pull("Select Id, Name from RCStringCat")
        For Each dr As DataRow In dt.Rows
            s.Append("<h3><a href=""#"" onclick=""LoadCat(this, " & dr.Item("Id") & ")"">" & dr.Item("name") & "</a></h3>")
            s.Append("<div></div>")
        Next
        
        
        ctx.Response.Write(s.ToString)
    End Sub
    
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class