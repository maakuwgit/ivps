<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="About.aspx.vb" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
	
		<div class="container-fluid page-header">
        		<div class="overlay"><h1 class="text-uppercase"><%= WebSite.Link("About").GetLabel() %></h1></div>
        </div>
            
        <div class="container">
        	<div class="row">
        		<div class="col-12">
           		<%= GetContent("7") %>
           		</div>
			</div>
		</div>
</asp:Content>