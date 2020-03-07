Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web

Partial Class admin_Menus_Add
    Inherits System.Web.UI.Page
    
    Public MenuLinksData

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    
		Dim Id = Request("Id")
		
		Dim SQLBuilder = new MSSQLBuilder("WMAMenuLinks")
		
		If Not Me.IsPostBack Then
			MenuLinksData = SQLBuilder.SelectAllForId(Id)
			
			Dim MenusTable As DataTable = RC4.Pull("Select * from WMAMenus Order By Name Asc")
            	menuid.DataTextField = "label"
        		menuid.DataValueField = "Id"
			menuid.DataSource = MenusTable
        		menuid.DataBind()
        		Dim item = new ListItem("Select a Menu", "", true)
        		menuid.Items.Insert(0,item)
        		
        		Dim LinksTable As DataTable = RC4.Pull("Select * from WMALinks Where Label <> '' Order By Label Asc")
            	linkid.DataTextField = "label"
        		linkid.DataValueField = "Id"
			linkid.DataSource = LinksTable
        		linkid.DataBind()
        		item = new ListItem("Select a Menu", "", true)
        		linkid.Items.Insert(0,item)
        		
        		If MenuLinksData.Rows.Count > 0 Then
			    menuid.SelectedValue = MenuLinksData.Rows(0).Item("menuid").ToString
			    linkid.SelectedValue = MenuLinksData.Rows(0).Item("linkid").ToString
			End If
        	
		End If
		
		'SliderData = SQLBuilder.SelectId(Nothing)

    End Sub

	 Protected Sub btnSaveClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveClose.Click
	 	Save()
	 	Close()
	 End Sub
	 
	 Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
	 	Dim Id = Save()
	 	Response.Redirect(Request.Url.AbsolutePath & "?id=" & Id)
	 End Sub
	 
    Protected Function Save()
    	For Each key as string in Request.Form
    		Response.Write(Key & ": " & Request(key) & "<br>")
    	Next
    	'return 0
		Dim SQLBuilder = new MSSQLBuilder("WMAMenuLinks")
		SQLBuilder.ParseHttpRequest(Request.Form)
		SQLBuilder.SetValueFor("menuid", menuid.SelectedValue)
		SQLBuilder.SetValueFor("linkid", linkid.SelectedValue)
		Dim Id = SQLBuilder.Save()
		Return Id
    End Function
    
    Protected Sub Close()
    	Response.Redirect("/Admin/Menus/?filter=" & Request("filter"))
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Close()
    End Sub
    
End Class
