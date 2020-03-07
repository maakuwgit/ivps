<%@ WebHandler Language="VB" Class="CatDetail" %>

Imports System
Imports System.Web
Imports System.Data

Public Class CatDetail : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/html"
        
        Dim s As New StringBuilder
        If Not ctx.Request("Id") Is Nothing Then
            Dim CatId As Integer = ctx.Request("Id")
            s.Append("<input type=""Button"" value=""Add String"" onclick=""AddString(" & CatId & ")"" />")
            Dim dt As DataTable = RC4.Pull("Select * from RCString where CatId=" & CatId)
            If dt.Rows.Count > 0 Then
                s.Append("<table class=""mGrid""><tr><th>Name</th><th>Value</th></tr>")
                For Each dr As DataRow In dt.Rows
                    s.Append("<tr>")
                    s.Append("<td>" & dr.Item("Name") & "</td>")
                    s.Append("<td>" & dr.Item("Value") & "</td>")
                    s.Append("</tr>")
                Next
                s.Append("</table>")
            End If
        End If
        ctx.Response.Write(s.ToString)
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class