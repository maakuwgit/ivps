<% @Import Namespace="System.Data" %>
<div class="bg-white" >
<h2 class="bg-golden text-white p-3">What's New</h2>
<%
	Dim data as DataTable =  NewsWidget.top(5) 
	For Each dr As DataRow In data.Rows
%>
	<div class="pl-3 pr-3 pb-3">
		<div class="text-secondary">
			<small><%= FormatDateTime(dr.Item("PubDate"), DateFormat.LongDate) %></small>
		</div>
		<div class="font-size-3">
			<a href="/NewsStory.aspx?id=<%= dr.Item("id") %>"><%= dr.Item("Title") %></a>
		</div>
	</div>
<%	
	Next
%>
</div>


