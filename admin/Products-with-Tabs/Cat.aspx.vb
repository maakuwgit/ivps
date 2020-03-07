Imports System.Data

Partial Class admin_Products_Cat
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Request("Id") Is Nothing Then
            Dim dt As DataTable = RC4.Pull("Select Name from RCProductCat2 where Id=" & CInt(Request("Id")))
            If dt.Rows.Count > 0 Then
                ParentId.Value = CInt(Request("Id"))
                pgTitle.InnerHtml = dt.Rows(0).Item("Name") & " SubCategories"
            End If
        End If
        LoadGrid()
    End Sub

    Protected Sub LoadGrid()
        Dim dt As DataTable
        If Not Request("Id") Is Nothing Then
            dt = RC4.Pull("Select * from RCProductCat2 where ParentId=" & CInt(Request("Id")) & " order by Seq asc")
        Else
            dt = RC4.Pull("Select * from RCProductCat2 where ParentId=0 order by Seq asc")
        End If

        gvCats.DataSource = dt
        gvCats.DataBind()
    End Sub
End Class