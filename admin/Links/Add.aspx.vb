Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Links_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
        
        	Dim LinkCategoryTable As DataTable = RC4.Pull("Select * from RCLinkCat")
            dropDownCategories.DataTextField = "Name"
        	dropDownCategories.DataValueField = "Id"
        	
        	dropDownCategories.DataSource = LinkCategoryTable
        	dropDownCategories.DataBind()
        	
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    ID.Value = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from RCLink Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        txtName.Text = dt.Rows(0).Item("Name")
                        txtLink.Text = dt.Rows(0).Item("Link")
                        txtDesc.Text = dt.Rows(0).Item("Description")
                        LinkImage.ImageUrl = "/LinkImg.ashx?id=" & CInt(Request("Id")) & "&h=200"
                        dropDownCategories.SelectedValue = dt.Rows(0).Item("CatId")
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If String.IsNullOrEmpty(ID.Value) Then
            cmd = New SqlCommand("Insert Into RCLink ([Name], [Link], [Description], [CatId] " & IIf(filePicture.HasFile, ", [Image]", "") & ") Values (@Name, @Link, @Description, @CatId" & IIf(filePicture.HasFile, ", @Img", "") & "); select scope_identity()", con)
        Else
            cmd = New SqlCommand("Update RCLink set [Name]=@Name, [Link]=@Link, [Description]=@Description, [CatId]=@CatId" & IIf(filePicture.HasFile, ", Image=@Img", "") & " where Id=@Id select scope_identity()", con)
            cmd.Parameters.AddWithValue("Id", CInt(ID.Value))
        End If
        cmd.Parameters.AddWithValue("CatId", dropDownCategories.SelectedValue)
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Link", txtLink.Text)
        cmd.Parameters.AddWithValue("Description", txtDesc.Text)
        If filePicture.HasFile Then
            cmd.Parameters.AddWithValue("Img", filePicture.FileBytes)
        End If
        con.Open()
        If String.IsNullOrEmpty(ID.Value) Then
        		Id.Value = cmd.ExecuteScalar()
        	Else
        		cmd.ExecuteScalar()
        	End If
        con.Close()
        Response.Redirect("/Admin/Links/")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Links/")
    End Sub
End Class
