Imports System.Data
Imports System.Data.SqlClient

Partial Class afgadmin_Gallery_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            If Not Request("Cat") Is Nothing Then
                txtCatName.Text = Request("Cat")
            End If
            If Not Request("Id") Is Nothing Then
                Id.Value = Request("Id")
                Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
                Dim ad As New SqlDataAdapter("Select * from RCVideoCat where Id=@CatId", con)
                ad.SelectCommand.Parameters.AddWithValue("CatId", Id.Value)
                Dim dt As New DataTable
                con.Open()
                ad.Fill(dt)
                con.Close()
                If dt.Rows.Count > 0 Then
                    txtCatName.Text = dt.Rows(0).Item("Name")
                    txtCatDesc.Text = dt.Rows(0).Item("Description")
                End If
            End If
        End If
    End Sub

    'Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
    '    Response.Redirect("/Admin/Gallery/")
    'End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        con.Open()
        Dim cmd As SqlCommand
		' Dont think this is needed - Phil
        'Dim cmdSeq As New SqlCommand("Select coalesce(max(seq),1) from VideoItem where CatId=@CatId", con)
        'If Id.Value = "" Then
        '    cmdSeq.Parameters.AddWithValue("CatId", 0)
		'Else
        '    cmdSeq.Parameters.AddWithValue("CatId", Id.Value)
		'End If
        'Dim Seq As Integer = cmdSeq.ExecuteScalar
        If Id.Value = "" Then
            cmd = New SqlCommand("Insert Into RCVideoCat (Name, Description) Values (@Name, @Description)", con)
        Else
            cmd = New SqlCommand("Update RCVideoCat set Name=@Name, Description=@Description where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", Id.Value)
        End If
        cmd.Parameters.AddWithValue("Name", txtCatName.Text)
        cmd.Parameters.AddWithValue("Description", txtCatDesc.Text)
        cmd.ExecuteNonQuery()
        Response.Redirect("/info/Admin/Videos/")
        con.Close()
    End Sub
End Class
