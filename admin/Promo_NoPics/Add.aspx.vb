Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Promo_Add
    Inherits System.Web.UI.Page

    Const FileTypes As String = ".pdf"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            If Not Request("Id") Is Nothing Then
                If IsNumeric(Request("Id")) Then
                    Dim Id As Integer = Request("Id")
                    Dim dt As DataTable = RC4.Pull("Select * from RCPromo where Id=" & Id)
                    If dt.Rows.Count > 0 Then
                        PromoId.Value = Id
                        With dt.Rows.Item(0)
                            If Not IsDBNull(.Item("Name")) Then txtName.Text = .Item("Name")
                            If Not IsDBNull(.Item("Desc")) Then txtDesc.Text = .Item("Desc")
                            If Not IsDBNull(.Item("StartDt")) Then txtStartDt.Text = .Item("StartDt")
                            If Not IsDBNull(.Item("EndDt")) Then txtEndDt.Text = .Item("EndDt")
                        End With
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim cmd As SqlCommand
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
        If PromoId.Value = 0 Then
            cmd = New SqlCommand("Insert into RCPromo (Name, [Desc], StartDt, EndDt) Values (@Name, @Desc, @StartDt, @EndDt) Select Scope_Identity()", con)
        Else
            cmd = New SqlCommand("Update RCPromo Set Name=@Name, [Desc]=@Desc, StartDt=@StartDt, EndDt=@EndDt Where Id=@Id Select -1", con)
            cmd.Parameters.AddWithValue("Id", PromoId.Value)
        End If
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Desc", txtDesc.Text)
        cmd.Parameters.AddWithValue("StartDt", txtStartDt.Text)
        cmd.Parameters.AddWithValue("EndDt", txtEndDt.Text)
        con.Open()
        Dim id As Integer = cmd.ExecuteScalar
        con.Close()
        If id = -1 Then id = PromoId.Value

        If FileUpload.PostedFile.ContentLength > 0 Then
            Dim fi As New IO.FileInfo(FileUpload.PostedFile.FileName)
            If FileTypes.Contains(LCase(fi.Extension)) Then
                If My.Computer.FileSystem.FileExists(MapPath("/images/promo/" & id & fi.Extension)) Then
                    My.Computer.FileSystem.DeleteFile(MapPath("/images/promo/" & id & fi.Extension))
                End If
                FileUpload.PostedFile.SaveAs(MapPath("/images/promo/" & id & fi.Extension))
            End If
        End If
        Response.Redirect("/Admin/Promo/")
    End Sub
End Class
