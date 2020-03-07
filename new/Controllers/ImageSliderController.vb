Imports System.Data

Public Class ImageSliderController
	Inherits ModuleController
	
	 Public Function All() As DataTable
			return RC4.Pull("SELECT * FROM WMASlider WHERE Published = 1 ORDER BY Seq Asc")
    End Function
    
End Class 