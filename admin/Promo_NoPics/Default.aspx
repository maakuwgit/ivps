<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Promo_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Promotions</h1>
    <input type="button" value="Add Promo" onclick="location.href='/Admin/Promo/Add.aspx'" />
    <asp:GridView ID="gvPromo" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No content areas have been created yet.">
        <Columns>
        <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-Width="40" />
        <asp:BoundField DataField="Name" HeaderText="Name" />
        <asp:BoundField DataField="Desc" HeaderText="Description" />
        <asp:BoundField DataField="StartDt" ItemStyle-Width="110" HeaderText="Starts" DataFormatString="{0:d}" />
        <asp:BoundField DataField="EndDt" ItemStyle-Width="110" HeaderText="Ends" DataFormatString="{0:d}" />
        <asp:TemplateField ItemStyle-Width="200" HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" />
                <asp:Button ID="btnDownload" runat="server" Text="Download" CommandArgument='<%#Eval("Id") %>' OnClick="btnDownload_Click" />
            </ItemTemplate>
        </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>