Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Docs_Add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadCats()
            If Not Request("Id") Is Nothing Then
                Dim dt As DataTable = RC4.Pull("Select * from RCDoc where Id=" & CInt(Request("Id")))
                If dt.Rows.Count > 0 Then
                    With dt.Rows(0)
                        DocId.value = .Item("Id")
                        Name.Text = .Item("Name")
                        Desc.Text = .Item("Description")
                        dlCat.SelectedValue = .Item("CatId")
                    End With
                End If
            Else
                Name.Attributes.Add("required", "required")
                fileUpload.Attributes.Add("required", "required")
            End If
        End If
    End Sub

    Protected Sub LoadCats()
        Dim dt As DataTable = RC4.Pull("Select * from vRCDocCat order by Name asc")
        dlCat.DataSource = dt
        dlCat.DataBind()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim c As SqlConnection = getCon()
        Dim cmd As SqlCommand
        If Not IsNumeric(DocId.Value) Then
            cmd = New SqlCommand("Insert into RCDoc (Name, Description, CatId, FileName, FileData) VALUES (@Name, @Description, @CatId, @FileName, @FileData)", c)
        Else
            cmd = New SqlCommand("Update RCDoc set Name=@Name, Description=@Description, CatId=@CatId" & IIf(fileUpload.HasFile, ", FileName=@FileName, FileData=@FileData", "") & " Where Id=@Id", c)
            cmd.Parameters.AddWithValue("Id", DocId.Value)
        End If

        cmd.Parameters.AddWithValue("Name", Name.Text)
        cmd.Parameters.AddWithValue("Description", Desc.Text)
        cmd.Parameters.AddWithValue("CatId", dlCat.SelectedValue)
        If fileUpload.HasFile Then
            cmd.Parameters.AddWithValue("FileName", fileUpload.FileName)
            cmd.Parameters.AddWithValue("FileData", fileUpload.FileBytes)
        End If
        c.Open()
        cmd.ExecuteNonQuery()
        c.Close()
        Response.Redirect("Default.aspx")
    End Sub

End Class
