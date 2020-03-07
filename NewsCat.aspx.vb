Imports System.Data
Imports System.Configuration

Partial Class News
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim parts() As String = getUrlPartsFromQueryString(Request)

		Dim NewsDataTable As DataTable = RC4.Pull("Select * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' And CatId = " & parts(2) & "order by PubDate desc")
		News.DataSource = NewsDataTable
		News.DataBind()
	
		Dim CategoryDataTable As DataTable = RC4.Pull("Select * from RCNewsCat Where Id = " & parts(2))
		Category.DataSource = CategoryDataTable
		Category.DataBind()
		

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
