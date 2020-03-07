<%@ Page MasterPageFile="~/admin/Admin.master" Language="VB" CodeFile="edit.aspx.vb" Inherits="Admin_testimonials_edit" ValidateRequest="false" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<link rel="stylesheet" type="text/css" href="/css/starability-minified/starability-all.min.css"/>

</asp:Content>
<asp:Content ID="ucContent" ContentPlaceHolderID="main" runat="server">
    <h1>Edit Review</h1>
    
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
        <textarea id="txtQuote" runat="server" rows="6" cols="40" class="form-control" ></textarea>
    </div>
  
    <asp:Literal runat="server" ID="ratingcontainer"></asp:Literal>
    
    <br /><br />
    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" Text="Save" runat="server" class="btn btn-primary"/>
    <asp:Button ID="btnCancel" Text="Cancel" OnClick="btnCancel_Click" runat="server" class="btn btn-secondary"/>
</asp:Content>