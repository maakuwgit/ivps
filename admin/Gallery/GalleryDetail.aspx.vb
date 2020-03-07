Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Drawing.Drawing2D

Partial Class admin_Gallery_GalleryDetail
    Inherits System.Web.UI.Page

    Dim id As Integer

    'Dim dlgScript As String = _
    '"$(document).ready(function () { " & _
    '    "var dlg = $(""#EditImage"").dialog({ title: 'Add / Edit Image', autoOpen: false, modal: true, width: 520 });" & _
    '    "dlg.parent().appendTo($(""form""));" & _
    '"});"


    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        id = Request("Id")
        GalleryId.Value = id
        Dim dt As DataTable = RC4.Pull("Select Id, Name from RCGalleryCat order by Seq asc")
        dlCat.DataSource = dt
        dlCat.DataTextField = "Name"
        dlCat.DataValueField = "Id"
        dlCat.DataBind()
        LoadGallery()
    End Sub

    Protected Sub LoadGallery()
        pnlPix.Controls.Clear()
        Dim dt As DataTable = RC4.Pull("Select * from RCGallery where Id=" & id)
        Dim dtPix As DataTable = RC4.Pull("Select Id, Name, Description, ContentType, Seq from RCGalleryImage where isDeleted='N' and GalleryId=" & id & " order by Seq asc")
        If dt.Rows.Count > 0 Then
            If Not IsDBNull(dt.Rows(0).Item("CatId")) Then
                dlCat.SelectedValue = dt.Rows(0).Item("CatId")
            End If
            If Not IsDBNull(dt.Rows(0).Item("Name")) Then
                lblName.Text = dt.Rows(0).Item("Name")
                txtGName.Text = dt.Rows(0).Item("Name")
            End If
            If Not IsDBNull(dt.Rows(0).Item("Description")) Then
                txtGDesc.Text = dt.Rows(0).Item("Description")
            End If
            chkShow.Checked = dt.Rows(0).Item("flagShowThumb") = 0

            For Each dr As DataRow In dtPix.Rows
                Dim pnlPic As New Panel
                Dim lblName As New Label
                Dim lblDesc As New Label
                Dim dvPic As New HtmlGenericControl("div")
                Dim Id As New HiddenField
                Dim Seq As New HiddenField
                Dim btnEdit As New Button
                Dim btnDel As New Button

                '=============================================================================================================='
                'pnlPic
                '=============================================================================================================='
                pnlPic.CssClass = "pnlPic"

                '=============================================================================================================='
                'btnEdit
                '=============================================================================================================='
                btnEdit.ID = "btnEdit" & dr.Item("Id")
                btnEdit.Text = "Edit"
                btnEdit.CommandArgument = dr.Item("Id")
                Seq.Value = dr.Item("Seq")
                Id.Value = dr.Item("Id")

                Dim tEdit As New AsyncPostBackTrigger
                tEdit.ControlID = btnEdit.UniqueID
                tEdit.EventName = "Click"
                asyncEditImage.Triggers.Add(tEdit)
                AddHandler btnEdit.Click, AddressOf btnEditImage_Click


                '=============================================================================================================='
                'btnDel
                '=============================================================================================================='
                btnDel.ID = "btnDel" & dr.Item("Id")
                btnDel.Text = "Delete"
                btnDel.CommandArgument = dr.Item("Id")
                btnDel.OnClientClick = "return confirm('Are you sure you want to delete this picture: " & dr.Item("Name") & "?')"

                AddHandler btnDel.Click, AddressOf btnDelete_Click
                'AddHandler Seq.TextChanged, AddressOf SeqUpdate

                '=============================================================================================================='
                'dvPic
                '=============================================================================================================='
                dvPic.Style.Add("background-image", "url('GetThumb.ashx?Id=" & dr.Item("Id") & "&s=thumb')")
                dvPic.Style.Add("width", ConfigStrings.GetValByName("thumb") & "px")
                dvPic.Style.Add("height", ConfigStrings.GetValByName("thumb") * 0.75 & "px")
                dvPic.Attributes.Add("class", "imgdiv")

                dvPic.Controls.Add(btnEdit)
                dvPic.Controls.Add(btnDel)

                '=============================================================================================================='
                'lblName
                '=============================================================================================================='
                If Not String.IsNullOrEmpty(dr.Item("Name")) Then
                    lblName.Text = dr.Item("Name")
                End If

                pnlPic.Controls.Add(Seq)
                pnlPic.Controls.Add(Id)
                pnlPic.Controls.Add(dvPic)
                pnlPic.Controls.Add(lblName)
                pnlPic.Controls.Add(lblDesc)
                If dr("Seq") = -1 Then
                    defImage.Controls.Add(pnlPic)
                Else
                    pnlPix.Controls.Add(pnlPic)
                End If

            Next
        End If
    End Sub

    Protected Sub btnAddImage_Click(sender As Object, e As System.EventArgs) Handles btnAddImage.Click
        txtName.Text = ""
        txtDesc.Text = ""
        txtAlt.Text = ""
        upload.Visible = true
        btnSave.CommandArgument = ""
        ScriptManager.RegisterStartupScript(asyncEditImage, asyncEditImage.GetType(), "AddImage", "$('#EditImage').dialog('open');", True)
    End Sub

    Protected Sub btnEditImage_Click(sender As Object, e As System.EventArgs)
        Dim dt As DataTable = RC4.Pull("Select Id, [Name], [Description], [Alt] from RCGalleryImage where Id=" & CInt(sender.CommandArgument))
        If dt.Rows.Count > 0 Then
            upload.Visible = False
            btnSave.CommandArgument = sender.CommandArgument
            If Not IsDBNull(dt.Rows(0).Item("Name")) Then txtName.Text = dt.Rows(0).Item("Name")
            If Not IsDBNull(dt.Rows(0).Item("Description")) Then txtDesc.Text = dt.Rows(0).Item("Description")
            If Not IsDBNull(dt.Rows(0).Item("Alt")) Then txtAlt.Text = dt.Rows(0).Item("Alt")
            ScriptManager.RegisterStartupScript(asyncEditImage, asyncEditImage.GetType(), "EditImage", "$('#EditImage').dialog('open');", True)
        End If
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = sender
        'RC4.SQLExec("Update RCGalleryImage set isDeleted='Y', DateDeleted=GetDate() where Id=" & CInt(btn.CommandArgument))
        RC4.SQLExec("Delete from RCGalleryImage where Id=" & CInt(btn.CommandArgument))
        pnlPix.Controls.Remove(btn.Parent.Parent)
        Response.Redirect("GalleryDetail.aspx?Id=" & GalleryId.Value)
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
        ScriptManager.RegisterStartupScript(asyncEditImage, asyncEditImage.GetType(), "CloseDlg", "$('#EditImage').dialog('close');", True)
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        If btnSave.CommandArgument <> "" Then
            Dim cmd As New SqlCommand("Update RCGalleryImage Set Name=@Name, Description=@Description, Alt=@Alt where Id=@Id", con)
            con.Open()
            cmd.Parameters.AddWithValue("Id", CInt(btnSave.CommandArgument))
            cmd.Parameters.AddWithValue("Name", txtName.Text)
            cmd.Parameters.AddWithValue("Description", txtDesc.Text)
            cmd.Parameters.AddWithValue("Alt", txtAlt.Text)
            cmd.ExecuteNonQuery()
            con.Close()
        Else
       
            For x As Integer = 0 To Request.Files.Count - 1

                Dim f As HttpPostedFile = Request.Files(x)
                
                If f.ContentLength > 0 Then
                    Dim ContentType As String = ""
                    If LCase(f.FileName).EndsWith(".jpg") Or LCase(f.FileName).EndsWith(".jpeg") Then
                        ContentType = "image/jpeg"
                    ElseIf LCase(f.FileName).EndsWith(".png") Then
                        ContentType = "image/png"
                    ElseIf LCase(f.FileName).EndsWith(".gif") Then
                        ContentType = "image/gif"
                    Else
                        Exit Sub
                    End If

                    Dim Name As String = ""

                    If String.IsNullOrEmpty(txtName.Text) Then
                        If f.FileName.Length > 4 Then
                            Name = f.FileName.Substring(0, f.FileName.Length - 4)
                        End If
                    Else
                        Name = txtName.Text
                    End If


                    con.Open()
                    Dim cmdSeq As New SqlCommand("Select (coalesce(max(Seq), -1) + 1) from RCGalleryImage where GalleryId = " & CInt(GalleryId.Value), con)
                    Dim Seq As Integer = cmdSeq.ExecuteScalar()
                    Dim cmd As New SqlCommand("Insert into RCGalleryImage (Name, Description, Alt, Data, ContentType, GalleryId, Seq) VALUES (@Name, @Description, @Alt, @Data, @ContentType, @GalleryId, @Seq)", con)
                    cmd.Parameters.AddWithValue("Name", Name)
                    cmd.Parameters.AddWithValue("Description", txtDesc.Text)
                    cmd.Parameters.AddWithValue("Alt", txtAlt.Text)

                    ' Restrict the size of the image
                    Dim image_file As System.Drawing.Image = System.Drawing.Image.FromStream(f.InputStream)
					Dim image_height As Integer = image_file.Height
					Dim image_width As Integer = image_file.Width
					Dim max_height As Integer = 800
					Dim max_width As Integer = 1200

					image_height = (image_height * max_width) / image_width
					image_width = max_width

					If image_height > max_height Then
						image_width = (image_width * max_height) / image_height
						image_height = max_height
					End If

					Dim bitmap_file As New Bitmap(image_file, image_width, image_height)
					Dim stream As New System.IO.MemoryStream

					bitmap_file.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg)
					stream.Position = 0

					Dim data(stream.Length) As Byte
					stream.Read(data, 0, stream.Length)
                
                    cmd.Parameters.AddWithValue("Data", data)
                    cmd.Parameters.AddWithValue("ContentType", ContentType)
                    cmd.Parameters.AddWithValue("GalleryId", GalleryId.Value)
                    cmd.Parameters.AddWithValue("Seq", Seq)
                    cmd.ExecuteScalar()
                    con.Close()


		 response.write("GalleryId.Value" & GalleryId.Value)
		 
                End If
            Next
        End If
        Response.Redirect("GalleryDetail.aspx?Id=" & id)
    End Sub

    Protected Sub btnSaveGalleryName_Click(sender As Object, e As System.EventArgs) Handles btnSaveGalleryName.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmd As New SqlCommand("Update RCGallery set Name=@Name, Description=@Desc, CatId=@CatId where Id=@Id", con)
        cmd.Parameters.AddWithValue("Name", txtGName.Text)
        cmd.Parameters.AddWithValue("Desc", txtGDesc.Text)
        cmd.Parameters.AddWithValue("CatId", dlCat.SelectedValue)
        cmd.Parameters.AddWithValue("Id", GalleryId.Value)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("GalleryDetail.aspx?Id=" & GalleryId.Value)
    End Sub

    Protected Sub chkShow_CheckedChanged(sender As Object, e As System.EventArgs) Handles chkShow.CheckedChanged
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        Dim cmd As New SqlCommand("Update RCGallery set flagShowThumb=@Thumb where Id=@Id", con)
        cmd.Parameters.AddWithValue("Id", GalleryId.Value)
        cmd.Parameters.AddWithValue("Thumb", IIf(chkShow.Checked, 1, 0))
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
    End Sub
End Class
