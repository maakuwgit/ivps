<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Add.aspx.vb" Inherits="admin_Promo_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".DatePicker").datepicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <asp:HiddenField ID="PromoId" runat="server" Value="0" />
    <h1>Add / Edit Promotion</h1>
    <em>*Promotions with no End Date will remain active. <br />
        *Promotions with no Start Date will be active unless the current date is after the End Date.<br />
        *Only PDF files can be uploaded for the promotion's attachment.
    </em><br /><br />
    <asp:Label runat="server" AssociatedControlID="txtName" Text="Name"></asp:Label><br />
    <asp:TextBox runat="server" ID="txtName" Width="300" required="required" MaxLength="128"></asp:TextBox><br /><br />

    <asp:Label runat="server" AssociatedControlID="txtDesc" Text="Description"></asp:Label><br />
    <asp:TextBox runat="server" ID="txtDesc" Width="300" required="required" MaxLength="128"></asp:TextBox><br /><br />

    <asp:Label runat="server" AssociatedControlID="txtStartDt" Text="Start Date"></asp:Label><br />
    <asp:TextBox runat="server" CssClass="DatePicker" ID="txtStartDt" Width="70"></asp:TextBox><br /><br />

    <asp:Label runat="server" AssociatedControlID="txtEndDt" Text="End Date"></asp:Label><br />
    <asp:TextBox runat="server" CssClass="DatePicker" ID="txtEndDt" Width="70"></asp:TextBox><br /><br />

    <asp:Label runat="server" AssociatedControlID="FileUpload" Text="Choose file to Upload"></asp:Label><br />
    <asp:FileUpload runat="server" ID="FileUpload" /><br /><br />
    <asp:Button runat="server" Text="Save" ID="btnSave" />
    <input type="button" value="Cancel" onclick="location.href='/Admin/Promo/'" />
</asp:Content>