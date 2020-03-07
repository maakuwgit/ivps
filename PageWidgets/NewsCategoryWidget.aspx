<% @Import Namespace="System.Data" %>
<div class="row">
<%
	Dim dataCat as DataTable =  NewsWidget.Categories() 
	For Each dr As DataRow In dataCat.Rows
%>
	<div class="col-12 mb-3">
		<a href="<%= Website.Link("News").Url()%>/category/<%= dr.Item("id")  %>/<%= ReplaceAlphanumericCharacters(dr.Item("Name")) %>"><%= dr.Item("Name")  %></a>
	</div>
<%	
	Next
%>
</div>
