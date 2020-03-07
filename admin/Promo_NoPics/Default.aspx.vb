Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Promo_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Dim dt As DataTable = RC4.Pull("Select * from RCPromo")
            gvPromo.DataSource = dt
            gvPromo.DataBind()
        End If
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Object, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Object, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from RCPromo where Id=" & id)
        Response.Redirect("/Admin/Promo/")
    End Sub

    Protected Sub btnDownload_Click(ByVal s As Button, ByVal e As EventArgs)
            Response.Clear()
            Response.ContentType = "application/octet-stream;"
            Response.AddHeader("content-disposition", "attachment;filename=" & HttpUtility.UrlEncode(CInt(s.CommandArgument)) & ".pdf")
        Response.WriteFile(MapPath("/images/promo/" & CInt(s.CommandArgument) & ".pdf"))
    End Sub
End Class
