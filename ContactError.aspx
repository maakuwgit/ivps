<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="About.aspx.vb" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
            
        <div class="container pt-5" style="min-height:70vh;">
        	<div class="row">
        		<div class="col-12">
        		<h1>Ooops</h1>
			Something went wrong when you submitted the contact form. Please try again.
			<% If Request("e") = 4 Then %>
				<div class="text-dark pt-3"><small><b><i>error: javascript not enabled.</i></b></smal></div>
			<% End If %>
			<% If Request("e") = 3 Then %>
				<div class="text-dark pt-3"><small><b><i>error: potential spam content.</i></b></smal></div>
			<% End If %>
			<% If Request("e") = 2 Then %>
				<div class="text-dark pt-3"><small><b><i>error: tokens don't match.</i></b></smal></div>
			<% End If %>
			<% If Request("e") = 1 Then %>
				<div class="text-dark pt-3"><small><b><i>error: no information was provided.</i></b></smal></div>
			<% End If %>
		</div>
	</div>
	</div>
		
</asp:Content>