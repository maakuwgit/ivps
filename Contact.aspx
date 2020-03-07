<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Contact.aspx.vb" Inherits="Contact" %>
<%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="ReCaptcha" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    	<!-- #Include file="\PageWidgets\DefaultPageHeader.aspx" -->	
   
	<div class="mb-5 mt-5">
				<%= Website.Content.GetForPage(Website.Router.QueryString("id")) %>
	</div>
            
        <div class="container">
			<div class="row">
				<div class="col-12 col-md-6 mb-3">
					<!-- #Include file="\PageWidgets\ContactWidget.aspx" -->	
				</div>
				<div class="col-12 col-md-6 mb-5">
					<div class="embed-responsive embed-responsive-4by3">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2938.934253244754!2d-83.04357068402409!3d42.556688930652875!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8824db749dda7623%3A0x298469e2171cc417!2sRAM+Solutions+Inc.!5e0!3m2!1sen!2sus!4v1558719461876!5m2!1sen!2sus" frameborder="0" style="border:0" allowfullscreen></iframe>
					</div>
					<div class="mt-3">
						<h4><%= Website.Company.Name %></h4>
						<div><%= Website.Company.Contact.Address %></div>
						<div><%= Website.Company.Contact.CityStateZip %></div>
						<div><span>Phone: </span><%= Website.Company.Contact.Phone %></div>
						<div><span>Fax: </span><%= Website.Company.Contact.Fax %></div>
					</div>
				</div>
		</div>
	</div>

</asp:Content>

