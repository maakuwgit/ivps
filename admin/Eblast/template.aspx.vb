Imports System.Data
Imports System.Data.SqlClient


Partial Class admin_emailCenter_addTemplate
    Inherits System.Web.UI.Page
    Sub page_load(ByVal s As Object, ByVal e As EventArgs)
        If Not Me.IsPostBack Then
            Dim dt As DataTable = Pull("Select [Title], [subject], [body], [description]  from EblastTemplates where id = " & CInt(Request.QueryString("id")))

            If Request("Id") Is Nothing Then
                Id.Value = 0
            Else
                Id.Value = Request("Id")
            End If


            If dt.Rows.Count > 0 Then
                txtTitle.Text = dt.Rows(0).Item("Title")
                txtSubject.Text = dt.Rows(0).Item("subject")
                ucFCK.Value = dt.Rows(0).Item("body")
                txtDesc.Text = dt.Rows(0).Item("description")
            End If
        End If
    End Sub

    Sub btnSubmit_Click(ByVal s As Object, ByVal e As EventArgs)
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        If Not Id.Value = 0 Then
            Dim cmd As New SqlCommand("Update EblastTemplates set [title]=@title, [description]=@description, [subject]=@subject, [body]=@body where Id=@Id", con)
            cmd.Parameters.AddWithValue("title", txtTitle.Text)
            cmd.Parameters.AddWithValue("description", txtDesc.Text)
            cmd.Parameters.AddWithValue("subject", txtSubject.Text)
            cmd.Parameters.AddWithValue("body", ucFCK.Value)
            cmd.Parameters.AddWithValue("Id", Id.Value)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
        Else
            Dim cmd As New SqlCommand("Insert into EblastTemplates values (@title, @description, @subject, @body)", con)
            cmd.Parameters.AddWithValue("title", txtTitle.Text)
            cmd.Parameters.AddWithValue("description", txtDesc.Text)
            cmd.Parameters.AddWithValue("subject", txtSubject.Text)
            cmd.Parameters.AddWithValue("body", ucFCK.Value)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
        End If

        'OLD CODE - Replaced 11/9/2011 by Brandon Lang
        'Dim ord As New OrderedDictionary
        'ord.Add("title", Tort.Transpose.SQLEncode(txtTitle.Text))
        'ord.Add("description", Tort.Transpose.SQLEncode(txtDesc.Text))
        'ord.Add("subject", Tort.Transpose.SQLEncode(txtSubject.Text))
        'ord.Add("body", Tort.Transpose.SQLEncode(ucFCK.Value))

        'Dim strSQL As String = ""
        'If Request.QueryString("id") = "" Then
        '    strSQL = Tort.DataManager.BuildSQLInsertString(ord, "EblastTemplates")
        'Else
        '    strSQL = Tort.DataManager.BuildSQLUpdateString(ord, "EblastTemplates", "id", Request.QueryString("id"))
        'End If
        'Tort.DataManager.Push(strSQL)
        Response.Redirect("Templates.aspx")
    End Sub
End Class
