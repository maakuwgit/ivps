<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" EnableEventValidation="false" AutoEventWireup="false" CodeFile="EditTab.aspx.vb" Inherits="admin_Products_Tab" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1 id="pgTitle" runat="server"></h1>
    <div>
        <p>
            <asp:Label runat="server" CssClass="input-label" AssociatedControlID="txtName" Text="Name"></asp:Label>
            <asp:TextBox runat="server" ID="txtName" Width="300" MaxLength="100" ReadOnly="false"></asp:TextBox>
        </p>
        <p>
            <asp:Label runat="server" CssClass="input-label" AssociatedControlID="txtDesc" Text="Description"></asp:Label>
            <asp:TextBox runat="server" CssClass="ckeditor" ID="txtDesc" TextMode="MultiLine"></asp:TextBox>
        </p>
        <p>
        <asp:Button runat="server" ID="btnSave" Text="Save" />
        <input type="button" value="Cancel" onclick="location.href='/admin/Products/'" />
        </p>
   </div>
    
</asp:Content>