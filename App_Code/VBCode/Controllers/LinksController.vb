Imports System.Data

Public Class LinksController
	Inherits ModuleController
	
	Public Function getMainMenuItems() As DataTable
		return RC4.Pull("SELECT * FROM WMAMenuLinks WHERE menuid = 1 ORDER BY [order] Asc")
	End Function
	
	Public Function getFooterMenuItems() As DataTable
		return RC4.Pull("SELECT * FROM WMAMenuLinks WHERE menuid = 2 ORDER BY [order] Asc")
	End Function
    
End Class 
