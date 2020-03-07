Imports System.Data
Imports System.IO

Public Class DocumentsController
	Inherits ModuleController
	
	Public CATEGORY_ID = "CategoryId"
	
	Public Sub New()
		Me.Value(CATEGORY_ID, False)
	End Sub
    
    	Public Function All() As DataTable
		return RC4.Pull("SELECT * FROM RCDoc ORDER by Seq asc")
    	End Function
    	
    	Public Function Categories() As DataTable
    		return RC4.Pull("SELECT * FROM RCDocCat Where bPublic = 1 Order by Seq")
    	End Function
    	
    	Public Function CategoryDocuments() As DataTable
    		return RC4.Pull("Select * from RCDoc Where CatId = " &  CategoryId & " Order by Seq")
    	End Function
    	
    	Public Function DocumentIcon(ByVal file As String) As String
		Dim extension As String = Path.GetExtension(file)
		return "/images/docs/icons/" & extension.Remove(0,1) & ".png"
	End Function
    	
    	Public Property CategoryId As Integer
	        Get
		  Return Me.Value(CATEGORY_ID)
	        End Get
	        Set(ByVal value As Integer)
		  Me.Value(CATEGORY_ID, value)
	        End Set
	End Property

End Class 