Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Links_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    ID.Value = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from RCLink Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        txtName.Text = dt.Rows(0).Item("Name")
                        txtLink.Text = dt.Rows(0).Item("Link")
                        txtDesc.Text = dt.Rows(0).Item("Description")
                        txtCatName.Text = dt.Rows(0).Item("CatName")
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If String.IsNullOrEmpty(ID.Value) Then
            cmd = New SqlCommand("Insert Into RCLink ([Name], [Link], [Description], [CatName]) Values (@Name, @Link, @Description, @CatName) select scope_identity()", con)
        Else
            cmd = New SqlCommand("Update RCLink set [Name]=@Name, [Link]=@Link, [Description]=@Description, [CatName]=@CatName where Id=@Id select scope_identity()", con)
            cmd.Parameters.AddWithValue("Id", CInt(ID.Value))
        End If
        cmd.Parameters.AddWithValue("CatName", txtCatName.Text)
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Link", txtLink.Text)
        cmd.Parameters.AddWithValue("Description", txtDesc.Text)
        'cmd.Parameters.AddWithValue("Value", txtContent.Value)
        con.Open()
        Id.Value = cmd.ExecuteNonQuery()
        con.Close()
        'If fileUpload.FileContent.Length > 0 Then
        '    Dim fi As New IO.FileInfo(fileUpload.PostedFile.FileName)
        '    If fi.Extension = "gif" Or fi.Extension = "png" Or fi.Extension = "jpg" Then
        '        fileUpload.SaveAs("/images/links/" & Id.Value & fi.Extension)
        '    End If
        'End If
        Response.Redirect("/Admin/Links/")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Links/")
    End Sub
End Class
