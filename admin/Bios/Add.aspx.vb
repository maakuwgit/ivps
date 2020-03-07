Imports System.Data
Imports System.Data.SqlClient

Imports System.Drawing


Partial Class admin_Bios_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            If Not Request("Id") Is Nothing Then
                Id.Value = Request("Id")
                Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
                Dim ad As New SqlDataAdapter("Select * from RCBio where Id=@Id", con)
                Dim dt As New DataTable
                ad.SelectCommand.Parameters.AddWithValue("Id", Id.Value)
                con.Open()
                ad.Fill(dt)
                con.Close()
                If dt.Rows.Count > 0 Then
                    txtName.Text = dt.Rows(0).Item("Name").ToString()
                    txtTitle.Text = dt.Rows(0).Item("Title").ToString()
                    txtDesc.Text = dt.Rows(0).Item("Description").ToString()
                    img.Src = dt.Rows(0).Item("FSLoc")
                    txtSlug.Text = dt.Rows(0).Item("Slug").ToString()
                End If
            Else
                fileUpload.Attributes.Add("required", "required")
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        If Not Id.Value = "" Then
            Dim cmd As New SqlCommand("Update RCBio set [Name]=@Name, [Title]=@Title, [Description]=@Description, [FSLoc]=@FSLoc, Slug=@Slug where Id=@Id", con)
            cmd.Parameters.AddWithValue("Name", txtName.Text)
            cmd.Parameters.AddWithValue("Title", txtTitle.Text)
            cmd.Parameters.AddWithValue("Description", txtDesc.Text)
            cmd.Parameters.AddWithValue("Id", Id.Value)
            	If txtSlug.Text.Trim.length > 0 Then
            		cmd.Parameters.AddWithValue("Slug", txtSlug.Text)
          	Else
          		cmd.Parameters.AddWithValue("Slug", CreateSlug(txtName.Text, false))
          	End If
            If fileUpload.PostedFile.ContentLength = 0 Then
                cmd.Parameters.AddWithValue("FSLoc", img.Src)
            Else
                Dim fi2 As New IO.FileInfo(fileUpload.PostedFile.FileName)
                If LCase(fi2.Extension) = ".jpg" Or LCase(fi2.Extension) = ".png" Or LCase(fi2.Extension) = ".gif" Then
                    Dim loc As String = HttpContext.Current.Server.MapPath("~/images/Bios/")
                    fileUpload.PostedFile.SaveAs(loc & Id.Value & LCase(fi2.Extension))
                    MakeThumb(loc & Id.Value & LCase(fi2.Extension))
                    cmd.Parameters.AddWithValue("FSLoc", "/images/Bios/" & Id.Value & LCase(fi2.Extension))
                End If
            End If
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
            Response.Redirect("/Admin/Bios/")
        Else
            If Not fileUpload.PostedFile.ContentLength = 0 Then
                Dim cmd As New SqlCommand("Insert Into RCBio (Name, Title, Description, Slug) Values(@Name, @Title, @Description, @Slug) SELECT SCOPE_IDENTITY()", con)
                cmd.Parameters.AddWithValue("Name", txtName.Text)
                cmd.Parameters.AddWithValue("Title", txtTitle.Text)
                cmd.Parameters.AddWithValue("Description", txtDesc.Text)
                If txtSlug.Text.Trim.length > 0 Then
            		cmd.Parameters.AddWithValue("Slug", txtSlug.Text)
          	Else
          		cmd.Parameters.AddWithValue("Slug", CreateSlug(txtName.Text, false))
          	End If
                con.Open()
                Dim GalleryItemId As Integer = cmd.ExecuteScalar
                Dim fi As New IO.FileInfo(fileUpload.PostedFile.FileName)
                If LCase(fi.Extension) = ".jpg" Or LCase(fi.Extension) = ".png" Or LCase(fi.Extension) = ".gif" Then
                    Dim loc As String = HttpContext.Current.Server.MapPath("~/images/Bios/")
                    fileUpload.PostedFile.SaveAs(loc & GalleryItemId & LCase(fi.Extension))
                    MakeThumb(loc & GalleryItemId & LCase(fi.Extension))
                    Dim cmd2 As New SqlCommand("Update RCBio set Seq=coalesce((select max(seq) from RCBio) + 1, 1), FSLoc='/images/Bios/" & GalleryItemId & LCase(fi.Extension) & "' where Id=" & GalleryItemId, con)
                    cmd2.Parameters.AddWithValue("Title", txtTitle.Text)
                    cmd2.ExecuteNonQuery()
                End If
                con.Close()
                Response.Redirect("/Admin/Bios/")
            End If
        End If
    End Sub

    Public Sub MakeThumb(ByVal ImgLoc As String)
        Dim myCallback As New System.Drawing.Image.GetThumbnailImageAbort(AddressOf ThumbnailCallback)
        Dim myBitmap As New System.Drawing.Bitmap(ImgLoc)
        Dim myThumbnail As System.Drawing.Image = myBitmap.GetThumbnailImage(195, 150, myCallback, IntPtr.Zero)
        Dim f As New IO.FileInfo(ImgLoc)
        Dim thumbName As String = f.Directory.FullName & "\thumb-" & f.Name
        myThumbnail.Save(thumbName)
    End Sub

    Public Function ThumbnailCallback() As Boolean
        Return False
    End Function
End Class
