Imports System.Data
Imports System.Web
Imports System.Data.SqlClient
Imports System.Drawing.Drawing2D
Imports System.Drawing
Imports System.IO


Public Module ReviewsWidget
	Public Function TopRandom(num as Integer)
		return RC4.Pull("Select Top " & num & " * FROM RCTestimonials WHERE isApproved = 1 ORDER BY NEWID()")
	End Function
End Module

Public Module TableMapper
	Public Function Map(Id As String)
		Dim dt = RC4.Pull("Select * from WMATableMapper where name = '" & Id & "'")
		If dt.Rows.Count > 0 Then 
			return dt.Rows(0)("Table").ToString()
		Else
			Throw New System.Exception("Table Mapper: Could not find the corresponding table for the given Id.")
		End If
	End Function
End Module

Public Module WebSite
	
	Public Function Link(id As String)
		return new Link(id)
	End Function
	
	Public Function Image(id As String)
		return new Image(id)
	End Function
	
	Public Function Router()
		return new Router()
	End Function
	
	Public Function Company()
		return new CompanyInfo()
	End Function
	
	Public Function Content()
		return new Content()
	End Function
	
	Public Function Label(id)
		return new SiteLabel(id)
	End Function

	Public Function GEOCode(Optional address As String = Nothing )
		return new GEOCode(address)
	End Function
	
	Public Function Browser()
		return new BrowserInfo()
	End Function

End Module

Class BrowserInfo
	Function IsMobileDevice()
		Dim myBrowserCaps As System.Web.HttpBrowserCapabilities = HttpContext.Current.Request.Browser
		return (CType(myBrowserCaps, System.Web.Configuration.HttpCapabilitiesBase)).IsMobileDevice 
	End Function
End Class

Public Class GEOCode 
	Inherits ModuleController
	
	Protected xmlDoc
	
	Public Sub New(address)
	    SetAddress(address)
	End Sub
	 
	Public Function SetAddress(address)
		If Not address Is Nothing Then
			Dim webClient As New System.Net.WebClient
	    		Dim result As String = webClient.DownloadString("https://maps.googleapis.com/maps/api/geocode/xml?address=" & address & "&key=" & GetResourceFor("geocode_api_key") & "&sensor=false")
			xmlDoc = New System.Xml.XmlDocument()
			xmlDoc.LoadXml(result)
		End If
	End FUnction
	
	Public Function GetLat()
		If Not ZeroResults() Then
			return xmlDoc.SelectSingleNode("/GeocodeResponse/result/geometry/location/lat").InnerText
		Else
			return nothing
		End If
	End Function
	
	Public Function GetLng()
		If Not ZeroResults() Then
			return xmlDoc.SelectSingleNode("/GeocodeResponse/result/geometry/location/lng").InnerText
		Else
			return nothing
		End If
	End Function
	
	Public Function Ok()
		return xmlDoc.SelectSingleNode("/GeocodeResponse/status").InnerText = "OK"
	End Function
	
	Public Function ZeroResults()
		return xmlDoc.SelectSingleNode("/GeocodeResponse/status").InnerText = "ZERO_RESULTS"
	End Function

End Class

Interface ContentReplacer
	Function FindAndReplace(content)
End Interface

Class ContactInfoTagReplacer : Implements ContentReplacer
	Function FindAndReplace(content) Implements ContentReplacer.FindAndReplace
		Dim Info = ""
		Dim ci = New CompanyInfo()
		Dim cc = New CompanyContact()
		Info &= "<div class=""font-weight-bold font-size-6"">" & ci.Name() & "</div>"
		Info &= "<div>" & cc.Address() & "</div>"
		Info &= "<div class=""mb-2"">" & cc.CityStateZip() & "</div>"
		Info &= "<div><b>Phone:</b> " & cc.Phone() & "</div>"
		Info &= "<div><b>New Patient Phone:</b> " & cc.Other("New Patient") & "</div>"
		Info &= "<div><b>Existing Patient Phone:</b> " & cc.Other("Exsisting Patient")  & "</div>"
		return content.replace("[contact_info]", Info)
	End Function
End Class

