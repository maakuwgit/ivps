<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Content_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

	<script src="/ckeditor/ckeditor.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
  <input type="button" value="< Back" onclick="window.history.go(-1)" class="btn btn-secondary btn-sm my-3"/>
    <h1>Label Editor</h1>
    <asp:HiddenField ID="Id" runat="server" />
	    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtName">Label</label>
        <asp:TextBox runat="server" ID="txtLabel" class="form-control col-12 col-lg-4"></asp:TextBox>
    </div>
	
<div class="form-group">
        <label class="input-label" for="ctl00_main_txtName">Locations</label>
        <asp:TextBox runat="server" ID="txtLocation" class="form-control col-12 col-lg-4"></asp:TextBox>
    </div>
    <div class="form-group">
        <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-primary my-3"/>
        <asp:Button runat="server" Text="Close" ID="btnCancel" class="btn btn-outline-secondary my-3"/>
    </div>
</asp:Content>