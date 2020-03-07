<%@ Page Title="" Language="VB" MasterPageFile="Site.master" AutoEventWireup="false" CodeFile="Reviews.aspx.vb" Inherits="Testimonials" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

<!-- #Include file="\PageWidgets\AlternatePageHeader.aspx" -->	

<article class="timeline-container container">
	<%
		Dim side = "left"
		For Each Review In ReviewsTable.Rows
			Dim cityState = Review("City") 
			If Review("State").ToString().Length > 0 Then
				cityState = cityState & "," & Review("State") 
			End if
			Dim createdDate = CDate(Review("dateCreated")).ToString("MMM dd, yyyy")


	%>
	
		   <div class="timeline-block timeline-block-<%= side %>">
			 <div class="timeline-content">
			 	<div class="row align-items-center">
			 		<% If side = "right" Then %>
				    <div class="position-relative arm-container order-1 d-none d-lg-block">
				    	<time class="date-created"><%= createdDate%></time>
				    	<div class="arm"><hr> <div class="bullet"></div></div>
				    </div>
				    <% End If %>
				    <div class="info order-2 d-flex flex-lg-row align-items-center">
						<div class="pr-1 pic">
							<img src="https://via.placeholder.com/100x100" class="rounded-circle">
						</div>
						<div class="name">
							<h3 class="h5"><%= Review("FirstName") %> <%= Review("LastName") %></h3>
							<address><%= cityState %></address>
					    </div>
				    </div>
				    <% If side = "left" Then %>
				    <div class="flex-lg-grow-1 arm-container position-relative order-1 order-lg-3 d-none d-lg-block">
				    	<time class="date-created"><%= createdDate %></time>
				    	<div class="arm"><hr> <div class="bullet"></div></div>
				    </div>
				    <% End If %>
			    </div>
			    
			    <p><span class="text-bold d-block d-lg-none mt-1"><%= createdDate %></span><%= Review("Quote") %></p>
			 </div>
		   </div>
	
	<%
		side = iif(side = "left", "right", "left")
		Next
	%>
</article>
<aside class="container">
	<h2 class="h3 text-med">Leave a review</h2>
	<hr>
	<form runat="server" role="form" class="no-gutter">
		<div>
			<div class="form-group">
				<asp:Label ID="Label1" runat="server" Text="First Name" AssociatedControlID="txtFirstName"></asp:Label>
				<asp:TextBox runat="server" id="txtFirstName" class="form-control" />
			</div>
	
			<div class="form-group">
				<asp:Label ID="Label2" runat="server" Text="Last Name" AssociatedControlID="txtLastName"></asp:Label>
				<asp:TextBox runat="server" id="txtLastName" class="form-control" />
			</div>
	
			<div class="form-group">
				<asp:Label ID="Label3" runat="server" Text="City" AssociatedControlID="txtCity"></asp:Label>
				<asp:TextBox runat="server" id="txtCity" class="form-control" />
			</div>
			<div class="form-group">
				<asp:Label ID="Label4" style="width:12% !important;" runat="server" Text="Review" AssociatedControlID="txtMessage"></asp:Label>
				<asp:TextBox TextMode="MultiLine" runat="server" id="txtMessage" Rows="4" class="form-control" />
			</div>
			
			
			<div class="form-group">
				<fieldset class="starability-basic">
					<legend>Rate Us</legend>
					<input type="radio" id="no-rate" class="input-no-rate" name="rating" value="0" checked aria-label="No rating." />

					<input type="radio" id="rate1" name="rating" value="1" />
					<label for="rate1">1 star.</label>

					<input type="radio" id="rate2" name="rating" value="2" />
					<label for="rate2">2 stars.</label>

					<input type="radio" id="rate3" name="rating" value="3"/>
					<label for="rate3">3 stars.</label>

					<input type="radio" id="rate4" name="rating" value="4" />
					<label for="rate4">4 stars.</label>

					<input type="radio" id="rate5" name="rating" value="5" />
					<label for="rate5">5 stars.</label>

					<span class="starability-focus-ring"></span>
				</fieldset>
			</div>
	
		
			<div class="form-group">
				<input type="submit" runat="server" value="Submit" id="btnSubmit" class="btn btn-primary"/>
				<span id="lblMsg" runat="server" class="alert"></span>  
			</div>
		</div>
	</form>
</aside>
</asp:Content>