<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Links.aspx.vb" Inherits="Links" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<header class="col-12" id="page-header">
	<h1>Accepted Insurances</h1>
	<hr>
</header>
<article class="col-12">
	<div class="container insurances">
	<% If LinksCategories.Rows.Count > 0 Then %>
		
		<% 
			For Each categoryRow in LinksCategories.Rows 
				Dim CatName As String = categoryRow("Name")
				Dim CatID = categoryRow("Id")
				Dim CatImg = Replace(LCase(CatName)," ", "_")

		%>
		<dl data-component="icon-grid" class="iflex align-content-center align-items-center">
			<dt>
				<img alt="<%= CatName %>" src="/images/logo__<%= CatImg %>.png">
			</dt>
			<% 
				Dim dd = RC4.Pull("Select * from RCLink where CatId = " & CatID & " order by Name asc")
				If dd.Rows.Count > 0 Then
					Dim ddIndex = 0
			%>
			<dd>
				<ul class="no-bullet">
				<% For Each link in dd.Rows %>
					<% If ddIndex >= 3 Then %>
				</ul>
				<ul class="no-bullet">
						<% ddIndex = 0 %>
					<% End If %>
					<li><%=link("Name")%></li>
					<% ddIndex = ddIndex + 1 %>
				<% Next %>
				</ul>
			</dd>
			<% Else %>
			<dd class="hide"></dd>
			<% End If %>
		</dl>
		<% Next %>
	<% End If %>
	</div>
</article>
</asp:Content>