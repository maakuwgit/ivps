<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_News_Add" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="/ckeditor/ckeditor.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <asp:HiddenField ID="NewsId" runat="server" />

<div class="form-group">
	<asp:CheckBox ID="ckFeatured" runat="server" Text="&nbsp;Featured" AutoPostBack="false" OnCheckedChanged-="chbTutorial_CheckedChanged" />
</div>

<div class="form-group">
    <asp:Label runat="server" AssociatedControlID="txtQuestion" Text="Question"></asp:Label>
    <asp:TextBox runat="server" ID="txtQuestion" Width="500" class="form-control"></asp:TextBox>
</div>

<div class="form-group">
    <asp:Label runat="server" AssociatedControlID="txtAnswer" Text="Answer"></asp:Label>
    <asp:TextBox runat="server" ID="txtAnswer" TextMode="MultiLine" Rows="6" Width="600" class="form-control"></asp:TextBox>
</div>

  <div class="form-group">
        <asp:Button runat="server" ID="btnSave" Text="Save" class="btn btn-primary"/>
        <asp:Button runat="server" ID="btnCancel" Text="Cancel" class="btn btn-light"/>
   </div>
</asp:Content>