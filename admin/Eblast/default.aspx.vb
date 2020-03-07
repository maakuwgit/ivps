Imports System.Data
Imports System.Net

Partial Class Admin_email
    Inherits System.Web.UI.Page

#Region "Page_Load"
    Sub page_load(ByVal s As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'If Application("Settings") Is Nothing Then
            '    Application("Settings") = Tort.Settings.BuildCache
            'End If
            Dim strSQL1 As String = "SELECT * FROM EblastTemplates ORDER BY Title"
            Dim dt As System.Data.DataTable = RC4.Pull(strSQL1)
            For Each row As System.Data.DataRow In dt.Rows
                Dim oLI As New ListItem
                If Not row.Item(1) Is DBNull.Value Then
                    oLI.Text = row.Item(1)
                End If
                If Not row.Item(0) Is DBNull.Value Then
                    oLI.Value = row.Item(0)
                End If
                rblTemplate.Items.Add(oLI)
            Next
            dt = RC4.Pull("SELECT * FROM EblastGroups ORDER BY Title")
            ddlGroups.Items.Add(" please select ")
            For Each r As DataRow In dt.Rows
                If Not IsDBNull(r.Item(1)) Or IsDBNull(r.Item(0)) Then
                    ddlGroups.Items.Add(New ListItem(r.Item(1), r.Item(0)))
                End If
            Next
        End If
    End Sub
#End Region

#Region "rblGroup_SelectedIndexChanged"
    Sub rblGroup_SelectedIndexChanged(ByVal s As Object, ByVal e As EventArgs)
        Select Case rblGroup.SelectedIndex
            Case 0
                pnlEmail.Visible = True
                ddlGroups.Visible = False
            Case 1
                pnlEmail.Visible = False
                ddlGroups.Visible = False
            Case 2
                pnlEmail.Visible = False
                ddlGroups.Visible = True
        End Select
    End Sub
#End Region

#Region "rblTemplate_SelectedIndexChanged"
    Sub rblTemplate_SelectedIndexChanged(ByVal s As Object, ByVal e As EventArgs)
        Dim dt As DataTable = Pull("Select [subject], [body] from EblastTemplates where id = " & CInt(rblTemplate.SelectedValue))
        If dt.Rows.Count > 0 Then
            txtSubject.Text = dt.Rows(0).Item("subject")
            ucFCK.Value = dt.Rows(0).Item("body")
        End If
        'For Each oET As Tort.EmailTemplate In Tort.EmailCenter.GetEmailTemplates
        '    If oET.ID = rblTemplate.SelectedItem.Value Then
        '        txtSubject.Text = Tort.Transpose.SQLDecode(oET.Subject)
        '        ucFCK.Value = Tort.Transpose.SQLDecode(oET.Body)
        '        Exit For
        '    End If
        'Next
    End Sub
#End Region

#Region "btnSubmit_Click"
    Sub btnSubmit_Click(ByVal s As Object, ByVal e As EventArgs)
        'Dim strAttachment As String = ""
        'If fileAttachment.PostedFile.ContentLength > 0 Then
        '    Dim strExt As String = System.IO.Path.GetExtension(fileAttachment.PostedFile.FileName)
        '    Dim strFilename As String = "eblast_" & Date.Now.Month.ToString & Date.Now.Day.ToString & Date.Now.Hour.ToString & Date.Now.Minute.ToString & Date.Now.Second.ToString & Date.Now.Millisecond.ToString & strExt

        '    fileAttachment.PostedFile.SaveAs(ConfigurationManager.AppSettings("path_upload") & strFilename)
        '    strAttachment = ConfigurationManager.AppSettings("path_upload") & strFilename
        'End If

        Dim iCountEmail As Integer = 0
        Dim x As Integer = 0
        Select Case rblGroup.SelectedIndex
            Case 0
                SendEmail(txtEmail.Text, txtSubject.Text, ucFCK.Value)
                ClearForm()
            Case 1
                Dim arr As ArrayList = GetAllRecipients()
                For x = 0 To arr.Count - 1
                    Try
                        SendEmail(arr.Item(x), txtSubject.Text, ucFCK.Value)
                    Catch ex As Exception

                    End Try
                    iCountEmail += 1
                Next
            Case 2
                If ddlGroups.SelectedIndex <> 0 Then
                    Dim arr As ArrayList = GetGroupRecipients(ddlGroups.SelectedValue)
                    For x = 0 To arr.Count - 1
                        Try
                            SendEmail(arr.Item(x), txtSubject.Text, ucFCK.Value)
                        Catch ex As Exception

                        End Try
                        iCountEmail += 1
                    Next
                Else
                    lblMsg.Text = "Please select a group."
                    ddlGroups.Focus()
                End If
        End Select

        ClearForm()
        lblMsg.Text = "Message delivered successfully."
    End Sub
#End Region

#Region "Helpers"

#Region "GetAllRecipients"
    Function GetAllRecipients() As ArrayList
        Dim arr As New ArrayList
        Dim strSQL As String = "SELECT email FROM RCEmail"
        Dim dt As System.Data.DataTable = RC4.Pull(strSQL)
        For Each row As System.Data.DataRow In dt.Rows
            If row.Item(0) <> "" Then
                If isValidEmail(row.Item(0)) = True Then
                    arr.Add(row.Item(0))
                End If
            End If
        Next
        Return arr
    End Function
#End Region

#Region "GetGroupRecipients"
    Function GetGroupRecipients(ByVal GroupId As Integer) As ArrayList
        Dim arr As New ArrayList
        Dim sql As String = "Select Id, Email from RCEmail where Id in (Select distinct(userId) from EblastGroupsIndex where GroupId = " & GroupId & ")"
        Dim dt As DataTable = RC4.Pull(sql)
        For Each r As DataRow In dt.Rows
            If Not IsDBNull(r.Item("Email")) Then
                arr.Add(r.Item("Email"))
            End If
        Next
        Return arr
    End Function

    'Function GetGroupRecipients(ByVal intGroupID As Integer) As ArrayList
    '    Dim arr As New ArrayList
    '    Dim strSQLIndex As String = "SELECT groupID, userID FROM EblastGroupsIndex WHERE groupID='" & intGroupID & "' ORDER BY userID"
    '    Dim dtIndex As System.Data.DataTable = RC4.Pull(strSQLIndex)
    '    For Each row As System.Data.DataRow In dtIndex.Rows
    '        Dim oU As Tort.User = Tort.UserManager.GetUserByID(row.Item(1))
    '        If Not oU Is Nothing Then
    '            arr.Add(oU.Email)
    '        End If
    '    Next
    '    Return arr
    'End Function
#End Region

#Region "isValidEmail"
    Function isValidEmail(ByVal strEmail As String) As Boolean
        Dim bolSuccess As Boolean = False
        Dim patternLenient As String = "\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
        Dim reLenient As New Regex(patternLenient)
        Dim patternStrict As String = "^(([^<>()[\]\\.,;:\s@\""]+" & "(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@" & "((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" & "\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+" & "[a-zA-Z]{2,}))$"
        Dim reStrict As New Regex(patternStrict)
        Dim isLenientMatch As Boolean = reLenient.IsMatch(strEmail)
        If isLenientMatch Then
            bolSuccess = True
        End If
        Return bolSuccess
    End Function
#End Region

#Region "ClearForm"
    Sub ClearForm()
        rblTemplate.SelectedIndex = 0
        rblGroup.SelectedIndex = 0
        ddlGroups.Visible = False
        txtSubject.Text = ""
        ucFCK.Value = ""
    End Sub
#End Region

#End Region

    Private Sub SendEmail(ByVal strEmailToCustomer As String, ByVal strSubject As String, ByVal strBody As String)
        Dim smtpMail As New System.Net.Mail.SmtpClient("mail.real-fast.com")
        smtpMail.Credentials = New NetworkCredential("millennium@real-fast.com", "millennium332")
        Dim Msg As New System.Net.Mail.MailMessage
        With Msg
            .To.Add(New System.Net.Mail.MailAddress(strEmailToCustomer))
            .From = New System.Net.Mail.MailAddress("millennium@real-fast.com")
            .Subject = strSubject
            .Body &= "<html>"
            .Body &= "<head>"
            .Body &= "<style> "
            .Body &= "/*DL, DT, DD TAGS LIST DATA*/"
            .Body &= "dl {margin-bottom:50px;font-family:Arial;font-size:9pt;border:1px solid #000000;margin:2px;padding:2px;}"
            .Body &= "dl(dt)"
            .Body &= "{"
            .Body &= "text-align:right;"
            .Body &= "background:#444444;"
            .Body &= "color:#fff;"
            .Body &= "float:left;"
            .Body &= "font-weight:bold;"
            .Body &= "margin-right:10px;"
            .Body &= "padding:5px;"
            .Body &= "width:125px;"
            .Body &= "display:block;"
            .Body &= "}"

            .Body &= "dl dd {margin:2px 0;padding:5px 0;}"
            .Body &= "</style>"
            .Body &= "</head>"
            .Body &= "<body bgcolor=""#ffffff"">"
            If IO.File.Exists(MapPath("/images/emailHeader.jpg")) Then
                .Body &= "<img src=""http://" & Request.Url.Host & "/images/emailHeader.jpg"" />"
            Else
                .Body &= "<h2>" & ConfigurationManager.AppSettings("ProjectName") & "</h2>"
            End If
            .Body &= strBody
            .Body &= "</body>"
            .Body &= "</html>"
            .IsBodyHtml = True
        End With
        smtpMail.Send(Msg)
    End Sub
End Class