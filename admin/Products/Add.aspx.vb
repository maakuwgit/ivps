Imports System.Data
Imports System.Data.SqlClient

Partial Class AddProduct
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            lblSnippet.Visible = False
            
            Dim LinksTable As DataTable = RC4.Pull("Select * from RCProductCat Order By Name Asc")
            dropDownPages.DataTextField = "Name"
        	dropDownPages.DataValueField = "Id"
        	
        	
        	
        	dropDownPages.DataSource = LinksTable
        	dropDownPages.DataBind()
        	
        	Dim item = new ListItem("Select a Category", "", true)
        	dropDownPages.Items.Insert(0,item)
        	
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    Id.Value = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from RCProduct Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        txtName.Text = dt.Rows(0).Item("Name")
                        txtContent.Value = dt.Rows(0).Item("Description")
                        lblSnippet.Text = ""
                        lblSnippet.Visible = True
                        dropDownPages.SelectedValue = dt.Rows(0).Item("catid").ToString
                          If Not IsDBNull(dt.Rows(0).Item("Featured")) Then cbFeatured.Checked = dt.Rows(0).Item("Featured")
                        If dt.Rows(0).Item("price").ToString.length > 0 Then
                        		price.text = dt.Rows(0).Item("price")
                        	End If
                        If dt.Rows(0).Item("catid").ToString.length > 0 Then
                        		productimg.ImageUrl = "/productImage.ashx?id=" & Request("Id")
                        else
                        		productimg.CssClass = "d-none"
                        End If
                    End If
                End If
          Else
          	productimg.CssClass = "d-none"
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
		Save()
        	Response.Redirect("/Admin/Products/")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Products/")
    End Sub
 
    
     Protected Sub btnSaveContinueEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveContinueEdit.Click
		Dim Cid = Save()
		 Response.Redirect("/Admin/Products/Add.aspx?id=" & Cid)
    End Sub
    
    Protected Function Save()
    		Dim mssql = New MSSQLBuilder("RCProduct")
		If Not Request("Id") Is Nothing Then
			mssql.SetValueFor("Id", Request("Id"))
		End If
		mssql.SetValueFor("name", txtName.Text)
		mssql.SetValueFor("seq", 1)
		mssql.SetValueFor("description",  txtContent.Value)
		mssql.SetValueFor("catid", dropDownPages.SelectedValue)
		mssql.SetValueFor("featured",  cbFeatured.Checked)
		mssql.SetValueFor("slug",  CreateSlug(txtName.Text, false))
		If price.text.length > 0 Then
			mssql.SetValueFor("price",  price.text)
		Else
			mssql.SetValueFor("price",  0)
		End If
		If fileUploadImage.HasFile = True Then
			Dim bytes = ImageUtility.ResizePostedFileToBytes(fileUploadImage.PostedFile)
			mssql.SetValueFor("data",  bytes)
			mssql.SetValueFor("datatype",  ImageUtility.PostedFileMimeType(fileUploadImage.PostedFile))
		End If
		Dim Cid = mssql.save()
		return Cid
    End Function
    
    
End Class
