Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Promo_Add
    Inherits System.Web.UI.Page

    Const FileTypes As String = ".pdf"
    Const PicTypes As String = ".jpg|.png|.gif"

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
                            If Not IsDBNull(.Item("Desc")) Then txtDesc.Value = .Item("Desc")
                            If Not IsDBNull(.Item("StartDt")) Then txtStartDt.Text = .Item("StartDt")
                            If Not IsDBNull(.Item("EndDt")) Then txtEndDt.Text = .Item("EndDt")
                             If Not IsDBNull(.Item("Featured")) Then cbFeatured.Checked = .Item("Featured")
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
            cmd = New SqlCommand("Insert into RCPromo (Name, [Desc], StartDt, EndDt, Featured) Values (@Name, @Desc, @StartDt, @EndDt, @Featured) Select Scope_Identity()", con)
        Else
            cmd = New SqlCommand("Update RCPromo Set Name=@Name, [Desc]=@Desc, StartDt=@StartDt, EndDt=@EndDt, Featured=@Featured Where Id=@Id Select -1", con)
            cmd.Parameters.AddWithValue("Id", PromoId.Value)
        End If
        cmd.Parameters.AddWithValue("Name", txtName.Text)
        cmd.Parameters.AddWithValue("Desc", txtDesc.Value)
        cmd.Parameters.AddWithValue("StartDt", txtStartDt.Text)
        cmd.Parameters.AddWithValue("EndDt", txtEndDt.Text)
         cmd.Parameters.AddWithValue("Featured", cbFeatured.Checked)
        con.Open()
        Dim id As Integer = cmd.ExecuteScalar
       
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
        If FileUpload1.PostedFile.ContentLength > 0 Then
            Dim fi As New IO.FileInfo(FileUpload1.PostedFile.FileName)
            If PicTypes.Contains(LCase(fi.Extension)) Then
                If My.Computer.FileSystem.FileExists(MapPath("/images/promo/p" & id & ".jpg")) Then
                    My.Computer.FileSystem.DeleteFile(MapPath("/images/promo/p" & id & ".jpg"))
                End If
                If My.Computer.FileSystem.FileExists(MapPath("/images/promo/p" & id & ".jpeg")) Then
                    My.Computer.FileSystem.DeleteFile(MapPath("/images/promo/p" & id & ".jpeg"))
                End If
                If My.Computer.FileSystem.FileExists(MapPath("/images/promo/p" & id & ".png")) Then
                    My.Computer.FileSystem.DeleteFile(MapPath("/images/promo/p" & id & ".png"))
                End If
                If My.Computer.FileSystem.FileExists(MapPath("/images/promo/p" & id & ".gif")) Then
                    My.Computer.FileSystem.DeleteFile(MapPath("/images/promo/p" & id & ".gif"))
                End If
                FileUpload1.PostedFile.SaveAs(MapPath("/images/promo/p" & id & fi.Extension))
            End If
            
            
             cmd = New SqlCommand("Update RCPromo Set ImgExt=@ImgExt Where Id=@Id", con)
            cmd.Parameters.AddWithValue("Id", PromoId.Value)
            cmd.Parameters.AddWithValue("ImgExt", fi.Extension)
             cmd.ExecuteScalar
            
        End If
        
         con.Close()
         
        Response.Redirect("/Admin/Promo/")
    End Sub
End Class