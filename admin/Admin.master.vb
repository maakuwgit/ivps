
Partial Class Admin
    Inherits System.Web.UI.MasterPage

    Protected Sub lnkLogOut_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkLogOut.Click
        Session.Abandon()
        Session("User") = Nothing
        Response.Redirect("/Admin/Login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("User") Is Nothing Then 
        	Response.Redirect("/Admin/Login.aspx")
        Else
        	 Session.Timeout = 120
        End If
    End Sub
End Class