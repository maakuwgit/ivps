Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Routing

Partial Class Staff
    Inherits System.Web.UI.Page
	Public TeamMemberInfo
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Dim MSSql = new MSSQLBuilder("RCBio")
            MSSql.Where("slug = '" & WebSite.Router.UrlPartReverse(0) & "'")
            Dim datatable = MSSql.SelectAll()
            If datatable.rows.count = 1 Then
            	TeamMemberInfo = datatable.Rows(0)
            else
            	TeamMemberInfo = MSSql.Table.CreateEmptyTable()
            end if
            
        End If
    End Sub
End Class
