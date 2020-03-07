
<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="StaffDetail.aspx.vb" Inherits="Staff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<figure class="col-12 col-sm-4 col-md-5 col-lg-6" data-backgrounder>
		<div class="feature">
			<img src="<%= TeamMemberInfo("FSLoc") %>" alt="">
		</div>
	</figure>
	<div class="col-12 col-sm-8 col-md-7 col-lg-6">		
		<header>
			<h1><%= TeamMemberInfo("name") %></h1>
			<hr>
		</header>
		<article>
			<h2 class="h3 smoke"><%= TeamMemberInfo("title") %></h2>
			<p><%= TeamMemberInfo("description") %></p>
			<nav>
				<a class="icon-link" href="<%= Website.Link(Website.Router.QueryString("id")).Url() %>"><svg class="icon"><use href="#icon__chevron--left"></use></svg> Back to IVPS Team</a>
			</nav>
		</article> 
	</div>

</asp:Content>
