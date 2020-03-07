<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Content_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
  <input type="button" value="< Back" onclick="window.history.go(-1)" class="btn btn-secondary btn-sm my-3"/>
    <h1>Location</h1>

    <input type="hidden" value="<%= Marker("id") %>" name="id">
    
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtName">Name</label><br>
        <input type="text" value="<%= Marker("name") %>" name="name" class="form-control">
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtLabel">Address</label><br>
        <input type="text" value="<%= Marker("address") %>" name="address" class="form-control">
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtUrl">City</label><br>
        <input type="text" value="<%= Marker("city") %>" name="city" class="form-control">
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtLocation">State</label><br>
        <input type="text" value="<%= Marker("state") %>" name="state" class="form-control" maxlength="2">
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtAction">Zip</label><br>
        <input type="text" value="<%= Marker("zip") %>" name="zip" class="form-control" maxlength="5">
    </div>
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtProperties">Phone</label><br>
        <input type="tel" value="<%= Marker("phone") %>" name="phone" class="form-control" maxlength="10" placeholder="Numbers only">
    </div>
    
    	<div class="form-group">
        <label class="input-label" for="ctl00_main_txtProperties">Latitude</label><br>
        <input type="text" value="<%= Marker("lat") %>" name="lat" class="form-control" placeholder="Leave blank to auto generate">
    </div>
    
    <div class="form-group">
        <label class="input-label" for="ctl00_main_txtProperties">Longitude</label><br>
        <input type="text" value="<%= Marker("lng") %>" name="lng" class="form-control" placeholder="Leave blank to auto generate">
    </div>

    <div class="form-group">
        <asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <asp:Button runat="server" Text="Save and Close" ID="btnSaveClose" class="btn btn-outline-success my-3"/>
        <asp:Button runat="server" Text="Close" ID="btnCancel" class="btn btn-secondary my-3"/>
    </div>

</asp:Content>