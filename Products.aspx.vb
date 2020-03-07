Imports System.Data.SqlClient
Imports System.Data

Partial Class Products
    Inherits System.Web.UI.Page

	Public ProductCatagoriesDataTable  As DataTable
	Public FeaturedProductsDataTable As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
		Dim SQLBuilder = new MSSQLBuilder("RCProductCat")
		ProductCatagoriesDataTable = SQLBuilder.SelectAll()
		FeaturedProductsDataTable = ControllerFactory.Products.GetFeatured()
    End Sub
	
	Function GetProductsForCategory(id)
		Dim SQLBuilder = new MSSQLBuilder("RCProduct")
		SQLBuilder.Where("CatId = " & id)
		return SQLBuilder.SelectAll()
	End Function


End Class
