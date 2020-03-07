Imports System.Data
Imports System.Data.SqlClient

Partial Class Coverage
    Inherits System.Web.UI.Page
	
	Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
	Dim SZip as String = txtZipSearch.Text
	Dim num6 As Integer
	
	zipcodeModal.Attributes("class") = zipcodeModal.Attributes("class") & " show"
    If Not Integer.TryParse(SZip, num6) Then
		searchLabel.Text = "Please enter a Zip code."
		Exit Sub
		
	Else
		Dim ZipCs As DataTable = RC4.Pull("Select * from ServiceZipCodes Where ZipCode = " & SZip & " ")
		If ZipCs.Rows.Count > 0 then
		searchLabel.Text = "Yes, we service your area!"
		Else
		searchLabel.Text = "Sorry, we do not service your area yet."
		End If
	End If
	End Sub
End Class
