Imports System.Data
Imports System.Data.SqlClient


Partial Class Promotions
    Inherits System.Web.UI.Page




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Dim dt As DataTable = RC4.Pull("Select * from RCPromo where startdt <= '" & Today.Date.ToShortDateString & "' and EndDT >= '" & Today.Date.ToShortDateString & "'")
            Dim s As String = ""
			If dt.Rows.Count = 0 Then 
			s = "No Current Promotions Available. <br />Please check back later."
			End If
			
            For Each dr As DataRow In dt.Rows
                s &= "<div class=""col-md-6"">"

                If Not My.Computer.FileSystem.FileExists(MapPath("/images/promo/p" & dr.Item("Id") & ".jpg")) Then
                    s &= "<div style=""width:0px; height:0px;""></div>"
                Else
                    's &= "<div style=""cursor:pointer; margin-right:10px; float:left; width:200px; background-repeat:no-repeat; background-position: center top; min-height:120px; background-image:url('/images/promo/" & dr.Item("Id") & ".jpg');"" onclick=""window.open('" & dr.Item("url") & "')"" ></div>"

                    s &= "<a target=""_blank"" href=""/images/promo/" & dr.Item("Id") & ".pdf""><img src='/images/promo/p" & dr.Item("Id") & ".jpg' class=""img-responsive"" style=""cursor:pointer;"" /></a>"

                End If
                s &= "<div class=""clear""></div>"
                s &= "<h4 class=""padboth"">" & dr.Item("Name") & "</h4>"

                s &= "<p class=""inline padh""><strong>Offer valid thru:</strong> " & dr.Item("EndDt") & "&nbsp;</p>"
                s &= "<p class=""padh"">" & dr.Item("Desc").ToString().Replace(vbCrLf, "<br />") & "</p>"
                s &= "<br/>"
                If My.Computer.FileSystem.FileExists(MapPath("/images/promo/" & dr.Item("Id") & ".pdf")) Then

                    s &= "<p><a class=""button lightyellowbg blue"" target=""_blank"" href=""/images/promo/" & dr.Item("Id") & ".pdf"">Download Promo PDF</a></p>"

                End If

                s &= "</div>"
            Next
            dvPromo.InnerHtml = s
        End If
    End Sub

    

End Class
