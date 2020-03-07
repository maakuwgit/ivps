Imports System.Data
Imports System.Data.DataTable

Partial Class admin_Content_Default
    Inherits System.Web.UI.Page
    
    Dim AddFileName = "Add.aspx"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadGrid()
        End If
    End Sub

    Protected Sub LoadGrid()
    	Dim SQLBuilder = new MSSQLBuilder("WMASlider")
    	SQLBuilder.OrderBy("Seq ASC")
        gvSlider.DataSource = SQLBuilder.SelectAll()
        gvSlider.DataBind()
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect(AddFileName & "?Id=" & s.CommandArgument)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        Dim SQLBuilder = new MSSQLBuilder("WMASlider")
        SQLBuilder.SetValueFor("Id", id)
    	SQLBuilder.Delete()
        Response.Redirect(System.IO.Path.GetDirectoryName(Request.AppRelativeCurrentExecutionFilePath))
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Response.Redirect(AddFileName)
    End Sub
    
End Class
