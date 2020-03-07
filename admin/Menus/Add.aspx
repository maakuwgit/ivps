<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Menus_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Add Menu Link</h1>
    
    <asp:HiddenField ID="Id" runat="server" />
    <p><asp:Label CssClass="input-label" runat="server" ID="lblSnippet"></asp:Label></p>
    <p><asp:Label CssClass="input-label" runat="server" ID="lblSnippet2"></asp:Label></p>
	<input type="hidden" value="<%= MenuLinksData.Rows(0)("Id") %>" name="Id">

	<div class="form-group">
	<label for="">Menu</label><br />
	<asp:DropDownList runat="server" ID="menuid"></asp:DropDownList>
	</div>
	
	<div class="form-group">
	<label for="">Link</label><br />
	<asp:DropDownList runat="server" ID="linkid"></asp:DropDownList>
	</div>
	
    <div class="form-group">
        <label class="input-label" for="name">Order</label>
        <input type="text" value="<%= MenuLinksData.Rows(0)("Order") %>" name="Order" class="form-control required col-2">
    </div>

	   <%= Forms.AddFormChecker() %>
    <div class="form-group">
        <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <asp:Button runat="server" Text="Save & Close" ID="btnSaveClose" class="btn btn-secondary my-3"/>
        <asp:Button runat="server" Text="Close" ID="btnCancel" class="btn btn-outline-secondary my-3"  OnClientClick="FormValidator.validate = false"/>
    </div> 
</asp:Content>