Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient

Partial Class Videos
    Inherits System.Web.UI.Page
    	
    	Public Videos

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
		Dim dtc As DataTable
		Dim dt As DataTable
        dtc = RC4.Pull("Select * from RCVideoCat Order by Id desc")
		dt = RC4.Pull("Select * from RCVideo Order by seq asc, Id asc")
		
		Videos = dt

    End Sub
    
End Class
