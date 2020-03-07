
Partial Class Error404
    Inherits System.Web.UI.Page
    
     Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
	LogSiteError(true, 404)
    End Sub
    
    Private Sub LogSiteError(IsProduction As Boolean, errorNumber As Integer)
    	if isProduction Then
		Dim SQLBuilder = new MSSQLBuilder("WMASiteErrorLog")
		SQLBuilder.where("raw_url = '" & Request.RawUrl & "'")
		Dim result = SQLBuilder.SelectAll()
		If result.rows.count = 0 Then
			SQLBuilder.ParseHttpRequest(Request.ServerVariables)
			SQLBuilder.SetValueFor("raw_url", Request.RawUrl )
			SQLBuilder.SetValueFor("response_status_code", errorNumber)
			SQLBuilder.SetValueFor("requests", 1)
			SQLBuilder.Save()
		Else	
			SQLBuilder.Reset()
			SQLBuilder.SetValueFor("id", result.rows(0)("id"))
			SQLBuilder.SetValueFor("response_status_code", errorNumber)
			SQLBuilder.SetValueFor("requests", (result.rows(0)("requests") + 1))
			SQLBuilder.Save()
		End If
    	End If
    End Sub

End Class
