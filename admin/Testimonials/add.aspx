<%@ Page MasterPageFile="~/admin/Admin.master" Language="VB" CodeFile="add.aspx.vb" Inherits="Admin_testimonials_add" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" type="text/css" href="/css/starability-minified/starability-all.min.css"/>
</asp:Content>
<asp:Content ID="ucContent" ContentPlaceHolderID="main" runat="server">

<h1>Add a Review</h1>

 <div class="form-group">
        <label class="input-label">First Name:</label>
        <asp:TextBox ID="txtFirstName" runat="server" class="form-control" />
    </div>
    
    <div class="form-group ">
        <label class="input-label">Last Name:</label>
        <asp:TextBox ID="txtLastName" runat="server" class="form-control" />
    </div>
    
    <div class="form-group  d-none">
        <label class="input-label">Email:</label>
        <asp:TextBox ID="txtEmail" runat="server" class="form-control" />
    </div>
    
    <div class="form-group d-none">
        <label class="input-label">Company:</label>
        <asp:TextBox ID="txtCompany" runat="server" class="form-control" />
    </div>
    
    <div class="form-group d-none">
        <label class="input-label">Position:</label>
        <asp:TextBox ID="txtPosition" runat="server" class="form-control" />
    </div>
    
    <div class="form-group">
        <label class="input-label">City:</label>
        <asp:TextBox ID="txtCity" runat="server" class="form-control" />
    </div>
    
    <div class="form-group d-none">
        <label class="input-label">State:</label>
        <asp:TextBox ID="txtState" runat="server" class="form-control" />
    </div>

    <div class="form-group d-none">
        <label class="input-label">Country:</label>
        <asp:TextBox ID="txtCountry" runat="server" class="form-control" />
    </div>
    
    <div class="form-group">
        <label class="input-label">Quote:</label>
        <asp:TextBox ID="txtqout" runat="server" TextMode="MultiLine"  Height="175px" class="form-control"/>
    </div> 
    
 
    <div class="form-group">
									<fieldset class="starability-basic">
									  <legend>Rating</legend>
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

    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" Text="Submit" runat="server" />
    <asp:Button ID="btnCancel" Text="Cancel" runat="server" />
</asp:Content>