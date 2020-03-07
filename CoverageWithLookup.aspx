<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Coverage.aspx.vb" Inherits="Coverage" %>
<% @Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	
	<div class="container">
	<div class="row align-items-center">
	<div class="col-lg-8">
		<!-- #Include file="\PageWidgets\DefaultPageHeader2.aspx" -->	
	</div>
	<div class="col-lg-4"><form runat="server">
		<div class="form-group">
				<div class="input-group">
					<asp:TextBox type="text" name="coverage_area_search" placeholder=" Search Coverage by Zipcode" class="form-control border-right-0" style="box-shadow:none;" ID="txtZipSearch" runat="server"></asp:TextBox> 
					<div class="input-group-prepend">
					<div class="input-group-text bg-white border-left-0" style="border-color:#BABABA;"><asp:button class="p-1 m-0 bg-white border-0 text-dark" style="min-width:1px;" runat="server" id="btnSearch"></asp:button></div>
				<asp:label id="searchLabel" runat="server"></asp:label>
				</div>
			 </div>
		</div>
	</div></form>
	</div>
	</div>
	
	<div class="container">
	<div class="row">
		<div class="col-lg-8">
			<img src="/images/tmp-map.png" class="img-fluid"/>
		</div>
		<article class="col-lg-4">
			<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
		</article>
		</div>
	</div>
	</div>
	
</asp:Content>