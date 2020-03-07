Imports System.Data

Partial Class Product
    Inherits System.Web.UI.Page

    Dim id As Integer = 0
    Dim ProductData As DataTable
    Public ProductDataRow

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
		Dim SQLBuilder = new MSSQLBuilder("RCProduct")
		Dim Slug = Website.Router.UrlPartReverse(0)
		SQLBuilder.Where("slug = '" & Slug & "'")
		ProductData = SQLBuilder.SelectAll()
		ProductDataRow = ProductData.Rows(0)
    End Sub
    
    Function GetCategoryName(id)
    		Dim SQLBuilder = new MSSQLBuilder("RCProductCat")
    		Dim DataTable = SQLBuilder.SelectAllForId(id)
    		If DataTable.Rows.Count > 0 Then
    			return DataTable.Rows(0)("name")
    		Else
    			return ""
    		End If
    End Function
    
End Class
