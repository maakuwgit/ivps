Imports System.Data
Imports System.Data.DataTable

Partial Class admin_Content_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadGrid()
        End If
    End Sub

    Protected Sub LoadGrid()
        Dim dt As DataTable = RC4.Pull("Select *, (Select Label From WMALinks Where id = RCContent.PageId) As Page from RCContent Order By Page Asc, Name Asc")
        gvContent.DataSource = dt
        gvContent.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Add.aspx?Id=" & s.CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from RCContent where Id=" & id)
        Response.Redirect("/Admin/Content/")
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Response.Redirect("Add.aspx")
    End Sub
    
    Protected Sub btnDuplicate_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        If id.tostring.length > 0 then
        RC4.SQLExec("Insert Into RCContent (Name,Value, Title) Select Name + ' - COPY',Value, Title From RCContent Where id=" & id)
        end if
        Response.Redirect("/Admin/Content/")
    End Sub
    
End Class
