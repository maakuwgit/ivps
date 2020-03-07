Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Content_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            lblSnippet.Visible = False
            
            Dim LinksTable As DataTable = RC4.Pull("Select * from WMALinks Where Label <> '' Order By Label Asc")
            dropDownPages.DataTextField = "Label"
        	dropDownPages.DataValueField = "Id"
        	
        	
        	
        	dropDownPages.DataSource = LinksTable
        	dropDownPages.DataBind()
        	
        	Dim item = new ListItem("Select a Page", "", true)
        	dropDownPages.Items.Insert(0,item)
        	
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    Id.Value = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from RCContent Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        txtName.Text = dt.Rows(0).Item("Name").ToString
                        txtTitle.Text = dt.Rows(0).Item("Title").ToString
                        txtContent.Value = dt.Rows(0).Item("Value")
                        lblSnippet.Text = "<strong>ASP.Net Code Snippet:</strong> <%=GetContent(""" & dt.Rows(0).Item("Id") & """)%>"
                        lblSnippet.Visible = True
                        dropDownPages.SelectedValue = dt.Rows(0).Item("PageId").ToString
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If String.IsNullOrEmpty(Id.Value) Then
            cmd = New SqlCommand("Insert Into RCContent ([Name], [Value], [PageId], [Title]) Values (@Name, @Value, @PageId, @Title)", con)
        Else
            cmd = New SqlCommand("Update RCContent set [Name]=@Name, [Value]=@Value, [PageId]=@PageId, [Title]=@Title, [DateModified]=GetDate() where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", CInt(Id.Value))
        End If
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Title", txtTitle.Text)
        cmd.Parameters.AddWithValue("Value", txtContent.Value)
        cmd.Parameters.AddWithValue("PageId", dropDownPages.SelectedValue)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("/Admin/Content/")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Content/")
    End Sub
 
    
     Protected Sub btnSaveContinueEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveContinueEdit.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        Dim Cid = Id.Value
        If String.IsNullOrEmpty(Cid) Then
            cmd = New SqlCommand("Insert Into RCContent ([Name], [Value], [PageId], Title) Values (@Name, @Value, @PageId, @Title); SELECT SCOPE_IDENTITY()", con)
        Else
            cmd = New SqlCommand("Update RCContent set [Name]=@Name, [Value]=@Value, [PageId]=@PageId, [Title]=@Title, [DateModified]=GetDate() where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", CInt(Id.Value))
        End If
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Title", txtTitle.Text)
        cmd.Parameters.AddWithValue("Value", txtContent.Value)
        cmd.Parameters.AddWithValue("PageId", dropDownPages.SelectedValue)
        con.Open()
        If String.IsNullOrEmpty(Cid) Then
        		Cid = cmd.ExecuteScalar()
        Else
        		cmd.ExecuteScalar()
        End If
        con.Close()
        Response.Redirect("/Admin/Content/Add.aspx?id=" & Cid)
    End Sub
    
    
End Class
