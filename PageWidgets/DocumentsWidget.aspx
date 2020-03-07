<% @Import Namespace="System.Data" %>
<article class="col-12">
<%
	Dim DocCategoriesData as DataTable =  ControllerFactory.Documents.Categories()
	
	For Each DocCategoriesDataRow As DataRow In DocCategoriesData.Rows
		ControllerFactory.Documents.CategoryId = DocCategoriesDataRow("Id") 
		
		Dim CategoryDocumentsData as DataTable = ControllerFactory.Documents.CategoryDocuments()
		Dim CategoryDescription = DocCategoriesDataRow("Description")
		
		If CategoryDocumentsData.Rows.Count > 0 Then
 %>
	<header>
		<h2 class="h5"><%= DocCategoriesDataRow("Name") %></h2>
	
	<% If Not CategoryDescription Is Nothing Then %>
		<p><%= CategoryDescription %></p>
	<% End If %>
	
	</header>
	<nav data-icon-links>
	<% For Each CategoryDocumentsDataRow As DataRow In CategoryDocumentsData.Rows %>
		<a href="/docfile3.ashx?id=<%= CategoryDocumentsDataRow("Id") %>" target="_blank" class="icon-link">
			<svg class="icon chocolate"><use href="#icon__download"></use></svg>
			<%= CategoryDocumentsDataRow("Name") %></a>
			<!-- Dev Note: there is no style for this -->
			<!--			<small  class="d-block"><%= CategoryDocumentsDataRow("Description") %></small>-->
	<%	Next %>
<%
		End If
	Next
%>
</article>

			


