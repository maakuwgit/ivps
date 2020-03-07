<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ProductCategory.aspx.vb" Inherits="ProductCategory" %>

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
		<h2><%= ProductCatagoriesDataTableRow("name") %></h2>
		<div class="row">
			<% For Each ProductsDataTableRow In ProductsDataTable.Rows %>
				<div class="col-lg-3 mb-4 d-flex flex-column"">
					<img src="/productImage.ashx?id=<%= ProductsDataTableRow("id")%>&w=800" class="img-fluid">
					<h5 class="mt-3"><%= ProductsDataTableRow("name")%></h5>
					<p><%= TruncateStringMiddle(RemoveHTML(ProductsDataTableRow("description")), 100) %></p>
					<div class="mt-auto"><a href="<%= Website.Link(8).Url() %>/<%= ProductCatagoriesDataTableRow("slug") %>/<%= ProductsDataTableRow("slug") %>">More <i class="fas fa-chevron-right"></i></a></div>
				</div>
			<% Next %>
		</div>
	</div>

	
</asp:Content>

