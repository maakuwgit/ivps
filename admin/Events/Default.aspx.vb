Imports System.Data
Imports System.Data.SqlClient


Partial Class admin_Events_Default
    Inherits System.Web.UI.Page

    Dim CurUser As New RCCUser

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            If Session("User") Is Nothing Then Exit Sub
            CurUser = GetUserLoggedIn(Session("user"))
            LoadCalendars()
            Dim dtUser As DataTable = RC4.Pull("Select firstName + ' ' + lastName as FullName, Id from Users")
            dlOwner.DataSource = dtUser
            dlOwner.DataBind()
        End If
    End Sub

    Protected Sub LoadCalendars()
        Dim dt As DataTable
        Select Case CurUser.access
            Case 0 'User
                dt = RC4.Pull("Select Id, Name, Description, (Select firstName + ' ' + lastName from Users where Users.Id = OwnerId) as Owner from RCCalendar where Id in (Select CalendarId from RCCalendarUser where UserId=" & CInt(CType(Session("User"), DataTable).Rows(0).Item("Id")) & ")")
            Case 10 'Power User
                dt = RC4.Pull("Select Id, Name, Description, (Select firstName + ' ' + lastName from Users where Users.Id = OwnerId) as Owner from RCCalendar")
            Case 11 'Super User
                btnAll.visible = True
                dt = RC4.Pull("Select Id, Name, Description, (Select firstName + ' ' + lastName from Users where Users.Id = OwnerId) as Owner from RCCalendar")
            Case Else
                Exit Sub
        End Select
        gvCal.DataSource = dt
        gvCal.DataBind()
    End Sub

    Protected Sub Permissions(ByVal s As Button, ByVal e As EventArgs)
        CalId.Value = s.CommandArgument
        Dim Cal As DataRow = GetCalendarById(CalId.Value)
        If Not Cal Is Nothing Then
            lblSecCalName.Text = Cal.Item("Name")
            Dim dtUserAll As DataTable = RC4.Pull("Select Id, FirstName + ' ' + LastName as [Name], (select count(*) from RCCalendarUser where UserId = Users.Id and CalendarId = " & CInt(CalId.Value) & ") as Sel from Users order by Name asc")
            ckL.Items.Clear()
            For Each dr As DataRow In dtUserAll.Rows
                Dim li As New ListItem
                li.Value = dr.Item("Id")
                li.Text = dr.Item("Name")
                li.Selected = dr.Item("Sel")
                ckL.Items.Add(li)
            Next
            ScriptManager.RegisterStartupScript(asyncCalendars, asyncCalendars.GetType(), "asyncCalendarComplete", "$('#dvSecurity').dialog('open');", True)
        End If
    End Sub

    Protected Function GetCalendarById(ByVal id As Integer) As DataRow
        Dim dt As DataTable = RC4.Pull("Select * from RCCalendar where id=" & id)
        If dt.Rows.Count > 0 Then
            Return dt.Rows(0)
        End If
        Return Nothing
    End Function

    Protected Sub Edit(ByVal sender As Button, ByVal e As EventArgs)
        Dim dt As DataTable = RC4.Pull("Select * from RCCalendar where Id=" & CInt(sender.CommandArgument))
        EditCalId.Value = sender.CommandArgument
        If dt.Rows.Count > 0 Then
            txtName.Text = dt.Rows(0).Item("Name")
            txtDesc.Text = dt.Rows(0).Item("Description")
            dlOwner.SelectedValue = dt.Rows(0).Item("OwnerId")
        End If
        ScriptManager.RegisterStartupScript(asyncEdit, asyncEdit.GetType(), "asyncCalendarComplete", "$('#dvEdit').dialog('open');", True)
    End Sub

    Protected Sub View(ByVal sender As Button, ByVal e As EventArgs)
        Response.Redirect("/admin/Events/View.aspx?Id=" & sender.CommandArgument)
    End Sub

    Protected Sub btnSecSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSecSave.Click
        Dim sql As String = "Delete from RCCalendarUser Where CalendarId = " & CInt(CalId.Value) & " "
        For Each li As ListItem In ckL.Items
            If li.Selected Then
                Sql &= "Insert into RCCalendarUser (UserId, CalendarId) Values (" & CInt(li.Value) & ", " & CInt(CalId.Value) & ") "
            End If
        Next
        RC4.SQLExec(Sql)
        ScriptManager.RegisterStartupScript(asyncCal, asyncCal.GetType(), "asyncCalComplete", "$('#dvSecurity').dialog('close');", True)
    End Sub

    Protected Sub btnEditSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEditSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmd As New SqlCommand("Update RCCalendar set Name=@Name, Description=@Description, OwnerId=@OwnerId where Id=@Id", con)
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Description", txtDesc.Text)
        cmd.Parameters.AddWithValue("OwnerId", dlOwner.SelectedValue)
        cmd.Parameters.AddWithValue("Id", EditCalId.Value)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        ScriptManager.RegisterStartupScript(asyncCal, asyncCal.GetType(), "asyncCalComplete", "$('#dvEdit').dialog('close');", True)
        LoadCalendars()
    End Sub
End Class