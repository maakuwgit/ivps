<% @Import Namespace="System.Data" %>
<div class="row">
<%
	Dim dataCat as DataTable =  ControllerFactory.News.Cornerstones()
	For Each csdr As DataRow In dataCat.Rows
%>
	<div class="col-12 mb-3">
		<a href="<%= Website.Link("News").Url()%>/category/<%= csdr.Item("id")  %>/<%= ReplaceAlphanumericCharacters(csdr.Item("Title")) %>"><%= csdr.Item("Title")  %></a>
	</div>
<%	
	Next
%>
</div>
