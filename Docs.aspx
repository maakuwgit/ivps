<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Docs.aspx.vb" Inherits="Docs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
		<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
		<!-- #Include file="\PageWidgets\DefaultPageHeader.aspx" -->
		<!-- #Include file="\PageWidgets\DocumentsWidget.aspx" -->
</asp:Content>
