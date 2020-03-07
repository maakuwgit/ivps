Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Users_Add
    Inherits System.Web.UI.Page

    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            If Not Request("Id") Is Nothing AndAlso IsNumeric(Request("Id")) Then
                Dim dt As DataTable = RC4.Pull("Select * from [Users] where id=" & CInt(Request("Id")))
                If dt.Rows.Count > 0 Then
                    With dt.Rows(0)
                        Id.Value = .Item("Id")
                        txtFirstName.Text = .Item("FirstName")
                        txtLastName.Text = .Item("LastName")
                        txtPhone.Text = .Item("Phone")
                        txtMobile.Text = .Item("Mobile")
                        txtEmail.Text = .Item("Email")
                        txtNotes.Value = IIf(IsDBNull(.Item("Notes")), "", .Item("Notes"))
                        txtAddress.Text = .Item("Address1")
                        txtAddress2.Text = .Item("Address2")
                        txtCity.Text = .Item("City")
                        txtState.Text = .Item("State")
                        txtZip.Text = .Item("Zip")
                        'Select Case .Item("access")
                        '    Case 0
                        '        dlAccess.SelectedIndex = 0
                        '    Case 1 To 10
                        '        dlAccess.SelectedIndex = 1
                        '    Case Is >= 11
                        '        dlAccess.SelectedIndex = 2
                        'End Select
                        'If Not IsDBNull(.Item("UserGroup")) Then dlUserGroup.SelectedValue = .Item("UserGroup")

                    End With
                End If
            Else
                btnReset.Visible = False
            End If
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Users/")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim cmd As SqlCommand
        If Id.Value = "" Then
            If txtPassword.Value = txtPassword2.Value Then
                cmd = New SqlCommand("Insert Into [Users] (access, lastAccessed, dateCreated,  FirstName, LastName, Phone, Mobile, Email, Address1, Address2, City, State, Zip, Password, IsMailingList, Notes) Values (11, GetDate(), GetDate(), @FirstName, @LastName, @Phone, @Mobile, @Email, @Address1, @Address2, @City, @State, @Zip, @Password, 1, @Notes)", con)
                cmd.Parameters.AddWithValue("Password", txtPassword.Value)
            Else
                lblMsg.Text = "Password fields must match."
                txtPassword.Focus()
                Exit Sub
            End If
        Else
            cmd = New SqlCommand("Update [Users] set FirstName=@FirstName, LastName=@LastName, Phone=@Phone, Mobile=@Mobile, Email=@Email, Notes=@Notes, Address1=@Address1, Address2=@Address2, City=@City, State=@State, Zip=@Zip where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", Id.Value)
        End If
        cmd.Parameters.AddWithValue("FirstName", txtFirstName.Text)
        cmd.Parameters.AddWithValue("LastName", txtLastName.Text)
        cmd.Parameters.AddWithValue("Phone", txtPhone.Text)
        cmd.Parameters.AddWithValue("Mobile", txtMobile.Text)
        cmd.Parameters.AddWithValue("Email", txtEmail.Text)
        cmd.Parameters.AddWithValue("Notes", txtNotes.Value)
        cmd.Parameters.AddWithValue("Address1", txtAddress.Text)
        cmd.Parameters.AddWithValue("Address2", txtAddress2.Text)
        cmd.Parameters.AddWithValue("City", txtCity.Text)
        cmd.Parameters.AddWithValue("State", txtState.Text)
        cmd.Parameters.AddWithValue("Zip", txtZip.Text)
        'cmd.Parameters.AddWithValue("UserGroup", dlUserGroup.SelectedItem.Text)
        'Select Case dlAccess.SelectedIndex
        '    Case Is <= 0
        '        cmd.Parameters.AddWithValue("Access", 0)
        '    Case 1
        '        cmd.Parameters.AddWithValue("Access", 10)
        '    Case 2
        '        cmd.Parameters.AddWithValue("Access", 11)
        'End Select
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("/Admin/Users/")
    End Sub

    Protected Sub btnReset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReset.Click
        If IsNumeric(Id.Value) Then
            Dim cmd As New SqlCommand("Update [Users] set Password=@Password where Id=@Id", con)
            cmd.Parameters.AddWithValue("Password", txtPassword.Value)
            cmd.Parameters.AddWithValue("Id", Id.Value)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
        End If
    End Sub
End Class
