<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Privacy.aspx.vb" Inherits="Privacy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

    	<div class="container-fluid page-header">
        		<div class="overlay"><h1><%= WebSite.Link("Privacy Policy").GetLabel() %></h1></div>
        </div>
            
        <div class="container">
		<div class="row col-12">
				<%= ReplaceSiteUrlPlaceholder(ReplaceCompanyNamePlaceholder(GetContent(2))) %>
			</div>
		</div>
		
</asp:Content>