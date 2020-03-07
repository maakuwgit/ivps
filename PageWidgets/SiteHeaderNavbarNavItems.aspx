<% @Import Namespace="System.Data" %>
<%
Dim links = ControllerFactory.links.getForLayout("header")

For Each link As DataRow In links.Rows
%>
<li class="nav-item">
	<%
	= WebSite.Link(link("linkid")).addClass("nav-link pr-5").createElement() 
	%>
</li>
<%
Next link
%>

