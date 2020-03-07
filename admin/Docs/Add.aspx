<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Docs_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Add / Edit Document</h1>
    
    <asp:HiddenField runat="server" ID="DocId" />

    <div class="form-group">
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="fileUpload" Text="Document"></asp:Label>
        <asp:FileUpload runat="server" ID="fileUpload" class="form-control-file"/>
    </div>
    <div class="form-group">
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="dlCat" Text="Category"></asp:Label>
        <asp:DropDownList runat="server" ID="dlCat" DataTextField="Name" DataValueField="Id" AutoPostBack="true" class="form-control"></asp:DropDownList>
    </div>
    <div class="form-group">
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="Name" Text="Name"></asp:Label>
        <asp:TextBox runat="server" ID="Name" MaxLength="100" class="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <asp:Label runat="server" CssClass="input-label" AssociatedControlID="Desc" Text="Description"></asp:Label>
        <asp:TextBox runat="server" ID="Desc" MaxLength="1024" TextMode="MultiLine" class="form-control" Rows="4"></asp:TextBox>
    </div>
    <div class="form-group">
    	<asp:Button runat="server" Text="Save" ID="btnSave" class="btn btn-success my-3"/>
        <input type="button" value="Cancel" class="btn btn-outline-secondary my-3" onclick="location.href='/admin/Docs/'" />
    </div>
</asp:Content>