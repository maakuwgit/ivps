
<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Staff.aspx.vb" Inherits="Staff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!-- #Include file="\PageWidgets\AlternatePageHeader.aspx" -->	
	<article class="col-12">
		<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
	
	<ul class="row no-bullet" data-staff>
	<asp:Repeater runat="server" ID="rptBio">
		<ItemTemplate>
			<li class="col-12 col-sm-6 col-md-4 col-lg-3">
				<figure data-backgrounder data-clickthrough>
					<a href="<%= Website.Link(Website.Router.QueryString("id")).Url() %>/<%# Eval("Slug") %>"><svg class="icon" style="pointer-events: none;"><use href="#icon__math--plus"></use></svg></a>
					<div class="feature">
						<asp:Image runat='server' id='staff_image' visible='<%# Container.DataItem("FSLoc") <> "" %>' src='<%#Eval("FSLoc") %>' alt='<%#Eval("Name")%>'/>
					</div>
				</figure>
				<h3 class="h4"><%# Eval("Name")%></h3>
				<h5 class="text-semi"><%# Eval("Title")%></h5>
				<!-- Dev Note: no styles to support this!
					<p class="d-none"><%# Eval("Description")%></p>
				-->
			</li>
		</ItemTemplate>
	</asp:Repeater>
	</ul>
	</article> 

</asp:Content>
