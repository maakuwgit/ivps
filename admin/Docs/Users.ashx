<%@ WebHandler Language="VB" Class="Users" %>

Imports System
Imports System.Data
Imports System.Web

Public Class Users : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/html"
        Dim CatId As Integer = ctx.Request("CatId")
        Dim dt As DataTable = RC4.Pull("Select Id, Email, (Select top 1 CatId from RCDocSecurity where UserId=Users.Id and CatId=" & CatId & ") as CatId from Users group by Users.Id, Users.Email")
        Dim sb As New StringBuilder
        
        If dt.Rows.Count > 0 Then
            sb.Append("[")
            For Each dr As DataRow In dt.Rows
                sb.Append("{ ""id"":" & dr("Id") & ", ""email"":""" & dr("Email") & """, ""access"":")
                If IsDBNull(dr("CatId")) Then
                    sb.Append("false")
                Else
                    sb.Append("true")
                End If
                sb.Append("},")
            Next
            sb.Remove(sb.Length - 1, 1)
            sb.Append("]")
        End If
        
        ctx.Response.Write(sb.ToString())
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class