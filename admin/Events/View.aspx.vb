Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Events_View
    Inherits System.Web.UI.Page

    Dim CurUser As RCCUser

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CurUser = GetUserLoggedIn(Session("user"))
        If Not Me.IsPostBack AndAlso Not Request("Id") Is Nothing AndAlso IsNumeric(Request("Id")) Then
            If CurUser Is Nothing Then Response.Redirect("/admin/Login.aspx")
            Dim Id As Integer = Request("Id")

            CalendarId.Value = Id
            Dim dtCal As DataTable = RC4.Pull("Select * from RCCalendar where Id=" & Id)

            cklCalendars.DataTextField = "Name"
            cklCalendars.DataValueField = "Id"

            Dim dtCalList As DataTable = RC4.Pull("Select Id, Name from RCCalendar")
            cklCalendars.DataSource = dtCalList
            cklCalendars.DataBind()
        End If
        If Not Me.IsPostBack AndAlso Not Request("Id") Is Nothing AndAlso CurUser.access = 11 Then
            If LCase(Request("Id")) = "kitchensink" Then
                Dim dtCal As DataTable = RC4.Pull("Select Id from RCCalendar")
                Dim sb As New StringBuilder
                sb.Append("eventSources: [")
                For x As Integer = 0 To dtCal.Rows.Count - 1
                    Dim cText As String
                    Select Case x Mod 5
                        Case 0
                            cText = "color:'#36C'"
                        Case 1
                            cText = "color:'#3C6'"
                        Case 2
                            cText = "color:'#C36'"
                        Case 3
                            cText = "color:'#C63'"
                        Case 4
                            cText = "color:'#000'"
                        Case Else
                            cText = "color:'#000'"
                    End Select
                    sb.Append("{url: '/admin/Events/Events.ashx?CalId=" & dtCal.Rows(x).Item("Id") & "', " & cText & ", textColor:'#fff'}")
                    If Not x = dtCal.Rows.Count - 1 Then sb.Append(",")
                Next
                sb.Append("],")
                'txtTemp.Text = sb.ToString
            End If


        End If
    End Sub

    Protected Function CheckUserSec(ByVal CalendarId As Integer, Optional ByVal UserId As Integer = -1) As Boolean
        If UserId = -1 Then
            UserId = CType(Session("User"), DataTable).Rows(0).Item("Id")
        End If
        Dim dt As DataTable = RC4.Pull("Select * from RCCalendarUser where CalendarId=" & CalendarId & " and UserId=" & UserId)
        If dt.Rows.Count > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        'Validation
        Dim bSel As Boolean = False
        For x As Integer = 0 To cklCalendars.Items.Count - 1
            If cklCalendars.Items(x).Selected Then bSel = True
        Next
        If Not bSel Then
            Dim scriptUpdate As String
            scriptUpdate = "$('#dvCals').addClass('error');"
            ScriptManager.RegisterStartupScript(asyncEvent, asyncEvent.GetType(), "asyncEventError", scriptUpdate, True)
            Exit Sub
        End If
        If String.IsNullOrEmpty(txtTitle.Text) Then
            Dim scriptUpdate As String
            scriptUpdate = "$('#" & txtTitle.ClientID & "').addClass('error');"
            ScriptManager.RegisterStartupScript(asyncEvent, asyncEvent.GetType(), "asyncEventError", scriptUpdate, True)
            txtTitle.Focus()
            Exit Sub
        End If

        'Save
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If EventId.Value = 0 Then
            cmd = New SqlCommand("Insert into RCEvent (Title, StartDt, EndDt, Owner, [Desc]) values (@Title, @StartDt, @EndDt, @Owner, @Desc) Select scope_identity()", con)
        Else
            cmd = New SqlCommand("Update RCEvent set Title=@Title, StartDt=@StartDt, EndDt=@EndDt, Owner=@Owner, [Desc]=@Desc where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", EventId.Value)
            'Check Owner to make sure they're updating an event that belongs to them? Maybe later... lol
        End If

        Dim dtStart, dtEnd As Date

        dtStart = CDate(txtStart.Text & " " & dlSHour.SelectedItem.Text & ":" & dlSMinute.SelectedItem.Text & dlSPeriod.SelectedItem.Text)
        dtEnd = CDate(txtEnd.Text & " " & dlEHour.SelectedItem.Text & ":" & dlEMinute.SelectedItem.Text & dlEPeriod.SelectedItem.Text)

        cmd.Parameters.AddWithValue("Title", txtTitle.Text)
        cmd.Parameters.AddWithValue("StartDt", dtStart)
        cmd.Parameters.AddWithValue("EndDt", dtEnd)
        cmd.Parameters.AddWithValue("Owner", CurUser.Id)
        cmd.Parameters.AddWithValue("Desc", txtDesc.Text)
        con.Open()
        If EventId.Value = 0 Then
            Dim Id As Integer = cmd.ExecuteScalar()

            For x As Integer = 0 To cklCalendars.Items.Count - 1
                If cklCalendars.Items(x).Selected Then
                    Dim cmdRel As New SqlCommand("Insert into RCCalendarEvent (EventId, CalendarId) values (@EventId, @CalendarId)", con)
                    cmdRel.Parameters.AddWithValue("EventId", Id)
                    cmdRel.Parameters.AddWithValue("CalendarId", cklCalendars.Items(x).Value)
                    cmdRel.ExecuteNonQuery()
                End If
            Next
        Else
            cmd.ExecuteNonQuery()
            Dim cmdDelRel As New SqlCommand("Delete from RCCalendarEvent where EventId=" & CInt(EventId.Value), con)
            cmdDelRel.ExecuteNonQuery()
            For x As Integer = 0 To cklCalendars.Items.Count - 1
                If cklCalendars.Items(x).Selected Then
                    Dim cmdRel As New SqlCommand("Insert into RCCalendarEvent (EventId, CalendarId) values (@EventId, @CalendarId)", con)
                    cmdRel.Parameters.AddWithValue("EventId", CInt(EventId.Value))
                    cmdRel.Parameters.AddWithValue("CalendarId", cklCalendars.Items(x).Value)
                    cmdRel.ExecuteNonQuery()
                End If
            Next
        End If
        con.Close()
        Dim SaveSuccess As String
        SaveSuccess = "$('#event').dialog('close'); $('#calendar').fullCalendar('refetchEvents');"
        ScriptManager.RegisterStartupScript(asyncEvent, asyncEvent.GetType(), "asyncEventComplete", SaveSuccess, True)
    End Sub

    Protected Sub EventId_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles EventId.ValueChanged
        ScriptManager.RegisterStartupScript(asyncEvent, asyncEvent.GetType(), "asyncEventComplete", "$('.DatePicker').datepicker()", True)
        If EventId.Value = 0 Then
            txtTitle.Text = ""
            txtDesc.Text = ""
        Else
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
            Dim dt, dtCalAssign As New DataTable
            Dim ad As New SqlDataAdapter("Select * from RCEvent where Id=@Id", con)
            Dim adCalAssign As New SqlDataAdapter("Select distinct(CalendarId) as CalendarId from RCCalendarEvent where EventId=@Id", con)
            ad.SelectCommand.Parameters.AddWithValue("Id", EventId.Value)
            adCalAssign.SelectCommand.Parameters.AddWithValue("Id", EventId.Value)
            con.Open()
            ad.Fill(dt)
            adCalAssign.Fill(dtCalAssign)
            con.Close()
            If dt.Rows.Count > 0 Then
                With dt.Rows(0)
                    txtTitle.Text = .Item("title")
                    txtDesc.Text = .Item("desc")
                    Dim startdt As Date = .Item("startdt")
                    Dim enddt As Date = .Item("enddt")
                    txtStart.Text = startdt.ToString("MM/dd/yyyy")
                    dlSHour.SelectedValue = IIf(startdt.Hour = 0, 12, startdt.Hour)
                    dlSMinute.SelectedValue = startdt.Minute
                    dlSPeriod.SelectedValue = startdt.ToString("tt")

                    txtEnd.Text = enddt.ToString("MM/dd/yyyy")
                    dlEHour.SelectedValue = IIf(enddt.Hour = 0, 12, enddt.Hour)
                    dlEMinute.SelectedValue = enddt.Minute
                    dlEPeriod.SelectedValue = enddt.ToString("tt")
                End With
            End If
            cklCalendars.ClearSelection()
            For Each dr As DataRow In dtCalAssign.Rows
                For x As Integer = 0 To cklCalendars.Items.Count - 1
                    If cklCalendars.Items(x).Value = dr.Item("CalendarId") Then
                        cklCalendars.Items(x).Selected = True
                    End If
                Next
            Next
        End If
    End Sub

    Protected Sub asyncEvent_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles asyncEvent.Load
        Dim scriptUpdate As String
        scriptUpdate = "$('.DatePicker').datepicker();"
        ScriptManager.RegisterStartupScript(asyncEvent, asyncEvent.GetType(), "asyncEventLoad", scriptUpdate, True)
    End Sub

    Protected Sub lnkDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkDelete.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmdCal As New SqlCommand("Delete from RCEvent where Id=@Id", con)
        Dim cmdCalRel As New SqlCommand("Delete from RCCalendarEvent where EventId=@Id", con)
        cmdCal.Parameters.AddWithValue("Id", EventId.Value)
        cmdCalRel.Parameters.AddWithValue("Id", EventId.Value)
        con.Open()
        cmdCal.ExecuteNonQuery()
        cmdCalRel.ExecuteNonQuery()
        con.Close()
        Dim DeleteSuccess As String
        DeleteSuccess = "$('#event').dialog('close'); $('#calendar').fullCalendar('refetchEvents');"
        ScriptManager.RegisterStartupScript(asyncEvent, asyncEvent.GetType(), "asyncEventDelete", DeleteSuccess, True)
    End Sub
End Class
