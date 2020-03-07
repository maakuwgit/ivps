<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!--#include file="module.aspx"-->
	<div class="container">
	<div class="row">
	<h1 class="mb-5"><%= modname %></h1>
	</div>
		<div class="row align-items-center">
			<div class="col-6 col-lg-4 text-center mb-5">
				<a href="<%= baseurl %>/menu" class="text-secondary"><i class="fas fa-book-open fa-6x"></i><h5 class="mt-1">Menus</h5></a>
			</div>
			<div class="col-6 col-lg-4 text-center mb-5">
				<a href="<%= baseurl %>/section"  class="text-secondary"><i class="fas fa-scroll fa-6x"></i><h5 class="mt-1">Sections</h5></a>
			</div>
			<div class="col-6 col-lg-4 text-center mb-5">
				<a href="<%= baseurl %>/item"  class="text-secondary"><i class="fas fa-utensils fa-6x"></i><h5 class="mt-1">Items</h5></a>
			</div>
			<div class="col-6 col-lg-4 text-center mb-5">
				<a href="<%= baseurl %>/MenuSection"  class="text-secondary"><i class="fas fa-book-open fa-6x"></i><h5 class="mt-1">Menu Sections</h5></a>
			</div>
			<div class="col-6 col-lg-4 text-center mb-5">
				<a href="<%= baseurl %>/MenuSectionItem"  class="text-secondary"><i class="fas fa-book-open fa-6x"></i><h5 class="mt-1">Menu Section Items</h5></a>
			</div>
			<div class="col-6 col-lg-4 text-center mb-5">
			</div>
			<div class="col-6 col-lg-4 text-center mb-5">
				<a href="<%= baseurl %>/itemsize"  class="text-secondary"><i class="fas fa-book-open fa-6x"></i><h5 class="mt-1">Item Sizes</h5></a>
			</div>
			<div class="col-6 col-lg-4 text-center mb-5">
				<a href="<%= baseurl %>/ItemInclude"  class="text-secondary"><i class="fas fa-book-open fa-6x"></i><h5 class="mt-1">Item Includes</h5></a>
			</div>
		</div>
	</div>
</asp:Content>
							