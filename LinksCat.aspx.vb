Imports System.Data
Imports System.Configuration

Partial Class Links
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Request("Id") Is Nothing Or Not IsNumeric(Request("Id")) Then
            Response.Redirect("/Links.aspx")
        Else
            Dim NewsDataTable As DataTable = RC4.Pull("Select *, '/LinkImg.ashx?Id=' + cast(Id as varchar(8)) as ImgSrc from RCLink where CatId = " & Request("Id") & "order by Id asc")
			Links.DataSource = NewsDataTable
        	Links.DataBind()
        
        	Dim CategoryDataTable As DataTable = RC4.Pull("Select * from RCLinkCat Where Id = " & Request("Id"))
        	Category.DataSource = CategoryDataTable
        	Category.DataBind()
        	
        	Dim CategoriesDataTable As DataTable = RC4.Pull("Select * from RCLinkCat order by Seq")
			Categories.DataSource = CategoriesDataTable
			Categories.DataBind()
			
        
        End If

    End Sub
    
    protected Sub Repeater_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        'Repeater NewsStories = TryCast(sender, Repeater)
        If sender IsNot Nothing And sender.Items.Count < 1 Then
        	If e.Item.ItemType = ListItemType.Footer Then
				Dim lblErrorMsg = e.Item.FindControl("lblErrorMsg")
				If lblErrorMsg IsNot Nothing Then
					lblErrorMsg.Visible = true
				End If
			End If
        End If
        
    End Sub
    
End Class
