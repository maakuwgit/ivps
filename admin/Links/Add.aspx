<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Links_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<h1>Site Content Editor</h1>
<asp:HiddenField ID="Id" runat="server" />

<label for="ctl00_main_txtName">Category</label><br />
<asp:DropDownList runat="server" ID="dropDownCategories"></asp:DropDownList><br /><br />

<label for="ctl00_main_txtName">Name</label><br />
<asp:TextBox runat="server" ID="txtName" width="600"></asp:TextBox><br /><br />

<label for="ctl00_main_txtDesc">Description</label><br />
<asp:TextBox runat="server" ID="txtDesc" TextMode="MultiLine" Rows="10" width="600"></asp:TextBox><br /><br />

<label for="ctl00_main_txtName">Url</label><br />
<asp:TextBox runat="server" ID="txtLink" width="600"></asp:TextBox><br /><br />

<div style="display:none;">
    <label for="ctl00_main_fileUpload">Image</label><br />
    <asp:FileUpload ID="fileUpload" runat="server" /><br /><br />

    <label for="ctl00_main_txtContent">Content</label><br />
    <textarea runat="server" id="txtContent" class="ckeditor" readonly="readonly"></textarea>
</div>

<asp:Label runat="server" AssociatedControlID="filePicture" Text="Picture"></asp:Label><br>
<asp:FileUpload runat="server" ID="filePicture"></asp:FileUpload>
    
<div style="height:200px;margin: 1rem 0 3rem 0;"><asp:Image id="LinkImage" runat="server" ImageAlign="left"/></div>

<p>
    <asp:Button runat="server" Text="Save" ID="btnSave" />
    <asp:Button runat="server" Text="Cancel" ID="btnCancel" />
</p>
</asp:Content>