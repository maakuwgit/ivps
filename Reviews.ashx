<%@ WebHandler Language="VB" Class="Testimonial" %>

Imports System
Imports System.Data
Imports System.Web

Public Class Testimonial : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/html"
        Dim sb As New StringBuilder
        Dim dt As DataTable = RC4.Pull("Select * from RCTestimonials where isApproved='True'")
        Dim r As New Random
        Dim x As Integer = r.Next(0, dt.Rows.Count)
        With dt.Rows(x)
            'sb.Append("<div class=""home-testimonial"">")
            sb.Append("<p>")
            sb.Append("""" & .Item("quote") & """")
            sb.Append("</p>")
            sb.Append("<div class=""author"">")
            sb.Append(.Item("firstName") & " " & .Item("lastName") & " | ")
            sb.Append(.Item("city") & ", " & .Item("state"))
            sb.Append("</div>")
            'sb.Append("</div>")
        End With
        ctx.Response.Write(sb.ToString)
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class