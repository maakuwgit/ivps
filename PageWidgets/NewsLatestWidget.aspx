<% @Import Namespace="System.Data" %>
<div class="row">
<%
	Dim data as DataTable =  NewsWidget.top(5) 
	For Each dr As DataRow In data.Rows
%>
	<div class="col-12 mb-3">
		<small><%= FormatDateTime(dr.Item("PubDate"), DateFormat.LongDate) %></small><br>
		<a href="<%= Website.Link("News").Url()%>/<%= dr.Item("Id") %>/<%= ReplaceAlphanumericCharacters(dr.Item("Title")) %>"><%= dr.Item("Title")  %></a>
	</div>
<%	
	Next
%>
</div>

