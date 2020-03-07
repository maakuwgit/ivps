<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Cat.aspx.vb" Inherits="admin_Docs_Add_Cat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Add / Edit Category</h1>

    <input type="Hidden" value="<%= CategoryRow("id") %>" name="id">

    <div class="form-group d-none">
        <label>Parent Category (Optional)</label>
        <asp:DropDownList runat="server" ID="ParentId" DataTextField="Name" DataValueField="Id" AutoPostBack="true" class="form-control"></asp:DropDownList>
    </div>
    <div class="form-group">
        <label>Name</label>
        <input type="text" value="<%= CategoryRow("name") %>" name="name" class="form-control" />
    </div>
    <div class="form-group">
        <label>Description</label>
        <textarea name="description" class="form-control" style="height:300px;"><%= CategoryRow("description") %></textarea>
    </div>
    <div class="form-group">
    	<asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <a  class="btn btn-outline-secondary my-3" href="CatDefault.aspx" >Cancel</a>
    </div>
</asp:Content>