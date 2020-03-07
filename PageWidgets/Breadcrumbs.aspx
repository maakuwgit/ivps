<%
Dim path = ""
Dim url = Request.RawUrl
Dim urlParts = url.ToString().split("/")
Dim urlPath = ""
For Each part As String in urlParts
	If Not part Is urlParts.First Then
		If Not IsNumeric(part) Then
			If part Is urlParts.Last Then
				path &= part
			Else
				urlPath &= "/" & part
				path &= "<a href=""" & urlPath & """>" & part & "</a>&nbsp;&#8827;&nbsp;"
			End If
		End If
	End If
Next
%>
<div class="container mb-5">
		<div class="row align-items-center">
				<%= path %>
		</div>
</div>
