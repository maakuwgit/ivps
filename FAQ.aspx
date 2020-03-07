<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="FAQ.aspx.vb" Inherits="FAQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!-- #Include file="\PageWidgets\DefaultPageHeader.aspx" -->	
	<article class="col-12">
		<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
		
					<% 
						For Each CatRow in FAQCategories.Rows 
							Dim Faqs = GetFaqsForCat(CatRow("id"))
					%>
					<h3 class="mb-3"><%= CatRow("Name")%></h3>
				<dl>
					<% For Each FaqRow in Faqs.Rows %>
					<dt data-accordion-trigger>
						<%= FaqRow("Question")%><svg class="icon"><use href="#icon__chevron--down"></use></svg>
					</dt>	
					<dd data-accordion-content>
						<p><%= FaqRow("Answer")%></p>
					</dd>
					<% Next %>
				</dl>
				<% Next %>
		
	</article>
	<script>	
		document.addEventListener("DOMContentLoaded", function(){
			$("[data-accordion-trigger]").on('click', function(e){
				var dt = $(this),
					dd = dt.next();

				$("[data-accordion-content]").not(dd).removeClass('active');
				$("[data-accordion-trigger]").not(dt).removeClass('active');

				dt.toggleClass('active');
				dd.toggleClass('active');
			})
		});
	</script>
</asp:Content>

