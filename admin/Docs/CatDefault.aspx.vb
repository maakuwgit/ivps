Imports System.Data

Partial Class admin_Docs_Cat_Default
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        LoadGrid()
    End Sub

    Protected Sub LoadGrid()
        	Dim dt As DataTable
     	dt = RC4.Pull("Select * from RCDocCat order by Seq asc")
        	gvCats.DataSource = dt
        	gvCats.DataBind()
    End Sub
    
    Protected Sub btnEdit_Click(sender As Object, e As EventArgs)
        Response.Redirect("Cat.aspx?Id=" & CType(sender, Button).CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs)
        RC4.SQLExec("Delete from RCDocCat where Id=" & CInt(CType(sender, Button).CommandArgument))
        Response.Redirect("CatDefault.aspx")
    End Sub
    
End Class