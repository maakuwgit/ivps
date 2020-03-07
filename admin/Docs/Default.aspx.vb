Imports System.Data

Partial Class admin_Docs_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim dt As DataTable = RC4.Pull("Select *, (Select top 1 name from vRCDocCat where Id=CatId) as Category from RCDoc Order By CatId")
        gvDocs.DataSource = dt
        gvDocs.DataBind()
    End Sub

    Protected Sub btnEdit_Click(sender As Object, e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & CType(sender, Button).CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs)
        RC4.SQLExec("Delete from RCDoc where Id=" & CInt(CType(sender, Button).CommandArgument))
        Response.Redirect("/admin/Docs/")
    End Sub

    Protected Sub btnDownload_Click(sender As Object, e As EventArgs)
        Dim dt As DataTable = RC4.Pull("Select FileData, FileName from RCDoc Where Id=" & CInt(CType(sender, Button).CommandArgument))
        If dt.Rows.Count > 0 Then
            With dt.Rows(0)
                Response.Clear()
                Response.AddHeader("Content-Disposition", "attachment;filename=" + .Item("FileName"))
                Response.BinaryWrite(.Item("FileData"))
                Response.End()
            End With
        End If
    End Sub
End Class