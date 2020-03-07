<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="NewsStory.aspx.vb" Inherits="News" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
.blog-content img {
    max-width: 100%;
    height: auto;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
			


<div class="container mt-5">
		
	<asp:Repeater runat="server" ID="Story" OnItemDataBound="BindInnerRepeaters">
	
		<ItemTemplate>
		<div class="row">
			<article class="col-9">
				<h1 class="mn-3"><%#Eval("Title") %></h1>
				<small><%# FormatDateTime(Eval("PubDate"), DateFormat.LongDate) %></small>
				<div class="mt-3">
					<div class="" style="display:<%# iif(Eval("img").ToString().length > 0, "block", "none") %>">
						<img src="/NewsImg.ashx?id=<%#Eval("Id") %>&w=500" class="img-responsive" />
					</div>
					<div class="blog-content">
						<p><%#Eval("Contents") %><p>
					</div>
							
				</div>
			</article>
			
				<div class="col-3">
						<div class="col-12 row">
							<div class="col-12 row mb-3"><a href="<%= WebSite.Link("News").addClass("nav-link").url() %>">&#9666; &nbspBack to News</a></div>
							
							<div><h5>Latest Posts</h5></div>
							<div class="col-12 p-0"><hr></div>
							<!-- #Include file="\PageWidgets\NewsLatestWidget.aspx" -->	
							<div class="mt-3"><h5>Categories</h5></div>
							<div class="col-12 p-0"><hr></div>
							<!-- #Include file="\PageWidgets\NewsCategoryWidget.aspx" -->	
						</div> 
			
				</div>
		</div>
		</ItemTemplate>

	</asp:Repeater>
</div>
        


</asp:Content>