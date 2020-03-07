<% @Import Namespace="System.Data" %>
<% @Import Namespace="System.Data.SqlClient" %>
<div class="d-flex justify-content-between align-items-center">
<%
	Dim linksdata as DataTable =  LinksWidget.getLinksForCategory(2) 
	For Each dr As DataRow In linksdata.Rows
%>
	<div class="d-inline-flex pr-1">
		<a target="_blank" href="<%= dr.Item("Link")%>"><img src='/LinkImg.ashx?Id=<%= dr.Item("Id") %>&w=75'  class="img-fluid"/></a>
	</div>
<%	
	Next
%>
</div>


