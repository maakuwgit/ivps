Imports System.Data

Partial Class admin_Gallery_Cat
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        LoadGrid()
    End Sub

    Protected Sub LoadGrid()
        Dim dt As DataTable = RC4.Pull("Select * from RCLinkCat order by Seq asc")
        gvCats.DataSource = dt
        gvCats.DataBind()
    End Sub
End Class