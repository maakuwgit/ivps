<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Content_Default" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h1>Links - HoF / HoW</h1>
    <asp:button ID="btnAdd" ToolTip="Add a New Link" runat="server" Text="Add Link" /><br />
    <asp:GridView ID="gvContent" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="No links have been created yet.">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-Width="40" />
            <asp:BoundField DataField="CatName" HeaderText="Category" />
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:TemplateField ItemStyle-Width="110" HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>