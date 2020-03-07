Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Products_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        DataLoad()
    End Sub
'case when Published = 1 then 'Yes' else 'No' end As Publish
	
    Protected Sub DataLoad()
        Dim dt As DataTable = RC4.Pull("Select * from RCProductCat t1 where ParentId=0 and (Select count(*) from RCProduct where (CatId=t1.Id or CatId in (Select Id from RCProductCat where ParentId=t1.Id))) > 0 order by Seq asc")
        rptCat.DataSource = dt
        rptCat.DataBind()
    End Sub

    Protected Sub rptCat_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptCat.ItemDataBound
        Dim Cat As Integer
        Cat = e.Item.DataItem("Id")
        'Dim dt As DataTable = RC4.Pull("Select RCProduct.*, RCProductCat.Name as Category, RCProductCat.Seq as CatSeq from RCProduct join RCProductCat on RCProduct.CatId = RCProductCat.ID where RCProduct.CatId=" & Cat & " or CatId in (Select Id from RCProductCat where ParentId=" & Cat & ")")
        Dim dt As DataTable = RC4.Pull("Select RCProduct.id, RCProduct.name, case when RCProduct.Published = 1 then 'Yes' else 'No' end As Published, RCProductCat.Name as Category, RCProductCat.Seq as CatSeq from RCProduct join RCProductCat on RCProduct.CatId = RCProductCat.ID where RCProduct.CatId=" & Cat & " or CatId in (Select Id from RCProductCat where ParentId=" & Cat & ")")
       	Dim gv As GridView = e.Item.FindControl("gv")
        gv.DataSource = dt
        gv.DataBind()
    End Sub

    Protected Sub btnEdit_Click(sender As Object, e As EventArgs)
        Dim Id As Integer = CType(sender, Button).CommandArgument
        Response.Redirect("Add.aspx?Id=" & Id)
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs)
        Dim Id As Integer = CType(sender, Button).CommandArgument
        RC4.SQLExec("Delete from RCProduct where Id=" & Id)
        DataLoad()
    End Sub


End Class
