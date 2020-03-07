<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Coverage.aspx.vb" Inherits="Coverage" %>
<% @Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	<!-- #Include file="\PageWidgets\PageHeaderWSearch.aspx" -->
	<article class="col-12">
		<div class="row">
			<figure class="col-lg-8" data-backgrounder style="background-color:#c4e3ff">
			<!--Dev Note: since this is using the old backgrounder logic, data-bg-color isn't supported-->
				<div class="feature">
					<img src="/assets/img/map__coverage_area.jpg" alt="A map of the greater Michigan area with locator pins on Southfield and Traverse City" data-src-md="/assets/img/map__coverage_area--md.jpg" data-src-lg="/assets/img/map__coverage_area--lg.jpg" data-src-xl="/assets/img/map__coverage_area--xl.jpg" srcset="/assets/img/map__coverage_area--xl.jpg 4x, /assets/img/map__coverage_area--lg.jpg 3x, /assets/img/map__coverage_area--md.jpg 2x, /assets/img/map__coverage_area.jpg 1x">
				</div>
			</figure>
			<section class="col-lg-4">
				<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
			</section>
		</div>
	</article>	
	<aside data-modal class="pattern" id="zipcodeModal" tabindex="-1" role="dialog" runat="server">
		<div class="container" role="document">
			<div class="row">
				<h5 class="col-12 text-center"><asp:label id="searchLabel" runat="server"></asp:label></h5>
	      <button type="button" class="btn--white close" data-dismiss="modal" aria-label="Close">
	        <span aria-hidden="true">&times;</span>
	      </button>
			</div>
		</div>
	</aside>
</asp:Content>