Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web

Partial Class admin_Content_Add
    Inherits System.Web.UI.Page
    
    Dim ImageFolderPath = "/images"
    Dim ImgFolder = Server.MapPath(ImageFolderPath)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            lblSnippet.Visible = False
            lblSnippet2.Visible = False
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    Id.Value = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from WMAImages Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        txtName.Text = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Name").ToString()), "", dt.Rows(0).Item("Name"))
                        txtProperties.Value = iif(dt.Rows(0).Item("Properties").ToString().Length > 0, dt.Rows(0).Item("Properties"), "{""alt"":"""",""title"":"""",""target"":"""",""rel"":"""",""class"":"""",""style"":""""}")
                        'txtFilename.Text = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Filename").ToString()), "", dt.Rows(0).Item("Filename"))
                        txtSrc.Text = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Src").ToString()), "", dt.Rows(0).Item("Src"))
                        displayImageLink.NavigateUrl = txtSrc.Text
                        displayImage.ImageUrl = dt.Rows(0).Item("Src")
                        lblSnippet.Text = "<strong>ASP.Net Code Snippet:</strong> <%=createImage(""" & dt.Rows(0).Item("id") & """)%>"
                        lblSnippet.Visible = True
                        lblSnippet2.Text = "<strong>or HTML:</strong> <xmp><img src=""" & dt.Rows(0).Item("Src") & """></xmp>"
                        lblSnippet2.Visible = True
                    Else
                    	txtProperties.Value = "{""alt"":"""",""title"":"""",""target"":"""",""rel"":"""",""class"":"""",""style"":""""}"
                    	displayImage.ImageUrl = ""
                    	displayImageLink.NavigateUrl = ""
                    End If
                End If
            Else
            	txtProperties.Value = "{""alt"":"""",""title"":"""",""target"":"""",""rel"":"""",""class"":"""",""style"":""""}"
            	displayImage.ImageUrl = ""
            	displayImageLink.NavigateUrl = ""
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If String.IsNullOrEmpty(Id.Value) Then
            cmd = New SqlCommand("Insert Into WMAImages ([Name], [Filename], [Src], [Properties]) Values (@Name, @Filename, @Src, @Properties)", con)
        Else
            cmd = New SqlCommand("Update WMAImages set [Name]=@Name, [Filename]=@Filename, [Src]=@Src, [Properties]=@Properties where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", CInt(Id.Value))
        End If
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        
        If (fileUploadImage.HasFile = true)
        	cmd.Parameters.AddWithValue("Filename", fileUploadImage.PostedFile.FileName)
        	cmd.Parameters.AddWithValue("Src", ImageFolderPath & "/" & fileUploadImage.PostedFile.FileName)
        Else
        	cmd.Parameters.AddWithValue("Filename", "")
        	cmd.Parameters.AddWithValue("Src", txtSrc.Text)
        End If
        cmd.Parameters.AddWithValue("Properties", txtProperties.Value)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        
        If (fileUploadImage.HasFile = true)
        	UploadImage()
        End If
        
        Response.Redirect("/Admin/Image/")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Image/")
    End Sub
    
    Protected Sub UploadImage()
    	If (Not fileUploadImage.PostedFile Is Nothing)
			Dim strFileName as string
			Dim strFilePath as string
			Dim strFolder as string

			'strFolder = Server.MapPath("/images")

			'Get the name of the file that is posted.
			strFileName = fileUploadImage.PostedFile.FileName
			strFileName = Path.GetFileName(strFileName)

			'Create the directory if it does not exist.
			If (not Directory.Exists(ImgFolder)) then
			   Directory.CreateDirectory(ImgFolder)
			End If

			'Save the uploaded file to the server.
			strFilePath = ImgFolder & "\" & strFileName

			If File.Exists(strFilePath) then
			   fileUploadImage.PostedFile.SaveAs(strFilePath)
			Else
			   fileUploadImage.PostedFile.SaveAs(strFilePath)
			End If
		End If
    End Sub
End Class
