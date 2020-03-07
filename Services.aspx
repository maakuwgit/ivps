<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Layout.aspx.vb" Inherits="Layout" %>
<% @Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<div data-service-list class="service-content col-lg-6">
	<!-- #Include file="\PageWidgets\DefaultPageHeader.aspx" -->	
	<article>
			<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
	</article>
</div>
<!-- #Include file="\PageWidgets\DefaultServicesNav.aspx" -->
<aside class="col-lg-6 d-none d-lg-block">
	<nav class="circular-menu">
	  <div class="circle open">
		<%= Website.Link(22).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(14).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(16).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(20).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(23).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(19).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(18).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(15).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(21).AddClass("chocolate wheel").CreateElement() %>
		<%= Website.Link(17).AddClass("chocolate wheel").CreateElement() %>
	  </div>
	  <a class="menu-button">
			<svg class="icon">
				<use xlink:href="#icon__seraphin"></use>
			</svg>
	  	<span>Our<br>Services</span>
	  </a>
	</nav>
</aside>
</asp:Content>