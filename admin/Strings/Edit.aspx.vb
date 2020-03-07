Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Strings_Edit
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Me.Form.Attributes.Add("autocomplete", "off")
        If Not Me.IsPostBack Then
            txtName.Focus()
            If Not Request("Id") Is Nothing Then
                Dim Id As Integer = Request("Id")
                StrId.Value = Id
                Dim dt As DataTable = RC4.Pull("Select * from RCString where Id=" & Id)
                If dt.Rows.Count > 0 Then
                    If Not IsDBNull(dt.Rows(0).Item("Name")) Then txtName.Text = dt.Rows(0).Item("Name")
                    If Not IsDBNull(dt.Rows(0).Item("Value")) Then txtValue.Value = dt.Rows(0).Item("Value")
                    If Not IsDBNull(dt.Rows(0).Item("CatId")) Then CatId.Value = dt.Rows(0).Item("CatId")
                End If
            Else
                StrId.Value = -1
                If Not Request("CatId") Is Nothing Then
                    CatId.Value = Request("CatId")
                Else
                    Response.Redirect("/admin/strings/")
                End If
            End If
        End If
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        If IsNumeric(CatId.Value) Then
            Response.Redirect("/admin/strings/?CatId=" & CatId.Value)
        Else
            Response.Redirect("/admin/strings/")
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If StrId.Value = -1 Then
            cmd = New SqlCommand("Insert into RCString (Name, Value, CatId) VALUES (@Name, @Value, @CatId)", con)
            cmd.Parameters.AddWithValue("CatId", CatId.Value)
        Else
            cmd = New SqlCommand("Update RCString set Name=@Name, Value=@Value where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", StrId.Value)
        End If

        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Value", txtValue.Value)

        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()

        ConfigStrings = New StringResList

        If IsNumeric(CatId.Value) Then
            Response.Redirect("/admin/strings/?CatId=" & CatId.Value)
        Else
            Response.Redirect("/admin/strings/")
        End If

    End Sub
End Class
