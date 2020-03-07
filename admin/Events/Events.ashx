<%@ WebHandler Language="VB" Class="Handler" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient

Public Class Handler : Implements IHttpHandler
    
    Dim epoch As Date = CDate("1/1/1970")
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        context.Response.ContentType = "application/json"

        Dim dtStart As Date = epoch.AddSeconds(context.Request("start"))
        Dim dtEnd As Date = epoch.AddSeconds(context.Request("end"))
        
        Dim CalId As Integer = -1
        If Not context.Request("CalId") Is Nothing AndAlso IsNumeric(context.Request("CalId")) Then
            CalId = context.Request("CalId")
        End If
        
        Dim r As New StringBuilder 'r = Response

        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim ad As New SqlDataAdapter("Select * from RCEvent where Id in (Select EventId from RCCalendarEvent where CalendarId=" & CalId & ")", con)
        Dim dt As New DataTable

        con.Open()
        ad.Fill(dt)
        con.Close()
        r.Append("[")
        For x As Integer = 0 To dt.Rows.Count - 1
            Dim dr As DataRow = dt.Rows(x)
            r.Append("{")
            r.Append("""id"": " & dr.Item("id") & ", ")
            r.Append("""title"": """ & dr.Item("title") & """, ")
            r.Append("""start"": """ & CDate(dr.Item("startdt")).ToString("yyyy-MM-dd") & "T" & CDate(dr.Item("startdt")).ToString("hh:mm:ss") & """, ")
            r.Append("""end"": """ & CDate(dr.Item("enddt")).ToString("yyyy-MM-dd") & "T" & CDate(dr.Item("enddt")).ToString("hh:mm:ss") & """, ")
            r.Append("""editable"": true, ""allDay"": false")
            If x = dt.Rows.Count - 1 Then
                r.Append("}")
            Else
                r.Append("},")
            End If
        Next
        
        r.Append("]")
        context.Response.Write(r.ToString)
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class