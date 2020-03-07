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
	
	Public Function Router(request As System.Web.HttpRequest)
		return new Router(request)
	End Function

End Module

Public Class Router
	
	protected request As System.Web.HttpRequest
	
	Sub New(request As System.Web.HttpRequest)
		request = request
	End Sub

	Public Function getUrlPartsFromQueryString()
		Dim variables as string = System.Web.HttpUtility.UrlDecode(request.QueryString.toString())
		return variables.Split("/")
	End Function
	
	Public Function getIdFromQueryString(Optional ByVal location as integer = 1, Optional ByVal name as String = "Id")
		If request(name) > 0 Then
			return request("Id")
		Else
			return getUrlPartsFromQueryString(request)(location)
		End If
	End Function
	
	Public Function getUrlPart(location As Integer)
		return getUrlPartsFromQueryString(request)(location)
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

Public Class Link : Inherits WebSiteElement
	
	Sub New(id as String)
		id = id
		Dim dt = RC4.Pull("Select * from WMALinks where name = '" & id & "'")
		If dt.Rows.Count > 0 Then
			properties = properties.Union(json_decode(dt.Rows(0)("properties"))).ToDictionary(Function(p) p.Key, Function(p) p.Value)
			For Each dr As DataRow In dt.Rows
				For Each column in dr.Table.Columns
					If column.ColumnName <> "properties" Then
						SetProperty(column.ColumnName.ToLower(), dr.Item(column.ColumnName))
					End If
				Next
			Next
		Else
			SetProperty("url", id)
		End If
	End Sub
	
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
				pair.Key.ToLower() <> "name" Then
					If pair.Key <> "url" Then
						sb.Append(" " & pair.Key & "=""" & pair.Value & """ ")
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
				pair.Key.ToLower() <> "name" Then
					If pair.Key <> "url" Then
						sb.Append(" " & pair.Key & "=""" & pair.Value & """ ")
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
			return "<a " & sb.ToString() & ">" & properties("label") & "</a>"
		Else
			return "<a " & sb.ToString() & ">[Missing Label]</a>"
		End If
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
		Dim dt = RC4.Pull("Select * from WMAImages where name = '" & id & "'")
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
						sb.Append(" " & pair.Key & "=""" & pair.Value & """ ")
					Else
						sb.Append("src=""" & pair.Value & """ ")
					End If
			End If
		Next
		return "<img " & sb.ToString() & ">"
	End Function

End Class