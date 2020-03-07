<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Product.aspx.vb" Inherits="Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

	<div class="container page-header mt-5">
		<div class="overlay"><h1 class="text-uppercase">Product</h1></div>
	</div>
   
	<div class="mb-5 mt-5">
				<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
	</div>
	
	<div class="container mb-5">
		<div class="row">
			<div class="col-lg-6">
				<img src="/productImage.ashx?id=<%= ProductDataRow("id")%>&w=800" class="img-fluid">
			</div>
			<div class="col-lg-6">
				<div class="mb-3">
					<small class="text-secondary"><%= GetCategoryName(ProductDataRow("catid")) %></small>
					<h4><%= ProductDataRow("name") %></h4>
				</div>
				<%= Website.Content.Process(ProductDataRow("description")) %>
			</div>
		</div>
	</div>
	
</asp:Content>