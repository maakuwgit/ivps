Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Content_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
        	
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    Id.Value = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from WMALAbel Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        txtLabel.Text = dt.Rows(0).Item("Label").ToString()
                        txtLocation.Text = dt.Rows(0).Item("Location").ToString()
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If String.IsNullOrEmpty(Id.Value) Then
            cmd = New SqlCommand("Insert Into WMALabel ([Label], [Location]) Values (@Label, @Location)", con)
        Else
            cmd = New SqlCommand("Update WMALabel set [Label]=@Label,  [Location]=@Location Where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", CInt(Id.Value))
        End If
        cmd.Parameters.AddWithValue("Label", txtLabel.Text)
        cmd.Parameters.AddWithValue("Location", txtLocation.Text)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("/Admin/Labels/")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Labels/")
    End Sub

    
    
End Class
