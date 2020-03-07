Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Content_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    
    	Dim LinksTable As DataTable = RC4.Pull("Select * from WMALinks Where Label <> '' Order By Label Asc")
	
	If LinksTable.Rows.Count > 0 Then
		For Each row As DataRow In LinksTable.Rows
			Dim url = WebSite.Link(row("id")).Url()
			Dim item = new ListItem(url, url, true)
			dropRedirectUrl.Items.Insert(0,item)
		Next row
	End If
        	Dim firstitem = new ListItem("Select Site Url", "", true)
        	dropRedirectUrl.Items.Insert(0,firstitem)
        	
        	'dropResponseCode.Items.Insert(0,  new ListItem("307 - Temporary Redirect", "307", true))
        	dropResponseCode.Items.Insert(0,  new ListItem("302 - Temporary Redirect", "302", true))
        	dropResponseCode.Items.Insert(0,  new ListItem("301 - Moved Permanently", "301", true))
        	dropResponseCode.Items.Insert(0,  new ListItem("Select a Response Code", "", true))
        	
        If Not Me.IsPostBack Then
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    Id.Value = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from WMASiteErrorLog Where Id=" & CInt(Request("Id")))
                    If dt.Rows.Count > 0 Then
                        txtUrl.Text = iif(String.IsNullOrEmpty(dt.Rows(0)("raw_url").ToString()), "", dt.Rows(0)("raw_url"))
                        txtRedirectUrl.Text = iif(String.IsNullOrEmpty(dt.Rows(0)("redirect_url").ToString()), "", dt.Rows(0)("redirect_url"))
                        'dropRedirectUrl.SelectedValue = dt.Rows(0).Item("redirect_url").ToString
                        dropResponseCode.SelectedValue = dt.Rows(0).Item("response_status_code").ToString
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
        If String.IsNullOrEmpty(Id.Value) Then
        	Dim raw_url = txtUrl.Text
        	If raw_url.length > 0 Then
        		If Not raw_url.StartsWith("/") Then
        			raw_url = "/" & raw_url
        		End If
            	cmd = New SqlCommand("Insert Into WMASiteErrorLog ([raw_url], [redirect_url], [response_status_code]) Values (@raw_url, @redirect_url, @response_status_code)", con)
            	cmd.Parameters.AddWithValue("raw_url", raw_url)
            Else
            	Response.Redirect("/Admin/Redirect/")
            End If
        Else
            cmd = New SqlCommand("Update WMASiteErrorLog set [redirect_url]=@redirect_url, response_status_code=@response_status_code where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", CInt(Id.Value))
        End If
        
        Dim redirect_url = ""
        Dim response_code = dropResponseCode.SelectedValue
        
        If dropRedirectUrl.SelectedValue.ToString.length > 0 Then
        	redirect_url = dropRedirectUrl.SelectedValue
        Else
        	redirect_url = txtRedirectUrl.Text
        End If
        
        If Not redirect_url.tostring.length > 0 Then
        	response_code = ""
        End If
        
        cmd.Parameters.AddWithValue("redirect_url", redirect_url)
        cmd.Parameters.AddWithValue("response_status_code", response_code)
    
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("/Admin/Redirect/")

    End Sub


    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Redirect/")
    End Sub
End Class
