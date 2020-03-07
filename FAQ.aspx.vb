Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Net

Partial Class FAQ
    Inherits System.Web.UI.Page
	Public FAQCategories
	
        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
        	FAQCategories = RC4.Pull("Select * from RCFAQCat order by seq")
        End If
    End Sub
    
    Function GetFaqsForCat(id)
    		Dim FAQDataTable As DataTable = RC4.Pull("Select * from RCFAQ Where catid = " & id & " order by seq")
    		return FAQDataTable
    End Function



End Class
