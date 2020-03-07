Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Gallery2_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Dim dt As DataTable = RC4.Pull("Select Id, Name from RCGalleryCat order by Seq asc")
            dlCat.DataSource = dt
            dlCat.DataTextField = "Name"
            dlCat.DataValueField = "Id"
            dlCat.DataBind()
            LoadRepeater()
        End If
    End Sub

    Protected Sub btnEdit_Click(sender As Object, e As EventArgs)
        Dim id As Integer = CType(sender, Button).CommandArgument
        Response.Redirect("GalleryDetail.aspx?Id=" & id)
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs)
        Dim id As Integer = CType(sender, Button).CommandArgument
        SQLExec("Delete from RCGallery where Id=" & id)
        SQLExec("Delete from RCGalleryImage where GalleryId=" & id)
        LoadRepeater()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmd As New SqlCommand("Insert into RCGallery (Name, Description, CatId) VALUES (@Name, @Desc, @CatId) Select scope_identity()", con)
        cmd.Parameters.AddWithValue("CatId", dlCat.SelectedValue)
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Desc", txtDesc.Text)
        con.Open()
        Dim id As Integer = cmd.ExecuteScalar
        con.Close()
        LoadRepeater()
    End Sub

    Protected Sub LoadRepeater()
        Dim dt As DataTable = RC4.Pull("Select Id, Name from RCGalleryCat order by Seq asc")
        myRepeater.DataSource = dt
        myRepeater.DataBind()
        'gvDocs.DataSource = dt
        'gvDocs.DataBind()
    End Sub

    Sub getNestedData(ByVal Sender As Object, ByVal e As RepeaterItemEventArgs)
        Dim dt As DataTable = RC4.Pull("Select * from RCGallery where CatId=" & e.Item.DataItem("Id") & " Order by Seq asc")
        Dim gv As GridView = e.Item.FindControl("gvDocs")
        gv.DataSource = dt
        gv.DataBind()
    End Sub

End Class