Class ContentTagReplacer : Implements ContentReplacer
	Function FindAndReplace(content) Implements ContentReplacer.FindAndReplace
		Dim pattern = "\[content.*?\]"
		Dim TheRegex As Regex = New Regex(pattern)
		Dim TheMatchEvaluator As MatchEvaluator = New MatchEvaluator(AddressOf TheEvaluator)
		return TheRegex.Replace(content, TheMatchEvaluator)
	End Function
	
	Function TheEvaluator(ByVal m As Match)
			Dim parts = m.value.Substring(1,m.length - 2 ).Split(" ")
         		Dim replacement = Website.Content.GetForId(parts(1))
         		return replacement
	End Function
End Class

Class LinkTagReplacer : Implements ContentReplacer
	Function FindAndReplace(content) Implements ContentReplacer.FindAndReplace
		Dim pattern = "\[link.*?\]"
		Dim TheRegex As Regex = New Regex(pattern)
		Dim TheMatchEvaluator As MatchEvaluator = New MatchEvaluator(AddressOf TheEvaluator)
		return TheRegex.Replace(content, TheMatchEvaluator)
	End Function
	
	Function TheEvaluator(ByVal m As Match)
			Dim parts = m.value.Substring(1,m.length - 2 ).Split(" ")
         		Dim replacement = Website.Link(parts(1)).CreateElement()
         		return replacement
	End Function
	
End Class

