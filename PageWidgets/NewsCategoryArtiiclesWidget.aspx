<% @Import Namespace="System.Data" %>
<div class="row">
<%
	' Need to set the category id in the news controller first. This can be done here or in the 
	' page that includes this widget (preferred method)
	' Example: ControllerFactory.News.CategoryId = 1
	'
	' By default it should return the top 10 articles. This can be changed using the below code.
	' Example: ControllerFactory.News.SelectTopNumber = 3
	
	Dim catArticlesDt as DataTable =  NewsWidget.CategoryArticles()
	For Each catArticlesDr As DataRow In catArticlesDt.Rows
%>
	<div class="col-12 mb-3">
		<a href="<%= Website.Link("News").Url()%>/category/<%= catArticlesDr.Item("id")  %>/<%= ReplaceAlphanumericCharacters(catArticlesDr.Item("Title")) %>"><%= catArticlesDr.Item("Title")  %></a>
	</div>
<%	
	Next
%>
</div>
