Imports System.Data
Imports System.Data.SqlClient

Partial Class SEO_Default
    Inherits System.Web.UI.Page

    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dt As New DataTable
        Dim ad As New SqlDataAdapter("Select * from RcSeo", con)
        con.Open()
        ad.Fill(dt)
        con.Close()
        If Not Me.IsPostBack Then
            For Each dr As DataRow In dt.Rows
                Dim l As New ListItem
                l.Text = dr.Item("Page")
                l.Value = dr.Item("Id")
                lbPage.Items.Add(l)
            Next
            If Not IO.File.Exists(MapPath("/robots.txt")) Then
                My.Computer.FileSystem.WriteAllText(MapPath("/robots.txt"), String.Empty, False)
            End If
            Dim sr As New IO.StreamReader(MapPath("/robots.txt"))
            txtRobots.Value = sr.ReadToEnd
            sr.Close()
        End If
        For Each l As ListItem In lbPage.Items
            For Each dr As DataRow In dt.Rows
                If dr.Item("Id") = l.Value Then
                    If IsDBNull(dr.Item("title")) Or IsDBNull(dr.Item("keywords")) Or IsDBNull(dr.Item("desc")) Then
                        l.Attributes.CssStyle.Add("color", "#000")
                    Else
                        If String.IsNullOrEmpty(dr.Item("title")) Or String.IsNullOrEmpty(dr.Item("keywords")) Or String.IsNullOrEmpty(dr.Item("desc")) Then
                            l.Attributes.CssStyle.Add("color", "#000")
                        End If
                    End If
                End If
            Next
        Next
        If lbPage.SelectedItem Is Nothing Then
            If lbPage.Items.Count > 0 Then
                lbPage.Items(0).Selected = True
                lbPage_SelectedIndexChanged(sender, e)
            End If
        End If
    End Sub
    
     Protected Sub btnPageRemove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPageRemove.Click
    	If CInt(lbPage.SelectedValue) > 0 Then
			Dim cmd As New SqlCommand("Delete  From RCSeo Where Id = @Id", con)
			cmd.Parameters.AddWithValue("Id", CInt(lbPage.SelectedValue))
			con.Open()
			cmd.ExecuteNonQuery()
			con.Close()
			Response.redirect("/admin/seo")
		End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim cmd As New SqlCommand("Update RCSeo set [Title]=@Title, [Desc]=@Desc, [Keywords]=@Keywords, StructuredData=@StructuredData where Id=@Id", con)
        cmd.Parameters.AddWithValue("Title", txtTitle.Text)
        cmd.Parameters.AddWithValue("Desc", txtDesc.Text)
        cmd.Parameters.AddWithValue("Keywords", txtKeywords.Text)
        cmd.Parameters.AddWithValue("StructuredData", txtStructuredData.Text)
        cmd.Parameters.AddWithValue("Id", CInt(lbPage.SelectedValue))
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
    End Sub
	
	Protected Sub btnPageAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPageAdd.Click
        Dim cmd As New SqlCommand("Insert into RCSeo (Page) Values (@Page)", con)
        cmd.Parameters.AddWithValue("Page", txtPageAdd.Text)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
		txtPageAdd.Text = ""
    End Sub

    Protected Sub lbPage_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbPage.SelectedIndexChanged
        Dim ad As New SqlDataAdapter("Select * from RCSeo where Id=" & CInt(lbPage.SelectedValue), con)
        Dim dt As New DataTable
        con.Open()
        ad.Fill(dt)
        con.Close()
        If dt.Rows.Count > 0 Then
            With dt.Rows(0)
                If Not IsDBNull(.Item("Desc")) Then
                    txtDesc.Text = .Item("Desc")
                Else
                    txtDesc.Text = ""
                End If
                If Not IsDBNull(.Item("Keywords")) Then
                    txtKeywords.Text = .Item("Keywords")
                Else
                    txtKeywords.Text = ""
                End If
				
                If Not IsDBNull(.Item("StructuredData")) Then
                    txtStructuredData.Text = .Item("StructuredData")
                Else
                    txtStructuredData.Text = ""
                End If
                If Not IsDBNull(.Item("Title")) Then
                    txtTitle.Text = .Item("Title")
                Else
                    txtTitle.Text = ""
                End If
                btnView.Attributes.Add("onclick", "window.open('" & .Item("Page") & "')")
            End With
        End If
    End Sub

    Protected Sub btnSaveRobots_Click(sender As Object, e As System.EventArgs) Handles btnSaveRobots.Click
        Try
            Dim sw As New IO.StreamWriter(MapPath("/robots.txt"))
            sw.Write(txtRobots.Value)
            sw.Close()
            lblRobots.Text = "File update successful."
        Catch ex As Exception
            lblRobots.Text = "File update failed. " & ex.Message
        End Try
    End Sub
End Class
