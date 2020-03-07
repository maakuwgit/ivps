Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_News_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
        
        	Dim NewsCategoryTable As DataTable = RC4.Pull("Select * from RCNewsCat")
            Categories.DataTextField = "Name"
        	Categories.DataValueField = "Id"
        	
            If Request("Id") Is Nothing Then
                newsTitle.InnerHtml = "New Story"
            Else
                NewsId.Value = Request("Id")
                Dim dt As DataTable = RC4.Pull("Select * from RCNews where Id=" & CInt(Request("Id")))
                If dt.Rows.Count > 0 Then
                    Dim dr As DataRow = dt.Rows(0)
                    newsTitle.InnerHtml = "Editing News Story :: " & dr("Title")
                    txtTitle.Text = dr("title")
                    txtDescription.Text = dr("description")
                    txtPubDate.Text = CDate(dr("pubdate")).ToShortDateString
                    txtContents.Text = dr("contents")
                    Slug.Text = dr("slug").ToString()
                    Categories.SelectedValue = dr("CatId").ToString
                    NewsStoryImage.ImageUrl = "/NewsImg.ashx?id=" & dr("Id") & "&h=200"
                     If Not IsDBNull(dr("Featured")) Then cbFeatured.Checked = dr("Featured")
                     If Not IsDBNull(dr("Cornerstone")) Then cbCornerstone.Checked = dr("Cornerstone")
                End If
            End If
            
            Categories.DataSource = NewsCategoryTable
        	Categories.DataBind()
            
        End If
    End Sub

	Protected Sub btnSaveClose_Click(sender As Object, e As EventArgs) Handles btnSaveClose.Click
		Save()
		Response.Redirect("/admin/news/")
	End Sub
	
    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
    	Dim Id = Save()
    	Response.Redirect("/admin/news/Add.aspx?Id=" & Id)
    End Sub
    
    Function Save()
    	    	' Have to redo form for this to work.
    	'Dim SqlBuilder = new MSSQLBuilder("RCNews")
    	'SqlBuilder.ParseHttpRequest(Request.form)
    	'SqlBuilder.Save()
    	
        Dim c As SqlConnection = getCon()
        Dim cmd As SqlCommand
        Dim Id = NewsId.Value
        If IsNumeric(NewsId.Value) Then
            cmd = New SqlCommand("Update RCNews set Title=@Title, Description=@Description, Contents=@Contents, PubDate=@PubDate, CatId=@CatId, Featured=@Featured, Cornerstone=@Cornerstone, Slug=@Slug " & IIf(filePicture.HasFile, ", Img=@Img", "") & " where Id=@Id", c)
            cmd.Parameters.AddWithValue("Id", NewsId.Value)
        Else
            cmd = New SqlCommand("Insert into RCNews (Title, Description, Contents, PubDate, CatId, Slug, Featured, Cornerstone " & IIf(filePicture.HasFile, ", Img", "") & ") values (@Title, @Description, @Contents, @PubDate, @CatId, @Slug, @Featured, @Cornerstone " & IIf(filePicture.HasFile, ", @Img", "") & "); SELECT SCOPE_IDENTITY()", c)
        End If
        cmd.Parameters.AddWithValue("Title", txtTitle.Text)
        cmd.Parameters.AddWithValue("Description", txtDescription.Text)
        cmd.Parameters.AddWithValue("Contents", txtContents.Text)
        cmd.Parameters.AddWithValue("CatId", Categories.SelectedValue)
        cmd.Parameters.AddWithValue("Featured", cbFeatured.Checked)
        cmd.Parameters.AddWithValue("Cornerstone", cbCornerstone.Checked)
        If Slug.Text.length = 0 Then
        		cmd.Parameters.AddWithValue("Slug", CreateSlug(txtTitle.Text))
        Else
        		cmd.Parameters.AddWithValue("Slug", Slug.Text)
        End If
        If IsDate(txtPubDate.Text) Then
            cmd.Parameters.AddWithValue("PubDate", txtPubDate.Text)
        Else
            cmd.Parameters.AddWithValue("PubDate", Today.Date)
        End If
        If filePicture.HasFile Then
            cmd.Parameters.AddWithValue("Img", filePicture.FileBytes)
        End If
        
        If cbFeatured.Checked Then
        	Dim cmd2 As SqlCommand
        	cmd2 = New SqlCommand("Update RCNews Set Featured=0", c)
        	c.Open()
        	cmd2.ExecuteScalar
        	c.Close()
        End If
        
        c.Open()
        
         If IsNumeric(Id) Then
         		cmd.ExecuteScalar()
         Else
        		Id = cmd.ExecuteScalar()
        End If
        	
        c.Close()
        
        return Id
        
    End Function

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("/admin/news/")
    End Sub
	
End Class
