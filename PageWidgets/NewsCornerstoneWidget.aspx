<% @Import Namespace="System.Data" %>
<div class="row">
<%
	Dim data as DataTable =  ControllerFactory.News.Cornerstones()
	For Each dr As DataRow In data.Rows
%>
	<div class="col-12 mb-3">
		<small><%= FormatDateTime(dr.Item("PubDate"), DateFormat.LongDate) %></small><br>
		<a href="<%= Website.Link("News").Url()%>/<%= dr.Item("Slug") %>"><%= dr.Item("Title")  %></a>
	</div>
<%	
	Next
%>
</div>

