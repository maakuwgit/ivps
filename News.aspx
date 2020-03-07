<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="News.aspx.vb" Inherits="News" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

		<div class="container-fluid page-header">
        		<div class="overlay"><h1  class="text-uppercase"><%= WebSite.Link("News").GetLabel() %></h1></div>
        </div>
            
        <div class="container pt-5">
        	<div class="row">
        		<div class="col-12">
           		<%= GetContent("10") %>
           		</div>
			</div>
		</div>

	
			
 <div class="container">
	<div class="row"> 
		<div class="col-lg-3 mt-3">
			<div><h5>Latest Posts</h5></div>
			<div class="col-12 p-0"><hr></div>
			<!-- #Include file="\PageWidgets\NewsLatestWidget.aspx" -->	
			<div class="mt-3"><h5>Categories</h5></div>
			<div class="col-12 p-0"><hr></div>
			<!-- #Include file="\PageWidgets\NewsCategoryWidget.aspx" -->	
		</div>
		
		 <div class="col-lg-9">
			<asp:Repeater runat="server" ID="News">
				<ItemTemplate>
					<article class="row">
						<div class="col-12">
							<small><%# FormatDateTime(Eval("PubDate"), DateFormat.LongDate) %></small>
						</div>
						<div class="col-12">
							<h2><a href="<%= Website.Link("News").Url()%>/<%#Eval("Id") %>/<%# ReplaceAlphanumericCharacters(Eval("Title")) %>"><%#Eval("Title") %></a><h2>
						</div>
						<div class="col-12 col-md-4">
								<img src='/NewsImg.ashx?id=<%#Eval("Id") %>&w=800' class='img-fluid mb-3 mt-3' style="display:<%# iif(Eval("img").ToString().length > 0, "block", "none") %>"/>
						</div>
						<div class="col-12 col-md-8">
							<%#Eval("Description") %>
							<p><a href="<%= Website.Link("News").Url()%>/<%#Eval("Id") %>/<%# ReplaceAlphanumericCharacters(Eval("Title")) %>">Read more</a></p>
						</div>
						<div class="col-12 p-0"><hr></div>
					</article>
				</ItemTemplate>
			</asp:Repeater>
		</div>      
	</div>
</div>

</asp:Content>