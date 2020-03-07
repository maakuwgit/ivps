Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class Docs
    Inherits System.Web.UI.Page


                            
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


Protected Function getDocumentIcon(ByVal file As String) As String
	Dim extension As String = Path.GetExtension(file)
	getDocumentIcon = "/images/docs/icons/" & extension.Remove(0,1) & ".png"
End Function

End Class