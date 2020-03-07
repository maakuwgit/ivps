Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Users_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Dim dt As DataTable = RC4.Pull("Select Id, case(coalesce(access,0)) when 11 then 'Admin' when 10 then 'Power User' when 0 then 'User' end as Access, firstName + ' ' + LastName as [Name], coalesce(isMailingList,0) as isMailingList from Users")
            gvUser.DataSource = dt
            gvUser.DataBind()
        End If
    End Sub

    Protected Sub ckMailList_CheckedChanged(ByVal s As CheckBox, ByVal e As EventArgs)
        Dim id As Integer = s.Attributes("UserId")
        RC4.SQLExec("Update [Users] set isMailingList = " & IIf(s.Checked, "1", "0") & " where Id=" & id)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from [Users] where Id=" & id)
        Response.Redirect("/Admin/Users/")
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument)
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Response.Redirect("Add.aspx")
    End Sub
End Class
