<header class="col-12" id="page-header">
	<h1>
<% 
	Dim PageTitle = Website.Content.GetTitleOfPage(Website.Router.QueryString("id"))
	If PageTitle.ToString().Length() > 0 Then 
%>
	<%= PageTitle %>
<% Else %>
	<%= WebSite.Link(Website.Router.QueryString("id")).GetLabel() %>
<% End If %>
	</h1>
	<hr>
<%
	Dim PageSubTitle = Website.Content.GetSubTitleOfPage(Website.Router.QueryString("id"))	
	If PageSubTitle.ToString().Trim().Length() > 0 Then 
%>
	<h2 class="pb-3"><i><%= PageSubTitle %></i></h2>
<% End If %>
	
</header> 