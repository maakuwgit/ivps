<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Products.aspx.vb" Inherits="Products" %>
<% @Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

	<div class="container page-header mt-5">
		<div class="overlay"><h1 class="text-uppercase">Products</h1></div>
	</div>
   
	<div class="mb-5 mt-5">
				<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
	</div>
	
	<div class="container mb-5 products">
		<h2>Our bestsellers and new products</h2>
		<div class="row">
			<% Dim ProductCatSql = new MSSQLBuilder("RCProductCat") %>
			<% For Each FeaturedRow In FeaturedProductsDataTable.Rows %>
			<% 
				ProductCatSql.Reset()
				ProductCatSql.Where("id=" & FeaturedRow("CatId"))
				Dim ProductCatDataRow = ProductCatSql.SelectAll().Rows(0)
			%>
				<div class="col-lg-3 mb-4 d-flex flex-column"">
					<img src="/productImage.ashx?id=<%= FeaturedRow("id")%>&w=800" class="img-fluid">
					<h5 class="mt-3"><%= FeaturedRow("name")%></h5>
					<p><%= TruncateStringMiddle(RemoveHTML(FeaturedRow("description")), 100) %></p>
					<div class="mt-auto"><a href="<%= Website.Link(8).Url() %>/<%= ProductCatDataRow("slug") %>/<%= FeaturedRow("slug") %>">More <i class="fas fa-chevron-right"></i></a></div>
				</div>
			<% Next %>
		</div>
	</div>
	
	<div class="container mb-5 products">
		<% For Each CategoryRow In ProductCatagoriesDataTable.Rows %>
		<h2><a href="<%= Website.Link(8).Url() %>/<%= CategoryRow("slug") %>"><%= CategoryRow("Name") %></a></h2>
		<div class="row">
			<% Dim ProductsDataTable = GetProductsForCategory(CategoryRow("id")) %>
			<% For Each FeaturedRow In ProductsDataTable.Rows %>
				<div class="col-lg-4 mb-4 d-flex flex-column"">
					<img src="/productImage.ashx?id=<%= FeaturedRow("id") %>&w=800" class="img-fluid">
					<h5 class="mt-3"><%= FeaturedRow("name")%></h5>
					<p><%= TruncateStringMiddle(RemoveHTML(FeaturedRow("description")), 100) %></p>
					<div class="mt-auto"><a href="<%= Website.Link(8).Url() %>/<%= CategoryRow("slug") %>/<%= FeaturedRow("slug") %>">More <i class="fas fa-chevron-right"></i></a></div>
				</div>
			<% Next %>
		</div>
		<% Next %>
	</div>
	
</asp:Content>