Class IncludeFileTagReplacer : Implements ContentReplacer
	Function FindAndReplace(content) Implements ContentReplacer.FindAndReplace
		Dim pattern = "\<!-- #Include file=.*?\-->"
		Dim TheRegex As Regex = New Regex(pattern)
		Dim TheMatchEvaluator As MatchEvaluator = New MatchEvaluator(AddressOf TheEvaluator)
		return TheRegex.Replace(content, TheMatchEvaluator)
	End Function
	
	Function TheEvaluator(ByVal m As Match)
		Dim parts = m.value.Substring(1,m.length - 4).Split("=")
		Dim sw = new StringWriter()
		Try
			HttpContext.Current.Server.Execute(parts(1).Replace("""", ""), sw)
		Catch ex As Exception
			'Do Nothing
		End Try
         	return sw.ToString()
	End Function
End Class

Class WidgetTagReplacer : Implements ContentReplacer
	Function FindAndReplace(content) Implements ContentReplacer.FindAndReplace
		Dim pattern = "\[page_widget.*?\]"
		Dim TheRegex As Regex = New Regex(pattern)
		Dim TheMatchEvaluator As MatchEvaluator = New MatchEvaluator(AddressOf TheEvaluator)
		return TheRegex.Replace(content, TheMatchEvaluator)
	End Function
	
	Function TheEvaluator(ByVal m As Match)
		Dim parts = m.value.Substring(1,m.length - 2 ).Split(" ")
		Dim sw = new StringWriter()
		Try
			HttpContext.Current.Server.Execute("/PageWidgets/" & parts(1).Replace("""", "") & ".aspx" , sw)
		Catch ex As Exception
			'Do Nothing
		End Try
         	return sw.ToString()
	End Function
End Class

Class FormTagReplacer : Implements ContentReplacer
	Function FindAndReplace(content) Implements ContentReplacer.FindAndReplace
		Dim pattern = "\[form.*?\]"
		Dim TheRegex As Regex = New Regex(pattern)
		Dim TheMatchEvaluator As MatchEvaluator = New MatchEvaluator(AddressOf TheEvaluator)
		return TheRegex.Replace(content, TheMatchEvaluator)
	End Function
	
	Function TheEvaluator(ByVal m As Match)
		Dim parts = m.value.Substring(1,m.length - 2 ).Split(" ")
		'This is where we can add a form that is create in the admin, once we have that capability
		Dim sw = new StringWriter()
		Dim identity = parts(1).ToLower()
		Select Case identity
			Case "contact"
				Try
					HttpContext.Current.Server.Execute("/PageWidgets/ContactWidget.aspx" , sw)
				Catch ex As Exception
					'Do Nothing
				End Try
			Case Else
		End Select
         	return sw.ToString()
	End Function
End Class

Class CompanyInfoTagReplacer : Implements ContentReplacer
	Function FindAndReplace(content) Implements ContentReplacer.FindAndReplace
		Dim reslist As StringResList = new StringResList()
		Dim company_name As String = reslist.GetValByName("Company Name")
		content = content.replace("{Company Name}", company_name)
		Dim site_url As String = reslist.GetValByName("Site Url")
		content = content.replace("{Site Url}", site_url)
		return content
	End Function
End Class

Public Class Content

	public ReplacerList As List(Of Object)
	
	Sub New()
		ReplacerList = new List(Of Object)
		ReplacerList.Add(new ContactInfoTagReplacer())
		ReplacerList.Add(new ContentTagReplacer())
		ReplacerList.Add(new CompanyInfoTagReplacer())
		ReplacerList.Add(new LinkTagReplacer())
		ReplacerList.Add(new WidgetTagReplacer())
		ReplacerList.Add(new FormTagReplacer())
		ReplacerList.Add(new IncludeFileTagReplacer())
	End Sub
	
	Public Function GetNameForId(id)
		return GetContentName(id)
	End Function
	
	Public Function GetForId(id)
		return GetFor(id)
	End Function
	
	Public Function GetFor(id)
		Dim intId
		If Integer.TryParse(id, intId) Then
			return _content(RC4.Pull("SELECT * FROM RCContent WHERE id = " & id))
		Else
			return _content(RC4.Pull("SELECT * FROM RCContent WHERE name = '" & id & "'"))
		End If
	End Function
	
	Public Function StripHTML(text)
		return Regex.Replace(text.ToString, "<.*?>", "")
	End Function
	
	Public Function GetForIdStripHTML(id)
		return Regex.Replace(GetFor(id).ToString, "<.*?>", "")
	End Function
	
	Public Function GetForStripHTML(id)
		return Regex.Replace(GetFor(id).ToString, "<.*?>", "")
	End Function
	
	Public Function GetTitleOfPage(id)
		If Not id Is Nothing Then
			return _title(RC4.Pull("SELECT * FROM RCContent WHERE PageId = " & id))
		Else
			return ""
		End If
	End Function
	
	Public Function GetSubTitleOfPage(id)
		If Not id Is Nothing Then
			return _subtitle(RC4.Pull("SELECT * FROM RCContent WHERE PageId = " & id))
		Else
			return ""
		End If
	End Function
	
	Public Function GetForPage(id)
		If Not id Is Nothing Then
			return _content(RC4.Pull("SELECT * FROM RCContent WHERE PageId = " & id))
		Else
			return ""
		End If
	End Function
	
	Public Function GetForUrl(id)
		return GetForPage(id)
	End Function
	
	Protected Function _content(dt)
		If dt.rows.count = 1 Then
			Dim content = dt.rows(0)("value")
			For each Replacer in ReplacerList
				content = Replacer.FindAndReplace(content)
			next
			return content
		Else
			return ""
		End If
	End Function
	
	protected Function _title(dt)
		If dt.rows.count = 1 Then
			Dim title = dt.rows(0)("title")
			return title
		Else
			return ""
		End If
	End Function
	
	protected Function _subtitle(dt)
		If dt.rows.count = 1 Then
			Dim title = dt.rows(0)("subtitle")
			return title
		Else
			return ""
		End If
	End Function
	
	Public Function RunThroughTagReplacer(txt)
		Dim content = txt
		For each Replacer in ReplacerList
			content = Replacer.FindAndReplace(content)
		next
		return content
	End Function
	
End Class

Public Class SiteLabel
	protected _value
	Sub New(id as String)
		id = id
		Dim dt
		Dim intId
		If Integer.TryParse(id, intId) Then
			dt = RC4.Pull("Select * from WMALabel where id = " & intId)
		Else
			dt = RC4.Pull("Select * from WMALinks Top 1 where description = '" & id & "'")
		End If
		If dt.rows.count > 0 Then
			_value = dt.rows(0)("Label")
		Else
			_value = "Missing Label: " & id
		End If
	End Sub
	Public Function Value
		return _value
	End Function
End Class

Public Class Router
	
	protected request As System.Web.HttpRequest
	
	Sub New()
		request = HttpContext.Current.Request
	End Sub
	
	Public Function IsHome()
		return HttpContext.Current.Request.RawUrl = "/" Or HttpContext.Current.Request.RawUrl.ToLower.StartsWith("/default") Or HttpContext.Current.Request.RawUrl.ToLower.StartsWith("/index")
	End Function

	Public Function getUrlPartsFromQueryString()
		Dim variables as string = System.Web.HttpUtility.UrlDecode(request.QueryString.toString())
		Dim p = variables.Split("?")
		return p(p.length-1).split("/")
	End Function 
	
	Public Function UrlPart(part As Integer)
		return getUrlPartsFromQueryString()(part)
	End Function
	
	Public Function UrlPartReverse(part As Integer)
		Dim p = getUrlPartsFromQueryString()
		Array.Reverse(p, 0, p.length)
		return p(part)
	End Function
	
	Public Function getUrlPart(location As Integer)
		return getUrlPartsFromQueryString()(location)
	End Function
	
	Public Function getQueryStringValue(key As String)
		return queryString(key)
	End Function
	
	Public Function queryString(key As String)
		Dim value = request.querystring(key)
		If value Is Nothing OrElse value.ToString.Length = 0 Then
			return Nothing
		End If
    		Dim parts = value.split("?")
    		if parts.count = 0 Then
    			return Nothing
    		End If
    		return parts(0)
	End Function
	
End Class

Public Class CompanyInfo
	Protected _contact = new CompanyContact()
	Public Function Other(name)
		return GetResourceFor(name)
	End Function
	Public Function Name
		return GetResourceFor("Company Name")
	End Function
	Public Function Contact
		return _contact
	End Function
	Public Function CopyrightStatement
		return "&copy; " & Today.Year & " " & Name
	End Function
End Class

Public Class CompanyContact
	Public Function Other(name)
		return GetResourceFor(name)
	End Function
	Public Function Address
		return GetResourceFor("Address")
	End Function
	Public Function Phone
		return GetResourceFor("Phone")
	End Function
	Public Function Fax
		return GetResourceFor("Fax")
	End Function
	Public Function Email
		return GetResourceFor("Email")
	End Function
	Public Function CityStateZip
		return GetResourceFor("City-State-Zip")
	End Function
End Class

Public Class WebSiteElement

	protected properties As New Dictionary(Of String, Object)(System.StringComparer.OrdinalIgnoreCase)

	Function AddProperty(name As String, value As Object)
		If properties.ContainsKey(name) Then
			properties(name) = properties.Item(name) & " " & value
		Else
			properties.add(name, value)
		End If
	End Function
	
	Function SetProperty(name As String, value As Object)
		properties(name) = value
	End Function
	
	Function GetProperty(name As String)
		If properties.ContainsKey(name.ToLower()) Then
			return properties(name.ToLower())
		Else
			return ""
		End If
	End Function
	
	'
	' If a property is added it will add the new value with any current values
	'
	Function addClass(c As String)
		AddProperty("class", c)
		return Me
	End Function
	
	Function addStyle(s As String)
		AddProperty("style", s)
		return Me
	End Function
	
	Function addEvent(name As String, value As String)
		AddProperty(name, value & ";")
		return Me
	End Function
	
	'
	' If a property is set it will replace any current value with the new value
	'
	Function setClass(c As String)
		SetProperty("class", c)
		return Me
	End Function
	
	Function setStyle(s As String)
		SetProperty("style", s)
		return Me
	End Function
	
	Function setEvent(name As String, value As String)
		SetProperty(name, value)
		return Me
	End Function
	
	Function setAttribute(name As String, value As String)
		SetProperty(name, value)
		return Me
	End Function
	
End Class

Public Class CompoundLink : Inherits WebSiteElement

	protected compoundurl = ""
	
	Sub New(id() as String)
		If id.Length <= 0 Then return
		Dim link
		For i As Integer = 0 To UBound(id, 1)
			link = New Link(id(i))
			compoundurl = compoundurl & link.url(false) & "/"
		Next i
		SetProperty("label", link.GetProperty("label") )
	End Sub
	
	Function CreateElement()
		Dim sb As New StringBuilder
		For Each pair In properties
			If pair.Key.ToLower() <> "label" And _ 
				pair.Key.ToLower() <> "location" And _
				pair.Key.ToLower() <> "action" And _
				pair.Key.ToLower() <> "id" And _
				pair.Key.ToLower() <> "parentid" And _
				pair.Key.ToLower() <> "name" Then
					If pair.Key <> "url" Then
						sb.Append(" " & pair.Key & "=""" & pair.Value & """ ")
					End If
			End If
		Next
		If properties.containsKey("label") Then
			return "<a href=""" & compoundurl & """ "  & sb.ToString() & ">" & properties("label") & "</a>"
		Else
			return "<a href=""" & compoundurl & """ "  & sb.ToString() & ">[Missing Label]</a>"
		End If
	End Function
	
End Class

Public Class Link : Inherits WebSiteElement
	
	Sub New(id as String)
		id = id
		Dim dt
		Dim intId
		If Integer.TryParse(id, intId) Then
			dt = RC4.Pull("Select * from WMALinks where active = 1 and id = " & intId)
		Else
			dt = RC4.Pull("Select * from WMALinks where active = 1 and name = '" & id & "'")
		End If
		If dt.Rows.Count > 0 Then
			properties = properties.Union(json_decode(dt.Rows(0)("properties"))).ToDictionary(Function(p) p.Key, Function(p) p.Value)
			For Each dr As DataRow In dt.Rows
				For Each column in dr.Table.Columns
					If column.ColumnName <> "properties" Then
						SetProperty(column.ColumnName.ToLower(), dr.Item(column.ColumnName))
					End If
				Next
			Next
			AddProperty("rawurl", dt.Rows(0)("url"))
			AddProperty("linkid", id)
			PrependParentUrl(GetProperty("parentid"), true)
		Else
			SetProperty("url", id)
		End If
	End Sub
	
	Function PrependParentUrl(parentid, first)
		If Not IsDBNull(parentid) AndAlso parentid > 0 Then
			Dim dt = RC4.Pull("Select * from WMALinks where active = 1 And id = " & parentid)
			If dt.Rows.Count > 0 Then
				If GetProperty("rawurl").StartsWith("#") AndAlso first Then
					PrependToUrl(dt.rows(0)("url"))
				Else
					PrependToUrl(dt.rows(0)("url") & "/")
				End If
				PrependParentUrl(dt.rows(0)("parentid"), false)
			End If
		End If
	End Function
	
	Function ParentUrl()
		If GetProperty("parentid").tostring().length > 0 Then
			Dim parentlink = new Link(GetProperty("parentid"))
			return parentlink.url()
		Else
			return Nothing
		End If
	End Function
	
	Function Parent()
		If GetProperty("parentid").tostring().length > 0 Then
			return new Link(GetProperty("parentid"))
		Else
			return Nothing
		End If
	End Function
	
	Function Children()
		Dim dt = RC4.Pull("Select * from WMALinks where active = 1 And parentid = " & GetProperty("id"))
		Dim links = New List(of Link)
		If dt.Rows.Count > 0 Then
			For Each row As DataRow In dt.Rows
			    links.add(new Link(row("id")))
			Next row
			return links
		Else
			return New List(of Link)
		End If
	End Function
	
	Function Url(Optional root As Boolean = true)
		If properties.containsKey("url") Then
			If root Then
				return "/" & properties("url")
			Else
				return properties("url")
			End If
		Else
			return ""
		End If
	End Function
	
	Function GetUrl(Optional root As Boolean = true)
		return Url(root)
	End Function
	
	Function AppendToUrl(path As String)
		properties("url") &= path
		return me
	End Function
	
	Function PrependToUrl(path As String)
		properties("url") = path & properties("url")
		return me
	End Function
	
	Function SetLabel(label As String)
		SetProperty("label", label)
		return Me
	End Function
	
	Function GetLabel()
		return properties("label")
	End Function

	'
	' An Image Object or String Object can be used. TheString Object needs to be the name of the image associated
	' with it's data in the database.
	'
	Function CreateElementForImage(Obj As Object)
		Dim img As Image
		If Obj.GetType() Is GetType(Image) Then
			img = Obj
		Else
			img = new Image(obj)
    	End If

		Dim sb As New StringBuilder
		For Each pair In properties
			If pair.Key.ToLower() <> "label" And _ 
				pair.Key.ToLower() <> "location" And _
				pair.Key.ToLower() <> "action" And _
				pair.Key.ToLower() <> "id" And _
				pair.Key.ToLower() <> "parentid" And _
				pair.Key.ToLower() <> "completeurl" And _
				pair.Key.ToLower() <> "name" Then
					If pair.Key <> "url" Then
						If  pair.Value.tostring.length > 0 Then
							sb.Append(" " & pair.Key & "=""" & pair.Value & """ ")
						End If
					Else
						If AddForwardSlash(pair.Value.ToString())  Then
							sb.Append("href=""/" & pair.Value & """ ")
						Else
							sb.Append("href=""" & pair.Value & """ ")
						End If
					End If
			End If
		Next
		return "<a " & sb.ToString() & ">" & img.CreateElement() & "</a>"
	End Function
	
	Function CreateElement()
		Dim sb As New StringBuilder
		For Each pair In properties
			If pair.Key.ToLower() <> "label" And _ 
				pair.Key.ToLower() <> "location" And _
				pair.Key.ToLower() <> "action" And _
				pair.Key.ToLower() <> "id" And _ 
				pair.Key.ToLower() <> "parentid" And _
				pair.Key.ToLower() <> "completeurl" And _
				pair.Key.ToLower() <> "name" Then
					If pair.Key <> "url" Then
						If  pair.Value.tostring.length > 0 Then
							sb.Append(" " & pair.Key & "=""" & pair.Value & """ ")
						End If
					Else
						If AddForwardSlash(pair.Value.ToString())  Then
							sb.Append("href=""/" & pair.Value & """ ")
						Else
							sb.Append("href=""" & pair.Value & """ ")
						End If 
					End If
			End If
		Next
		If properties.containsKey("label") Then
			If properties.containsKey("svgiconlink") Then
				return "<a " & sb.ToString() & " aria-label='" & properties("label") & "'><svg class='icon'><use href='" & properties("svgiconlink") & "'></use></svg><span>" & properties("label") & "</span></a>"
			Else
				return "<a aria-label='" & properties("label") & "' " & sb.ToString() & "><span>" & properties("label") & "</span></a>"
			End If
		Else
			return "<a aria-label='Missing Label!' " & sb.ToString() & ">[Missing Label]</a>"
		End If
	End Function
	
	Function CreateChildListElement(Optional ByVal UlClasses As String = "", Optional ByVal LiClasses As String = "")
		Dim html = "<ul class=""pl-0 nav-child-list " & UlClasses & """ style=""list-style: none;"">"
		Dim childList = Children()
		For Each child In childList
			child.addClass(GetProperty("class"))
			child.addStyle(GetProperty("style"))
			html &= "<li class=""" & LiClasses & " link-" & child.GetProperty("id") & """>" & child.CreateElement() & "</li>"
		Next
		html &= "</ul>"
		return html
	End Function
	
	Private Function AddForwardSlash(str As String)
		If Not str.StartsWith("/") Then
			if  str.StartsWith("tel:")  _ 
				Or  str.StartsWith("mailto:") Then
				return false
			Else
				return true
			End If
		Else
			return false
		End If
	End Function

End Class

Public Class Image : Inherits WebSiteElement

	Sub New(id as String)
		id = id
		Dim dt
		Dim intId
		If Integer.TryParse(id, intId) Then
			dt = RC4.Pull("Select * from WMAImages where id = " & id)
		Else
			dt = RC4.Pull("Select * from WMAImages where name = '" & id & "'")
		End If
		If dt.Rows.Count > 0 Then
			properties = properties.Union(json_decode(dt.Rows(0)("properties"))).ToDictionary(Function(p) p.Key, Function(p) p.Value)
			For Each dr As DataRow In dt.Rows
				For Each column in dr.Table.Columns
					If column.ColumnName <> "properties" Then
						SetProperty(column.ColumnName.ToLower(), dr.Item(column.ColumnName))
					End If
				Next
			Next
		End If
	End Sub
	
	Function Src(Optional root As Boolean = false)
		If properties.containsKey("src") Then
			If root Then
				return "/" & properties("src")
			Else
				return properties("src")
			End If
		Else
			return ""
		End If
	End Function
	
	Function CreateElement()
		Dim sb As New StringBuilder
		For Each pair In properties
			If pair.Key.ToLower() <> "name" And _ 
				pair.Key.ToLower() <> "id" And _ 
				pair.Key.ToLower() <> "filename" Then
					If pair.Key <> "src" Then
						If  pair.Value.tostring.length > 0 Then
							sb.Append(" " & pair.Key & "=""" & pair.Value & """ ")
						End If
					Else
						sb.Append("src=""" & pair.Value & """ ")
					End If
			End If
		Next
		return "<img " & sb.ToString() & ">"
	End Function

End Class