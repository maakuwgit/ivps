Imports System.Data

Public Class BiosController
	Inherits ModuleController
	
	Public Sub New()
	End Sub

	Public Function Top(num as Integer) As DataTable
		return RC4.Pull("SELECT TOP " & num & " * FROM RCBio ORDER by Seq asc")
    End Function
    
    Public Function All() As DataTable
		return RC4.Pull("SELECT * FROM RCBio ORDER by Seq asc")
    End Function

End Class 