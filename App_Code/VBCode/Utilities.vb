Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing.Drawing2D
Imports System.Drawing
Imports System.Web.Script.Serialization

Public Module Utilities
 
	Function LoadWidgetAsync(url, element)
		Dim Request = HttpContext.Current.Request
		Dim Response = HttpContext.Current.Response
		Response.Write("<script>$('" & element & "').load('" & Request.Url.Scheme & "://" & Request.Url.Host  & "/" & url & "');</script>")
	End Function
	
	Function json_decode(data)
		Dim serializer As New JavaScriptSerializer()
		return serializer.Deserialize(Of Dictionary(Of String, Object))(data)
	End Function

	Function json_encode(data)
		Dim serializer As New JavaScriptSerializer()
		return serializer.Serialize(data)
	End Function
	
	Public Function getCopyrightStatement()
		Dim reslist As StringResList = new StringResList()
		Dim str As String = reslist.GetValByName("copyright")
		return ReplaceCompanyNamePlaceholder(Replace(str, "{Today.Year}", Today.Year, CompareMethod.Text))
	End Function
	
	Public Function GetCookieValue(cookieName)
    If Not HttpContext.Current.Request.Cookies(cookieName) Is Nothing Then
         return HttpContext.Current.Request.Cookies(cookieName).value
    Else    
        return Nothing
    End If
  End Function
	
	Public Function ReplaceCompanyNamePlaceholder(str as String)
		Dim reslist As StringResList = new StringResList()
		Dim company_name As String = reslist.GetValByName("Company Name")
		return Replace(str, "{Company Name}", company_name, CompareMethod.Text)
	End Function
	
	Public Function ReplaceSiteUrlPlaceholder(str as String)
		Dim reslist As StringResList = new StringResList()
		Dim company_name As String = reslist.GetValByName("Site Url")
		return Replace(str, "{Site Url}", company_name, CompareMethod.Text)
	End Function
	
	Public Function getUrlPartsFromQueryString(request As System.Web.HttpRequest)
		Dim variables as string = System.Web.HttpUtility.UrlDecode(request.QueryString.toString())
		return variables.Split("/")
	End Function
	
	Public Function getIdFromPrettyUrl(request As System.Web.HttpRequest)
		If request("Id") > 0 Then
			return Request("Id")
		Else
			return getUrlPartsFromQueryString(request)(1)
		End If
	End Function
	
	' This returns the query string value of the location value's query string.
	Public Function RouterGetValueFromQueryStringForKey(Name As String)
		Dim value = HttpContext.Current.Request.querystring(Name)
    	Dim parts = value.split("?")
    	return parts(0)
	End Function
	
	Public Function routerGetUrlPart(request As System.Web.HttpRequest, index As Integer)
		return getUrlPartsFromQueryString(request)(index)
	End Function
	
	Public Function FilterSEORawUrl(rawurl As String)
    	If rawurl.Trim().StartsWith("/images") Or _
    		rawurl.Trim().StartsWith("/admin") Or _
    		rawurl.Trim().StartsWith("/css") Or _
    		rawurl.Trim().StartsWith("/js") Or _
    		rawurl.Trim().EndsWith(".ico") Or _
    		rawurl.Trim().EndsWith(".js") Or _
    		rawurl.Trim().EndsWith(".png") Or _
    		rawurl.Trim().EndsWith(".gif") Or _
    		rawurl.Trim().EndsWith(".jpg") Or _
    		rawurl.Trim().EndsWith(".jpeg") _
    	Then
    		return ""
    	End If
    	return rawurl
    End Function
    
    Public Function addUrlToSEOTable(rawurl As String) 
    	return FilterSEORawUrl(rawurl).length > 0
    End Function
     
    Public Function ToBase64String(stringToBase64Encode As String)
    	return Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(stringToBase64Encode )) 
    End Function
    
    Public Function FromBase64String(base64EncodedString As String)
    	return ASCIIEncoding.ASCII.GetString(Convert.FromBase64String(base64EncodedString))
    End Function
    
    public Function IsBase64String(Str As String)
    	If (Str.Length Mod 4) = 0 And Regex.IsMatch(Str, "^[a-zA-Z0-9\+/]*={0,3}$", RegexOptions.None) Then
    		return True
    	End If
    		return False
	End Function 

	Public Function nl2br(ByVal str As String, Optional prefix as String = "")
		Dim htmlBreakElement As String = "<br />" & prefix
		return  prefix & str.Replace(vbCrLf, htmlBreakElement).Replace(vbLf, htmlBreakElement).Replace(vbCr, htmlBreakElement) .Replace(Environment.NewLine, htmlBreakElement)
	End Function
	
	Public Function nl2ul(ByVal str As String)
		Dim htmlBreakElement As String = "</li><li>"
		Dim ul = "<ul>"
		ul  +=  "<li>" & str.Replace(vbCrLf, htmlBreakElement).Replace(vbLf, htmlBreakElement).Replace(vbCr, htmlBreakElement) .Replace(Environment.NewLine, htmlBreakElement)
		ul += "</li></ul>"
		return ul
	End Function
	
	Public Function ReplaceAlphanumericCharacters(text As String)
		' Remove all leading and trailing spaces
		text = text.Trim()
		' Replace all double spaces with single space
		text = Regex.Replace(text, " {2,}", " ")
		' Remove other char
		text = Regex.Replace(text.ToLower(), "[!?&]", "")
		' Replace all non Alphanumeric Characters with "-"
		return Regex.Replace(text, "[^a-zA-Z0-9]", "-")
	End Function
	
	Public Function RemoveHTML(ByVal text As Object)
		return Regex.Replace(text.ToString, "<.*?>", "")
	End Function
	
	Public Function HasHTML(ByVal text As Object)
		If Not text Is Nothing Then
			return Regex.IsMatch(text.ToString, "<.*?>")
		Else
			return false
		End If
	End Function
	
	Public Function HasSpamContent(ByVal text As Object)
		If Not text Is Nothing Then
			return Regex.IsMatch(text.ToString, "<.*?>|\[.*?]|http:|https:|www\.")
		Else
			return false
		End If
	End Function
	
	Public Function TruncateStringMiddle(ByVal str As String, ByVal numOfChar As Integer)
		If numOfChar < str.length Then
			Dim halfNumOfChar = numOfChar/2
			return Left(str, halfNumOfChar).Trim() & "..." & Right(str, halfNumOfChar).Trim()
		Else
			return str
		End If
	End Function
	
	Public Function TruncateString(ByVal text As Object, Optional textMaxWidth As Integer = 0) As String
		If textMaxWidth > 0 And text.ToString.Length > textMaxWidth Then
			return Left(text.ToString, textMaxWidth) & "..."
		Else
			return text.ToString
		End If
	End Function
	
	Public Function TruncateStringAndRemoveHTML(ByVal text As Object, Optional textMaxWidth As Integer = 0) As String
		If textMaxWidth > 0 And text.ToString.Length > textMaxWidth Then
			return Regex.Replace(Left(text.ToString, textMaxWidth) & "...", "<.*?>", "")
		Else
			return Regex.Replace(text.ToString, "<.*?>", "")
		End If
	End Function
	
	Public Function WordLimit(ByVal str As Object, ByVal intLimit As Integer, Optional ByVal moreUrl As String = "") As String

		If intLimit = False Then
			return str
		End If
		
		Dim strA() As String = str.ToString.Split(" ")
		Dim strNewString As String = ""
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
	
	Public Function WordLimitContainer(ByVal str As Object, ByVal intLimit As Integer, ByVal uniqueid As String, Optional ByVal moreUrlLabel As String = "&#8595; Show More", Optional ByVal lessUrlLabel As String = "&#8593; Show Less" ) As String

		Dim strA() As String = str.ToString.Split(" ")
		Dim strNewString As String = ""
		Dim  strRemaingString As String = ""
		Dim intLength As Integer = str.ToString.Length
		Dim TChrs As Int32
		Dim i As Int32, intWordCount As Integer = 1

		If strA.Length > intLimit Then

			For i = 0 To intLimit Step +1
				If intWordCount = intLimit Then
					strNewString = Left(str, TChrs)
				Else
					TChrs += strA(i).Length + 1 '(+1 for space) 
				End If
				intWordCount += 1
			Next
			
			strRemaingString = Right(str, str.length - strNewString.length)
			
			strNewString =  "<div class=""word-limit-container""><span>" & strNewString & "</span>"

			strNewString =  strNewString & "<span class=""elipse elipse-"& uniqueid &""" > ... </span>"
			strNewString =  strNewString & "<span class=""overflow hide overflow-"& uniqueid &""">" & strRemaingString & "</span>"
			strNewString =  strNewString & "<div class=""my-2""><a  href="""" onclick=""document.querySelector('.overflow-"& uniqueid &"').classList.toggle('hide');document.querySelector('.elipse-"& uniqueid &"').classList.toggle('hide');document.querySelector('.moreUrlLabel-"& uniqueid &"').classList.toggle('hide');document.querySelector('.lessUrlLabel-"& uniqueid &"').classList.toggle('hide');return false;""><span class=""show-more moreUrlLabel-"& uniqueid &""">" & moreUrlLabel & "</span><span class=""show-less hide lessUrlLabel-"& uniqueid &""">" & lessUrlLabel & "</span></a></div>"
			strNewString = strNewString & "<style>.hide{display:none;}</style>"
			
			strNewString = strNewString & "</div>"
			
		Else
			strNewString = str.ToString
		End If

		Return strNewString

	End Function
	
	Public Function CreateSlug(ByVal Title As String, Optional addNumber As Boolean = true) As String
		 Dim Slug As String = Title.ToLower()
		 ' Replace characters specific fo croatian language
		 ' You don't need this part for english language
		 ' Also, you can replace other characters specific for other languages
		 ' e.g. é to e for French language etc. 
		 Slug = Slug.Replace("č", "c")
		 Slug = Slug.Replace("ć", "c")
		 Slug = Slug.Replace("š", "s")
		 Slug = Slug.Replace("ž", "z")
		 Slug = Slug.Replace("đ", "dj")
 
		 ' Replace - with empty space
		 Slug = Slug.Replace("-", " ")
 
		 ' Replace unwanted characters with space
		 Slug = Regex.Replace(Slug, "[^a-z0-9\s-]", " ")
		 ' Replace multple white spaces with single space
		 Slug = Regex.Replace(Slug, "\s+", " ").Trim()
		 ' Replace white space with -
		 Slug = Slug.Replace(" ", "-")
		 
		 Dim number As Integer
         Randomize()
         ' The program will generate a number from 0 to 50
         number = Int(Rnd() * 999) + 1
  
         If addNumber Then
         		Slug = Slug & "-" & number
         End If
 
		 Return Slug
	End Function

End Module