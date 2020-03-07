Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Products_Tab
    Inherits System.Web.UI.Page
	Dim TabId as Integer
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Request("Id") Is Nothing Then
		TabId = (Request("Id"))
		Id.Value = Request("Id")
            Dim dt As DataTable = RC4.Pull("Select * from RCProductTab where Id=" & CInt(Request("Id")))
            If dt.Rows.Count > 0 Then
			For Each dr as DataRow in dt.Rows
			pgTitle.InnerHtml = "" & dr("Name") & ""
			txtName.Text = (dr("Name"))
			IF NOT IsDBNull (dr("Content")) Then 
			txtDesc.Text = (dr("Content"))
			Else 
			txtDesc.Text = ""
			End If
			'Tab.InnerHtml=& ""
			Next
            End If
        End If
        
    End Sub
	
		Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
		Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
		If Not Request("Id") Is Nothing Then
			TabId = (Request("Id"))
			txtDesc.Text =  txtName.Text
			Exit Sub
        	Dim sql As String = ("Update RCProductTab set Name=@Name, Content=@Content where Id = " & CInt(Request("Id")))
			cmd = New SqlCommand(sql, con)
			Dim Namer as String
			Namer = txtName.Value + "7"
			cmd.Parameters.AddWithValue("Id", Id.Value)
			 'cmd.Parameters.AddWithValue("Name", txtName.Text)
			 cmd.Parameters.AddWithValue("Name", Namer)
			 cmd.Parameters.AddWithValue("Content", txtDesc.Text)
			 
			con.Open()
			cmd.ExecuteNonQuery()
			con.Close()
			Response.Redirect("/Admin/Products/Default.aspx")
		Else 
			Response.Redirect("/Default.aspx")
		End If
		End Sub

    
End Class