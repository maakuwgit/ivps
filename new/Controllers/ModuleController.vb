Imports System.Data
Public Class ModuleController

	' Holds the property values
	Dim properties As New Dictionary(Of String, Object)
	
	Public Function Value( name as String, Optional val As Object = Nothing) 
    	If val Is Nothing Then
        	If properties.ContainsKey(name) Then
            	return properties(name)
            Else
            	return Nothing
            End If
		Else
			If properties.ContainsKey(name) Then
			 	properties(name) = val
			 Else
			 	properties.Add(name, val)
			 End If
		End If
    End Function

End Class 