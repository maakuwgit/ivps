Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_News_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            
                Dim dt As DataTable = RC4.Pull("Select * from RCFAQ where Id=" & CInt(Request("Id")))
                If dt.Rows.Count > 0 Then
                    Dim dr As DataRow = dt.Rows(0)
                    txtQuestion.Text = dr("Question")
                    txtAnswer.Text = dr("Answer")
                    ckFeatured.Checked = dr("Featured")
                End If
           
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
		Dim IDPass as String = ""
		IDPass = CInt(Request("Id"))
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As SqlCommand
	Dim dta As DataTable = RC4.Pull("Select * from RCFAQ where Id=" & CInt(Request("Id")))
	If dta.Rows.Count = 0 Then
        
            Dim sql As String = "Insert Into RCFAQ (Question, Answer) VALUES (@Question, @Answer)"
            cmd = New SqlCommand(sql, con)
		cmd.Parameters.AddWithValue("seq", 1)
        Else
            Dim sql As String = "Update RCFAQ set Question=@Question, Answer=@Answer, Featured=@Featured where Id=" & IDPass & ""
            cmd = New SqlCommand(sql, con)
            'cmd.Parameters.AddWithValue("Id", IDPass)
        End If
        cmd.Parameters.AddWithValue("Question", txtQuestion.Text)
        cmd.Parameters.AddWithValue("Answer", txtAnswer.Text)
        cmd.Parameters.AddWithValue("Featured",ckFeatured.Checked)
	'cmd.Parameters.AddWithValue("seq", 1)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("/Admin/FAQ/?filter=" & Request("filter"))
    End Sub
   
    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        Response.Redirect("/Admin/FAQ/?filter=" & Request("filter"))
    End Sub

End Class
