Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Docs_Add2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadCats()
			LoadTabs()
            If Not Request("Id") Is Nothing Then
                Dim dt As DataTable = RC4.Pull("Select * from RCProduct where Id=" & CInt(Request("Id")))
                If dt.Rows.Count > 0 Then
                    With dt.Rows(0)
                        DocId.Value = .Item("Id")
                        If Not IsDBNull(.Item("Name")) Then Name.Text = .Item("Name")
                        If Not IsDBNull(.Item("Description2")) Then Description2.Text = .Item("Description2")
                        If Not IsDBNull(.Item("ShortDescription")) Then ShortDescription.Text = .Item("ShortDescription")
                        If Not IsDBNull(.Item("CatId")) Then dlCat.SelectedValue = .Item("CatId")
                    End With
                End If
            Else
                Name.Attributes.Add("required", "required")
                'fileUpload.Attributes.Add("required", "required")
            End If
        End If
    End Sub
			
	Protected Sub LoadTabs()
		Dim dt As DataTable = RC4.Pull("Select * from RCProductTab where ProductId=" & CInt(Request("Id")))
		Tabs.DataSource = dt
		Tabs.DataBind()
	End Sub
	
	Protected Sub btnAddTab_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddTab.Click
		If Request("Id") Is Nothing Then
			ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Success", "alert('The product must be save before new tab content can be added.');", True)			
		Else
			Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        	Dim cmd As SqlCommand
        	Dim sql As String = "Insert Into RCProductTab (ProductId, Name) Values (" & Request("Id") & ", 'Tab Name')"
        	cmd = New SqlCommand(sql, con)
        	con.Open()
        	cmd.ExecuteNonQuery()
        	con.Close()
        	Response.Redirect("/Admin/Products/Z-Add.aspx?Id=" & Request("Id"))
		End If
	End Sub
	
	Protected Sub btnUpdateTab_Click(sender As Object, e As EventArgs)
        Dim Id As Integer = CType(sender, Button).CommandArgument
		
			
				Response.Redirect("/Admin/Products/EditTab.aspx?Id=" & Id)
			
	End Sub

    Protected Sub LoadCats()
        Dim dt As DataTable = RC4.Pull("Select * from vRCProductCat order by Name asc")
        dlCat.DataSource = dt
        dlCat.DataBind()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
    
    For Each item As RepeaterItem In Tabs.Items
    	ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Success", "alert('"& item.ClientId  &"');", True)
	Next

        Dim c As SqlConnection = getCon()
        Dim cmd As SqlCommand
        If Not IsNumeric(DocId.Value) Then
            cmd = New SqlCommand("Insert into RCProduct (Name, CatId, Description2, ShortDescription" & _
                                IIf(imgUpload.HasFile, ", ImgFileName, ImgData", "") & _
                                IIf(tdsUpload.HasFile, ", TDSFileName, TDSData", "") & _
                                ") VALUES (@Name, @CatId, @Description2" & _
                                IIf(imgUpload.HasFile, ", @ImgFileName, @ImgData", "") & _
                                IIf(tdsUpload.HasFile, ", @TDSFileName, @TDSData", "") & _
                                ")", c)
        Else
            cmd = New SqlCommand("Update RCProduct set Name=@Name, CatId=@CatId, Description2=@Description2, ShortDescription=@ShortDescription" & _
                                 IIf(imgUpload.HasFile, ", ImgFileName=@ImgFileName, ImgData=@ImgData", "") & _
                                 IIf(tdsUpload.HasFile, ", TDSFileName=@TDSFileName, TDSData=@TDSData", "") & _
                                 " Where Id=@Id", c)
            cmd.Parameters.AddWithValue("Id", DocId.Value)
        End If

        cmd.Parameters.AddWithValue("Name", Name.Text)
        cmd.Parameters.AddWithValue("Description2", Description2.Text)
        cmd.Parameters.AddWithValue("ShortDescription", ShortDescription.Text)
        cmd.Parameters.AddWithValue("CatId", dlCat.SelectedValue)
        If imgUpload.HasFile Then
            cmd.Parameters.AddWithValue("ImgFileName", imgUpload.FileName)
            cmd.Parameters.AddWithValue("ImgData", imgUpload.FileBytes)
        End If
        If tdsUpload.HasFile Then
            cmd.Parameters.AddWithValue("TDSFileName", tdsUpload.FileName)
            cmd.Parameters.AddWithValue("TDSData", tdsUpload.FileBytes)
        End If
        c.Open()
        cmd.ExecuteNonQuery()
        c.Close()
        Response.Redirect("Default.aspx")
    End Sub

End Class
