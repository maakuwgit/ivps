Imports System.Data
Imports System.Data.SqlClient

Partial Class afgadmin_Gallery_Default
    Inherits System.Web.UI.Page

    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadCats()
            LoadItems()
        End If
    End Sub

    Sub LoadCats()
        Dim CurCat As String = ""
        If Not cmbCat.SelectedItem Is Nothing Then
            CurCat = cmbCat.SelectedItem.Text
        End If
        Dim AD As New SqlDataAdapter("Select id, Name from RCVideoCat", con)
        Dim dt As New DataTable
        con.Open()
        AD.Fill(dt)
        con.Close()
        cmbCat.DataTextField = "CatName"
        cmbCat.DataMember = "id"
        cmbCat.DataSource = dt
        cmbCat.DataBind()

        For x As Integer = 0 To cmbCat.Items.Count - 1
            If cmbCat.Items(x).Text = CurCat Then cmbCat.SelectedIndex = x
        Next
    End Sub

    Sub LoadItems()
       '' If Not cmbCat.SelectedItem Is Nothing Then
            Dim AD As New SqlDataAdapter("Select * from RCVideo where CatId=1order by seq asc", con)
            'AD.SelectCommand.Parameters.AddWithValue("CatId", cmbCat.SelectedItem.Selected)
            Dim DT As New DataTable
            con.Open()
            AD.Fill(DT)
            con.Close()
            For x As Integer = 0 To DT.Rows.Count - 1
                If Not DT.Rows(x).Item("Code").ToString.Contains("/watch") Then
                    DT.Rows(x).Item("Code") = DT.Rows(x).Item("Code").ToString.Replace("?", "&").Replace("http://youtube.com/v/", "http://youtube.com/watch?v=")
                End If
            Next
            gvGalleryItems.DataSource = DT
            gvGalleryItems.DataBind()
        'Else
          ''  gvGalleryItems.DataSource = Nothing
           '' gvGalleryItems.DataBind()
       '' End If
    End Sub

    Protected Sub cmbCat_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbCat.SelectedIndexChanged
        LoadItems()
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        If Not cmbCat.SelectedItem Is Nothing Then
            Response.Redirect("/Admin/Videos/Add.aspx?Cat=" & cmbCat.SelectedItem.Text)
        Else
            Response.Redirect("/Admin/Videos/Add.aspx")
        End If
    End Sub

    Protected Sub btnEdit_Click(ByVal sender As Button, ByVal e As EventArgs)
        Response.Redirect("/Admin/Videos/Add.aspx?Id=" & sender.CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Button, ByVal e As EventArgs)
        Dim cmdUpdate As New SqlCommand("Update RCVideo set Seq=Seq-1 where CatId=(Select Id from RCVideoCat where Id=@Id) and Seq > (select Seq from RCVideo where Id=@Id)", con)
        Dim cmdDelete As New SqlCommand("Delete From RCVideo Where Id=@Id", con)
        cmdUpdate.Parameters.AddWithValue("Id", sender.CommandArgument)
        cmdDelete.Parameters.AddWithValue("Id", sender.CommandArgument)
        con.Open()
        cmdUpdate.ExecuteNonQuery()
        cmdDelete.ExecuteNonQuery()
        con.Close()
        LoadCats()
        LoadItems()
    End Sub

    Protected Sub btnUp_Click(ByVal sender As Button, ByVal e As EventArgs)
        'Get Current Category
        con.Open()
        Dim cmdCurCat As New SqlCommand("Select CatId from RCVideo where Id=@Id", con)
        cmdCurCat.Parameters.AddWithValue("Id", sender.CommandArgument)
        Dim CatName As String = cmdCurCat.ExecuteScalar

        'Command for Current Sequence #
        Dim cmdCurSeq As New SqlCommand("Select Seq from RCVideo where Id=@Id", con)

        'Command for Max Sequence #
        Dim cmdMaxSeq As New SqlCommand("Select Max(Seq) from RCVideo where CatId=@CatId", con)

        'Add Params to SQLCommands
        cmdCurSeq.Parameters.AddWithValue("Id", sender.CommandArgument)
        cmdMaxSeq.Parameters.AddWithValue("CatId", CatName)

        'Execute them and store values in some variables
        Dim Seq As Integer = cmdCurSeq.ExecuteScalar
        Dim MaxSeq As Integer = cmdMaxSeq.ExecuteScalar

        If Seq <> 1 Then
            Dim cmd As New SqlCommand("Update RCVideo set Seq=" & Seq - 1 & " where Id=@Id Update RCVideo set Seq=" & Seq & " where CatId=@CatId and Seq=" & Seq - 1 & " and Id<>@Id", con)
            cmd.Parameters.AddWithValue("Id", sender.CommandArgument)
            cmd.Parameters.AddWithValue("CatId", CatName)
            cmd.ExecuteNonQuery()
        End If
        con.Close()
        LoadItems()
        'Response.Redirect("/Admin/Gallery/")
    End Sub

    Protected Sub btnDown_Click(ByVal sender As Button, ByVal e As EventArgs)
        'Get Current Category
        con.Open()
        Dim cmdCurCat As New SqlCommand("Select CatName from RCVideo where Id=@Id", con)
        cmdCurCat.Parameters.AddWithValue("Id", sender.CommandArgument)
        Dim CatName As String = cmdCurCat.ExecuteScalar

        'Command for Current Sequence #
        Dim cmdCurSeq As New SqlCommand("Select Seq from RCVideo where Id=@Id", con)

        'Command for Max Sequence #
        Dim cmdMaxSeq As New SqlCommand("Select Max(Seq) from RCVideo where CatId=@CatId", con)

        'Add Params to SQLCommands
        cmdCurSeq.Parameters.AddWithValue("Id", sender.CommandArgument)
        cmdMaxSeq.Parameters.AddWithValue("CatId", CatName)

        'Execute them and store values in some variables
        Dim Seq As Integer = cmdCurSeq.ExecuteScalar
        Dim MaxSeq As Integer = cmdMaxSeq.ExecuteScalar

        If Seq < MaxSeq Then
            Dim cmd As New SqlCommand("Update RCVideo set Seq=" & Seq + 1 & " where Id=@Id and Seq<@MaxSeq Update RCVideo set Seq=" & Seq & " where Seq=" & Seq + 1 & " and Id<>@Id", con)
            cmd.Parameters.AddWithValue("Id", sender.CommandArgument)
            cmd.Parameters.AddWithValue("MaxSeq", MaxSeq)
            cmd.ExecuteNonQuery()
        End If
        con.Close()
        LoadItems()
        'Response.Redirect("/Admin/Gallery/")
    End Sub
End Class
