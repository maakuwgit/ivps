<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="GalleryList.aspx.vb" Inherits="GalleryList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

		<div  class="container">
       	<div class="">
			<div class="row">
				<h2>Gallery</h2>
			</div>
			<div class="row">
				<%= GetContent("Gallery")%>
			</div>
			<div class="row">
			
				<div class="col-lg-3 pl-0">
					<h5>Categories</h5>
					<ul class="pl-0" style="list-style-type:none !important;" id="galleryLines" runat="server">
						
					</ul>
				</div>
				<div class="col-lg-9">
					<div id="galleries" class="row" runat="server"></div>
				</div>
			
			</div>
		</div>
	</div>
	
</asp:Content>