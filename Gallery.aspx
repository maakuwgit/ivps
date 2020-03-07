<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Gallery.aspx.vb" Inherits="Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

	<div  class="container">
       	<div class="">
       		<a href="<%= WebSite.Link("Gallery").url() %>" class="btn small">< Back to Main Gallery</a>
			<div class="">
				 <h2><asp:Literal runat="server" ID="lblName"></asp:Literal></h2>
			</div>
			<div class="">
                <div id="gallery" class="row" runat="server"></div>
			</div>
		</div>
	</div>

     <link href="/js/fancybox/jquery.fancybox.min.css" rel="stylesheet">
     <script src="/js/fancybox/jquery.fancybox.min.js" type="text/javascript"></script>

</asp:Content>

