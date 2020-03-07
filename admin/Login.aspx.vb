Imports System.Data
Imports System.Data.SqlClient
Imports System.Net.Mail

Partial Class admin_Login
    Inherits System.Web.UI.Page

    Dim EmailRegex As String = "^(?("")("".+?""@)|(([0-9a-zA-Z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-zA-Z])@))(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,6}))$"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            txtUserName.Focus()
        End If
    End Sub

    Protected Sub btnLogIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogIn.Click
        If Regex.IsMatch(txtUserName.Text, EmailRegex) Then
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
            Dim ad As New SqlDataAdapter("Select * from [Users] where email=@email", con)
            ad.SelectCommand.Parameters.AddWithValue("email", txtUserName.Text)
            Dim dt As New DataTable
            con.Open()
            ad.Fill(dt)
            con.Close()
            If dt.Rows.Count > 0 Then
                If dt.Rows(0).Item("password") = txtPassword.Text Then
                    Session("User") = dt
                    Response.Redirect("/Admin/Default.aspx")
                End If
            End If
            lblMsg.InnerHtml = "Invalid User / Password combination."
            txtPassword.Focus()
        Else
            ClientScript.RegisterStartupScript(Me.GetType(), "Error", "alert('Invalid email address.');", True)
            txtUserName.Focus()
        End If
    End Sub

    Protected Sub lnkLostPW_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkLostPW.Click
        If Regex.IsMatch(txtUserName.Text, EmailRegex) Then
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
            Dim ad As New SqlDataAdapter("Select * from [Users] where email=@email", con)
            ad.SelectCommand.Parameters.AddWithValue("email", txtUserName.Text)
            Dim dt As New DataTable
            con.Open()
            ad.Fill(dt)
            con.Close()
            If dt.Rows.Count > 0 Then
                Dim smtp As New SmtpClient("mail.real-fast.com")
                Dim msg As New MailMessage
                msg.IsBodyHtml = True
                msg.From = New MailAddress("test@real-fast.com")
                msg.To.Add(txtUserName.Text)
                msg.Subject = Request.Url.Host & " :: Lost Password"
                msg.Body = "<!doctype html><html><head><style>body{font-family:Arial, Helvetica, sans-serif; font-size:10pt;}</style><title>" & msg.Subject & "</title></head><body>Your password is: " & dt.Rows(0).Item("Password") & "<body>"
                msg.IsBodyHtml = True
                smtp.Send(msg)
            End If
        Else
            ClientScript.RegisterStartupScript(Me.GetType(), "Error", "alert('Invalid email address.');", True)
            txtUserName.Focus()
        End If
    End Sub
End Class