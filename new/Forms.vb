Imports System.Data
Imports System.Web
Imports System.Data.SqlClient
Imports System.Drawing.Drawing2D
Imports System.Drawing
Imports System.IO

Public Module Forms

	Private _Email = new Email()
	Private _LandingPage = new LandingPage()
	Private _EventTracking = new EventTracking()
	
	Public Function Email
		return _Email
	End Function
	
	Public Function LandingPage
		return _LandingPage
	End Function
	
	Public Function EventTracking
		return _EventTracking
	End Function
	
	Public Function StringToBase64(stringToBase64Encode as String)
		return Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(stringToBase64Encode )) 
	End Function
	
	Public Function StringFromBase64(base64EncodedString as String)
		return ASCIIEncoding.ASCII.GetString(Convert.FromBase64String(base64EncodedString))
	End Function
	
	Public Function StringIsBase64(Str as String)
		If (Str.Length Mod 4) = 0 And Regex.IsMatch(Str, "^[a-zA-Z0-9\+/]*={0,3}$", RegexOptions.None) Then
    		return True
    	End If
    		return False
	End Function
	
	Public Function AddFormChecker()
		System.Web.HttpContext.Current.Response.Write("<script>")
		System.Web.HttpContext.Current.Response.WriteFile ("/js/form-checker.js")
		System.Web.HttpContext.Current.Response.Write("</script>")
	End Function

End Module


Public Class Email
	Public  Const DATA_PREFIX As String = "d_"
	Public  Const LABEL_PREFIX As String = "l_"
	Public  Const LANDING_PAGE As String = DATA_PREFIX & "lp"
	Public  Const NAME As String = DATA_PREFIX & "fn"
	Public  Const MAILING_LIST As String = DATA_PREFIX & "fml"
	Public  Const DEFAULT_MAILING_LIST As String = "gencontact"
	Public  Const DEFAULT_NO_REPLY_EMAIL As String = "NoReply@real-fast.com"
	Public  Const DEFAULT_FROM_EMAIL As String = "WebContact@real-fast.com"
	
	Private _MailingList = DEFAULT_MAILING_LIST
	Private _FormName = ""

	 Public Property MailingList() As String
        Get
            Return _MailingList
        End Get
        Set(ByVal value As String)
            _MailingList = value
        End Set
    End Property
    
    Public Property FormName() As String
        Get
            Return _FormName
        End Get
        Set(ByVal value As String)
            _FormName = value
        End Set
    End Property
    
	Public Function IncludeInEmail(Item As String)
		If Not Item.ToLower().StartsWith(DATA_PREFIX)  And Not _ 
		Item.ToLower().StartsWith(LABEL_PREFIX) And Not _ 
		Item.ToLower().StartsWith("g-recaptcha") Then
			return True
		End If
			return false
	End Function

End Class

Public Class LandingPage

	Public  Const PREFIX As String = "lp"
	Public  Const CONTENT_ID_KEY As String = PREFIX & "ci"
	Public  Const TITLE_KEY As String = PREFIX & "t"
	
	' The landing page url. By default use the defined in the admin Links area named "Thank You Page"
	Private _Url = WebSite.Link("Thank You Page").Url()
	'
	' The following are used to build the thank you page url and can be set before including the widget in a page
	'		EXAMPLE:
	'		<%
	'			' Assign the copy to be displayed on the thank you page
	'			Forms.LandingPage.ContentId = 13
	'		%>
	'
	' Additional values to be added to the end of the landing page query string
	Private _UrlQueryString = ""
	' Define the content to be displayed on the thank you page. This value pull from the content editor in the admin
	Private _ContentId = GetResourceFor("CFTPCI")
	Private _Title = "Thank You"
	
    Public Property ContentId() As String
        Get
            Return _ContentId
        End Get
        Set(ByVal value As String)
            _ContentId = value
        End Set
    End Property
    
    Public Property Title() As String
        Get
            Return _Title
        End Get
        Set(ByVal value As String)
            _Title = value
        End Set
    End Property
    
     Public Property Url() As String
        Get
            Return _Url
        End Get
        Set(ByVal value As String)
            _Url = value
        End Set
    End Property
    
    Public Property UrlQueryString() As String
        Get
            Return _UrlQueryString
        End Get
        Set(ByVal value As String)
            _UrlQueryString = value
        End Set
    End Property

	Public Function BuildUrl()
		Dim ETracking = Forms.EventTracking
		
		Dim url = _Url & "?" & _
		CONTENT_ID_KEY & "=" & _ContentId & _ 
		"&" & TITLE_KEY & "=" & _Title & _ 
		"&" & ETracking.EVENT_TRACKING_ACTION_KEY & "=" & ETracking.Action & _ 
		"&" & ETracking.EVENT_TRACKING_LABEL_KEY  & "=" & ETracking.Label & _ 
		"&" & ETracking.EVENT_TRACKING_VALUE_KEY  & "=" & ETracking.Value
		
		If  _UrlQueryString.toString().length > 0 Then
			url += "&" & _UrlQueryString
		End If
		
		return url
	End Function
	
End Class

Public Class EventTracking
	'ga('send', 'event', 'Home Phone Click', 'Call Tracking');
	
	Public  Const PREFIX As String = "lp"
	Public  Const EVENT_TRACKING_ACTION_KEY As String = PREFIX & "a"
	Public  Const EVENT_TRACKING_LABEL_KEY As String = PREFIX & "l"
	Public  Const EVENT_TRACKING_VALUE_KEY As String = PREFIX & "v"

	Private _Action = "Form Submitted"
	Private _Label = ""
	Private _Value = ""
	
	Public Property Action() As String
        Get
            Return _Action
        End Get
        Set(ByVal value As String)
            _Action = value
        End Set
    End Property
    
    Public Property Label() As String
        Get
            Return _Label
        End Get
        Set(ByVal value As String)
            _Label = value
        End Set
    End Property
    
    Public Property Value() As String
        Get
            Return _Value
        End Get
        Set(ByVal value As String)
            _Value = value
        End Set
    End Property
    
End Class

