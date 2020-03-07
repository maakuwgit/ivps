Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Content_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
	
	Dim LinksTable As DataTable = RC4.Pull("Select * from WMALinks Where Label <> '' Order By Label Asc")
          dropDownParents.DataTextField = "Label"
	dropDownParents.DataValueField = "Id"
        	dropDownParents.DataSource = LinksTable
        	dropDownParents.DataBind()
        	Dim item = new ListItem("Select a Parent", "", true)
        	Dim item2 = new ListItem("No Parent", "")
        	Dim item3 = new ListItem("---------------------", "")
        	dropDownParents.Items.Insert(0,item3)
        	dropDownParents.Items.Insert(0,item2)
        	dropDownParents.Items.Insert(0,item3)
        	dropDownParents.Items.Insert(0,item)
        	
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    Id.Value = Request("Id")
                    Idlbl.text = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from WMALinks Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        txtName.Text = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Name").ToString()), "", dt.Rows(0).Item("Name"))
                        txtProperties.Value = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Properties").ToString()),  "{""alt"":"""",""title"":"""",""target"":"""",""rel"":"""",""class"":"""",""style"":""""}", dt.Rows(0).Item("Properties"))
                        txtLabel.Text = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Label").ToString()), "", dt.Rows(0).Item("Label"))
                        txtUrl.Text = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Url").ToString()), "", dt.Rows(0).Item("Url"))
                        txtLocation.Text = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Location").ToString()), "", dt.Rows(0).Item("Location"))
                        txtAction.Text = iif(String.IsNullOrEmpty(dt.Rows(0).Item("Action").ToString()), "Rewrite", dt.Rows(0).Item("Action"))
                         If Not IsDBNull(dt.Rows(0).Item("Active")) Then cbActive.Checked = dt.Rows(0).Item("active")
                         dropDownParents.SelectedValue = dt.Rows(0).Item("Parentid").ToString
                    Else
                    	cbActive.Checked = 1
                    	txtAction.Text = "Rewrite"
                    	txtProperties.Value = "{""alt"":"""",""title"":"""",""target"":"""",""rel"":"""",""class"":"""",""style"":""""}"
                    End If
                End If
            Else
            	cbActive.Checked = 1
            	txtAction.Text = "Rewrite"
            	txtProperties.Value = "{""alt"":"""",""title"":"""",""target"":"""",""rel"":"""",""class"":"""",""style"":""""}"
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If String.IsNullOrEmpty(Id.Value) Then
            cmd = New SqlCommand("Insert Into WMALinks ([Name], [Label], [Url], [Location], [Action], [Properties], [ParentId], [Active], [CompleteUrl]) Values (@Name, @Label, @Url, @Location, @Action, @Properties, @ParentId, @Active, @CompleteUrl)", con)
        Else
            cmd = New SqlCommand("Update WMALinks set [Name]=@Name, [Label]=@Label, [Url]=@Url, [Location]=@Location, [Action]=@Action, [Properties]=@Properties, [ParentId]=@ParentId, [Active]=@Active, [CompleteUrl]=@CompleteUrl where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", CInt(Id.Value))
        End If
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Label", txtLabel.Text)
        cmd.Parameters.AddWithValue("Url", txtUrl.Text)
        cmd.Parameters.AddWithValue("Location", txtLocation.Text)
        cmd.Parameters.AddWithValue("Action", txtAction.Text)
        cmd.Parameters.AddWithValue("Properties", txtProperties.Value)
         cmd.Parameters.AddWithValue("ParentId", dropDownParents.SelectedValue)
         cmd.Parameters.AddWithValue("Active", cbActive.Checked)
         cmd.Parameters.AddWithValue("CompleteUrl", BuildCompleteUrl(dropDownParents.SelectedValue, txtUrl.Text))
         
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("/Admin/Url/?filter=" & Request("filter"))
        'Response.Write(BuildCompleteUrl(dropDownParents.SelectedValue, txtUrl.Text))
        'Response.write("DD:" & dropDownParents.SelectedValue)
    End Sub

    Function BuildCompleteUrl(parentid, prependToUrl)
	If Not IsDBNull(parentid) AndAlso parentid.ToString.length > 0 AndAlso parentid > 0 Then
		Dim dt = RC4.Pull("Select * from WMALinks where active = 1 And id = " & parentid)
		If dt.Rows.Count > 0 Then
			return BuildCompleteUrl(dt.rows(0)("parentid"), dt.rows(0)("url") & "/" & prependToUrl)
		End If
	End If
	return prependToUrl
    End Function

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Url/?filter=" & Request("filter"))
    End Sub
End Class
