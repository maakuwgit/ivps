Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Routing

Partial Class Staff
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Dim dt As New DataTable
            dt = RC4.Pull("Select * from RCBio order by Seq asc")
            rptBio.DataSource = dt
            rptBio.DataBind()
        End If
    End Sub
End Class
