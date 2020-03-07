Imports System.Data
Partial Class News
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        
        Dim NewsDataTable As DataTable = RC4.Pull("Select Top 20 * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' order by PubDate desc")
		News.DataSource = NewsDataTable
        News.DataBind()
 
    End Sub
    
    Public Shared Function WordLimit(ByVal str As Object, ByVal intLimit As Integer, Optional ByVal moreUrl As String = "") As String
		Dim strA() As String = str.ToString.Split(" "), strNewString As String = ""
		Dim intLength As Integer = str.ToString.Length
		Dim TChrs As Int32
		Dim i As Int32, intWordCount As Integer = 1

		If strA.Length > intLimit Then

			For i = 0 To intLimit Step +1
				If intWordCount = intLimit Then
					strNewString = Left(str, TChrs)
				End If
				TChrs += strA(i).Length + 1 '(+1 for space)
				intWordCount += 1
			Next
			
			If moreUrl.length > 0 Then
				strNewString =  strNewString & " ... <a href=""" & moreUrl & """ style=""font-weight:600;"">More ></a>"
			Else
				strNewString =  strNewString & " ..."
			End If
			
		Else
			strNewString = str.ToString
		End If

		Return strNewString

	End Function

    
End Class
