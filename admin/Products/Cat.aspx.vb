Imports System.Data
Imports System.Data.SqlClient

Partial Class Cat
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            lblSnippet.Visible = False
            
            Dim LinksTable As DataTable = RC4.Pull("Select * from RCProductCat Order By name")
            parentid.DataTextField = "Name"
        	parentid.DataValueField = "Id"
        	
        	
        	
        	parentid.DataSource = LinksTable
        	parentid.DataBind()
        	
        	Dim item = new ListItem("Select a Category - Optional", "", true)
        	parentid.Items.Insert(0,item)
        	
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    Id.Value = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from RCProductCat Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        name.Text = dt.Rows(0).Item("Name")
                        description.Value = dt.Rows(0).Item("Description")
                        lblSnippet.Text = ""
                        lblSnippet.Visible = True
                        parentid.SelectedValue = dt.Rows(0).Item("parentid").ToString
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
    		Save()
    		Response.Redirect("/Admin/Products/DefaultCat.aspx")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Products/DefaultCat.aspx")
    End Sub
 
     Protected Sub btnSaveContinueEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveContinueEdit.Click
    		Dim Cid  = Save()
        	Response.Redirect("/Admin/Products/Cat.aspx?id=" & Cid)
    End Sub
    
    Function Save()
    		Dim mssql = New MSSQLBuilder("RCProductCat")
    		If Not Request("Id") Is Nothing Then
    			mssql.SetValueFor("Id", Request("Id"))
    		End If
    		mssql.SetValueFor("Name", name.text)
    		mssql.SetValueFor("Seq", 1)
    		mssql.SetValueFor("Description",  description.Value)
    		mssql.SetValueFor("ParentId", parentid.SelectedValue)
    		mssql.SetValueFor("slug",  CreateSlug(name.Text, false))
    		Dim Cid  = mssql.save()
    		return Cid
    End Function
    
    
End Class
