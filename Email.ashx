<%@ WebHandler Language="VB" Class="Email" %>

Imports System
Imports System.Data
Imports System.Web
Imports System.Net
Imports System.Net.Mail

'''''''''''''''''''''''''''''''''''''''''''''''''
' TO DO
' Form Checker
' GoogleReCaptcha
'
'''''''''''''''''''''''''''''''''''''''''''''''''
Public Class Email : Implements IHttpHandler
    Dim EmailRegex As String = "^(?("")("".+?""@)|(([0-9a-zA-Z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-zA-Z])@))(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,6}))$"
    Dim Request
    Dim Response
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
    	 Request = ctx.Request
    	 Response = ctx.Response
    	 
    	 If Request.Form("noscript")  Then
		Response.redirect("/contacterror.aspx?e=4")
    		return
    	End If
    	
    	'
    	' If there is no data reject the submission
    	'
	If Request.Form.Count = 0 Then
		Response.redirect("/contacterror.aspx?e=1")
    		return
    	End If
    	
    	'
    	' If The session GUID doesn't match reject the submission
    	'
    	If Not Forms.ValidSessionGuid( Request.Form(Forms.SESSION_GUID) ) Then
    		'Response.write(" Form Session Guid: " & Request.Form(Forms.SESSION_GUID))
    		Response.redirect("/contacterror.aspx?e=2")
    		return
    	End If
    	
    	'
    	' This will check all values for html and reject the submit if any is found. This could be a point of false positives
    	' because there are other values in the collection that have nothing to do with the actual contact form. System data stuff.
    	' If they have any html then the form will be rejected.
    	'
    	For Each key In Request.form.keys
    		If HasSpamContent(Request(key)) Then
    			Response.redirect("/contacterror.aspx?e=3")
    			return
    		End If
    	Next
	
	'
	' If the Comments contain HTML reject submission. I left this here incase the above causes problems. 
	' The front end filters should take care of html in any other field.
	'
    	If HasSpamContent(Request("Comments")) Then
    		Response.redirect("/contacterror.aspx?e=3")
    	End If

	Dim smtp As New SmtpClient 
        	smtp.Host = RC4.ConfigStrings.GetByName("Host").Value
        	smtp.Credentials = New NetworkCredential(RC4.ConfigStrings.GetByName("SMTPAccount").Value, RC4.ConfigStrings.GetByName("SMTPPassword").Value)
        	Dim msg As New MailMessage
        
        
        '
        ' Get the email address list or use the default if none is passed
        '
	Dim MailingListName = GetFormValueFor(Forms.Email.MAILING_LIST, Forms.Email.DEFAULT_MAILING_LIST) 
        	For Each Str As RC4.StringRes In RC4.ConfigStrings
            	If LCase(Str.Name) = LCase(MailingListName)  Then
                		msg.To.Add(Str.Value)
            	End If
        	Next
        
        
        '
        ' Determine the reply to email address. If none present the use default
        '
        Dim ReplyTo = GetFormValueFor("Email", Forms.Email.DEFAULT_NO_REPLY_EMAIL)
        msg.ReplyTo = New MailAddress(ReplyTo)
        
        
        '
        ' Message From
        '
        msg.From = New MailAddress(Forms.Email.DEFAULT_FROM_EMAIL)
        msg.IsBodyHtml = True
        
        
        '
        ' Build the HTML message
        '
        msg.Body &= "<html><head><style type=""text/css"">body{font-family:Arial, Helvetica; font-size:11pt;}</style></head><body><table>"
		msg.Body &="<tr><td colspan=2 style=""padding:10px;font-size:16px;font-weight:bold;background:#eee;color:#666;margin-bottom:15px;""><img src=""/images/logo.png"" style=""width:100%;height:auto;display:block""><br />Form Submission</td></tr>"
        
        For Each Item In Request.Form
        	If  Forms.Email.IncludeInEmail(Item) Then
        		msg.Body &= "<tr><td style=""padding:5px;"">" & GetLabelForValue(item) & ": </td><td style=""padding:5px;"">" & Request(item) & "</td></tr>"
        		Response.Write("<BR>" & Item & ": " & Request(item) & "<br>")
        	end if
		Next
		
		msg.Body &= "</table></body></html>"
		
		
		Dim reslist As StringResList = new StringResList()
		Dim company_name As String = reslist.GetValByName("Company Name")
		
		'
		' Set the subject if available if not use the referral page as the value
		'
		msg.Subject = company_name & " Form Submission - " & GetFormValueFor(Forms.Email.NAME, Request.ServerVariables("HTTP_REFERER") )
        smtp.Send(msg)
        
        
        '
        ' Redirect to a page. Home Page is default. Could make it the referral page.
        '
        If GetRedirectUrl().length > 0 Then
        	Response.Redirect(GetRedirectUrl())
        End If
        
    End Sub
    
    '
    ' Returns the value of a form item and if it's base64 encoded, decodes it
    '
    Public Function GetFormValueFor(ByVal Item As String, Optional ByVal DefaultValue As String = "")
    	If Request(Item) <> "" Then
    		If Forms.StringIsBase64(Request(Item)) Then
    			return Forms.StringFromBase64(Request(Item))
    		Else
    			Return Request(Item)
    		End If
    	End If
    	Return DefaultValue
    End Function
    
    '
    '  Returns a Pretty string for a forms name to be used in the email
    '
    Public Function GetLabelForValue(item as String)
    	return GetFormValueFor(Forms.Email.LABEL_PREFIX & item, item)
    End Function
    
    '
    ' Returns a the redirect url if present. If not present it redirects to home page.
    ' Maybe redirect back to page
    '
    Public Function GetRedirectUrl()
    	return GetFormValueFor(Forms.Email.LANDING_PAGE, Request.ServerVariables("HTTP_REFERER") )
    End Function

		' Don't know what this is used for.
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
    
End Class