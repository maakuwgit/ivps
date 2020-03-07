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
                Dim ad As New SqlDataAdapter("Select * from RCVideo where Id=@Id", con)
                ad.SelectCommand.Parameters.AddWithValue("Id", Id.Value)
                Dim dt As New DataTable
                con.Open()
                ad.Fill(dt)
                con.Close()
                If dt.Rows.Count > 0 Then
                    txtImgName.Text = dt.Rows(0).Item("Name").ToString
                    txtImgDesc.Text = dt.Rows(0).Item("Description")
                    txtCatName.Text = dt.Rows(0).Item("CatId")
                    txtCode.Text = dt.Rows(0).Item("Code")
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
        Dim cmdSeq As New SqlCommand("Select coalesce(max(seq),1) from RCVideo where CatId=1", con)
        cmdSeq.Parameters.AddWithValue("CatName", txtCatName.Text)
        Dim Seq As Integer = cmdSeq.ExecuteScalar
        If Id.Value = "" Then
            cmd = New SqlCommand("Insert Into RCVideo (Name, Description, CatId, Code, Seq) Values(@Name, @Description, @CatId, @Code, @Seq + 1) SELECT SCOPE_IDENTITY()", con)
        Else
            cmd = New SqlCommand("Update RCVideo set Name=@Name, Description=@Description, CatId=@CatId, Code=@Code where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", Id.Value)
        End If
        cmd.Parameters.AddWithValue("Name", txtImgName.Text)
        cmd.Parameters.AddWithValue("Description", txtImgDesc.Text)
        cmd.Parameters.AddWithValue("CatId", 1)
        cmd.Parameters.AddWithValue("Code", txtCode.Text)
        cmd.Parameters.AddWithValue("Seq", Seq)
        cmd.ExecuteNonQuery()
        Response.Redirect("/Admin/Videos/")
        con.Close()
    End Sub
End Class
