Imports System.Data
Imports System.Configuration

Partial Class News
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        
        'Dim parts() As String = getUrlPartsFromQueryString(Request)
        
        Dim Id = getIdFromPrettyUrl(Request)

        Dim NewsStory As DataTable = RC4.Pull("Select * from RCNews where id='" & Id & "'")
		Story.DataSource = NewsStory
        Story.DataBind()

    End Sub
    
    protected Sub BindInnerRepeaters(sender As Object, e As RepeaterItemEventArgs)
        
    	'Dim CategoriesDataTable As DataTable = RC4.Pull("Select * from RCNewsCat order by Seq")
    	'Dim Categories As Repeater = TryCast(e.Item.FindControl("Categories"), Repeater)
        'Categories.DataSource = CategoriesDataTable
        'Categories.DataBind()
        	
        'Dim NewsDataTable As DataTable = RC4.Pull("Select Top 5 * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' order by PubDate desc")
        'Dim TopNews As Repeater = TryCast(e.Item.FindControl("TopNews"), Repeater)
		'TopNews.DataSource = NewsDataTable
        'TopNews.DataBind()
        
    End Sub

    
End Class
