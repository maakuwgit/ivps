Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Bios_Default
    Inherits System.Web.UI.Page

    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadItems()
        End If
    End Sub

    Sub LoadItems()
        Dim AD As New SqlDataAdapter("Select * from RCBio order by seq asc", con)
        Dim DT As New DataTable
        con.Open()
        AD.Fill(DT)
        con.Close()
        gvBio.DataSource = DT
        gvBio.DataBind()
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
            Response.Redirect("Add.aspx")
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Button, ByVal e As EventArgs)
        Dim cmdUpdate As New SqlCommand("Update RCBio set Seq=Seq-1 where Seq > (select Seq from RCBio where Id=@Id)", con)
        Dim cmdDelete As New SqlCommand("Delete From RCBio Where Id=@Id", con)
        cmdUpdate.Parameters.AddWithValue("Id", sender.CommandArgument)
        cmdDelete.Parameters.AddWithValue("Id", sender.CommandArgument)
        con.Open()
        cmdUpdate.ExecuteNonQuery()
        cmdDelete.ExecuteNonQuery()
        con.Close()
        LoadItems()
    End Sub

    Protected Sub btnEdit_Click(ByVal sender As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & sender.CommandArgument)
    End Sub

    Protected Sub btnUp_Click(ByVal sender As Button, ByVal e As EventArgs)
        'Command for Current Sequence #
        Dim cmdCurSeq As New SqlCommand("Select Seq from RCBio where Id=@Id", con)

        'Command for Max Sequence #
        Dim cmdMaxSeq As New SqlCommand("Select Max(Seq) from RCBio", con)

        'Add Params to SQLCommands
        cmdCurSeq.Parameters.AddWithValue("Id", sender.CommandArgument)

        'Execute them and store values in some variables
        con.Open()
        Dim Seq As Integer = cmdCurSeq.ExecuteScalar
        Dim MaxSeq As Integer = cmdMaxSeq.ExecuteScalar

        If Seq <> 1 Then
            Dim cmd As New SqlCommand("Update RCBio set Seq=" & Seq - 1 & " where Id=@Id Update RCBio set Seq=" & Seq & " where Seq=" & Seq - 1 & " and Id<>@Id", con)
            cmd.Parameters.AddWithValue("Id", sender.CommandArgument)
            cmd.ExecuteNonQuery()
        End If
        con.Close()
        LoadItems()
    End Sub

    Protected Sub btnDown_Click(ByVal sender As Button, ByVal e As EventArgs)
        'Command for Current Sequence #
        Dim cmdCurSeq As New SqlCommand("Select Seq from RCBio where Id=@Id", con)

        'Command for Max Sequence #
        Dim cmdMaxSeq As New SqlCommand("Select Max(Seq) from RCBio", con)

        'Add Params to SQLCommands
        cmdCurSeq.Parameters.AddWithValue("Id", sender.CommandArgument)

        'Execute them and store values in some variables
        con.Open()
        Dim Seq As Integer = cmdCurSeq.ExecuteScalar
        Dim MaxSeq As Integer = cmdMaxSeq.ExecuteScalar

        If Seq < MaxSeq Then
            Dim cmd As New SqlCommand("Update RCBio set Seq=" & Seq + 1 & " where Id=@Id Update RCBio set Seq=" & Seq & " where Seq=" & Seq + 1 & " and Id<>@Id", con)
            cmd.Parameters.AddWithValue("Id", sender.CommandArgument)
            cmd.ExecuteNonQuery()
        End If
        con.Close()
        LoadItems()
    End Sub
End Class
