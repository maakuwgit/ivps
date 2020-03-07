Imports System.Data

Partial Class ProductCategory
    Inherits System.Web.UI.Page


    Private Shared Property InnerHtml As Object
    
    Public ProductsDataTable As DataTable
    Protected ProductCatagoriesDataTableRow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
    
    		Dim SQLBuilder = new MSSQLBuilder("RCProductCat")
		Dim Slug = Website.Router.UrlPartReverse(0)
		SQLBuilder.Where("slug = '" & Slug & "'")
		Dim ProductCatagoriesDataTable = SQLBuilder.SelectAll()
		ProductCatagoriesDataTableRow = ProductCatagoriesDataTable.Rows(0)
		
		SQLBuilder = new MSSQLBuilder("RCProduct")
		SQLBuilder.Where("CatId = '" & ProductCatagoriesDataTableRow("id") & "'")
		ProductsDataTable = SQLBuilder.SelectAll()

    End Sub
    
End Class

