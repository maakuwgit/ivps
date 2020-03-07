Imports System.Data
Imports System.Data.DataTable

Partial Class Menu_Edit
    Inherits System.Web.UI.Page
    
    Public dt As DataTable
    Public size As DataTable
    Public include As DataTable
    Public item As DataTable
    Public menuSectionItem As DataTable
    Public selectedMenuSectionItem As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    	 If Not Me.IsPostBack Then
		dt = MSSQLBuilder.Query("SELECT ms.id As id, m.name as menuname, s.name As sectionname FROM mnuMenuSection ms INNER JOIN mnuMenu m ON ms.menu_id = m.id INNER JOIN mnuSection s ON ms.section_id = s.id WHERE ms.id = " & Request("id") & " Order By m.name asc")
        
		Dim itemsql = new MSSQLBuilder("mnuItem")
		itemsql.OrderBy("name asc")
		item = itemsql.SelectAll()
	
		Dim sizesql = new MSSQLBuilder("mnuItemSize")
		sizesql.OrderBy("name asc")
		size = sizesql.SelectAll()
	
		Dim incudesql = new MSSQLBuilder("mnuInclude")
		incudesql.OrderBy("items asc")
		include = incudesql.SelectAll()
	
		menuSectionItem = MSSQLBuilder.query("SELECT msi.*, i.name as item, s.name as size, inc.items as include  FROM mnuMenuSectionItem msi LEFT JOIN mnuItem i ON msi.item_id = i.id LEFT JOIN mnuItemSize s ON msi.size_id = s.id LEFT JOIN mnuInclude inc ON msi.include_id = inc.id WHERE menu_section_id = " & Request("id"))
		
		Dim msiSQLBuilder = new MSSQLBuilder("mnuMenuSectionItem")
		If Not Request("msid") Is Nothing Then
			selectedMenuSectionItem = msiSQLBuilder.SelectAllForId(Request("msid"))
		Else
			selectedMenuSectionItem = msiSQLBuilder.SelectAllForId(Nothing)
		End If
	End If
    End Sub

    Protected Sub btnClose_Click(ByVal s As Button, ByVal e As EventArgs)  Handles btnClose.Click
	Response.Redirect("default.aspx")
   End Sub
   
   Protected Sub btnReset_Click(ByVal s As Button, ByVal e As EventArgs)  Handles btnReset.Click
	Response.Redirect("edit.aspx?id=" & Request("id"))
   End Sub

   Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
	btnSave_Click(sender, e)
   End Sub
   
   Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
	Dim id = save()
	Response.Redirect("edit.aspx?id=" & Request("id"))
   End Sub
   
   Protected Sub btnSaveClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveClose.Click
	save()
	btnClose_Click(sender, e)
   End Sub
   
   Protected Function Save()
   	Dim msSQLBuilder = new MSSQLBuilder("mnuMenuSectionItem")
	msSQLBuilder.ParseHttpRequest(Request.form)
	'Response.Write(msSQLBuilder.saveToString())
	return msSQLBuilder.save()
   End Function
    
End Class
