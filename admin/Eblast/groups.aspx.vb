Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_emailCenter_groups
    Inherits System.Web.UI.Page
    Sub page_load(ByVal s As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim dt As System.Data.DataTable = RC4.Pull("SELECT * FROM EblastGroups")
            For Each row As Data.DataRow In dt.Rows
                Dim oLI As New ListItem
                oLI.Text = row.Item("title")
                oLI.Value = row.Item("id")
                ddlGroups.Items.Add(oLI)
            Next
            FillUsers()
        End If
    End Sub

    Sub ddlGroups_SelectedIndexChanged(ByVal s As Object, ByVal e As EventArgs) Handles ddlGroups.SelectedIndexChanged
        FillUsers()
    End Sub

    Sub btnAddAll_Click(ByVal s As Object, ByVal e As EventArgs)
        Dim strSQL As String = ""
        strSQL += "INSERT INTO EblastGroupsIndex (groupID, userID) Select " & CInt(ddlGroups.SelectedValue) & ", Id from RCEmail where Id not in (Select UserId from EblastGroupsIndex where groupid=" & ddlGroups.SelectedValue & ")"
        RC4.SQLExec(strSQL)
        FillUsers()
    End Sub

    Sub btnRemoveAll_Click(ByVal s As Object, ByVal e As EventArgs)
        Dim strSQL As String = "DELETE FROM EblastGroupsIndex WHERE groupID = " & CInt(ddlGroups.SelectedValue) & ""
        RC4.SQLExec(strSQL)
        FillUsers()
    End Sub

    Sub btnAdd_Click(ByVal s As Object, ByVal e As EventArgs)
        For x As Integer = lstUsers.Items.Count - 1 To 0 Step -1
            With lstUsers.Items(x)
                If .Selected Then
                    Dim strSQL As String = "SELECT id FROM EblastGroupsIndex WHERE userID=" & CInt(Request.QueryString("id")) & " AND groupID='" & .Value & "'"
                    Dim dt As System.Data.DataTable = RC4.Pull(strSQL)
                    If dt.Rows.Count = 0 Then
                        Dim strSQLUpdate As String = "INSERT INTO EblastGroupsIndex (groupID, userID) VALUES ( '" & CInt(ddlGroups.SelectedValue) & "', '" & .Value & "')"
                        RC4.SQLExec(strSQLUpdate)
                        lstGroups.Items.Add(lstUsers.Items(x))
                        lstUsers.Items.RemoveAt(x)
                    End If
                End If
            End With
        Next
    End Sub

    Sub btnRemove_Click(ByVal s As Object, ByVal e As EventArgs)
        For x As Integer = lstGroups.Items.Count - 1 To 0 Step -1
            With lstGroups.Items(x)
                If .Selected Then
                    Dim strSQL As String = "SELECT * FROM EblastGroupsIndex WHERE groupID='" & ddlGroups.SelectedValue & "' AND userID='" & .Value & "'"
                    Dim dt As System.Data.DataTable = RC4.Pull(strSQL)
                    If dt.Rows.Count > 0 Then
                        Dim strSQLUpdate As String = "DELETE FROM EblastGroupsIndex WHERE groupID='" & ddlGroups.SelectedValue & "' AND userID='" & .Value & "'"
                        RC4.SQLExec(strSQLUpdate)
                        lstUsers.Items.Add(lstGroups.Items(x))
                        lstGroups.Items.RemoveAt(x)
                    End If
                End If
            End With
        Next
    End Sub

    Sub btnDeleteUser_Click(ByVal s As Object, ByVal e As EventArgs)
        Dim str As String = "DELETE FROM RCCEmail WHERE email='" & lstUsers.SelectedItem.Text & "'"
        RC4.SQLExec(str)
        Response.Redirect("groups.aspx", False)
    End Sub

    Sub FillUsers()
        If IsNumeric(ddlGroups.SelectedValue) Then
            Dim intGroupID As Integer = ddlGroups.SelectedValue
            Dim sqlUsers As String = "Select Id, Email from RCEmail where Id not in (Select UserId from EblastGroupsIndex where GroupId = " & intGroupID & ")"
            Dim dtUsers As DataTable = RC4.Pull(sqlUsers)

            Dim sqlGroup As String = "Select Id, Email from RCEmail where Id in (Select UserId from EblastGroupsIndex where GroupId = " & intGroupID & ")"
            Dim dtGroup As DataTable = RC4.Pull(sqlGroup)

            'All Users
            lstUsers.DataTextField = "Email"
            lstUsers.DataValueField = "Id"
            lstUsers.DataSource = dtUsers
            lstUsers.DataBind()

            'Users in the group
            lstGroups.DataTextField = "Email"
            lstGroups.DataValueField = "Id"
            lstGroups.DataSource = dtGroup
            lstGroups.DataBind()
        Else
            lblMsg.InnerHtml = "No Eblast groups exist. Click the button above to Add a New Group."
            ddlGroups.Enabled = False
            lstUsers.Enabled = False
            lstGroups.Enabled = False
        End If
    End Sub

    Const emailRegex = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|""(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*"")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"

    Protected Sub btnSubmitEmails_Click(sender As Object, e As System.EventArgs) Handles btnSubmitEmails.Click
        Dim str As String = txtEmails.Value
        str = str.Replace(",", " ").Replace("|", " ").Replace(vbCrLf, " ").Replace(vbLf, " ").Replace(vbTab, " ")

        Dim Emails() As String = str.Split(" ")

        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        con.Open()

        For Each s As String In Emails
            If Regex.IsMatch(s, emailRegex) Then
                Dim cmdCheck As New SqlCommand("Select count(*) from RCCEmail where Email=@Email", con)
                cmdCheck.Parameters.AddWithValue("Email", s)
                If cmdCheck.ExecuteScalar = 0 Then
                    Dim cmd As New SqlCommand("insert into RCCEmail (Email, DtAdded) VALUES (@Email, GetDate())", con)
                    cmd.Parameters.AddWithValue("Email", s)
                    cmd.ExecuteNonQuery()
                End If
            End If
        Next
        con.Close()

        ddlGroups.Items.Clear()
        Dim dt As System.Data.DataTable = RC4.Pull("SELECT * FROM EblastGroups")
        For Each row As Data.DataRow In dt.Rows
            Dim oLI As New ListItem
            oLI.Text = row.Item("title")
            oLI.Value = row.Item("id")
            ddlGroups.Items.Add(oLI)
        Next
        FillUsers()

    End Sub
End Class
