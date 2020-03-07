Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Docs_Add_Cat
    Inherits System.Web.UI.Page
    
    Public CategoryRow

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
    		Dim MSSql = new MSSQLBuilder("RCDocCat") 
		If Not Me.IsPostBack Then
			LoadCats()
			If Not Request("Id") Is Nothing Then
		 		Dim dt = MSSql.SelectAllForId(Request("Id"))
		 		CategoryRow = dt.Rows(0)
			Else	
				Dim dt = MSSql.Table.CreateEmptyTable()
				CategoryRow = dt.Rows(0)
			End If
		End If
    End Sub

    Protected Sub LoadCats()
    		Dim MSSql = new MSSQLBuilder("RCDocCat")
    		MSSql.OrderBy("Name asc")	
    		Dim newListItem As ListItem
		newListItem = New ListItem("Assign to Parent Category", "0")
		
        	ParentId.DataSource = MSSql.SelectAll()
        	
        	ParentId.DataBind()
        	ParentId.Items.Insert(0, newListItem )
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        	Dim MSSql = new MSSQLBuilder("RCDocCat")
        	MSSql.ParseHttpRequest(Request.Form)
        	If Not Request.Form("ctl00$main$ParentId") Is Nothing Then
        		MSSql.SetValueFor("ParentId", Request.Form("ctl00$main$ParentId"))
        	End If
        	MSSql.Save()
        	Response.Redirect("CatDefault.aspx")
    End Sub

End Class
