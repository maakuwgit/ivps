<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Layout.aspx.vb" Inherits="Layout" %>
<% @Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	
	<!-- #Include file="\PageWidgets\DefaultPageHeader.aspx" -->	
   
	<article class="col-12">
		<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
	</article>
	
</asp:Content>