Imports System.Data
Imports System.Data.SqlClient

Partial Class Links
    Inherits System.Web.UI.Page
    Public LinksCategories


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            
        LinksCategories = RC4.Pull("Select * from RCLinkCat order by Seq")
        
    End Sub
End Class
